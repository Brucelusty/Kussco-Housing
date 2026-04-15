codeunit 50083 "Fixed-Call Deposit Processing"
{
    trigger OnRun()
    begin

    end;

    procedure FnRunFDMaturityInstructions()
    var
        myInt: Integer;
    begin
        fixedD.Reset();
        fixedD.SetFilter(MaturityDate, '<=%1', Today);
        fixedD.SetRange(Credited, false);
        if fixedD.FindSet() then begin
            repeat

            batchTemplate := 'GENERAL';
            batchName := 'FXDEP';
            docNo := fixedD."FD No";

            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
            GenJournalLine.DELETEALL;

            saccoGen.Get();

            vend.RESET;
            vend.SETRANGE("ID No.", fixedD."ID NO");
            vend.SETFILTER("Account Type", '108');
            IF vend.FIND('-') THEN BEGIN
                fixedno := vend."No.";
                
                //Credit FD Interest A/C
                LineNo := LineNo + 10000;
                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", 
                saccoGen."FD Interest A/C", Today, fixedD."Interest Earned" , 'FOSA', 'Matured Interest to FD - '+fixedD."Account Name", '');

                //Debit FD A/C
                LineNo := LineNo + 10000;
                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                fixedno, Today, fixedD."Interest Earned"*-1, 'FOSA', 'Matured Interest to FD - '+fixedD."Account Name", '');

                if fixedD."Upon Maturity" = fixedD."Upon Maturity"::"Close the FXD against the Account"  then begin

                    //Credit FD A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedno, Today, (fixedD.Amount + fixedD."Interest Earned"), 'FOSA', 'Transfer from FD to FOSA - '+fixedD."Account Name", '');

                    //Debit FOSA A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedD."Account No", Today, (fixedD.Amount + fixedD."Interest Earned") *-1, 'FOSA', 'Transfer from FD to FOSA - '+fixedD."Account Name", '');
                    
                    //Credit FOSA A/C Withholding Tax
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedD."Account No", Today, (fixedD."Withholding Tax"), 'FOSA', 'Withholding Tax on FD - '+fixedD."Account Name", '');
                    
                    //Debit Withholding Tax A/C 
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", 
                    saccoGen."WithHolding Tax Account", Today,(fixedD."Withholding Tax") *-1, 'FOSA', 'Withholding Tax on FD - '+fixedD."Account Name", '');

                    fixedD.Credited := TRUE;
                    fixedD."Posted Date" := TODAY;
                    fixedD."Posted By" := USERID;
                    fixedD.Posted := TRUE;
                    fixedD.MODIFY;
                    
                    fdPlacement.Reset();
                    fdPlacement.SetRange("Fixed Deposit No.", fixedD."FD No");
                    fdPlacement.SetRange("Account to Tranfers FD Amount", fixedD."Account No");
                    fdPlacement.SetRange(Posted, false);
                    if fdPlacement.Find('-') then begin
                        fdPlacement.Closed := true;
                        fdPlacement."FD Closed By" := UserId;
                        fdPlacement."FD Closed On" := Today;
                        
                        fdPlacement.Posted := true;
                        fdPlacement."Posted By" := UserId;
                        fdPlacement."Posted On" := Today;
                        fdPlacement.Modify;
                    end;
                    
                    if fixedD."Account No" <> '' then begin
                        fdMsg:= 'Dear '+fixedD."Account Name"+'. Your Fixed Deposit of Ksh.'+Format(fixedD.Amount)+' has matured and posted to your FOSA A/C. Thank you for your patronage.';
                        smsManagement.SendSmsWithID(Source::FIXED_DEPOSIT_MATURITY, vend."Mobile Phone No", fdMsg, vend."BOSA Account No", fixedD."Account No", true, 240, true, 'CBS', CreateGuid(),'CBS');
                    end;

                end else if fixedD."Upon Maturity" = fixedD."Upon Maturity"::"Roll-over the FXD and refix the Principal"  then begin

                    //Credit FD A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedno, Today,(fixedD.Amount + fixedD."Interest Earned"), 'FOSA', 'Matured Fixed Deposit from FD to FOSA-'+fixedD."Account Name", '');

                    //Debit FOSA A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedD."Account No", Today, (fixedD.Amount + fixedD."Interest Earned") *-1, 'FOSA', 'Matured Fixed Deposit from FD to FOSA-'+fixedD."Account Name", '');
                    
                    //Credit FOSA A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedD."Account No", Today,(fixedD."Withholding Tax"), 'FOSA', 'Withholding Tax on FD Interest-'+fixedD."Account Name", '');

                    //Debit Withholding Tax A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", 
                    saccoGen."WithHolding Tax Account", Today, (fixedD."Withholding Tax") *-1, 'FOSA', 'Withholding Tax on FD Interest-'+fixedD."Account Name", '');

                    fdPlacement.Reset();
                    fdPlacement.SetRange("Fixed Deposit No.", fixedD."FD No");
                    fdPlacement.SetRange("Account to Tranfers FD Amount", fixedD."Account No");
                    fdPlacement.SetRange(Posted, false);
                    if fdPlacement.Find('-') then begin
                        fdPlacement.Posted := true;
                        fdPlacement."Posted By" := UserId;
                        fdPlacement."Posted On" := Today;
                        fdPlacement.Modify;
                    end;
                    
                    if fixedD."Account No" <> '' then begin
                        fdMsg:= 'Dear '+fixedD."Account Name"+'. Your Fixed Deposit of Ksh.'+Format(fixedD.Amount)+' has matured and posted to your FOSA A/C. Thank you for your patronage.';
                        smsManagement.SendSmsWithID(Source::FIXED_DEPOSIT_MATURITY, vend."Mobile Phone No", fdMsg, vend."BOSA Account No", fixedD."Account No", true, 240, true, 'CBS', CreateGuid(),'CBS');
                    end;

                    //Refixing of Matured Principal
                    //Credit FD A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedD."Account No", Today,(fixedD.Amount), 'FOSA', 'Refixing Matured Fixed Deposit Principal from FOSA to FD - '+fixedD."Account Name", '');

                    //Debit FOSA A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedno, Today, (fixedD.Amount) *-1, 'FOSA', 'Refixing Matured Fixed Deposit Principal from FOSA to FD - '+fixedD."Account Name", '');

                    fd.Reset();
                    fd.SetRange("FD No", fixedD."FD No");
                    fd.SetRange("Account No", fixedD."Account No");
                    if fd.Find('-') then begin
                        fd.Fixed:= true;
                        fd."Fixed Date" := Today;
                        fd.matured := false;
                        fd.MaturityDate := 0D;
                        fd.Credited:= false;
                        fd.Posted := false;
                        fd."Posted By" := '';
                        fd."Posted Date" := 0D;
                        fd."posted time" := 0T;

                        fd.Modify(true);

                        FnInsertFDPlacement(fd);
                    end;
                    
                    if fixedD."Account No" <> '' then begin
                        fdMsg:= 'Dear '+fixedD."Account Name"+'. Your Fixed Deposit of Ksh.'+Format(fixedD.Amount)+' has been processed for a duration of '+Format(fixedD.Duration)+' months. Thank you for your patronage.';
                        smsManagement.SendSmsWithID(Source::FIXED_DEPOSIT, vend."Mobile Phone No", fdMsg, vend."BOSA Account No", fixedD."Account No", true, 240, true, 'CBS', CreateGuid(),'CBS');
                    end;

                end else if fixedD."Upon Maturity" = fixedD."Upon Maturity"::"Roll-over the FXD and refix the Principal and Interest"  then begin

                    //Credit FD A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedno, Today,(fixedD.Amount + fixedD."Interest Earned"), 'FOSA', 'Matured Fixed Deposit from FD to FOSA-'+fixedD."Account Name", '');

                    //Debit FOSA A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedD."Account No", Today, (fixedD.Amount + fixedD."Interest Earned") *-1, 'FOSA', 'Matured Fixed Deposit from FD to FOSA-'+fixedD."Account Name", '');
                    
                    //Credit FOSA A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedD."Account No", Today,(fixedD."Withholding Tax"), 'FOSA', 'Withholding Tax on FD Interest-'+fixedD."Account Name", '');

                    //Debit Withholding Tax A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", 
                    saccoGen."WithHolding Tax Account", Today, (fixedD."Withholding Tax") *-1, 'FOSA', 'Withholding Tax on FD Interest-'+fixedD."Account Name", '');

                    fdPlacement.Reset();
                    fdPlacement.SetRange("Fixed Deposit No.", fixedD."FD No");
                    fdPlacement.SetRange("Account to Tranfers FD Amount", fixedD."Account No");
                    fdPlacement.SetRange(Posted, false);
                    if fdPlacement.Find('-') then begin
                        fdPlacement.Posted := true;
                        fdPlacement."Posted By" := UserId;
                        fdPlacement."Posted On" := Today;
                        fdPlacement.Modify;
                    end;
                    
                    //Refixing of Matured Principal + Intrest Less Tax
                    //Credit FD A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedD."Account No", Today,(fixedD.Amount + fixedD.interestLessTax), 'FOSA', 'Refixing Matured Fixed Deposit Principal + Net Interest from FOSA to FD - '+fixedD."Account Name", '');

                    //Debit FOSA A/C
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                    fixedno, Today, (fixedD.Amount + fixedD.interestLessTax) *-1, 'FOSA', 'Refixing Matured Fixed Deposit Principal + Interes from FOSA to FD - '+fixedD."Account Name", '');

                    fd.Reset();
                    fd.SetRange("FD No", fixedD."FD No");
                    fd.SetRange("Account No", fixedD."Account No");
                    if fd.Find('-') then begin
                        fd.Fixed:= true;
                        fd."Fixed Date" := Today;
                        fd.matured := false;
                        fd.MaturityDate := 0D;
                        fd.Credited:= false;
                        fd.Posted := false;
                        fd."Posted By" := '';
                        fd."Posted Date" := 0D;
                        fd."posted time" := 0T;

                        fd.Amount := fixedD.Amount + fixedD.interestLessTax;
                        fd.Validate("Fd Duration");
                        fd.Modify(true);

                        FnInsertFDPlacement(fd);
                    end;

                end;
            END;
            until fixedD.Next() = 0;
            //Post New
            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
            IF GenJournalLine.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
            END;
        end;
    end;

    local procedure FnInsertFDPlacement(fdTable: Record "Fixed Deposit")
    var
        myInt: Integer;
    begin
        fdPlacement.Reset();
        fdPlacement.Init();
        fdPlacement."Fixed Deposit No." := fdTable."FD No";
        fdPlacement."Member No" := vend."BOSA Account No";
        fdPlacement.Validate("Member No");
        fdPlacement."Fixed Deposit Account No" := fixedno;
        fdPlacement."Account to Tranfers FD Amount" := fdTable."Account No";
        fdPlacement."Amount to Fix" := fdTable.Amount;
        fdPlacement."Fixed Deposit Start Date" := fdTable.Date;
        fdPlacement."Fixed Duration" := fdTable.Duration;
        fdPlacement."Application Date" := fdTable.Date;
        fdPlacement."FD Interest Rate" := fdTable."Interest Rate";
        fdPlacement."Created On" := Today;
        fdPlacement."Created By" := UserId;
        fdPlacement."Date Effected" := Today;
        fdPlacement."Fixed Deposit Type" := fdTable."Fd Duration";
        fdPlacement."Expected Interest Earned" := fdTable."Interest Earned";
        fdPlacement."Expected Tax After Term Period" := fdTable."Withholding Tax";
        fdPlacement."Expected Net After Term Period" := fdTable."Amount After maturity";
        fdPlacement."FD Maturity Date" := fdTable.MaturityDate;
        fdPlacement."Maturity Instructions" := fdTable."Upon Maturity";
        fdPlacement.Effected := true;
        fdPlacement."Effected By" := UserId;
        fdPlacement."Date Effected" := Today;
        fdPlacement.Insert(True);
    end;

    var
        AUFactory: Codeunit "Au Factory";
        smsManagement: Codeunit "Sms Management";
        GenJournalLine: Record "Gen. Journal Line";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY,MEMBER_ALLOWANCES,DIVIDEND_PROCESSING;
        vend: Record Vendor;
        fixedD: Record "Fixed Deposit";
        callD: Record "Fixed Deposit";
        fd: Record "Fixed Deposit";
        fdPlacement: Record "Fixed Deposit Placement";
        fdType: Record "Fixed Deposit Type";
        FixedR: Record "Fixed Deposit";
        Trail: Record "Audit Trail";
        saccoGen: Record "Sacco General Set-Up";
        LineNo: Integer;
        fixedno: Code[30];
        fdMsg: Text[1800];
        memberno: Code[30];
        batchTemplate: Code[20];
        batchName: Code[20];
        docNo: Code[20];
    }
