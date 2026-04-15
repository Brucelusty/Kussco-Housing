codeunit 50106 "Loan Sweeping"
{

    trigger OnRun()
    var
        myInt: Integer;
    begin
        SweepDefaultedLoans();
        //SweepDefaultedOtherLoans();
    end;

    procedure SweepDefaultedLoans()
    var
        Loans: Record "Loans Register";
        LoansReg: Record "Loans Register";
        Vendor: Record Vendor;
        LineNo: integer;
        VBalance: Decimal;
        BATCH_TEMPLATE: code[100];
        BATCH_NAME: code[100];
        DOCUMENT_NO: code[100];
        OutstandingPenalty: Decimal;
        OutstandingInterest: Decimal;
        OutstandingBalance: Decimal;
        TotalRepay: Decimal;
    begin
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'RECOVER';


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'RECOVER');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll;
        end;

        /*         LoansReg.Reset();
                LoansReg.SetAutoCalcFields("Total Outstanding Balance");
                LoansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                LoansReg.SetRange("Loan Disbursement Date", 0D);
                if LoansReg.FindSet() then begin
                    repeat
                        LoansReg."Loan Disbursement Date" := DT2Date(LoansReg.SystemCreatedAt);
                        LoansReg.Validate("Loan Disbursement Date");
                        loansReg.Modify;
                    until LoansReg.Next() = 0;
                end */
        ;

        DOCUMENT_NO := 'LNRECOVERY ' + Format(Today);
        Vendor.Reset();
        Vendor.SetFilter(Vendor."Account Type", '103');
        //Vendor.SetRange(Vendor."No.", '001-010017-3000');
        Vendor.SetAutoCalcFields(Balance);
        // Vendor.SetFilter(Balance, '>%1', 1000);
        if Vendor.FindSet() then begin
            repeat
                VBalance := 0;
                VBalance := Vendor.GetAvailableBalance();

                if VBalance > 0 then begin
                    Loans.Reset();
                    loans.SetFilter(Loans."Loan Disbursement Date", '<>%1', 0D);
                    Loans.SetFilter(Loans."Expected Date of Completion", '<%1', Today);
                    Loans.SetAutoCalcFields(Loans."Total Outstanding Balance");
                    // Loans.SetFilter("Loan Product Type", '%1|%2', 'A03', 'M_OD');
                    Loans.SetRange(Loans."Loan Product Type", 'A03');
                    Loans.SetFilter(Loans."Total Outstanding Balance", '>%1', 0);
                    Loans.SetRange(Loans."Client Code", Vendor."BOSA Account No");
                    IF Loans.FindSet() then BEGIN
                        repeat
                            TotalRepay := 0;
                          //  Error('Vbalnce%1',Loans."Loan  No.");
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", Loans."Outstanding Penalty");

                            if Loans."Outstanding Penalty" > 0 then begin
                                OutstandingPenalty := 0;
                                if VBalance > Loans."Outstanding Penalty" then
                                    OutstandingPenalty := Loans."Outstanding Penalty"
                                else
                                    OutstandingPenalty := VBalance;

                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Paid",
                                GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingPenalty * -1, '', Loans."Loan  No.",
                                'Penalty Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                 GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingPenalty, ' ', Loans."Loan  No.",
                                 'Penalty Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                VBalance := VBalance - OutstandingPenalty;
                                TotalRepay := TotalRepay + OutstandingPenalty;
                            end;

                            if Loans."Outstanding Interest" > 0 then begin
                                OutstandingInterest := 0;
                                if VBalance > Loans."Outstanding Interest" then
                                    OutstandingInterest := Loans."Outstanding Interest"
                                else
                                    OutstandingInterest := VBalance;

                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingInterest * -1, '', Loans."Loan  No.",
                                'Interest Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                 GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingInterest, ' ', Loans."Loan  No.",
                                 'Interest Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                VBalance := VBalance - OutstandingInterest;
                                TotalRepay := TotalRepay + OutstandingInterest;
                            end;

                            if VBalance > 0 then begin
                                OutstandingBalance := 0;
                                if VBalance > Loans."Outstanding Balance" then
                                    OutstandingBalance := Loans."Outstanding Balance"
                                else
                                    OutstandingBalance := VBalance;

                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingBalance * -1, '', Loans."Loan  No.",
                                'Loan Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                 GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingBalance, ' ', Loans."Loan  No.",
                                 'Loan Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                VBalance := VBalance - OutstandingBalance;
                                TotalRepay := TotalRepay + OutstandingBalance;
                            end;

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;

                            Members.Reset();
                            Members.SetRange(Members."No.", Loans."Client Code");
                            if Members.FindFirst() then begin
                                if TotalRepay > 100 then begin
                                    CreationMessage := 'Dear ' + NameStyle.NameStyle(loans."Client Code") + ', Ksh ' + Format(TotalRepay) + ' has been deducted to repay your defaulted ' + Loans."Loan Product Type Name" + '. Thank you for Banking With Us.';
                                    smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;
                        until Loans.Next() = 0;
                    end;
                end;
            until Vendor.Next() = 0;

        END;
    end;




    procedure SweepDefaultedOtherLoans()
    var
        Loans: Record "Loans Register";
        LoansReg: Record "Loans Register";
        Vendor: Record Vendor;
        LineNo: integer;
        VBalance: Decimal;
        BATCH_TEMPLATE: code[100];
        BATCH_NAME: code[100];
        DOCUMENT_NO: code[100];
        OutstandingPenalty: Decimal;
        OutstandingInterest: Decimal;
        OutstandingBalance: Decimal;
        TotalRepay: Decimal;
        Schedule: Record "Loan Repayment Schedule";
        LArrears: Decimal;
    begin
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'RECOVER';


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'RECOVER');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll;
        end;



        DOCUMENT_NO := 'LNRECOVERY ' + Format(Today);
        Vendor.Reset();
        Vendor.SetFilter(Vendor."Account Type", '103');
        Vendor.SetAutoCalcFields(Balance);
        Vendor.SetFilter(Balance, '>%1', 1000);
        Vendor.SetRange(Vendor."BOSA Account No", '013064');
        if Vendor.FindFirst() then begin
            repeat
                TotalRepay := 0;
                VBalance := 0;
                VBalance := Vendor.GetAvailableBalance();
                if VBalance > 0 then begin
                    Loans.Reset();
                    Loans.SetRange(Loans."Loan  No.", 'FL007241');
                    Loans.SetAutoCalcFields(Loans."Total Outstanding Balance");
                    Loans.SetFilter("Loan Product Type", '<>%1&<>%2', 'A03', 'M_OD');
                    Loans.SetFilter(Loans."Total Outstanding Balance", '>%1', 0);
                    Loans.SetRange(loans."Client Code", Vendor."BOSA Account No");
                    Loans.SetFilter(Loans."Loans Category", '<>%1', Loans."Loans Category"::Perfoming);
                    IF Loans.FindFirst() then BEGIN
                        repeat

                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", Loans."Outstanding Penalty");
                            if AUFactory.CheckIfScheduleIsGenerated(Loans."Loan  No.") = false then begin
                                AUFactory.FnGenerateLoanRepaymentSchedule(Loans."Loan  No.");
                            end;
                            Schedule.Reset();
                            Schedule.SetRange(Schedule."Loan No.", Loans."Loan  No.");
                            Schedule.SetFilter(Schedule."Repayment Date", '..%1', Today);
                            if Schedule.FindLast() then begin
                                LArrears := 0;
                                LArrears := Loans."Outstanding Balance" - Schedule."Loan Balance";
                                Error('SheduBal%1OutBal%2', Schedule."Loan Balance", Loans."Outstanding Balance");

                                if LArrears > 0 then begin
                                    if Loans."Outstanding Penalty" > 0 then begin
                                        OutstandingPenalty := 0;
                                        if VBalance > Loans."Outstanding Penalty" then
                                            OutstandingPenalty := Loans."Outstanding Penalty"
                                        else
                                            OutstandingPenalty := VBalance;

                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Paid",
                                        GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingPenalty * -1, '', Loans."Loan  No.",
                                        'Penalty Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                        //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                        //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                         GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingPenalty, ' ', Loans."Loan  No.",
                                         'Penalty Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                        VBalance := VBalance - OutstandingPenalty;
                                        TotalRepay := TotalRepay + OutstandingPenalty;
                                    end;

                                    if Loans."Outstanding Interest" > 0 then begin
                                        OutstandingInterest := 0;
                                        if VBalance > Loans."Outstanding Interest" then
                                            OutstandingInterest := Loans."Outstanding Interest"
                                        else
                                            OutstandingInterest := VBalance;

                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                        GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingInterest * -1, '', Loans."Loan  No.",
                                        'Interest Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                        //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                        //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                         GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingInterest, ' ', Loans."Loan  No.",
                                         'Interest Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                        VBalance := VBalance - OutstandingInterest;
                                        TotalRepay := TotalRepay + OutstandingInterest;
                                    end;

                                    Error('OutstandingPenalty%1,OutsInt%2,OutBal%3', OutstandingPenalty, OutstandingInterest, LArrears);
                                    if VBalance > 0 then begin
                                        OutstandingBalance := 0;
                                        if LArrears > 0 then
                                            OutstandingBalance := LArrears
                                        else
                                            OutstandingBalance := 0;

                                        if VBalance > OutstandingBalance then
                                            OutstandingBalance := OutstandingBalance
                                        else
                                            OutstandingBalance := VBalance;

                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                        GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingBalance * -1, '', Loans."Loan  No.",
                                        'Loan Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                        //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                        //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                         GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingBalance, ' ', Loans."Loan  No.",
                                         'Loan Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                        VBalance := VBalance - OutstandingBalance;
                                        TotalRepay := TotalRepay + OutstandingBalance;

                                    end;

                                    /*                             GenJournalLine.Reset;
                                                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                                                if GenJournalLine.Find('-') then begin
                                                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                                                end;

                                                                if TotalRepay > 0 then begin
                                                                    Members.Reset();
                                                                    Members.SetRange(Members."No.", Loans."Client Code");
                                                                    if Members.FindFirst() then begin
                                                                        CreationMessage := 'Dear ' + NameStyle.NameStyle(loans."Client Code") + ', Ksh ' + Format(TotalRepay) + ' has been deducted to repay your arrears on ' + Loans."Loan Product Type Name" + '. Thank you for Banking With Us.';
                                                                        smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                                                                    end;
                                                                end; */
                                end;
                            end;
                        until Loans.Next() = 0;
                    end;
                end;
            until Vendor.Next() = 0;
        END;
    end;

    procedure SweepAllDefaultedLoans()
    var
        Loans: Record "Loans Register";
        Vendor: Record Vendor;
        LineNo: integer;
        VBalance: Decimal;
        BATCH_TEMPLATE: code[100];
        BATCH_NAME: code[100];
        DOCUMENT_NO: code[100];
        OutstandingInterest: Decimal;
        OutstandingBalance: Decimal;
    begin

        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'RECOVER';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'RECOVER');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll
        end;

        DOCUMENT_NO := 'RECOVERIES ' + Format(Today);
        Vendor.Reset();
        // Vendor.SetRange(Vendor."No.",'001-012061-3000');
        Vendor.SetFilter(Vendor."Account Type", '103');
        if Vendor.FindSet() then begin

            //Message('Recover%1',VBalance);
            repeat
                VBalance := 0;
                VBalance := AUFactory.FnCalculateAvailableBalance(Vendor."No.");
                // Message('Recover%1', Vendor."No.");
                if VBalance > 0 then begin

                    Loans.Reset();
                    Loans.SetFilter(Loans."Expected Date of Completion", '<%1', Today);
                    Loans.SetAutoCalcFields(Loans."Outstanding Balance");
                    Loans.SetFilter(Loans."Loan Product Type", '%1', 'A03');
                    Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
                    Loans.SetRange(loans."Client Code", Vendor."BOSA Account No");
                    IF Loans.FindSet() then BEGIN
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                            if Loans."Outstanding Interest" > 0 then begin
                                OutstandingInterest := 0;
                                if VBalance > Loans."Outstanding Interest" then
                                    OutstandingInterest := Loans."Outstanding Interest"
                                else
                                    OutstandingInterest := VBalance;

                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingInterest * -1, '', Loans."Loan  No.",
                                'Interest Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                 GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingInterest, ' ', Loans."Loan  No.",
                                 'Interest Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                VBalance := VBalance - OutstandingInterest;
                            end;

                            if VBalance > 0 then begin
                                OutstandingBalance := 0;
                                if VBalance > Loans."Outstanding Balance" then
                                    OutstandingBalance := Loans."Outstanding Balance"
                                else
                                    OutstandingBalance := VBalance;

                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingBalance * -1, '', Loans."Loan  No.",
                                'Loan Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                 GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingBalance, ' ', Loans."Loan  No.",
                                 'Loan Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                VBalance := VBalance - OutstandingInterest;
                            end;



                        until Loans.Next() = 0;
                    end;
                end;

            until Vendor.Next() = 0;
            // GenJournalLine.Reset;
            //  GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            // GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            //  if GenJournalLine.Find('-') then begin
            //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            //  end;
        END;
    end;



    procedure SweepAllDefaultedLoansInd(ClientCode: Code[40])
    var
        Loans: Record "Loans Register";
        Vendor: Record Vendor;
        LineNo: integer;
        VBalance: Decimal;
        BATCH_TEMPLATE: code[100];
        BATCH_NAME: code[100];
        DOCUMENT_NO: code[100];
        OutstandingInterest: Decimal;
        OutstandingBalance: Decimal;
        TotalRepay: Decimal;
    begin

        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'RECOVER';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'RECOVER');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll
        end;

        DOCUMENT_NO := 'RECOVERIES ' + Format(Today);
        Vendor.Reset();
        Vendor.SetRange(Vendor."BOSA Account No", ClientCode);
        Vendor.SetFilter(Vendor."Account Type", '103');
        if Vendor.FindSet() then begin

            //Message('Recover%1',VBalance);
            repeat
                VBalance := 0;
                VBalance := AUFactory.FnCalculateAvailableBalance(Vendor."No.");
                // Message('Recover%1', Vendor."No.");
                if VBalance > 0 then begin

                    Loans.Reset();
                    Loans.SetFilter(Loans."Expected Date of Completion", '<%1', Today);
                    Loans.SetAutoCalcFields(Loans."Outstanding Balance");
                    Loans.SetFilter("Loan Product Type", '%1|%2', 'A03', 'M_OD');
                    Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
                    Loans.SetRange(loans."Client Code", Vendor."BOSA Account No");
                    IF Loans.FindSet() then BEGIN
                        repeat
                            TotalRepay := 0;
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                            if Loans."Outstanding Interest" > 0 then begin
                                OutstandingInterest := 0;
                                if VBalance > Loans."Outstanding Interest" then
                                    OutstandingInterest := Loans."Outstanding Interest"
                                else
                                    OutstandingInterest := VBalance;

                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingInterest * -1, '', Loans."Loan  No.",
                                'Interest Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                 GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingInterest, ' ', Loans."Loan  No.",
                                 'Interest Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                VBalance := VBalance - OutstandingInterest;
                                TotalRepay += OutstandingInterest;
                            end;

                            if VBalance > 0 then begin
                                OutstandingBalance := 0;
                                if VBalance > Loans."Outstanding Balance" then
                                    OutstandingBalance := Loans."Outstanding Balance"
                                else
                                    OutstandingBalance := VBalance;

                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingBalance * -1, '', Loans."Loan  No.",
                                'Loan Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                 GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingBalance, ' ', Loans."Loan  No.",
                                 'Loan Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                                VBalance := VBalance - OutstandingBalance;
                                TotalRepay += OutstandingBalance;
                            end;

                            Members.Reset();
                            Members.SetRange(Members."No.", Loans."Client Code");
                            if Members.FindFirst() then begin
                                CreationMessage := 'Dear ' + NameStyle.NameStyle(loans."Client Code") + ', Ksh ' + Format(TotalRepay) + ' has been deducted to repay your defaulted ' + Loans."Loan Product Type Name" + '. Thank you for Banking With Us.';
                                smsManagement.SendSmsWithID(Source::LOAN_DEFAULTED, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                            end;

                        until Loans.Next() = 0;
                    end;
                end;
            until Vendor.Next() = 0;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
        END;
    end;



    procedure SweepDefaultedLoansIndividual(AccNo: Code[40])
    var
        Loans: Record "Loans Register";
        Vendor: Record Vendor;
        LineNo: integer;
        VBalance: Decimal;
        BATCH_TEMPLATE: code[100];
        BATCH_NAME: code[100];
        DOCUMENT_NO: code[100];
        OutstandingInterest: Decimal;
        OutstandingBalance: Decimal;
    begin
        VBalance := 0;
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'RECOVER';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'RECOVER');
        if GenJournalLine.Find('-') then begin
            GenJournalLine.DeleteAll
        end;

        DOCUMENT_NO := 'RECOVER' + Loans."Loan  No.";
        Vendor.Reset();
        Vendor.SetRange(Vendor."No.", AccNo);
        Vendor.SetFilter(Vendor."Account Type", '103');
        if Vendor.FindFirst() then begin
            VBalance := AUFactory.FnCalculateAvailableBalance(Vendor."No.");
            if VBalance > 0 then begin
                Loans.Reset();
                Loans.SetFilter(Loans."Expected Date of Completion", '<%1', Today);
                Loans.SetAutoCalcFields(Loans."Outstanding Balance");
                Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
                Loans.SetRange(loans."Client Code", Vendor."BOSA Account No");
                IF Loans.FindFirst() then BEGIN
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                        if Loans."Outstanding Interest" > 0 then begin
                            OutstandingInterest := 0;
                            if VBalance > Loans."Outstanding Interest" then
                                OutstandingInterest := Loans."Outstanding Interest"
                            else
                                OutstandingInterest := VBalance;

                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                            GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingInterest * -1, '', Loans."Loan  No.",
                            'Interest Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                            //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                            //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                             GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingInterest, ' ', Loans."Loan  No.",
                             'Interest Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                            VBalance := VBalance - OutstandingInterest;
                        end;

                        if VBalance > 0 then begin
                            if VBalance > Loans."Outstanding Balance" then
                                OutstandingBalance := Loans."Outstanding Balance"
                            else
                                OutstandingBalance := VBalance;

                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."Account Type"::Customer, Loans."Client Code", today, OutstandingBalance * -1, '', Loans."Loan  No.",
                            'Loan Repayment - ' + Loans."Loan Product Type Name", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                            //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                            //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                             GenJournalLine."Account Type"::Vendor, Loans."Account No", today, OutstandingBalance, ' ', Loans."Loan  No.",
                             'Loan Repayment -  ' + Loans."Loan Product Type Name" + ' - ' + Loans."Loan  No.", Loans."Loan  No.", GenJournalLine."Application Source"::" ");
                            VBalance := VBalance - OutstandingInterest;
                        end;



                    until Loans.Next() = 0;
                end;
            end;
            /*             GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        end; */
        END;
    end;



    procedure PostUnpostedMobile()
    var
        MobileTrans: Record "MOBILE MPESA Trans";
        LineNo: Integer;
        BATCH_TEMPLATE: Code[60];
        BATCH_NAME: Code[80];
        DOCUMENT_NO: Code[40];
        SFactory: Codeunit "SURESTEP FactoryMobile";
        Customer: Record Customer;
        Paybill: Codeunit "AU Paybill Automations";

    begin

        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'RECOVERY';
        GenJournalLine.Reset();
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll();
        end;
        MobileTrans.Reset();
        MobileTrans.SetRange(MobileTrans."Transaction Found", false);
        MobileTrans.SetFilter(MobileTrans."Document Date", '%1..%2', 20240611D, 20240614D);
        MobileTrans.SetRange(MobileTrans."Transaction Type", 'Withdrawal');
        if MobileTrans.FindSet() then begin
            repeat
                DOCUMENT_NO := '';
                DOCUMENT_NO := MobileTrans.Trace;
                ChargeAmount := 0;

                GraduatedCharge.Reset;
                if GraduatedCharge.Find('-') then begin
                    repeat
                        if (MobileTrans.Amount >= GraduatedCharge."Min Band") and (MobileTrans.Amount <= GraduatedCharge."Upper Band") then begin
                            VendorComm := 0;
                            ChargeAmount := 0;
                            ExciseDuty := 0;
                            MpesaComm := 0;
                            TotalAmount := 0;
                            ChargeAmount := GraduatedCharge.Total;
                            VendorComm := GraduatedCharge."Vendor Comm";
                            SaccoCommission := GraduatedCharge."Sacco Comm";
                            MpesaComm := GraduatedCharge.Mpesa;
                            ExciseDuty := GraduatedCharge."Excise Duty";
                            TotalAmount := GraduatedCharge.Total;
                            MpesaCommAccount := GraduatedCharge."Mpesa Account";
                            VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                            SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                        end;
                    until GraduatedCharge.Next = 0;
                end;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, MobileTrans."Account No", MobileTrans."Document Date", MobileTrans.Amount, 'FOSA', DOCUMENT_NO,
                 'Mobile Transaction' + ' ' + MobileTrans.Trace, '');


                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", 'BNK00013', MobileTrans."Document Date", -MobileTrans.Amount, 'FOSA', DOCUMENT_NO,
                 'Mobile Transaction' + ' ' + MobileTrans.Trace, '');



                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, MobileTrans."Account No", MobileTrans."Document Date", TotalAmount, 'FOSA', DOCUMENT_NO,
                 'Mobile charges' + ' ' + MobileTrans.Trace, '');//


                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", 'BNK00013', MobileTrans."Document Date", MpesaComm * -1, 'FOSA', DOCUMENT_NO,
                 'Mobile Trans Mpesa' + ' ' + MobileTrans.Trace, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, VendorCommAccount, MobileTrans."Document Date", VendorComm * -1, 'FOSA', DOCUMENT_NO,
                 'Mobile Trans Mpesa Comm' + ' ' + MobileTrans.Trace, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, MobileTrans."Document Date", SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
                 'Mobile Trans Mpesa Comm' + ' ' + MobileTrans.Trace, '');

                SaccoGen.Get();
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", MobileTrans."Document Date", ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
                 'Excise Duty Mpesa Comm' + ' ' + MobileTrans.Trace, '');


                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                end;

            until MobileTrans.Next() = 0;
        end;
    end;

    var
        AUFactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
        ChargeAmount: Decimal;
        GraduatedCharge: Record "MPESA  Withdrawal";
        GraduatedCharges: Record "Airtime Purchase Charges";
        GraduatedChargeB: Record "External Transfer Charges";
        MpesaComm: Decimal;
        SaccoCommission: Decimal;
        NameStyle: Codeunit "Send Birthday SMS";
        VendorComm: Decimal;
        ExciseDuty: Decimal;
        TotalAmount: Decimal;
        SaccoGen: Record "Sacco General Set-Up";
        Category: Text;
        VendorCommAccount: Code[20];
        ExciseDutyAccount: Code[20];
        TotalAmountAccount: Code[20];
        SaccoCommissionAccount: Code[20];

        Members: Record Customer;
        MpesaCommAccount: Code[20];
        smsManagement: Codeunit "Sms Management";
        CreationMessage: Text[2500];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
}
