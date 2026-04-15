page 50051 "Call Deposit Card"
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
                    Caption = 'Call No.';
                }
                field(Call;Rec.Call)
                {
                    ShowMandatory = true;
                }
                field("Account No"; rec."Account No")
                {
                    Editable = LinesEditable;
                }
                field("Account Name"; rec."Account Name")
                {
                    Editable = false;
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
                field("Interest Rate"; Rec."Interest Rate")
                {
                    Editable=false;
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
            action("Transfer From FOSA")
            {
                Enabled = FosaTransEnabled;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
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
                        DefaultBatch.Description := 'Transfer from FOSA to FD';
                        DefaultBatch.Insert();
                    end;


                    AccP.RESET;
                    AccP.SETRANGE(AccP."ID No.", rec."ID NO");
                    AccP.SETFILTER(AccP."Account Type", '108');
                    IF AccP.FIND('-') THEN BEGIN
                        fixedno := AccP."No.";

                        //Credit FOSA A/C
                        LineNo := LineNo + 10000;
                        AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                        rec."Account No", Today, rec.Amount, 'FOSA', 'Transfer Call Deposit from FOSA to FD-'+rec."Account Name", '');

                        //Debit FD A/C
                        LineNo := LineNo + 10000;
                        AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                        fixedno, Today, rec.Amount *-1, 'FOSA', 'Transfer Call Deposit from FOSA to FD-'+rec."Account Name", '');

                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        END;

                        rec."FD Certificate No" := rec."FD No" +'-'+AccP."ID No.";
                        rec.Fixed := TRUE;
                        rec."Fixed Date" := TODAY;
                        rec."Fixed By" := USERID;
                        rec.MODIFY();


                        //Create Audit Entry
                        IF Trail.FINDLAST THEN BEGIN
                            EntryNo := Trail.EntryNo + 1;
                        END ELSE BEGIN
                            EntryNo := 1;
                        END;

                        AuditTrail.FnInsertAuditRecords(Format(EntryNo) + USERID, 'Call Fixing', rec.Amount,
                        'CALL DEPOSIT', TODAY, TIME, '', rec."FD No", rec."Account No", '');
                        //End Create Audit Entry
                        COMMIT;
                    END;
                end;
            }
            action("Transfer Fixed To FOSA")
            {
                Enabled = MaturedEnabled;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    saccoGen.Get();
                    IF rec.Credited = TRUE THEN
                        ERROR('This account has already been credited');
                    IF CONFIRM('Are you sure you want to transfer funds to Ordinary Savings Account?', TRUE, FALSE) = TRUE THEN BEGIN

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
                            if (CalcDate(saccoGen."Min Call Days to Earn Interest", rec."Fixed Date")>Today) then begin
                                if Confirm('This call deposit is yet to reach the minimum no. of days to earn interest. Do you wish to proceed?', true)= false then exit;
                                
                                //Credit FD A/C
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                                fixedno, Today, (rec.Amount), 'FOSA', 'Transfer Early Call Deposit from FD to FOSA-'+rec."Account Name", '');

                                //Debit FOSA A/C
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                                rec."Account No", Today, (rec.Amount) *-1, 'FOSA', 'Transfer Early Call Deposit from FD to FOSA-'+rec."Account Name", '');
                                
                                rec.Credited := TRUE;
                                rec."Posted Date" := TODAY;
                                rec."Posted By" := USERID;
                                rec.Posted := TRUE;
                                rec.MODIFY;
                            end else begin
                                months:= 0;
                                months:= Round((Today - (CalcDate(saccoGen."Min Call Days to Earn Interest", rec."Fixed Date")))/30,1,'<');
                                rec."Interest Rate" := CalcCallInterest(months, rec.Amount);
                                rec."Interest Earned" := ((rec.Amount*(rec."Interest Rate"/100))* months/12);
                                rec."Withholding Tax" := rec."Interest Earned" * 0.15;
                                rec.interestLessTax := rec."Interest Earned" * 0.85;
                                //Credit FD Interest A/C
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", 
                                saccoGen."FD Interest A/C", Today, rec."Interest Earned" , 'FOSA', 'Matured Intereston Call Deposit to FD-'+rec."Account Name", '');

                                //Debit FD A/C
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                                fixedno, Today, rec."Interest Earned"*-1, 'FOSA', 'Matured Interest on Call Deposit to FD-'+rec."Account Name", '');

                                //Credit FD A/C
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                                fixedno, Today, (rec.Amount + rec."Interest Earned"), 'FOSA', 'Transfer Call Deposit from FD to FOSA-'+rec."Account Name", '');

                                //Debit FOSA A/C
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                                rec."Account No", Today, (rec.Amount + rec."Interest Earned") *-1, 'FOSA', 'Transfer Call Deposit from FD to FOSA-'+rec."Account Name", '');
                                
                                //Credit FOSA A/C
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                                rec."Account No", Today, (rec."Withholding Tax"), 'FOSA', 'Transfer Call Deposit Interest from FOSA-'+rec."Account Name", '');

                                //Debit Tax A/C
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", 
                                saccoGen."WithHolding Tax Account", Today, (rec."Withholding Tax") *-1, 'FOSA', 'Transfer Call Deposit Interest from FOSA-'+rec."Account Name", '');
                            end;
                            //Post New
                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                            GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                            IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            END;
                            
                            rec.MaturityDate := Today;
                            rec.Credited := TRUE;
                            rec.Posted := true;
                            rec."Posted By" := UserId;
                            rec."Posted Date" := Today;
                            rec."posted time" := Time;
                            rec.modify;

                            FixedR.RESET;
                            FixedR.SETRANGE(FixedR."FD No", rec."FD No");
                            IF FixedR.FINDFIRST THEN BEGIN
                                REPORT.RUN(175081, TRUE, TRUE, FixedR)
                            END;
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
                Visible = false;

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
                            fixedno, Today, (rec.Amount) , 'FOSA', 'FD Termination-'+rec."Account Name", '');

                            //Debit FOSA A/C
                            LineNo := LineNo + 10000;
                            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor, 
                            rec."Account No", Today, (rec.Amount)*-1, 'FOSA', 'FD Termination-'+rec."Account Name", '');


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

        if rec.matured = true then begin
            MaturedEnabled := true;
        end;
        LinesEditable := TRUE;
        IF rec.Fixed = TRUE THEN
            LinesEditable := FALSE;
    end;

    var
    
    EntryNo: Integer;
    LineNo: Integer;
    Selected: Integer;
    months: Integer;
    DActivity: Code[20];
    DBranch: Code[20];
    fixedno: Code[30];
    batchTemplate: Code[20];
    batchName: Code[20];
    docNo: Code[20];
    Options: Text[250];
    Text000: Label '3M,6M,12M';
    Text001: Label 'You selected option %1.';
    Text002: Label 'Choose one of the following Fixed Deposit Durations:';
    FosaTransEnabled: Boolean;
    CreditEnabled: Boolean;
    MaturedEnabled: Boolean;
    LinesEditable: Boolean;
    AccP: Record 23;
    GenJournalLine: Record 81;
    DefaultBatch: Record 232;
    fd: Record "Fixed Deposit";
    fdType: Record "Fixed Deposit Type";
    interestCalc: Record "FD Interest Calculation Crite";
    FixedR: Record "Fixed Deposit";
    Trail: Record "Audit Trail";
    saccoGen: Record "Sacco General Set-Up";
    AuditTrail: Codeunit "AU Audit Management";
    AUFactory: Codeunit "Au Factory";

    local procedure GetFDCode() FDcode: Code[20]
    begin
        Options := Text000;
        Selected := Dialog.StrMenu(Options, 1, Text002);
        if Selected = 1 then begin
            fdType.Reset();
            fdType.SetRange("No. of Months", 3);
            if fdType.Find('-') then begin
                FDcode:= fdType.Code;
            end;
        end else if Selected = 2 then begin
            fdType.Reset();
            fdType.SetRange("No. of Months", 6);
            if fdType.Find('-') then begin
                FDcode:= fdType.Code;
            end;
        end else if Selected = 3 then begin
            fdType.Reset();
            fdType.SetRange("No. of Months", 12);
            if fdType.Find('-') then begin
                FDcode:= fdType.Code;
            end;
        end;
    end;

    local procedure CalcCallInterest(days: Integer; callDep: Decimal) InterestRate: Decimal
    var
    begin
        InterestRate := 0;
        if days <= 3 then begin
            interestCalc.Reset();
            interestCalc.SetRange("No of Months", 3);
            if interestCalc.Find('-') then begin
                // Interest := ((callDep *(interestCalc."On Call Interest Rate"/100))*days/12);
                InterestRate := interestCalc."On Call Interest Rate";
            end;
        end else if (days >= 3) and (days <=6) then begin
            interestCalc.Reset();
            interestCalc.SetRange("No of Months", 6);
            if interestCalc.Find('-') then begin
                InterestRate := interestCalc."On Call Interest Rate";
            end;
        end else if (days >= 6) and (days <=12) then begin
            interestCalc.Reset();
            interestCalc.SetRange("No of Months", 12);
            if interestCalc.Find('-') then begin
                InterestRate := interestCalc."On Call Interest Rate";
            end;
        end;
    end;
}

