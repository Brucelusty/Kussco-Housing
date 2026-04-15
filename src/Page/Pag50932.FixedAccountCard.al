//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50932 "Fixed Account Card"
{
    ApplicationArea = All;
    Caption = 'Account Card';
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Vendor;
    SourceTableView = where("Account Type" = const('108'));

    layout
    {
        area(content)
        {
            group(AccountTab)
            {
                Caption = 'General Info';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'Account No.';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Vendor Account No"; Rec."Vendor Account No")
                {
                    caption = 'Source of Cash';
                    Editable = false;
                    Importance = Additional;
                }
                field("Fixed Deposit Type";Rec."Fixed Deposit Type")
                {
                    //Editable = false;
                    Importance = Additional;
                }
                field("Fixed Amount"; Rec."Fixed Amount")
                {
                    //Editable = false;
                    Importance = Additional;
                }
                field("FD Interest Rate"; Rec."FD Interest Rate")
                {

                    //Editable = false;


                }
                field("Fixed Deposit Start Date"; Rec."Fixed Deposit Start Date")
                {
                    //Editable = false;
                }

                field(Duration; Rec.Duration) { }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    Caption = 'Maturity Date';
                    //Editable = false;
                }
                field("Withdrawal Before Maturity Charges"; Rec."Withdrawal Before Maturity Charges") { 
                    //Editable = false; 
                    }
                field("Tax Rate %"; Rec."Tax Rate %") { 
                   // Editable = false;
                     }
                field("Upon Maturity"; Rec."Upon Maturity") {
                     //Editable = false;
                      }

                field("Computed Interest"; Rec."Computed Interest") { }
                field(Tax; Rec.Tax) {
                    // Editable = false;
                      }
                field("Net Interest"; Rec."Net Interest") { 
                   // Editable = false;
                     }
                                     field("Amount Transfered?";Rec."Amount Transfered?") { 
                   // Editable = false;
                     }


                field("Fixed Deposit Certificate No."; Rec."Fixed Deposit Certificate No.")
                {
                   // Editable = false;
                }




                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'ID No.';
                    Editable = false;
                }
                field("KRA Pin"; Rec."KRA Pin")
                {
                    Caption = 'Pin Number';
                    Editable = false;
                }
                field("Personal No."; Rec."Personal No.")
                {
                    Editable = false;
                    Caption = 'Payroll Number';
                }

                field("Member Type"; Rec."Member Type")
                {
                    Editable = false;

                    ShowMandatory = true;
                    Caption = 'Membership Category';
                }
                field("Exempted From Tax"; Rec."Exempted From Tax")
                {
                    Visible = true;
                    Editable = false;
                }



                field(Status; Rec.Status)
                {
                    Editable = false;
                    Style = Standard;
                    StyleExpr = true;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.TestField("Resons for Status Change");

                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Account Status");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');

                        if Rec."Account Type" = 'FIXED' then begin
                            if Rec."Balance (LCY)" > 0 then begin
                                Rec.CalcFields("Last Interest Date");

                                if Rec."Call Deposit" = true then begin
                                    if Rec.Status = Rec.Status::Dormant then begin
                                        if Rec."Last Interest Date" < Today then
                                            Error('Fixed deposit interest not UPDATED. Please update interest.');
                                    end else begin
                                        if Rec."Last Interest Date" < Rec."FD Maturity Date" then
                                            Error('Fixed deposit interest not UPDATED. Please update interest.');
                                    end;
                                end;
                            end;
                        end;

                        if Rec.Status = Rec.Status::Active then begin
                            if Confirm('Are you sure you want to re-activate this account? This will recover re-activation fee.', false) = false then begin
                                Error('Re-activation terminated.');
                            end;

                            Rec.Blocked := Rec.Blocked::" ";
                            Rec.Modify;





                        end;


                        //Account Closure
                        if Rec.Status = Rec.Status::Dormant then begin
                            Rec.TestField("Closure Notice Date");
                            if Confirm('Are you sure you want to close this account? This will recover closure fee and any '
                            + 'interest earned before maturity will be forfeited.', false) = false then begin
                                Error('Closure terminated.');
                            end;


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then
                                GenJournalLine.DeleteAll;



                            AccountTypes.Reset;
                            AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                            if AccountTypes.Find('-') then begin
                                Rec."Date Closed" := Today;

                                //Closure charges
                                /*Charges.RESET;
                                IF CALCDATE(AccountTypes."Closure Notice Period","Closure Notice Date") > TODAY THEN
                                Charges.SETRANGE(Charges.Code,AccountTypes."Closing Prior Notice Charge") */

                                Charges.Reset;
                                if CalcDate(AccountTypes."Closure Notice Period", Rec."Closure Notice Date") > Today then
                                    Charges.SetRange(Charges.Code, AccountType."Closing Charge")

                                else
                                    Charges.SetRange(Charges.Code, AccountTypes."Closing Charge");
                                if Charges.Find('-') then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No." + '-CL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := Charges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := Charges."Charge Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := Charges."GL Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;
                                //Closure charges


                                //Interest forfeited/Earned on maturity
                                Rec.CalcFields("Untranfered Interest");
                                if Rec."Untranfered Interest" > 0 then begin
                                    ForfeitInterest := true;
                                    //If FD - Check if matured
                                    if AccountTypes."Fixed Deposit" = true then begin
                                        if Rec."FD Maturity Date" <= Today then
                                            ForfeitInterest := false;
                                        if Rec."Call Deposit" = true then
                                            ForfeitInterest := false;

                                    end;

                                    //PKK INGORE MATURITY
                                    ForfeitInterest := false;
                                    //If FD - Check if matured

                                    if ForfeitInterest = true then begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        GenJournalLine."Account No." := AccountTypes."Interest Forfeited Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Interest Forfeited';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := -Rec."Untranfered Interest";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        InterestBuffer.Reset;
                                        InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                                        if InterestBuffer.Find('-') then
                                            InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);


                                    end else begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        if AccountTypes."Fixed Deposit" = true then
                                            GenJournalLine."Account No." := Rec."Savings Account No."
                                        else
                                            GenJournalLine."Account No." := Rec."No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Interest Earned';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := -Rec."Untranfered Interest";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        InterestBuffer.Reset;
                                        InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                                        if InterestBuffer.Find('-') then
                                            InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);



                                    end;


                                    //Transfer Balance if Fixed Deposit
                                    if AccountTypes."Fixed Deposit" = true then begin
                                        Rec.CalcFields("Balance (LCY)");

                                        Rec.TestField("Savings Account No.");

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := Rec."Savings Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD Balance Tranfers';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        if Rec."Amount to Transfer" <> 0 then
                                            GenJournalLine.Amount := -Rec."Amount to Transfer"
                                        else
                                            GenJournalLine.Amount := -Rec."Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := Rec."No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD Balance Tranfers';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        if Rec."Amount to Transfer" <> 0 then
                                            GenJournalLine.Amount := Rec."Amount to Transfer"
                                        else
                                            GenJournalLine.Amount := Rec."Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;


                                    end;

                                    //Transfer Balance if Fixed Deposit


                                end;

                                //Interest forfeited/Earned on maturity
                                /*
                                //Post New
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                                GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                                IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                END;
                                //Post New
                                */

                                Message('Funds transfered successfully to main account and account closed.');




                            end;
                        end;


                        //Account Closure

                    end;
                }

            }




        }
        area(factboxes)
        {
            part(Control1000000034; "FOSA Statistics FactBox")
            {
                Visible = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control16; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                Visible = false;
                SubPageLink = "No." = field("BOSA Account No");
            }
            part(Control1000000116; "Vendor Picture-Uploaded")
            {
                Visible = false;
                Caption = 'Picture';
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000115; "Vendor Signature-Uploaded")
            {
                Visible = false;
                Caption = 'Signature';
                SubPageLink = "No." = field("No.");
            }



        }


    }


    actions
    {
        area(navigation)
        {

            action("Ledger E&ntries")
            {
                Caption = 'Ledger E&ntries';
                Image = VendorLedger;
                Visible = false;
                RunObject = Page "Vendor Ledger Entries";
                RunPageLink = "Vendor No." = field("No.");
                RunPageView = sorting("Vendor No.");
                ShortCutKey = 'Ctrl+F7';
            }


            action("Re-new Fixed Deposit")
            {
                Caption = 'Re-new Fixed Deposit';
                Image = "Report";
                Visible = true;

                trigger OnAction()
                begin

                    if AccountTypes.Get(Rec."Account Type") then begin
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Rec."Call Deposit" = false then begin
                                Rec.TestField("Fixed Duration");
                                Rec.TestField("FD Maturity Date");
                                if Rec."FD Maturity Date" > Today then
                                    Error('Fixed deposit has not matured.');

                            end;

                            if Rec."Don't Transfer to Savings" = false then
                                Rec.TestField("Savings Account No.");

                            Rec.CalcFields("Last Interest Date");

                            if Rec."Call Deposit" = true then begin
                                if Rec."Last Interest Date" < Today then
                                    Error('Fixed deposit interest not UPDATED. Please update interest.');
                            end else begin
                                if Rec."Last Interest Date" < Rec."FD Maturity Date" then
                                    Error('Fixed deposit interest not UPDATED. Please update interest.');
                            end;




                            if Confirm('Are you sure you want to renew this Fixed deposit. Interest will be transfered accordingly?') = false then
                                exit;


                            Rec.CalcFields("Untranfered Interest");

                            if Rec."Call Deposit" = false then begin
                                Rec."Date Renewed" := Rec."FD Maturity Date";
                            end else
                                Rec."Date Renewed" := Today;
                            Rec.Validate("Date Renewed");
                            Rec.Modify;

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then
                                GenJournalLine.DeleteAll;



                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := Rec."No." + '-RN';
                            GenJournalLine."External Document No." := Rec."No.";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            if Rec."Don't Transfer to Savings" = false then
                                GenJournalLine."Account No." := Rec."Savings Account No."
                            else
                                GenJournalLine."Account No." := Rec."No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Interest Earned';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -Rec."Untranfered Interest";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            InterestBuffer.Reset;
                            InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                            if InterestBuffer.Find('-') then
                                InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);


                            //Post
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                            end;




                            Message('Fixed deposit renewed successfully');
                        end;
                    end;
                end;
            }

            action("<Page Member Page - BOSA>")
            {
                Caption = 'Member Page';
                Image = Planning;
                Visible = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Member Account Card";
                RunPageLink = "No." = field("BOSA Account No");
            }
            action("<Action11027600800>")
            {
                Caption = 'Loans Statements';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                Visible = false;
                trigger OnAction()
                begin
                    /*Cust.RESET;
                    Cust.SETRANGE(Cust."No.","No.");
                    IF Cust.FIND('-') THEN
                    REPORT.RUN(,TRUE,TRUE,Cust)
                    */

                end;
            }
            action("FOSA Loans")
            {
                Caption = 'All Loans';
                Promoted = true;
                RunObject = Page "Loans Sub-Page List";
                RunPageLink = "Account No" = field("No.");
                Visible = false;
            }
            action("Close Account")
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Close this Account?', false) = true then begin
                        if Rec."Balance (LCY)" > 1 then begin
                            Error('The Member Account has funds. The funds must be withdrawn or transfered');
                        end else begin
                            Rec.Status := Rec.Status::Closed;
                            Rec."Account Closed By" := UserId;
                            Rec."Account Closed On" := WorkDate;
                        end;
                    end;
                end;
            }
            separator(Action1102760142)
            {
            }
            action("<Action110276013300>")
            {
                Caption = 'Update FDR Interest';
                Image = "Report";
                Visible = false;
                trigger OnAction()
                begin
                    if Rec."Account Type" <> 'FIXED' then
                        Error('Only applicable for Fixed Deposit accounts.');

                    Rec.CalcFields("Last Interest Date");

                    if Rec."Last Interest Date" >= Today then
                        Error('Interest Up to date.');

                    //IF CONFIRM('Are you sure you want to update the Fixed deposit interest.?') = FALSE THEN
                    //EXIT;

                    /*
                    Vend.RESET;
                    Vend.SETRANGE(Vend."No.","No.");
                    IF Vend.FIND('-') THEN
                    REPORT.RUN(,TRUE,TRUE,Vend)
                    */

                end;
            }
            action("Account Signatories ")
            {
                Caption = 'Account Signatories';
                Image = Form;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                RunObject = Page "Account Signatories Details";
                RunPageLink = "Account No" = field("No.");
            }
            action("Account Agent Details")
            {
                Caption = 'Account Agents';
                Image = Form;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Account Agent List";
                RunPageLink = "Account No" = field("No.");
            }

            action("FD Certificate")
            {
                Caption = 'FD Certificate';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin


                    Vend.Reset;
                    Vend.SetRange(Vend."No.", Rec."No.");
                    if Vend.Find('-') then
                        Report.run(50006, true, false, Vend)

                    //Report.run(172476,TRUE,FALSE,Vend)
                end;
            }

            action("Place Fixed Deposit Amount")
            {
                Visible = true;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin

                    //Transfer Balance if Fixed Deposit

                    AccountTypes.Reset;

                    AccountTypes.SETRANGE(AccountTypes."Current Account", true);
                    if AccountTypes.Find('-') then begin



                        if Confirm('Are you sure you want to effect the transfer from the Savings account', false) = true then
                            Rec.TestField("Amount Transfered?", false);
                        Rec.TestField("Upon Maturity");
                        Rec.TestField(Tax);
                        Rec.TestField("Tax Rate %");
                        Rec.TestField("Computed Interest");
                        Rec.TestField("Net Interest");


                        Rec.TestField("No.");
                        Rec.TestField("Vendor Posting Group");
                        Rec.TestField("Vendor Account No");
                        Rec.TestField("Fixed Amount");

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then
                            GenJournalLine.DeleteAll;

                        Vend.Reset;
                        Vend.SetRange(Vend."Account Type", AccountTypes.code);
                        Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                        if Vend.Find('-') then
                            if Rec."Savings Account No." = '' then
                                Rec."Savings Account No." := Vend."No."
                            else
                                Rec."Savings Account No." := Rec."Savings Account No.";
                        // Message('Here%1', Rec."Savings Account No.");
                        Vend.CalcFields(Vend.Balance);
                        if Vend.Balance < Rec."Amount to Transfer" then Error('  Balance');
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := 'FD' + Rec."No.";
                        GenJournalLine."External Document No." := 'FD' + Rec."No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Fixed Deposit Placement';
                        //GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := -Rec."Fixed Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := 'FD' + Rec."No.";
                        GenJournalLine."External Document No." := Rec."No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."Vendor Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Fixed Deposit Placement';
                        // GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := Rec."Fixed Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //END;
                        // end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;
                    Rec."Transferred By" := UserId;
                    rec."Date Transfered" := CurrentDateTime;
                    rec."Amount Transfered?" := true;



                    Rec.modify;
                    //Transfer Balance if Fixed Deposit

                end;
            }
            action("Mature Fixed Deposit")
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                trigger OnAction()
                begin
                    // if rec."FD Maturity Date"<Today then error('This FD is Yet.');
                    if Rec."Upon Maturity" <> Rec."Upon Maturity"::"Close the FXD against the Account" then
                        error('This option is only applicable to FD with terms Close the FXD against the Account');
                    //Transfer Balance if Fixed Deposit
                    Rec.TestField(Revoked, false);
                    Rec.TestField("Amount Transfered?", true);

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                    if AccountTypes.Find('-') then begin
                        ;
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Vend.Get(Rec."No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                Vend.SetRange(Vend."Account Type", AccountTypes.code);
                                Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                                if Vend.Find('-') then
                                    if Rec."Savings Account No." = '' then
                                        Rec."Savings Account No." := Vend."No."
                                    else
                                        Rec."Savings Account No." := Rec."Savings Account No.";
                                Vend.CalcFields(Vend.Balance);

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := 'FD' + Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'matured Deposit Placement';
                                //GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Deposit Placement';
                                // GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Interest Earned start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.Get();
                                GenJournalLine."Account No." := SaccoGenSetup."Interest Expense on Fixed Deposit";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Expense on Fixed Deposit for-' + rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Computed Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest earned from Fixed Deposit Placement';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Computed Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Interest Earned end..........................



                                if rec."Exempted From Tax" = false then begin
                                    //Withholding Tax start..........................
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."External Document No." := Rec."Vendor Account No";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."Vendor Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'WTax charged on Interest Earned from FD';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    SaccoGenSetup.get();
                                    GenJournalLine.Amount := Rec.Tax;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    SaccoGenSetup.get();
                                    GenJournalLine."Account No." := SaccoGenSetup."WithHolding Tax Account";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Wtax charged on Interest Earned from FD-' + Rec."Vendor Account No";
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := -Rec.Tax;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                    //Withholding end..........................
                                end;




                            end;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;


                    Message('Amount transfered successfully.');

                end;
            }

            //rolloverstart
            action("Rollover Principal Plus Interest")
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                trigger OnAction()
                var
                    NetInterest: decimal;
                begin
                    //if rec."FD Maturity Date"<Today then error('This FD is Yet.');
                    //if Rec."Upon Maturity" <> Rec."Upon Maturity"::"Roll-over the FXD and refix the Principal and Interest" then
                    //    error('This option is only applicable to FD with terms Roll-over the FXD and refix the Principal and Interest');
                    //Transfer Balance if Fixed Deposit
                    Rec.TestField(Revoked, false);
                    Rec.TestField("Amount Transfered?", true);

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                    if AccountTypes.Find('-') then begin
                        ;
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Vend.Get(Rec."No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                Vend.SetRange(Vend."Account Type", AccountTypes.code);
                                Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                                if Vend.Find('-') then
                                    if Rec."Savings Account No." = '' then
                                        Rec."Savings Account No." := Vend."No."
                                    else
                                        Rec."Savings Account No." := Rec."Savings Account No.";
                                Vend.CalcFields(Vend.Balance);

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := 'FD' + Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'matured Deposit Placement';
                                //GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Deposit Placement';
                                // GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Interest Earned start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.Get();
                                GenJournalLine."Account No." := SaccoGenSetup."Interest Expense on Fixed Deposit";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Expense on Fixed Deposit for-' + rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Computed Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest earned from Fixed Deposit Placement';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Computed Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Interest Earned end..........................



                                if rec."Exempted From Tax" = false then begin
                                    //Withholding Tax start..........................
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."External Document No." := Rec."Vendor Account No";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."Vendor Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'WTax charged on Interest Earned from FD';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    SaccoGenSetup.get();
                                    GenJournalLine.Amount := Rec.Tax;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    SaccoGenSetup.get();
                                    GenJournalLine."Account No." := SaccoGenSetup."WithHolding Tax Account";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Wtax charged on Interest Earned from FD-' + Rec."Vendor Account No";
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := -Rec.Tax;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //Withholding end..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := 'FD' + Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'matured Deposit Rollover';
                                //GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Deposit Rollover';
                                // GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                NetInterest := 0;
                                NetInterest := Rec."Computed Interest" - Rec.Tax;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                SaccoGenSetup.Get();
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Rollover-' + rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -NetInterest;//Rec."Computed Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Rollover';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount :=NetInterest;//Rec."Computed Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;






                            end;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                    
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        
                    end;


                    Message('Amount transfered successfully.');

                end;
            }
            //rolloverend


            action("Rollover Principal")
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                trigger OnAction()
                begin
                    //if rec."FD Maturity Date"<Today then error('This FD is Yet.');
                   // if Rec."Upon Maturity" <> Rec."Upon Maturity"::"Roll-over the FXD and refix the Principal" then
                     //   error('This option is only applicable to FD with terms Roll-over the FXD and refix the Principal');
                    //Transfer Balance if Fixed Deposit
                    Rec.TestField(Revoked, false);
                    Rec.TestField("Amount Transfered?", true);

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                    if AccountTypes.Find('-') then begin
                        ;
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Vend.Get(Rec."No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                Vend.SetRange(Vend."Account Type", AccountTypes.code);
                                Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                                if Vend.Find('-') then
                                    if Rec."Savings Account No." = '' then
                                        Rec."Savings Account No." := Vend."No."
                                    else
                                        Rec."Savings Account No." := Rec."Savings Account No.";
                                Vend.CalcFields(Vend.Balance);

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := 'FD' + Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'matured Deposit Placement';
                                //GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Deposit Placement';
                                // GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Interest Earned start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.Get();
                                GenJournalLine."Account No." := SaccoGenSetup."Interest Expense on Fixed Deposit";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Expense on Fixed Deposit for-' + rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Computed Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest earned from Fixed Deposit Placement';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Computed Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Interest Earned end..........................



                                if rec."Exempted From Tax" = false then begin
                                    //Withholding Tax start..........................
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."External Document No." := Rec."Vendor Account No";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."Vendor Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'WTax charged on Interest Earned from FD';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    SaccoGenSetup.get();
                                    GenJournalLine.Amount := Rec.Tax;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    SaccoGenSetup.get();
                                    GenJournalLine."Account No." := SaccoGenSetup."WithHolding Tax Account";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Wtax charged on Interest Earned from FD-' + Rec."Vendor Account No";
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := -Rec.Tax;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //Withholding end..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := 'FD' + Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'matured Deposit Rollover';
                                //GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := 'FD' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Deposit Rollover';
                                // GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                            end;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;


                    Message('Amount transfered successfully.');

                end;
            }
            //rolloverend


            action("Revoke Fixed Deposit Amount")
            {
                Visible = true;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin

                    //Transfer Balance if Fixed Deposit
                    //if rec."FD Maturity Date">=Today then error('This FD cant be revoked coz Maturity Date already passed.');
                    AccountTypes.Reset;

                    AccountTypes.SETRANGE(AccountTypes."Current Account", true);
                    if AccountTypes.Find('-') then begin



                        if Confirm('Are you sure you want to Revoke this FD', false) = true then
                            Rec.TestField("No.");
                        Rec.TestField(Revoked, false);
                        //Rec.TestField(amo,false);

                        Rec.TestField("Vendor Posting Group");
                        Rec.TestField("Vendor Account No");
                        Rec.TestField("Fixed Amount");

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then
                            GenJournalLine.DeleteAll;

                        Vend.Reset;
                        Vend.SetRange(Vend."Account Type", AccountTypes.code);
                        Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                        if Vend.Find('-') then
                            if Rec."Savings Account No." = '' then
                                Rec."Savings Account No." := Vend."No."
                            else
                                Rec."Savings Account No." := Rec."Savings Account No.";
                        // Message('Here%1', Rec."Savings Account No.");
                        Vend.CalcFields(Vend.Balance);
                        if Vend.Balance < Rec."Amount to Transfer" then Error('  Balance');
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := 'FD' + Rec."No.";
                        GenJournalLine."External Document No." := 'FD' + Rec."No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Revoked Deposit Placement';
                        //GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := Rec."Fixed Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := 'FD' + Rec."No.";
                        GenJournalLine."External Document No." := Rec."No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."Vendor Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Revoked Deposit Placement';
                        // GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := -Rec."Fixed Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //END;
                        // end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;
                    Rec."Transferred By" := UserId;
                    rec."Date Transfered" := CurrentDateTime;
                    Rec.Revoked := true;




                    Rec.modify;
                    //Transfer Balance if Fixed Deposit

                end;
            }



            separator(Action1102760180)
            {
            }

            action("Transfer Fixed Amount to Current")
            {
                Promoted = true;
                Visible = false;
                trigger OnAction()
                begin

                    //Transfer Balance if Fixed Deposit

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                    if AccountTypes.Find('-') then begin
                        ;
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Vend.Get(Rec."No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                Vend.SetRange(Vend."Account Type", AccountTypes.code);
                                Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                                if Vend.Find('-') then
                                    if Rec."Savings Account No." = '' then
                                        Rec."Savings Account No." := Vend."No."
                                    else
                                        Rec."Savings Account No." := Rec."Savings Account No.";
                                Vend.CalcFields(Vend.Balance);

                                //Transfer of Fixed Amount to Current/Jipange Account start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Fixed Deposit Transfer';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Fixed Deposit Transfer';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Transfer Amount to Savings";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Transfer of Fixed Amount to Current/Jipange Account end..........................
                                //Interest Earned start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.Get();
                                GenJournalLine."Account No." := SaccoGenSetup."Interest Expense on Fixed Deposit";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Expense on Fixed Deposit for-' + rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := ((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100);
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."Vendor Account No";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest earned from Fixed Deposit Placement';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100);
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Interest Earned end..........................


                                //Excise Duty start..........................



                                //Withholding Tax start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'WTax charged on Interest Earned from FD';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                SaccoGenSetup.get();
                                GenJournalLine.Amount := ((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100) * SaccoGenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.get();
                                GenJournalLine."Account No." := SaccoGenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Wtax charged on Interest Earned from FD-' + Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100) * SaccoGenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Withholding end..........................




                            end;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;


                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name", 'FTRANS');
                    GenJournalLine.DELETEALL;

                    Message('Amount transfered successfully.');
                    rec.Modify()

                end;
            }

            action("Rollover Principle")
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    //Transfer Balance if Fixed Deposit

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                    if AccountTypes.Find('-') then begin
                        ;
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Vend.Get(Rec."No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                Vend.SetRange(Vend."Account Type", AccountTypes.code);
                                Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                                if Vend.Find('-') then
                                    if Rec."Savings Account No." = '' then
                                        Rec."Savings Account No." := Vend."No."
                                    else
                                        Rec."Savings Account No." := Rec."Savings Account No.";
                                Vend.CalcFields(Vend.Balance);


                                //Interest Earned start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.Get();
                                GenJournalLine."Account No." := SaccoGenSetup."Interest Expense on Fixed Deposit";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Expense on Fixed Deposit for-' + rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := ((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100);
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."Vendor Account No";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest earned from Fixed Deposit Placement';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100);
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Interest Earned end..........................


                                //Withholding Tax start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'WTax charged on Interest Earned from FD';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                SaccoGenSetup.get();
                                GenJournalLine.Amount := ((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100) * SaccoGenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.get();
                                GenJournalLine."Account No." := SaccoGenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Wtax charged on Interest Earned from FD-' + Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100) * SaccoGenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Withholding end..........................




                            end;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;

                    /*
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                    GenJournalLine.DELETEALL;
                    */
                    Message('Amount transfered successfully.');
                    rec.Modify()

                end;
            }

            action("Rollover Principle + Interest")
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    //Transfer Balance if Fixed Deposit

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                    if AccountTypes.Find('-') then begin
                        ;
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Vend.Get(Rec."No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                Vend.SetRange(Vend."Account Type", AccountTypes.code);
                                Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                                if Vend.Find('-') then
                                    if Rec."Savings Account No." = '' then
                                        Rec."Savings Account No." := Vend."No."
                                    else
                                        Rec."Savings Account No." := Rec."Savings Account No.";
                                Vend.CalcFields(Vend.Balance);
                                //Interest Earned start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.Get();
                                GenJournalLine."Account No." := SaccoGenSetup."Interest Expense on Fixed Deposit";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Expense on Fixed Deposit for-' + rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := ((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100);
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest earned from Fixed Deposit Placement';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100);
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Interest Earned end..........................


                                //Withholding Tax start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'WTax charged on Interest Earned from FD';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                SaccoGenSetup.get();
                                GenJournalLine.Amount := ((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100) * SaccoGenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.get();
                                GenJournalLine."Account No." := SaccoGenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Wtax charged on Interest Earned from FD-' + Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100) * SaccoGenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Withholding end..........................




                            end;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;

                    /*
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                    GenJournalLine.DELETEALL;
                    */
                    Message('Amount transfered successfully.');
                    rec.Modify()

                end;
            }
            //End Principle + Interest Rollover


            action("Rollover Interest")
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    //Transfer Balance if Fixed Deposit

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                    if AccountTypes.Find('-') then begin
                        ;
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Vend.Get(Rec."No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                Vend.SetRange(Vend."Account Type", AccountTypes.code);
                                Vend.SetRange(Vend."BOSA Account No", Rec."BOSA Account No");
                                if Vend.Find('-') then
                                    if Rec."Savings Account No." = '' then
                                        Rec."Savings Account No." := Vend."No."
                                    else
                                        Rec."Savings Account No." := Rec."Savings Account No.";
                                Vend.CalcFields(Vend.Balance);

                                //Transfer of Fixed Amount to Current/Jipange Account start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Fixed Deposit Transfer';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Fixed Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Matured Fixed Deposit Transfer';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Transfer Amount to Savings";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Transfer of Fixed Amount to Current/Jipange Account end..........................



                                //Withholding Tax start..........................
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."Vendor Account No";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'WTax charged on Interest Earned from FD';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                SaccoGenSetup.get();
                                GenJournalLine.Amount := ((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100) * SaccoGenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                SaccoGenSetup.get();
                                GenJournalLine."Account No." := SaccoGenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Wtax charged on Interest Earned from FD-' + Rec."Vendor Account No";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -((Rec."Fixed Amount" * Rec."FD Duration" * Rec."FD Interest Rate") / 100) * SaccoGenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //Withholding end..........................




                            end;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;

                    /*
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                    GenJournalLine.DELETEALL;
                    */
                    Message('Amount transfered successfully.');
                    rec.Modify()

                end;
            }




            ////////Earn Interest Only start

            ///Earn Interest only end 


            action("Renew Term deposit")
            {
                Visible = false;


                trigger OnAction()
                begin

                    if AccountTypes.Get(Rec."Account Type") then begin
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Confirm('Are you sure you want to renew the fixed deposit.', false) = false then
                                exit;




                            Rec."Prevous Fixed Deposit Type" := Rec."Fixed Deposit Type";
                            Rec."Prevous FD Deposit Status Type" := Rec."FDR Deposit Status Type";
                            Rec."Prevous FD Maturity Date" := Rec."FD Maturity Date";
                            Rec."Prevous FD Start Date" := Rec."Fixed Deposit Start Date";
                            Rec."Prevous Fixed Duration" := Rec."Fixed Duration";
                            Rec."Prevous Interest Rate FD" := Rec."Interest rate";
                            Rec."Prevous Expected Int On FD" := Rec."Expected Interest On Term Dep";
                            Rec."Date Renewed" := Today;


                            Rec."Fixed Deposit Type" := '';
                            //"Fixed Duration":=0D;
                            Rec."FDR Deposit Status Type" := Rec."fdr deposit status type"::New;
                            Rec."FD Maturity Date" := 0D;
                            Rec."Fixed Deposit Start Date" := 0D;
                            Rec."Expected Interest On Term Dep" := 0;
                            Rec."Interest rate" := 0;
                            Rec."Amount to Transfer" := 0;
                            Rec."Transfer Amount to Savings" := 0;
                            Rec."Fixed Deposit Status" := Rec."fixed deposit status"::" ";
                            //"FDR Deposit Status Type":="FDR Deposit Status Type"::"";

                            InterestBuffer.Reset;
                            InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                            if InterestBuffer.Find('-') then begin
                                InterestBuffer.DeleteAll;
                            end;



                            Rec."FDR Deposit Status Type" := Rec."fdr deposit status type"::New;
                            Rec.Modify;

                            Message('Fixed deposit renewed successfully');
                        end;
                    end;
                    //END;
                end;
            }
            action("Terminate Term Deposit")
            {
                Visible = false;


                trigger OnAction()
                begin

                    //Transfer Balance if Fixed Deposit

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                    if AccountTypes.Find('-') then begin
                        if AccountTypes."Fixed Deposit" = true then begin
                            if Vend.Get(Rec."No.") then begin
                                if Confirm('Are you sure you want to Terminate this Fixed Deposit Contract?', false) = false then
                                    exit;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.CalcFields(Vend."Balance (LCY)", "Interest Earned");
                                if (Vend."Balance (LCY)") < Rec."Transfer Amount to Savings" then
                                    Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No." + '-OP';
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'FD Termination Tranfer';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Balance (LCY)";//+("Interest Earned"-("Interest Earned"*(GenSetup."Withholding Tax (%)"/100)));
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No." + '-OP';
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Savings Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'FD Termination Tranfer';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Balance (LCY)";//+("Interest Earned"-("Interest Earned"*(GenSetup."Withholding Tax (%)"/100)));
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                /*IF AccountType.GET("Account Type") THEN BEGIN

                                GenJournalLine.INIT;
                                GenJournalLine."Journal Template Name":='PURCHASES';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Journal Batch Name":='FTRANS';
                                GenJournalLine."Document No.":="No."+'-OP';
                                GenJournalLine."External Document No.":="No.";
                                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                                GenJournalLine."Account No.":="No.";
                                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date":=TODAY;
                                GenJournalLine.Description:='FD Termination Charge';
                                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                                GenJournalLine.Amount:=("Interest Earned"-("Interest Earned"*(GenSetup."Withholding Tax (%)"/100)))*(AccountType."Term terminatination fee"/100);
                                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                GenJournalLine."Bal. Account No.":=AccountType."Term Termination Account";
                                IF GenJournalLine.Amount<>0 THEN
                                GenJournalLine.INSERT;
                                END;*/
                            end;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;


                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    GenJournalLine.DeleteAll;

                    Message('Amount transfered successfully back to the Current Account.');
                    Rec."FDR Deposit Status Type" := Rec."fdr deposit status type"::Terminated;

                    /*
                   //Renew Fixed deposit - OnAction()

                   IF AccountTypes.GET("Account Type") THEN BEGIN
                   IF AccountTypes."Fixed Deposit" = TRUE THEN BEGIN
                   IF CONFIRM('Are you sure you want to renew the fixed deposit.',FALSE) = FALSE THEN
                   EXIT;

                   TESTFIELD("FD Maturity Date");
                   IF FDType.GET("Fixed Deposit Type") THEN BEGIN
                   "FD Maturity Date":=CALCDATE(FDType.Duration,"FD Maturity Date");
                   "Date Renewed":=TODAY;
                   "FDR Deposit Status Type":="FDR Deposit Status Type"::Renewed;
                   MODIFY;

                   MESSAGE('Fixed deposit renewed successfully');
                   END;
                   END;
                   END;
                     */

                end;
            }



            action("Create Member Account")
            {
                Image = CalculateWarehouseAdjustment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Cust.Reset;
                    Cust.SetRange(Cust."ID No.", Rec."ID No.");
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then begin
                        //IF (Cust."No." <> "No.") AND ("Account Category"="Account Category"::Single) THEN
                        Error('There already exists a member');
                    end;


                    Saccosetup.Get();
                    NewMembNo := Saccosetup.BosaNumber;

                    //Create BOSA account
                    Cust."No." := Format(NewMembNo);
                    Cust.Name := Rec.Name;
                    Cust.Address := Rec.Address;
                    Cust."Post Code" := Rec."Post Code";
                    Cust.County := Rec.City;
                    Cust."Phone No." := Rec."Mobile Phone No";
                    Cust."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    Cust."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    Cust."Customer Posting Group" := 'MEMBER';
                    Cust."Account Category" := Rec."account category"::Individual;
                    Cust."Registration Date" := Today;
                    Cust."Mobile Phone No" := Rec."Mobile Phone No";
                    Cust.Status := Cust.Status::Active;
                    Cust."Employer Code" := Rec."Employer Code";
                    Cust."Date of Birth" := Rec."Date of Birth";
                    //Cust.Picture:=Picture;
                    //Cust.Signature:=Signature;
                    //Cust."Station/Department":="Station/Department";
                    Cust."E-Mail" := Rec."E-Mail";
                    Cust.Location := Rec.Location;
                    Cust.Title := Rec.Title;
                    Cust."Home Address" := Rec."Home Address";
                    Cust."Home Postal Code" := Rec."Home Postal Code";
                    Cust."Home Town" := Rec."Home Town";
                    Cust."Recruited By" := Rec."Recruited By";
                    Cust."Contact Person" := Rec."Contact Person";
                    Cust."ContactPerson Relation" := Rec."ContactPerson Relation";
                    Cust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                    Cust."Members Parish" := Rec."Members Parish";
                    Cust."Parish Name" := Rec."Parish Name";
                    //Cust."Member Share Class":="Member Share Class";
                    Cust."Member's Residence" := Rec."Member's Residence";

                    //*****************************to Sort Joint
                    Cust."Name 2" := Rec."Name 2";
                    Cust."Address3-Joint" := Rec.Address3;
                    Cust."Postal Code 2" := Rec."Postal Code 2";
                    Cust."Home Postal Code2" := Rec."Home Postal Code2";
                    Cust."Home Town2" := Rec."Home Town2";
                    Cust."ID No.2" := Rec."ID No.2";
                    Cust."Passport 2" := Rec."Passport 2";
                    Cust.Gender2 := Rec.Gender2;
                    Cust."Marital Status2" := Rec."Marital Status2";
                    Cust."E-Mail (Personal3)" := Rec."E-Mail (Personal2)";
                    Cust."Employer Code2" := Rec."Employer Code2";
                    Cust."Employer Name2" := Rec."Employer Name2";
                    Cust."Picture 2" := Rec."Picture 2";
                    Cust."Signature  2" := Rec."Signature  2";
                    Cust."Member Parish 2" := Rec."Member Parish 2";
                    Cust."Member Parish Name 2" := Rec."Member Parish Name 2";


                    Cust."Name 3" := Rec."Name 3";
                    Cust."Address3-Joint" := Rec.Address4;
                    Cust."Postal Code 3" := Rec."Postal Code 3";
                    Cust."Home Postal Code3" := Rec."Home Postal Code3";
                    Cust."Mobile No. 4" := Rec."Mobile No. 4";
                    Cust."Home Town3" := Rec."Home Town3";
                    Cust."ID No.3" := Rec."ID No.3";
                    Cust."Passport 3" := Rec."Passport 3";
                    Cust.Gender3 := Rec.Gender3;
                    Cust."Marital Status3" := Rec."Marital Status3";
                    Cust."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                    Cust."Employer Code3" := Rec."Employer Code3";
                    Cust."Employer Name3" := Rec."Employer Name3";
                    Cust."Picture 3" := Rec."Picture 3";
                    Cust."Signature  3" := Rec."Signature  3";
                    Cust."Member Parish Name 3" := Rec."Member Parish Name 3";
                    Cust."Member Parish Name 3" := Rec."Member Parish Name 3";
                    //Cust."Joint Account Name":="First Name"+'& '+"First Name2"+'& '+"First Name3"+'JA';
                    //Cust."Account Category":="Account Category";

                    //****************************End to Sort Joint

                    //**
                    //Cust."Office Branch":="Office Branch";
                    //Cust.Department:=Department;
                    //Cust.Occupation:=Occupation;
                    //Cust.Designation:=Designation;
                    //Cust."Bank Code":="Bank Code";
                    //Cust."Bank Branch Code":="Bank Name";
                    //Cust."Bank Account No.":="Bank Account No";
                    //**
                    Cust."Sub-Location" := Rec."Sub-Location";
                    Cust.District := Rec.District;
                    Cust."Payroll No" := Rec."Personal No.";
                    Cust."ID No." := Rec."ID No.";
                    Cust."Mobile Phone No" := Rec."Mobile Phone No";
                    Cust."Marital Status" := Rec."Marital Status";
                    Cust."Customer Type" := Cust."customer type"::Member;
                    Cust.Gender := Rec.Gender;

                    //CALCFIELDS(Signature,Picture);
                    //PictureExists:=Picture.HASVALUE;
                    //SignatureExists:=Signature.HASVALUE;
                    //IF (PictureExists=TRUE) AND (SignatureExists=TRUE) THEN BEGIN
                    //Cust.Picture:=Picture;
                    //Cust.Signature:=Signature;
                    //END ELSE
                    //ERROR('Kindly upload a Picture and signature');

                    Cust."Monthly Contribution" := Rec."Monthly Contribution";
                    Cust."Contact Person" := Rec."Contact Person";
                    Cust."Contact Person Phone" := Rec."Contact Person Phone";
                    Cust."ContactPerson Relation" := Rec."ContactPerson Relation";
                    Cust."Recruited By" := Rec."Recruited By";
                    Cust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                    //Cust."Village/Residence":="Village/Residence";
                    Cust.Insert(true);


                    Message('Back Office Account Created Successfully. The Member Number is now' + NewMembNo);


                    Saccosetup.BosaNumber := IncStr(NewMembNo);
                    Saccosetup.Modify;
                end;
            }


            action("Send Account Statement")
            {
                Caption = 'Send Account Statement';
                Image = "Report";
                Promoted = true;
                Visible = false;
                //PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    Vend.Reset;
                    Vend.SetRange(Vend."No.", Rec."No.");
                    if Vend.Find('-') then
                        //Report.run(172890,TRUE,FALSE,Vend);
                        Report.run(172072, true, false, Vend);
                end;
            }

            //   }
        }
    }

    trigger OnAfterGetRecord()
    begin

        //Hide balances for hidden accounts
        /*IF CurrForm.UnclearedCh.VISIBLE=FALSE THEN BEGIN
        CurrForm.BookBal.VISIBLE:=TRUE;
        CurrForm.UnclearedCh.VISIBLE:=TRUE;
        CurrForm.AvalBal.VISIBLE:=TRUE;
        CurrForm.Statement.VISIBLE:=TRUE;
        CurrForm.Account.VISIBLE:=TRUE;
        END;
        
        
        IF Hide = TRUE THEN BEGIN
        IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID."Show Hiden" = FALSE THEN BEGIN
        CurrForm.BookBal.VISIBLE:=FALSE;
        CurrForm.UnclearedCh.VISIBLE:=FALSE;
        CurrForm.AvalBal.VISIBLE:=FALSE;
        CurrForm.Statement.VISIBLE:=FALSE;
        CurrForm.Account.VISIBLE:=FALSE;
        END;
        END;
        END;
        //Hide balances for hidden accounts
          */
        MinBalance := 0;
        if AccountType.Get(Rec."Account Type") then
            MinBalance := AccountType."Minimum Balance";

        /*CurrForm.lblID.VISIBLE := TRUE;
        CurrForm.lblDOB.VISIBLE := TRUE;
        CurrForm.lblRegNo.VISIBLE := FALSE;
        CurrForm.lblRegDate.VISIBLE := FALSE;
        CurrForm.lblGender.VISIBLE := TRUE;
        CurrForm.txtGender.VISIBLE := TRUE;
        IF "Account Category" <> "Account Category"::Single THEN BEGIN
        CurrForm.lblID.VISIBLE := FALSE;
        CurrForm.lblDOB.VISIBLE := FALSE;
        CurrForm.lblRegNo.VISIBLE := TRUE;
        CurrForm.lblRegDate.VISIBLE := TRUE;
        CurrForm.lblGender.VISIBLE := FALSE;
        CurrForm.txtGender.VISIBLE := FALSE;
        END;*/
        OnAfterGetCurrRecords();

        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User ID", UserId);
        Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
        if not Statuschange.Find('-') then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        // CalcFields(NetDis);
        UnclearedLoan := Rec.NetDis;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;
        if Rec."Account Category" = Rec."account category"::Joint then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;


        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;

        OverDraftVisible := false;
        if Rec."Account Type" = '406' then begin
            OverDraftVisible := true;
        end;


        ExcessRuleVisible := false;
        ObjExcessSetup.Reset;
        ObjExcessSetup.SetRange(ObjExcessSetup."Account Type Affected", Rec."Account Type");
        if ObjExcessSetup.FindSet then begin
            ExcessRuleVisible := true;
        end;

        EnableBOSAPenaltyExemption := false;
        if (Rec."Account Type" = '602') or (Rec."Account Type" = '603') then
            EnableBOSAPenaltyExemption := true;


        EnableSpecificSweepingAccount := false;
        if Rec."Overdraft Sweeping Source" = Rec."overdraft sweeping source"::"Specific FOSA Account" then
            EnableSpecificSweepingAccount := true;

    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Rec.Find(Which);
        CurrPage.Editable := RecordFound or (Rec.GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Creditor Type" := Rec."creditor type"::"FOSA Account";
        Rec."Account Type" := 'FIXED';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecords;
    end;

    trigger OnOpenPage()
    begin
        ActivateFields;


        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;
        if Rec."Account Category" = Rec."account category"::Joint then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;

        OverDraftVisible := false;
        if Rec."Account Type" = '406' then begin
            OverDraftVisible := true;
        end;

        ExcessRuleVisible := false;
        ObjExcessSetup.Reset;
        ObjExcessSetup.SetRange(ObjExcessSetup."Account Type Affected", Rec."Account Type");
        if ObjExcessSetup.FindSet then begin
            ExcessRuleVisible := true;
        end;

        EnableBOSAPenaltyExemption := false;
        if (Rec."Account Type" = '602') or (Rec."Account Type" = '603') then
            EnableBOSAPenaltyExemption := true;


        EnableSpecificSweepingAccount := false;
        if Rec."Overdraft Sweeping Source" = Rec."overdraft sweeping source"::"Specific FOSA Account" then
            EnableSpecificSweepingAccount := true;
        CUeMgt.GetVisitFrequency(ObjCueControl.Activity::FOSA, Rec."No.", Rec.Name);
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        SaccoGenSetup: Record "Sacco General Set-Up";
        Vend: Record Vendor;
        Cust: Record "Members Register";
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loan GuarantorsFOSA";
        Loans: Record "Loans Register";
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        AccountType: Record "Account Types-Saving Products";
        ReplCharge: Decimal;
        Acc: Record Vendor;
        SearchAcc: Code[10];
        Searchfee: Decimal;
        Statuschange: Record "Status Change Permision";
        UnclearedLoan: Decimal;
        LineN: Integer;
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        UserSetup: Record "User Setup";
        Saccosetup: Record "Sacco No. Series";
        NewMembNo: Code[30];
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        FieldStyleI: Text;
        OverDraftVisible: Boolean;
        ExcessRuleVisible: Boolean;
        ObjExcessSetup: Record "Excess Repayment Rules";
        ObjAccount: Record Vendor;
        EnableBOSAPenaltyExemption: Boolean;
        EnableSpecificSweepingAccount: Boolean;
        CUeMgt: Codeunit "Cue Management";
        ObjCueControl: Record "Control Cues";


    procedure ActivateFields()
    begin
        //CurrForm.Contact.EDITABLE("Primary Contact No." = '');
    end;

    local procedure OnAfterGetCurrRecords()
    begin
        xRec := Rec;
        ActivateFields;
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyleI := '';

        if Rec."Account Special Instructions" <> '' then
            FieldStyleI := 'Attention';
    end;

}




