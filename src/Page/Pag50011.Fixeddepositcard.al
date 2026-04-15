page 50011 "Fixed deposit card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Fixed Deposit";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("FD No"; Rec."FD No")
                {
                }
                field("Account No"; rec."Account No")
                {
                    //Editable = LinesEditable;
                }
                field("Account Name"; rec."Account Name")
                {
                    Editable = false;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    // Editable = false;
                }
                field("ID NO"; rec."ID NO")
                {
                    Editable = false;
                }
                field(Amount; rec.Amount)
                {
                    // Editable = LinesEditable;
                    ShowMandatory = true;
                }
                field("Fd Duration"; rec."Fd Duration")
                {
                    // Editable = LinesEditable;
                    Caption = 'FD Code';
                }
                field(Duration; Rec.Duration)
                {
                    Editable = LinesEditable;
                }
                field("Upon Maturity"; Rec."Upon Maturity")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    Editable = false;
                }
                field("Interest Earned"; rec."Interest Earned")
                {
                    Editable = false;
                }
                field("Withholding Tax"; rec."Withholding Tax")
                {
                    Editable = false;
                }
                field(interestLessTax; rec.interestLessTax)
                {
                    Caption = 'Interest Less Tax';
                    Editable = false;
                }
                field("Amount After maturity"; rec."Amount After maturity")
                {
                    Editable = false;
                }
                field("Creted by"; rec."Created by")
                {
                    Caption = 'Created by';
                    Editable = false;
                }
                field(Date; rec.Date)
                {
                    Caption = 'Fixing Date';
                    // Editable = false;
                }
                field(MaturityDate; rec.MaturityDate)
                {
                    Editable = false;
                }
                field(Fixed; rec.Fixed)
                {
                    Editable = false;
                }
                field("Fixed By"; rec."Fixed By")
                {
                }
                field("Fixed Date"; rec."Fixed Date")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action("Transfer From BANK")
            {
                Enabled = FosaTransEnabled;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //if rec."Upon Maturity" = rec."Upon Maturity"::" " then Error('Select an option for upon maturity.');
                    IF rec.Credited = TRUE THEN begin
                        ERROR('This account has already been credited');
                    end;
                    IF CONFIRM('Are you sure you want to transfer funds from Ordinary Savings Account?', TRUE, FALSE) = false THEN Exit;

                    batchTemplate := 'GENERAL';
                    batchName := 'FXDEP';
                    docNo := rec."FD No";

                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                    GenJournalLine.DELETEALL;

                    DefaultBatch.Reset();
                    DefaultBatch.SetRange("Journal Template Name", 'GENERAL');
                    DefaultBatch.SetRange(Name, 'FXDEP');
                    if DefaultBatch.Find('-') = false then begin
                        DefaultBatch.Init();
                        DefaultBatch."Journal Template Name" := 'GENERAL';
                        DefaultBatch.Name := 'FXDEP';
                        DefaultBatch.Description := 'Fixed Deposit Process Transactions';
                        DefaultBatch.Insert();
                    end;


                    AccP.RESET;
                    AccP.SETRANGE(AccP."No.", rec."Account No");
                    // AccP.SETFILTER(AccP."Account Type", '108');
                    IF AccP.FIND('-') THEN BEGIN
                        fixedno := AccP."No.";

                        //Credit FOSA A/C
                        LineNo := LineNo + 10000;
                        AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account",
                        rec."Bank Account", Today, rec.Amount, '', 'Transfer from bank to Debenture-' + rec."Account Name", '');

                        //Debit FD A/C
                        LineNo := LineNo + 10000;
                        AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                        fixedno, Today, rec.Amount * -1, '', 'Transfer from bank to Debenture-' + rec."Account Name", '');

                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        END;

                        rec."FD Certificate No" := rec."FD No" + '-' + AccP."ID No.";
                        rec.Fixed := TRUE;
                        rec."Fixed Date" := TODAY;
                        rec."Fixed By" := USERID;
                        rec.MODIFY();

                        if rec."Account No" <> '' then begin
                            fdMsg := 'Dear ' + Rec."Account Name" + '. Your Debenture of Ksh.' + Format(rec.Amount) + ' has been processed for a duration of ' + Format(rec.Duration) + ' months. Thank you for your patronage.';
                            //  smsManagement.SendSmsWithID(Source::FIXED_DEPOSIT, AccP."Mobile Phone No", fdMsg, AccP."BOSA Account No", rec."Account No", true, 240, true, 'CBS', CreateGuid(),'CBS');
                        end;

                        //Send Email

                        //Create Audit Entry
                        IF Trail.FINDLAST THEN BEGIN
                            EntryNo := Trail.EntryNo + 1;
                        END ELSE BEGIN
                            EntryNo := 1;
                        END;

                        AuditTrail.FnInsertAuditRecords(Format(EntryNo) + USERID, 'Debenture Fixing', rec.Amount,
                        'DEBENTURES', TODAY, TIME, '', rec."FD No", rec."Account No", '');
                        //End Create Audit Entry
                        COMMIT;

                        FixedR.RESET;
                        FixedR.SETRANGE(FixedR."FD No", rec."FD No");
                        IF FixedR.FINDFIRST THEN BEGIN
                            // REPORT.RUN(175081, TRUE, TRUE, FixedR)
                        END;

                        FnInsertFDPlacement(Rec);
                    END;
                end;
            }
            action("Transfer Interest")
            {
                Enabled = MaturedEnabled;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Visible = false;//Kit
                trigger OnAction()
                begin
                    //credit savings
                    IF rec.Credited = TRUE THEN
                        ERROR('This account has already been credited');
  /*                   IF TODAY < rec.MaturityDate THEN
                        ERROR('This fixed deposit has not matured yet.'); */
                    IF CONFIRM('Are you sure you want to transfer funds to Debenture Account?', TRUE, FALSE) = TRUE THEN BEGIN

                        batchTemplate := 'GENERAL';
                        batchName := 'FXDEP';
                        docNo := rec."FD No";

                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                        GenJournalLine.DELETEALL;

                        saccoGen.Get();

                        AccP.RESET;
                        AccP.SETRANGE(AccP."No.", rec."Account No");
                        //  AccP.SETFILTER(AccP."Account Type", '108');
                        IF AccP.FIND('-') THEN BEGIN
                            fixedno := AccP."No.";

                            //Debit Interest Earned to Interest Expense A/C
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                            saccoGen."FD Interest A/C", Today, rec."Interest Earned", '', 'Matured Interest to debenture Account-' + rec."Account Name", '');


                            //Credit FD A/C
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                            fixedno, Today, (-rec."Interest Earned"), '', 'Matured Interest to debenture Account' + rec."Account Name", '');


                            //Credit FOSA A/C Withholding Tax
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                            rec."Account No", Today, (rec."Withholding Tax"), '', 'Withholding Tax on Debenture-' + rec."Account Name", '');

                            //Debit Withholding Tax A/C 
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                            saccoGen."WithHolding Tax Account", Today, (rec."Withholding Tax") * -1, '', 'Withholding Tax on Debenture-' + rec."Account Name", '');

                            rec.Credited := TRUE;
                            rec."Posted Date" := TODAY;
                            rec."Posted By" := USERID;
                            rec.Posted := TRUE;
                            rec.MODIFY;

                            fdPlacement.Reset();
                            fdPlacement.SetRange("Fixed Deposit No.", Rec."FD No");
                            fdPlacement.SetRange("Account to Tranfers FD Amount", rec."Account No");
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




                            //Post New
                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                            GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                            IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            END;

                            if rec."Account No" <> '' then begin
                                fdMsg := 'Dear ' + Rec."Account Name" + '. Your Fixed Deposit of Ksh.' + Format(rec.Amount) + ' has matured and posted to your FOSA A/C. Thank you for your patronage.';
                               // smsManagement.SendSmsWithID(Source::FIXED_DEPOSIT_MATURITY, AccP."Mobile Phone No", fdMsg, AccP."BOSA Account No", rec."Account No", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                            end;
                        END;
                    END;
                end;
            }
            action("Terminate Fixed Deposit")
            {
                Enabled = (not MaturedEnabled) and (CreditEnabled);
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //credit savings
                    IF rec.Posted = TRUE THEN
                        ERROR('This account has already been credited');
                    if rec.Revoked = true then begin
                        Error('This FD has already been terminated.');
                    end;
                    IF TODAY >= rec.MaturityDate THEN
                        ERROR('This fixed deposit has already matured.');
                    IF CONFIRM('Are you sure you want to terminate this fixed deposit?', TRUE, FALSE) = TRUE THEN BEGIN

                        batchTemplate := 'GENERAL';
                        batchName := 'FXDEP';
                        docNo := rec."FD No";

                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                        GenJournalLine.DELETEALL;

                        AccP.RESET;
                        AccP.SETRANGE(AccP."ID No.", rec."ID NO");
                        AccP.SETFILTER(AccP."Account Type", '108');
                        IF AccP.FIND('-') THEN BEGIN
                            fixedno := AccP."No.";

                            //Credit FD A/C
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                            fixedno, Today, (rec.Amount), 'FOSA', 'FD Termination-' + rec."Account Name", '');

                            //Debit FOSA A/C
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                            rec."Account No", Today, (rec.Amount) * -1, 'FOSA', 'FD Termination-' + rec."Account Name", '');


                            // LineNo := LineNo + 10000;
                            // GenJournalLine.INIT;
                            // GenJournalLine."Journal Template Name" := 'GENERAL';
                            // GenJournalLine."Journal Batch Name" := 'FXDEP';
                            // GenJournalLine."Line No." := LineNo;
                            // GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            // GenJournalLine."Account No." := fixedno;
                            // GenJournalLine."Document No." := rec."FD No";
                            // GenJournalLine."Posting Date" := TODAY;
                            // GenJournalLine.Description := 'Fixed deposit';
                            // GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            // GenJournalLine.Amount := rec.Amount;
                            // GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            // GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            // GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            // IF GenJournalLine.Amount <> 0 THEN
                            //     GenJournalLine.INSERT;

                            // //END credit fixed deposit


                            // //Debit ordinary
                            // LineNo := LineNo + 10000;
                            // GenJournalLine.INIT;
                            // GenJournalLine."Journal Template Name" := 'GENERAL';
                            // GenJournalLine."Journal Batch Name" := 'FXDEP';
                            // GenJournalLine."Line No." := LineNo;
                            // GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            // GenJournalLine."Account No." := rec."Account No";
                            // GenJournalLine."Posting Date" := TODAY;
                            // GenJournalLine."Document No." := rec."FD No";
                            // GenJournalLine.Description := 'Fixed deposit ';
                            // GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            // GenJournalLine.Amount := -rec.Amount;
                            // GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            // GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            // GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            // IF GenJournalLine.Amount <> 0 THEN
                            //     GenJournalLine.INSERT;

                            //end debit ordinary savings

                            //Post New
                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                            GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                            IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            END;
                            rec.Revoked := TRUE;
                            rec."Revoked Date" := TODAY;
                            rec."Revoked By" := USERID;
                            rec.MODIFY();

                            fdPlacement.Reset();
                            fdPlacement.SetRange("Fixed Deposit No.", Rec."FD No");
                            fdPlacement.SetRange("Account to Tranfers FD Amount", rec."Account No");
                            fdPlacement.SetRange(Posted, false);
                            if fdPlacement.Find('-') then begin
                                fdPlacement.Closed := true;
                                fdPlacement."FD Closed By" := UserId;
                                fdPlacement."FD Closed On" := Today;
                                fdPlacement.Modify;
                            end;

                            Message('Terminated Successfully.');
                            CurrPage.Close();
                        END;
                    END;
                end;
            }
        }
        area(Reporting)
        {

            action("Reprint Receipt")
            {
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    FixedR.RESET;
                    FixedR.SETRANGE(FixedR."FD No", rec."FD No");
                    IF FixedR.FINDFIRST THEN BEGIN
                        REPORT.RUN(175081, TRUE, TRUE, FixedR)
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        MaturedEnabled := false;
        FosaTransEnabled := TRUE;
        IF rec.Fixed = TRUE THEN
            FosaTransEnabled := FALSE;

        CreditEnabled := FALSE;
        IF rec.Fixed = TRUE THEN
            CreditEnabled := TRUE;

        if Rec.MaturityDate > Today then begin
            MaturedEnabled := true;
            Rec.matured := true;
            Rec.Modify;
        end;
        if Rec.MaturityDate <= Today then begin
            MaturedEnabled := false;
            Rec.matured := false;
            Rec.Modify;
        end;

        LinesEditable := TRUE;
        IF rec.Fixed = TRUE THEN
            LinesEditable := FALSE;
    end;

    var

        EntryNo: Integer;
        LineNo: Integer;
        Selected: Integer;
        DActivity: Code[20];
        DBranch: Code[20];
        fixedno: Code[30];
        memberno: Code[30];
        batchTemplate: Code[20];
        batchName: Code[20];
        docNo: Code[20];
        fdMsg: Text[1800];
        Options: Text[250];
        Text000: Label '3M,6M,12M';
        Text001: Label 'You selected option %1.';
        Text002: Label 'Choose one of the following Fixed Deposit Durations:';
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT;
        FosaTransEnabled: Boolean;
        CreditEnabled: Boolean;
        MaturedEnabled: Boolean;
        LinesEditable: Boolean;
        AccP: Record 23;
        GenJournalLine: Record 81;
        DefaultBatch: Record 232;
        fd: Record "Fixed Deposit";
        fdPlacement: Record "Fixed Deposit Placement";
        fdType: Record "Fixed Deposit Type";
        FixedR: Record "Fixed Deposit";
        Trail: Record "Audit Trail";
        saccoGen: Record "Sacco General Set-Up";
        AuditTrail: Codeunit "AU Audit Management";
        AUFactory: Codeunit "Au Factory";
        smsManagement: Codeunit "Sms Management";

    local procedure GetFDCode() FDcode: Code[20]
    begin
        Options := Text000;
        Selected := Dialog.StrMenu(Options, 1, Text002);
        if Selected = 1 then begin
            fdType.Reset();
            fdType.SetRange("No. of Months", 3);
            if fdType.Find('-') then begin
                FDcode := fdType.Code;
            end;
        end else if Selected = 2 then begin
            fdType.Reset();
            fdType.SetRange("No. of Months", 6);
            if fdType.Find('-') then begin
                FDcode := fdType.Code;
            end;
        end else if Selected = 3 then begin
            fdType.Reset();
            fdType.SetRange("No. of Months", 12);
            if fdType.Find('-') then begin
                FDcode := fdType.Code;
            end;
        end;
    end;

    local procedure FnInsertFDPlacement(fdTable: Record "Fixed Deposit")
    var
        myInt: Integer;
    begin
        fdPlacement.Reset();
        fdPlacement.Init();
        fdPlacement."Fixed Deposit No." := fdTable."FD No";
        fdPlacement."Member No" := AccP."BOSA Account No";
        //fdPlacement.Validate("Member No");
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
}

