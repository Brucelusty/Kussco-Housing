codeunit 50108 "Exit Recovery"
{
    trigger OnRun()
    begin

    end;

    procedure RecoverLoans(member: Code[20]; totalLoans: Decimal) Cleared: Boolean;
    var
    begin
        batchName := '';
        batchTemplate := '';
        docNo := '';
        depAccount := '';
        loanNo := '';
        accountBal := 0;
        remainder := 0;
        payment := 0;

        PayWithdrawalFee(member);
        

        batchTemplate := 'PAYMENTS';
        batchName := 'EXITREC';
        docNo := member + '-EXITRECOVERY';
        lineNo := 0;


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'EXITREC');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll;
        end;

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
        GenBatches.SetRange(GenBatches.Name, 'EXITREC');
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'PAYMENTS';
            GenBatches.Name := 'EXITREC';
            GenBatches.Description := 'EXIT RECOVERY';
            GenBatches.Insert;
        end;


        vend.Reset();
        vend.SetRange("BOSA Account No", member);
        vend.SetRange("Account Type", '102');
        if vend.Find('-') then begin
            vend.CalcFields(Balance);
            accountBal := vend.Balance;
            remainder := accountBal;
            depAccount := vend."No.";
        end;
        Cleared := false;
        if accountBal < totalLoans then Error('The member''s deposits of %1 cannot fully recover their total loan balance of %2.', accountBal, totalLoans);

        loansReg.Reset();
        loansReg.SetRange("Client Code", member);
        loansReg.SetFilter("Outstanding Interest", '>%1', 0);
        if loansReg.Find('-') then begin
            repeat
                detCust.Reset();
                detCust.SetRange("Customer No.", member);
                detCust.SetRange("Loan No", loansReg."Loan  No.");
                detCust.SetRange(Reversed, false);
                detCust.SetFilter("Transaction Type", '%1|%2', detCust."Transaction Type"::"Interest Paid", detCust."Transaction Type"::"Interest Due");
                if detCust.FindLast() then begin
                    detCust.CalcSums(Amount);
                    payment := detCust.Amount;
                end;

                if remainder >= payment then begin
                    lineNo := lineNo + 10000;
                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, depAccount, Today, payment, '', '',
                    'Interest-' + loansReg."Loan  No." + '-' + Member + '-Recovery', '', GenJournalLine."Application Source"::" ");
                    //--------------------------------(CREDIT Deposit Account)---------------------------------------------

                    //------------------------------------ DEBIT Loan Interest ---------------------------------------------------------------------------------------------
                    lineNo := lineNo + 10000;
                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                    GenJournalLine."Account Type"::Customer, Member, Today, payment * -1, ' ', '',
                    'Interest-' + loansReg."Loan  No." + '-' + Member + '-Recovery', loansReg."Loan  No.", GenJournalLine."Application Source"::" ");

                    remainder := remainder - payment;
                end;
            until loansReg.Next() = 0;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", batchTemplate);
            GenJournalLine.SetRange("Journal Batch Name", batchName);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
        end;


        loanNo := '';
        lineNo := lineNo;
        remainder := remainder;

        loansReg.Reset();
        loansReg.SetRange("Client Code", member);
        loansReg.SetFilter("Outstanding Balance", '>%1', 0);
        if loansReg.Find('-') then begin
            repeat
                loansReg.CalcFields("Outstanding Balance");
                payment := loansReg."Outstanding Balance";
                if remainder >= payment then begin
                    lineNo := lineNo + 10000;
                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, depAccount, Today, payment, '', '',
                    'Repayment-' + loansReg."Loan  No." + '-' + Member + '-Recovery', '', GenJournalLine."Application Source"::" ");
                    //--------------------------------(CREDIT Deposit Account)---------------------------------------------

                    //------------------------------------ DEBIT Loan Repayment ---------------------------------------------------------------------------------------------
                    lineNo := lineNo + 10000;
                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::Repayment,
                    GenJournalLine."Account Type"::Customer, Member, Today, payment * -1, ' ', '',
                    'Repayment-' + loansReg."Loan  No." + '-' + Member + '-Recovery', loansReg."Loan  No.", GenJournalLine."Application Source"::" ");

                    remainder := remainder - payment;
                end;
            until loansReg.Next() = 0;
            
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", batchTemplate);
            GenJournalLine.SetRange("Journal Batch Name", batchName);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
        end;
        remainder := remainder;
        Message('%1 Remainder', remainder);
        Cleared := true;
        Message('Cleared.');
    end;

    procedure checkGuarantorship(member: Code[20]) cleared: Boolean;
    var
        myInt: Integer;
    begin
        batchName := '';
        batchTemplate := '';
        docNo := '';
        depAccount := '';
        loanNo := '';
        accountBal := 0;
        remainder := 0;
        payment := 0;
        currentLiability := 0;

        loanGuar.Reset();
        loanGuar.SetRange("Member No", member);
        loanGuar.SetRange(Substituted, false);
        if loanGuar.Find('-') then begin
            repeat
                loansReg.Reset();
                loansReg.SetRange("Loan  No.", loanGuar."Loan No");
                loansReg.SetFilter("Outstanding Balance", '>%1', 0);
                if loansReg.Find('-') then begin
                    loansReg.CalcFields("Outstanding Balance");
                    currentLiability := currentLiability + (Round(((loansReg."Outstanding Balance" / loansReg."Approved Amount") * loanGuar."Amont Guaranteed"), 0.01, '='));
                end;
            until loanGuar.Next() = 0;
        end;

        if currentLiability = 0 then begin
            cleared := true;
            Message('Cleared');
        end else if currentLiability > 0 then begin
            if Confirm('Do you wish to recover this member''s guaranteed amounts?', false) = true then begin

                vend.Reset();
                vend.SetRange("BOSA Account No", member);
                vend.SetRange("Account Type", '102');
                if vend.Find('-') then begin
                    depAccount := vend."No.";
                    vend.CalcFields(Balance);
                    remainder:= vend.Balance;
                    Message('%1 Remainder', remainder);
                end;

                cleared:= false;
                if currentLiability > remainder then Error('The member''s current liability of %1 is greater than the member''s remaining deposits of %2.', currentLiability, remainder);

                batchTemplate := 'PAYMENTS';
                batchName := 'EXITREC';
                docNo := member + '-EXITRECOVERY';
                lineNo := 0;


                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                GenJournalLine.SetRange("Journal Batch Name", 'EXITREC');
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DeleteAll;
                end;

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
                GenBatches.SetRange(GenBatches.Name, 'EXITREC');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'PAYMENTS';
                    GenBatches.Name := 'EXITREC';
                    GenBatches.Description := 'EXIT RECOVERY';
                    GenBatches.Insert;
                end;

                currentLiability := 0;
                loanGuar.Reset();
                loanGuar.SetRange("Member No", member);
                loanGuar.SetRange(Substituted, false);
                if loanGuar.Find('-') then begin
                    repeat
                        loansReg.Reset();
                        loansReg.SetRange("Loan  No.", loanGuar."Loan No");
                        loansReg.SetFilter("Outstanding Balance", '>%1', 0);
                        if loansReg.Find('-') then begin
                            loansReg.CalcFields("Outstanding Balance");
                            currentLiability := Round(((loansReg."Outstanding Balance" / loansReg."Approved Amount") * loanGuar."Amont Guaranteed"), 0.01, '=');

                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, depAccount, Today, currentLiability, '', '',
                            'Guarantorship-' + loansReg."Loan  No." + '-' + Member + '-Recovery', '', GenJournalLine."Application Source"::" ");
                            //--------------------------------(CREDIT Deposit Account)---------------------------------------------

                            //------------------------------------ DEBIT Guaranteed Loan ---------------------------------------------------------------------------------------------
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."Account Type"::Customer, loansReg."Client Code", Today, currentLiability * -1, ' ', '',
                            'Guarantorship-' + loansReg."Loan  No." + '-' + Member + '-Recovery', loansReg."Loan  No.", GenJournalLine."Application Source"::" ");

                            remainder := remainder - currentLiability;
                        end;
                    until loanGuar.Next() = 0;
                    
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", batchTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", batchName);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;

                    cleared := true;
                    Message('Cleared');
                end;
            end else cleared:= false;
        end;
    end;

    procedure PostDeathDepositstoFOSA(member: Code[20]; BBF: Boolean)paid: Boolean;
    var
        myInt: Integer;
    begin
        FEAccount:= '';
        depAccount:= '';
        withAccount:= '';
        withAmount:= 0;
        saccoGenSetup.Get();
        deathDep:= 0;

        PayWithdrawalFee(member);

        vend.Reset();
        vend.SetRange("BOSA Account No", member);
        vend.SetRange("Account Type", '102');
        if vend.Find('-') then begin
            depAccount:= vend."No.";
            vend.CalcFields(Balance);
            deathDep:= vend.Balance;
            // * saccoGenSetup."Death Deposit Multiplier";
            // if deathDep = 0 then Error('Check that the deposit multiplier for death exits has been set up in the sacco general setup.');
        end;

        FEAccount:= saccoGenSetup."Funeral Expenses Account";

        batchTemplate := 'PAYMENTS';
        batchName := 'DEPTRANS';
        docNo := 'DEPTRANS-'+ member;
        lineNo := 0;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'DEPTRANS');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll
        end;
        
        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
        GenBatches.SetRange(GenBatches.Name, 'DEPTRANS');
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'PAYMENTS';
            GenBatches.Name := 'DEPTRANS';
            GenBatches.Description := 'Deposit Transfer To Ordinary Savings';
            GenBatches.Insert;
        end;

        vend.Reset();
        vend.SetRange("BOSA Account No", member);
        vend.SetRange("Account Type", '103');
        if vend.Find('-') then begin
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor, depAccount, Today, deathDep, '', '',
            'Member-Deposit Tranfer -FOSA- '+Member, '', GenJournalLine."Application Source"::" ");
            //--------------------------------(CREDIT BOSA Deposit Account)---------------------------------------------

            //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor, Vend."No.", Today, deathDep * -1, ' ', '',
            'Member-Deposit Tranfer -FOSA- '+Member, '', GenJournalLine."Application Source"::" ");

            if BBF = true then begin
                lineNo := lineNo + 10000;
                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", FEAccount, Today, deathDep, '', '',
                'Insurance-Deposit Tranfer -FOSA- '+Member, '', GenJournalLine."Application Source"::" ");
                //--------------------------------(CREDIT Funeral Rider Account)---------------------------------------------

                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                lineNo := lineNo + 10000;
                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, Vend."No.", Today, deathDep * -1, ' ', '',
                'Insurance-Deposit Tranfer -FOSA- '+Member, '', GenJournalLine."Application Source"::" ");
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", batchTemplate);
            GenJournalLine.SetRange("Journal Batch Name", batchName);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;

            paid := true;
            Message('Paid.');
        end;
    end;

    procedure PayWithdrawalFee(member: Code[20])
    var
        myInt: Integer;
    begin
        withAccount:= '';
        withAmount:= 0;

        saccoGenSetup.Get();
        withAccount:= saccoGenSetup."Withdrawal Fee Account";
        withAmount:= saccoGenSetup."Withdrawal Fee";
        
        batchTemplate := 'PAYMENTS';
        batchName := 'CLOSUREFEE';
        docNo := 'CLOSFEE-'+ member;
        lineNo := 0;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'CLOSUREFEE');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll
        end;
        
        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
        GenBatches.SetRange(GenBatches.Name, 'CLOSUREFEE');
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'PAYMENTS';
            GenBatches.Name := 'CLOSUREFEE';
            GenBatches.Description := 'Withdrawal Fee Payment';
            GenBatches.Insert;
        end;

        vend.Reset();
        vend.SetRange("BOSA Account No", member);
        vend.SetRange("Account Type", '102');
        if vend.Find('-') then begin
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor, vend."No.", Today, withAmount, '', '',
            'Membership Closure Fee-'+Member, '', GenJournalLine."Application Source"::" ");
            //--------------------------------(CREDIT BOSA Deposit Account)---------------------------------------------

            //------------------------------------2. DEBIT Withdrawal Fee A/C---------------------------------------------------------------------------------------------
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::"G/L Account", withAccount, Today, withAmount * -1, ' ', '',
            'Membership Closure Fee-'+Member, '', GenJournalLine."Application Source"::" ");
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", batchTemplate);
        GenJournalLine.SetRange("Journal Batch Name", batchName);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
    end;

    procedure FullRePayRefunds(member: Code[20]; amountToPay: Decimal) rem: Decimal
    var
        myInt: Integer;
        totalRef: Decimal;
        disburseAmount: Decimal;
        excess: Decimal;
    begin
        depAmount:= 0;
        ESSAmount:= 0;
        disburseAmount:= 0;
        
        batchTemplate := 'PAYMENTS';
        batchName := 'REFUNDFOSA';
        docNo := 'REFUND-FOSA-'+ member;
        lineNo := 0;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'REFUNDFOSA');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll
        end;
        
        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
        GenBatches.SetRange(GenBatches.Name, 'REFUNDFOSA');
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'PAYMENTS';
            GenBatches.Name := 'REFUNDFOSA';
            GenBatches.Description := 'Refund Deposits to FOSA';
            GenBatches.Insert;
        end;

        vend.Reset();
        vend.SetRange("BOSA Account No", member);
        vend.SetRange("Account Type", '102');
        if vend.Find('-') then begin
            depAccount:= vend."No.";
            vend.CalcFields(Balance);
            depAmount:= vend.Balance;
        end;
        vend.Reset();
        vend.SetRange("BOSA Account No", member);
        vend.SetRange("Account Type", '104');
        if vend.Find('-') then begin
            ESSAccount:= vend."No.";
            vend.CalcFields(Balance);
            ESSAmount:= vend.Balance;
        end;

        if (depAmount <= 0) and (ESSAmount <= 0) then Error('The member %1 lacks a balance to refund.', member);

        if amountToPay > depAmount then begin
            disburseAmount:= depAmount;
            excess:= amountToPay-depAmount;
        end else begin
            disburseAmount := amountToPay;
            excess:= 0;
        end;

        vend.Reset();
        vend.SetRange("BOSA Account No", member);
        vend.SetRange("Account Type", '103');
        if vend.Find('-') then begin
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor, depAccount, Today, disburseAmount, '', '',
            'Membership Closure Refund-'+Member, '', GenJournalLine."Application Source"::" ");
            //--------------------------------(CREDIT BOSA Deposit Account)---------------------------------------------

            //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor, vend."No.", Today, disburseAmount * -1, ' ', '',
            'Membership Closure Refund-'+Member, '', GenJournalLine."Application Source"::" ");
            
            //-------------------------------------------------------------------------------------------------------------------//
            disburseAmount:= 0;
            if (excess > 0) and (ESSAmount > 0) then begin
                disburseAmount := excess;
                if disburseAmount = ESSAmount then begin
                    disburseAmount := ESSAmount
                end else disburseAmount := (ESSAmount - excess);

                lineNo := lineNo + 10000;
                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, ESSAccount, Today, disburseAmount, '', '',
                'Membership Closure Refund-'+Member, '', GenJournalLine."Application Source"::" ");
                //--------------------------------(CREDIT ESS Shares Account)---------------------------------------------

                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                lineNo := lineNo + 10000;
                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, vend."No.", Today, disburseAmount * -1, ' ', '',
                'Membership Closure Refund-'+Member, '', GenJournalLine."Application Source"::" ");
            end;
        end;
        
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", batchTemplate);
        GenJournalLine.SetRange("Journal Batch Name", batchName);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        rem := ((depAmount + ESSAmount) - amountToPay);
    end;

    var
        lineNo: Integer;
        accountBal: Decimal;
        currentLiability: Decimal;
        payment: Decimal;
        remainder: Decimal;
        deathDep: Decimal;
        withAmount: Decimal;
        ESSAmount: Decimal;
        depAmount: Decimal;
        depAccount: Code[20];
        ESSAccount: Code[20];
        withAccount: Code[20];
        docNo: Code[30];
        batchName: Code[20];
        batchTemplate: Code[20];
        loanNo: Code[20];
        FEAccount: Code[20];
        cust: Record Customer;
        vend: Record Vendor;
        loansReg: Record "Loans Register";
        loanGuar: Record "Loans Guarantee Details";
        AUFactory: Codeunit "Au Factory";
        saccoGenSetup: Record "Sacco General Set-Up";
        GenBatches: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        detCust: Record "Detailed Cust. Ledg. Entry";
}
