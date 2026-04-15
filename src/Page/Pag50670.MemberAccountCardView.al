//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50670 "Member Account Card View"
{
    ApplicationArea = All;
    Caption = 'Account Card';
    DeleteAllowed = false;
    Editable = true;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approval,Budgetary Control,Cancellation,Account Details,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Vendor;
    SourceTableView = where("Creditor Type" = const("FOSA Account"),
                            "Debtor Type" = const("FOSA Account"));

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
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    Caption = 'Member No.';
                    Editable = false;
                }
                field("Joint Account Name"; Rec."Joint Account Name")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("First Name"; Rec."First Name")
                {
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field("Amount to freeze"; Rec."Amount to freeze")
                {
                    Editable = false;
                     Visible = false;
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
                     Visible = false;
                }
                field("ATM No"; Rec."ATM No.") { Visible = false; }

                field("CardStatus"; Rec."Card Status")
                {
                     Visible = false;
                }
                field("NHIF No"; Rec."NHIF No")
                {
                    Editable = false;
                     Visible = false;

                }
                field("Passport No."; Rec."Passport No.")
                {
                    Editable = false;
                }
                field("Religion."; Rec."Religion.")
                {
                    Editable = false;
                    ShowMandatory = true;
                    Caption = 'Religion';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    Editable = false;
                     Visible = false;

                }
                field("Receive SMS Notification"; Rec."Receive SMS Notification")
                {
                    Editable = false;
                    ShowMandatory = true;
                     Visible = false;
                }
                field(Age; Rec.Age)
                {
                    Editable = false;
                     Visible = false;
                }
                field("Date of Registration"; Rec."Date of Registration")
                {
                    Editable = false;
                    Caption = 'Registration Date';
                    ShowMandatory = true;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Type"; Rec."Member Type")
                {
                    Editable = false;

                    ShowMandatory = true;
                    Caption = 'Membership Category';
                }
                field("Exempted From Tax"; Rec."Exempted From Tax")
                {
                     Visible = false;
                    Editable = false;
                }
                field("Why Exempt from Tax?"; Rec."Why Exempt from Tax?") {  Visible = false;}
                field("Station Representative"; Rec."Station Representative")
                {
                    Visible = false;
                    Editable = false;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Mode Of Remmittance"; Rec."Mode Of Remmittance")
                {
                    ShowMandatory = true;
                    Visible = false;
                    Editable = false;
                }
                field("How Did you Know us?"; Rec."How Did you Know us?")
                {
                    ShowMandatory = true;
                    Editable = false;
                     Visible = false;
                }


                field("Reffered By Member No"; Rec."Reffered By Member No")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Reffered By Member Name"; Rec."Reffered By Member Name")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    Editable = false;
                     Visible = false;
                }
                field("Registration Fee Comm %"; Rec."Registration Fee Comm %")
                {
                    Editable = false;
                     Visible = false;
                }
                field("Registration Fee Comm Amount"; Rec."Registration Fee Comm Amount")
                {
                    Editable = false;
                     Visible = false;
                }

                field(AvailableBal; Rec.GetAvailableBalance())
                {
                    Caption = 'Withdrawable Balance';
                    Editable = false;
                     Visible = false;
                }
                field(SuspendedBal; (Rec.Balance - Rec.GetAvailableBalance()))
                {
                    Caption = 'Suspended Balance';
                    Editable = false;
                     Visible = false;
                }
                // field(AvailableBal; Rec."Balance (LCY)" - ((Rec."Uncleared Cheques" - Rec."Cheque Discounted Amount") + Rec."ATM Transactions" + Rec."EFT Transactions" + MinBalance + Rec."Mobile Transactions" + Rec."Frozen Amount" + rec."Amount to freeze"))
                // {
                //     Caption = 'Withdrawable Balance';
                //     Editable = false;
                // }
                field("Last Account Trans";Rec."Last Account Trans")
                {
                    Caption = 'Last Account Transaction Date';
                }

                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    Caption = 'Book Balance';
                    Enabled = false;
                    Visible = false;
                }

                field("Cheque Discounted"; Rec."Cheque Discounted")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Comission On Cheque Discount"; Rec."Comission On Cheque Discount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Reason For Blocking Account"; Rec."Reason For Blocking Account")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Account Blocked From Transacting';
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Resons for Status Change");
                    end;
                }
                field("Account Frozen"; Rec."Account Frozen")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Account Frozen By"; Rec."Account Frozen By")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Reason for Freezing Account"; Rec."Reason for Freezing Account")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Frozen Amount"; Rec."Frozen Amount")
                {
                    Visible = false;
                }
                field("ATM No."; Rec."ATM No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cheque Clearing No"; Rec."Cheque Clearing No")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
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
                field("Membership Status";Rec."Membership Status")
                {
                }
                field("Staff Account"; Rec."Staff Account")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Closure Notice Date"; Rec."Closure Notice Date")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }

                field("Resons for Status Change"; Rec."Resons for Status Change")
                {
                    Caption = 'Reason for Status Change';
                    Editable = false;
                    Visible = false;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    Editable = false;
                    MultiLine = true;
                    Visible = false;
                }
                field("Interest Earned"; Rec."Interest Earned")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Untranfered Interest"; Rec."Untranfered Interest")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Allowable Cheque Discounting %"; Rec."Allowable Cheque Discounting %")
                {
                    Editable = true;
                    Importance = Additional;
                    Visible = false;
                }
                field("S-Mobile No"; Rec."S-Mobile No")
                {
                    Editable = false;
                     Visible = false;
                }
                field("Mobile Transactions"; Rec."Mobile Transactions")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Account Special Instructions"; Rec."Account Special Instructions")
                {
                    Editable = false;
                    Importance = Additional;
                    Style = Attention;
                    StyleExpr = true;
                    Visible = false;
                }
                field("No Of Signatories"; Rec."No Of Signatories")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Account Creation Date"; Rec."Account Creation Date")
                {
                    Editable = false;
                    Visible = false;
                }
                group(Control25)
                {
                    Visible = false;
                    field("Excess Repayment Rule"; Rec."Excess Repayment Rule")
                    {
                    }
                }


                group("OverDraft Details")
                {
                   // Visible = OverDraftVisible;
                     Visible = false;
                    field("Over Draft Limit Amount"; Rec."Over Draft Limit Amount")
                    {
                        Importance = Promoted;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Over Draft Limit Expiry Date"; Rec."Over Draft Limit Expiry Date")
                    {
                        Editable = false;
                        Importance = Promoted;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Overdraft Sweeping Source"; Rec."Overdraft Sweeping Source")
                    {

                        trigger OnValidate()
                        begin
                            EnableSpecificSweepingAccount := false;
                            if Rec."Overdraft Sweeping Source" = Rec."overdraft sweeping source"::"Specific FOSA Account" then
                                EnableSpecificSweepingAccount := true;
                        end;
                    }
                    group("Specific Sweeping Account")
                    {
                        Caption = '.';
                        Visible = EnableSpecificSweepingAccount;
                        field("Specific OD Sweeping Account"; Rec."Specific OD Sweeping Account")
                        {
                        }
                    }
                    part(OverDraftApplications; "OverDraft Details SubPage")
                    {
                        SubPageLink = "Over Draft Account" = field("No.");
                    }
                }
            }
            group(ExemptBOSAPenalty)
            {
                Caption = 'Exempt BOSA Penalty';
                 Visible = false;
                //Visible = EnableBOSAPenaltyExemption;
                field("Exempt BOSA Penalty"; Rec."Exempt BOSA Penalty")
                {
                }
                field("Exemption Expiry Date"; Rec."Exemption Expiry Date")
                {
                }
            }
            
            group("Store Details")
            {
                 Visible = false;
                field("Business Name"; Rec."Business Name(Store)")
                {
                    //Editable = false;
                }
                field("Business Short Code"; Rec."Business Short Code(Store)")
                {
                    //Editable = false;
                }
                field("Business Type"; Rec."Business Type(Store)")
                {
                    // Editable = false;
                }
                field("Business Status"; Rec."Business Status(Store)")
                {
                    //Editable = false;

                }
                field("Business Location"; Rec."Business Location(Store)")
                {
                    // Editable = false;
                }
                field("Business Contact"; Rec."Business Contact(Store)")
                {
                    //  Editable = false;
                }
                field("Business Email"; Rec."Business Email(Store)")
                {
                    //Editable = false;
                }
                field("Business Phone"; Rec."Business Phone(Store)")
                {
                    //Editable = false;
                }
                field("Business Website"; Rec."Business Website(Store)")
                {
                    // Editable = false;
                }
                field("Business Description"; Rec."Business Description(Store)")
                {
                    // Editable = false;
                }
            }
            group(MdosiJr)
            {
                Caption = 'Junior Account';
                // Editable = false;
                Visible = childVisisble;
                field("Child Name";Rec."Child Name")
                {
                    // Editable = false;
                }
                field("Child Birth certificate";Rec."Child Birth certificate")
                {
                    // Editable = false;
                }
                field("Child DOB";Rec."Child DOB")
                {
                    // Editable = false;
                }
                field("Childs Gender";Rec."Childs Gender")
                {
                    // Editable = false;
                }
            }
            group("Contacts")
            {
                field("Salary Processing"; Rec."Salary Processing")
                {
                    // Editable = false;
                     Visible = false;
                }

                field("Salary earner"; Rec."Salary earner")
                {
                    // Editable = false;
                     Visible = false;
                }

                field(County; Rec.County)
                {
                    Editable = false;
                    Visible = true;
                }
                field("Sub-county"; Rec."Sub-county")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Area"; Rec."Area")
                {
                    Editable = false;
                }

                field("Nearest Landmark"; Rec."Nearest Landmark")
                {
                    Editable = false;
                    Caption = 'Nearest Landmark';
                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    Editable = false;
                    ShowMandatory = true;
                }


                field("Secondary Mobile No"; Rec."Secondary Mobile No")
                {
                    Editable = false;
                    Visible = true;
                }

                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    Editable = false;
                    Caption = 'Personal E-mail Address';
                }

                field("Work E-Mail"; Rec."Work E-Mail")
                {
                    Editable = false;
                    Caption = 'Job E-mail Address';
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Box Address';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }




            }
            group("Financials")
            {
                Visible = true;
                field("Bank Code"; Rec."Bank Code")
                {
                    Editable = false;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    Editable = false;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    Editable = false;
                    ;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    Editable = false;
                }
            }
            group("OverDraft Debt Collector Details")
            {
                Visible = false;
                field("OD Under Debt Collection"; Rec."OD Under Debt Collection")
                {
                }
                field("OD Debt Collector"; Rec."OD Debt Collector")
                {
                }
                field("OD Debt Collector Interest %"; Rec."OD Debt Collector Interest %")
                {
                    Editable = false;
                }
                field("Debt Collection date Assigned"; Rec."Debt Collection date Assigned")
                {
                    Editable = false;
                }
                field("Debt Collector Name"; Rec."Debt Collector Name")
                {
                    Editable = false;
                }
                field("OD Bal As At Debt Collection"; Rec."OD Bal As At Debt Collection")
                {
                    Editable = false;
                }
            }

            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Editable = false;
                Visible = Joint2DetailsVisible;
                field("Name 2"; Rec."Name 2")
                {
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No2"; Rec."Payroll/Staff No2")
                {
                    Caption = 'Payroll No';
                    Editable = false;
                }
                field("Address3-Joint"; Rec."Address3-Joint")
                {
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 2"; Rec."Postal Code 2")
                {
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 2"; Rec."Town 2")
                {
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 3"; Rec."Mobile No. 3")
                {
                    Caption = 'Mobile No.';
                    Editable = false;
                }
                field("Date of Birth2"; Rec."Date of Birth2")
                {
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("ID No.2"; Rec."ID No.2")
                {
                    Caption = 'ID No.';
                    Editable = false;
                }
                field("Passport 2"; Rec."Passport 2")
                {
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 2"; Rec."Member Parish 2")
                {
                    Caption = 'Member Parish';
                    Editable = false;
                }
                field("Member Parish Name 2"; Rec."Member Parish Name 2")
                {
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender2; Rec.Gender2)
                {
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status2"; Rec."Marital Status2")
                {
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code2"; Rec."Home Postal Code2")
                {
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town2"; Rec."Home Town2")
                {
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code2"; Rec."Employer Code2")
                {
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name2"; Rec."Employer Name2")
                {
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal2)"; Rec."E-Mail (Personal2)")
                {
                    Caption = 'E-Mail (Personal)';
                    Editable = false;
                }
            }
            group(Joint3Details)
            {
                Editable = false;
                Visible = Joint3DetailsVisible;
                field("Name 3"; Rec."Name 3")
                {
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No3"; Rec."Payroll/Staff No3")
                {
                    Caption = 'Payroll/Staff No';
                    Editable = false;
                }
                field(Address4; Rec.Address4)
                {
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 3"; Rec."Postal Code 3")
                {
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 3"; Rec."Town 3")
                {
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 4"; Rec."Mobile No. 4")
                {
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth3"; Rec."Date of Birth3")
                {
                    Caption = 'Date of Birth';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("ID No.3"; Rec."ID No.3")
                {
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 3"; Rec."Passport 3")
                {
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 3"; Rec."Member Parish 3")
                {
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Parish Name 3"; Rec."Member Parish Name 3")
                {
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender3; Rec.Gender3)
                {
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status3"; Rec."Marital Status3")
                {
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code3"; Rec."Home Postal Code3")
                {
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town3"; Rec."Home Town3")
                {
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code3"; Rec."Employer Code3")
                {
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name3"; Rec."Employer Name3")
                {
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal3)"; Rec."E-Mail (Personal3)")
                {
                    Editable = false;
                }
            }
            group("Fixed Deposit Details")
            {
                Caption = 'Term Deposit Details';
                Visible = false;
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    Caption = 'Term Deposit Type';
                    Editable = true;
                    Visible = true;
                }
                field("Fixed Deposit Start Date"; Rec."Fixed Deposit Start Date")
                {
                    Editable = true;
                }
                field("Fixed Duration"; Rec."Fixed Duration")
                {
                    Caption = 'Term Duration';
                    Editable = true;
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    Caption = 'Amount to Transfer from Current';
                    Editable = true;
                }
                field("Fixed Deposit Certificate No."; Rec."Fixed Deposit Certificate No.")
                {
                    Editable = false;
                }
                field("Expected Interest On Term Dep"; Rec."Expected Interest On Term Dep")
                {
                    Caption = 'Expected Interest Earned';
                    Editable = false;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    Caption = 'Maturity Date';
                    Editable = true;
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    Caption = 'Term Deposit Status';
                    Editable = false;
                }
                field("Term Deposit Status Type"; Rec."FDR Deposit Status Type")
                {
                    Caption = 'Term Deposit Status Type';
                    Editable = true;
                }
                field("On Term Deposit Maturity"; Rec."On Term Deposit Maturity")
                {
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    Editable = true;
                }
                field("Savings Account No."; Rec."Savings Account No.")
                {
                    Caption = 'Current Account No.';
                    Editable = false;
                }
                field("Transfer Amount to Savings"; Rec."Transfer Amount to Savings")
                {
                    Caption = 'Transfer Amount to Current';
                    Editable = false;
                }
                field("Last Interest Earned Date"; Rec."Last Interest Earned Date")
                {
                    Editable = false;
                }
            }
            group("Previous Term Deposit Details")
            {
                Caption = 'Previous Term Deposit Details';
                Editable = false;
                Visible = false;
                field("Prevous Fixed Deposit Type"; Rec."Prevous Fixed Deposit Type")
                {
                    Caption = 'Fixed Deposit Type';
                    Editable = false;
                }
                field("Prevous FD Start Date"; Rec."Prevous FD Start Date")
                {
                    Caption = 'Fixed Deposit Start Date';
                    Editable = false;
                }
                field("Prevous Fixed Duration"; Rec."Prevous Fixed Duration")
                {
                    Caption = 'Fixed Deposit Duration';
                    Editable = false;
                }
                field("Prevous Expected Int On FD"; Rec."Prevous Expected Int On FD")
                {
                    Caption = 'Expected Int On Fixed Deposit';
                    Editable = false;
                }
                field("Prevous FD Maturity Date"; Rec."Prevous FD Maturity Date")
                {
                    Caption = 'Fixed Maturity Date';
                    Editable = false;
                }
                field("Prevous FD Deposit Status Type"; Rec."Prevous FD Deposit Status Type")
                {
                    Caption = 'Fixed Deposit Status Type';
                    Editable = false;
                }
                field("Prevous Interest Rate FD"; Rec."Prevous Interest Rate FD")
                {
                    Caption = 'Interest Rate Fixed Deposit';
                    Editable = false;
                }
                field("Date Renewed"; Rec."Date Renewed")
                {
                }
            }
            group("ATM Details")
            {
                Caption = 'ATM Details';
                Editable = false;
                 Visible = false;
                field("ATM No.B"; Rec."ATM No.")
                {
                    Editable = false;
                }
                field("ATM Withdrawal Limit"; Rec."ATM Withdrawal Limit")
                {
                    //Visible = false;
                }
                field("ATM Transactions"; Rec."ATM Transactions")
                {
                    Visible = false;
                }
                field("Atm card ready"; Rec."Atm card ready")
                {
                    Caption = 'ATM Card Ready For Collection';
                    Visible = false;
                }
                field("FDR Deposit Status Type"; Rec."ATM Issued")
                {
                    Visible = false;
                }
                field("ATM Self Picked"; Rec."ATM Self Picked")
                {
                    Visible = false;
                }
                field("ATM Collector Name"; Rec."ATM Collector Name")
                {
                    Visible = false;
                }
                field("ATM Collector's ID"; Rec."ATM Collector's ID")
                {
                    Visible = false;
                }
                field("Card Status"; Rec."Card Status")
                {
                    //Visible = false;
                }
            }
            group("Bulk Withdrawal Application")
            {
                Caption = 'Bulk Withdrawal Application';
                Editable = false;
                Visible = false;
                field("Bulk Withdrawal Appl Done"; Rec."Bulk Withdrawal Appl Done")
                {
                    Caption = 'Bulk Withdrawal Appl. Done';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Date"; Rec."Bulk Withdrawal Appl Date")
                {
                    Caption = 'Bulk Withdrawal Appl. Date';
                    Editable = false;
                }
                field("Bulk Withdrawal App Date For W"; Rec."Bulk Withdrawal App Date For W")
                {
                    Caption = 'Withdrawal Date';
                }
                field("Bulk Withdrawal Appl Amount"; Rec."Bulk Withdrawal Appl Amount")
                {
                    Caption = 'Bulk Withdrawal Appl. Amount';
                    Editable = false;
                }
                field("Bulk Withdrawal Fee"; Rec."Bulk Withdrawal Fee")
                {
                    Caption = 'Bulk Withdrawal Fee';
                    Editable = false;
                }
                field("Bulk Withdrawal App Done By"; Rec."Bulk Withdrawal App Done By")
                {
                    Caption = 'Bulk Withdrawal Appl. Captured By';
                    Editable = false;
                }
            }
            group("Transaction Alerts Subscription")
            {
                Visible = false;
                field("Transaction Alerts"; Rec."Transaction Alerts")
                {
                    Caption = 'Transactions Alert';
                }
            }
            // part(Control30;"CloudPESA PIN Reset Logs")
            // {
            //     Caption = 'Sweeping Instructions';
            //     SubPageLink = "Account Name"=field("No."),
            //                   No=field("BOSA Account No");
            // }
            part(Control35; "Member Account Freeze Subpage")
            {
                Caption = 'Account Frozen Amounts Details';
                SubPageLink = "Account No" = field("No.");
                SubPageView = where(Frozen = filter(true));
                 Visible = false;
            }
        }
        area(factboxes)
        {
            part(Control1000000034; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
            part(Control16; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("BOSA Account No");
            }
            systempart(AccNotes; Notes)
            {
                Caption = 'Account Notes';
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Key Documents';
                SubPageLink = "Table ID" = const(Database::Vendor), "No." = field("No.");
            }
            part(Control1000116; "Vendor Child Picture")
            {
                Caption = 'Child Picture';
                Visible = childVisisble;
                Enabled = childVisisble;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000116; "Vendor Picture-Uploaded")
            {
                Caption = 'Picture';
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000115; "Vendor Signature-Uploaded")
            {
                Caption = 'Signature';
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000120; "Vendor ID-F-Uploaded")
            {
                Caption = 'ID Front';
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000121; "Vendor ID-B-Uploaded")
            {
                Caption = 'ID Back';
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Visible = false;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Vendor),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Visible = false;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(23),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("ATM Cards Linked")
                {
                    Image = List;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "ATM Card Nos Buffer";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Re-Link ATM Card")
                {
                    Caption = 'Link ATM Card';
                    Image = List;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction() begin
                        UserSetup.Get(UserId);
                        if UserSetup.Overdraft <> true then Error('You do not have permission to update ATM card information.');

                        if rec."Account Type" <> '103' then Error('The account has to be an Ordinary Savings account to link an ATM.');
                        if rec."ATM No." <> '' then Error('The account already has an ATM No. %1.', Rec."ATM No.");
                        
                        vend.Reset();
                        vend.SetRange("No.", Rec."No.");
                        if Vend.Find('-') then begin
                            Report.Run(175074, true, false, Vend);
                        end;
                    end;
                }
                action("Update Child Dob")
                {
                    Caption = 'Mdosi Jr DoB';
                    ToolTip = 'Update the date of birth in a mdosi junior account';
                    Image = DateRange;
                    Promoted = true;
                    PromotedCategory = Process;
                   Visible = false;
                    trigger OnAction() begin
                        UserSetup.Get(UserId);
                        if UserSetup.Overdraft <> true then Error('You do not have permission to update mdosi jr account details.');

                        if rec."Account Type" <> '109' then Error('The account has to be a Mdosi Junior account.');
                        if rec."Child DOB" <> 0D then Error('The account already has a child date of birth %1.', Rec."Child DOB");
                        
                        vend.Reset();
                        vend.SetRange("No.", Rec."No.");
                        if Vend.Find('-') then begin
                            Report.Run(175076, true, false, Vend);
                        end;
                    end;
                }
                action("Change Status")
                {
                    Caption = 'Change Member Account Status';
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = false;
                    trigger
                    OnAction()
                    var
                    UserSetUp: record "User Setup";
                    begin
                        UserSetup.Get(UserId);
                        if UserSetup."Change account status" <> true then
                            Error('You have no permissions to change the Member Account Status.');
                        //question:= Dialog.
                        if Confirm('Are you sure you wish to change the FOSA account status?', false) = true then begin
                            if Vend.Get(rec."No.") then begin
                                if Vend.status = Vend.status::Active then begin
                                    Vend.status := Vend.status::Dormant;
                                    Vend.Modify();
                                    Message('The account status is now  %1', Vend.status);
                                end
                                else if Vend.status <> Vend.status::Active then begin
                                    Vend.Status := Vend.status::Active;
                                    Vend.Modify();
                                    Message('The account status is now , %1', Vend.status);
                                end;
                            end;
                        end else begin
                            Message('Cancelled');
                        end;
                    end;
                }
                action("Freeze ATM Card")
                {
                    Image = Lock;
                    Promoted = true;
                    PromotedOnly = true;
Visible = false;
                    trigger
                    OnAction()
                    var
                    UserSetUp: record "User Setup";
                    begin
                        UserSetup.Get(UserId);
                        if UserSetup."Freeze Amount" <> true then Error('You have no permissions to freeze a member''s ATM card.');

                        if Confirm('Are you sure you wish to change the FOSA account status?', false) = true then begin
                            if Rec."Card Status" = Rec."Card Status"::Active then begin
                                Rec."Card Status" := Rec."Card Status"::Frozen;
                                Rec.Modify;
                                Message('The member''s ATM card status is %1.', Format(Rec."Card Status"));
                            end else if Rec."Card Status" = Rec."Card Status"::Frozen then begin
                                Rec."Card Status" := Rec."Card Status"::Active;
                                Rec.Modify;
                                Message('The member''s ATM card status is %1.', Format(Rec."Card Status"));
                            end;
                        end else begin
                            Message('Cancelled');
                        end;
                    end;
                }
                action("Re-new Fixed Deposit")
                {
                    Caption = 'Re-new Fixed Deposit';
                    Image = "Report";
                    Visible = false;

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
                action("Close Account")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
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
                action("Account Signatories ")
                {
                    Caption = 'Account Signatories';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    RunObject = Page "Account Signatories Details";
                    RunPageLink = "Account No" = field("BOSA Account No");
                }
                action("Account Agent Details")
                {
                    Caption = 'Account Agents';
                    Image = Form;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    RunObject = Page "Account Agent List";
                    RunPageLink = "Account No" = field("No.");
                }
                
                action(" Account Nominee Details")
                {
                    Caption = 'Account Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    Visible = false;
                    RunObject = Page "FOSA Account  NOK Details";
                    RunPageLink = "Account No" = field("No.");
                }
            }
            group(ActionGroup1102755009)
            {
                action("Transfer Term Amnt from Current")
                {
                    Visible = false;

                    trigger OnAction()
                    begin

                        //Transfer Balance if Fixed Deposit

                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin
                            //IF AccountTypes."Fixed Deposit" <> TRUE THEN BEGIN
                            if Vend.Get(Rec."Savings Account No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the Current account', false) = true then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                if Vend.Find('-') then
                                    Vend.CalcFields(Vend."Balance (LCY)");
                                //IF (Vend."Balance (LCY)" - 500) < "Fixed Deposit Amount" THEN
                                //ERROR('Savings account does not have enough money to facilate the requested trasfer.');
                                //MESSAGE('Katabaka ene!');
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Savings Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Term Balance Tranfers';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                //GenJournalLine.Amount:="Fixed Deposit Amount";
                                GenJournalLine.Amount := Rec."Amount to Transfer";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //MESSAGE('The FDR amount is %1 ',"Fixed Deposit Amount");
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Term Balance Tranfers';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                //GenJournalLine.Amount:=-"Fixed Deposit Amount";
                                GenJournalLine.Amount := -Rec."Amount to Transfer";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //END;
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;



                        /*//Post New
                        
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        END;
                        
                        //Post New
                        */

                        /*
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        GenJournalLine.DELETEALL;
                        
                           */
                        //Transfer Balance if Fixed Deposit

                    end;
                }
                action("Transfer Term Amount to Current")
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
                                    if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
                                        GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.Find('-') then
                                        GenJournalLine.DeleteAll;

                                    Vend.CalcFields(Vend."Balance (LCY)");
                                    if (Vend."Balance (LCY)") < Rec."Transfer Amount to Savings" then
                                        Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Term Balance Tranfers';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := Rec."Transfer Amount to Savings";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."Savings Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Term Balance Tranfers';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := -Rec."Transfer Amount to Savings";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
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

                    end;
                }
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
                action("Break Call")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(172465, true, false, Vend)
                    end;
                }
                action("Member Statement")
                {
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Visible = FALSE;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        /*
                        IF ("Assigned System ID"<>'')  THEN BEGIN //AND ("Assigned System ID"<>USERID)
                          IF UserSetup.GET(USERID) THEN
                        BEGIN
                        IF UserSetup."View Special Accounts"=FALSE THEN ERROR ('You do not have permission to view this account Details, Contact your system administrator! ')
                        END;
                        
                          END;*/
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."BOSA Account No");
                        if Cust.Find('-') then
                            Report.run(172886, true, false, Cust);

                    end;
                }
                action("Page Vendor Statement")
                {
                    Caption = 'Account Statement';
                    Image = "Report";
                    Visible = FALSE;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;

                        end;
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(172890, true, false, Vend)

                        //Report.run(172476,TRUE,FALSE,Vend)
                    end;
                }
                action("NewPage Vendor Statement")
                {
                    Caption = 'NewAccount Statement';
                    Image = "Report";
                    Visible = FALSE;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin


                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(304, true, false, Vend)

                        //Report.run(172476,TRUE,FALSE,Vend)
                    end;
                }
                action("FOSA Statement")
                {
                    Caption = 'FOSA Statement';
                    Image = "Report";
                    Promoted = true;
                    Visible = FALSE;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin


                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(172476, true, false, Vend)

                        //Report.run(172476,TRUE,FALSE,Vend)
                    end;
                }
                action("Old FOSA Statement")
                {
                    Caption = 'Old FOSA Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then begin
                            Report.run(50230, true, false, Vend);
                        end;
                    end;
                }
                action("FOSA Statement New")
                {
                    Caption = 'Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin


                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(50004, true, false, Vend);
                        //Report.run(172476,TRUE,FALSE,Vend)
                    end;
                }
                action("&Card")
                {
                    Caption = 'Member Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = FIELD("BOSA Account No");
                    ShortCutKey = 'Shift+F7';

                }
                action("Page Vendor Statistics")
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    Visible = false;
                }
                action("Members Statistics")
                {
                    Caption = 'Member Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                action("Charges")
                {
                    Caption = 'Charges';
                    Image = Statistics;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Front Office Charges";
                }
                action("Charge Statement Fee")
                {
                    Image = CalculateCost;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ObjAccount.Reset;
                        ObjAccount.SetRange(ObjAccount."No.", Rec."No.");
                        if ObjAccount.Find('-') then
                            Report.run(172142, true, false, ObjAccount)
                    end;
                }
                action("Recover Class B Shares")
                {
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    Visible = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    

                    trigger OnAction()
                    begin

                        if Rec."Account Type" = 'SPECIAL' then
                            Error('You cannot recover Class B Shares from this account');

                        if Rec."Shares Recovered" = true then
                            Error('Class B shares already recovered');

                        if Confirm('Are you sure you want to recover Class B shares? This will recover Class B shares.', false) = false then
                            exit;


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin

                            // charges
                            Charges.Reset;
                            Charges.SetRange(Charges.Code, AccountTypes."FOSA Shares");
                            if Charges.Find('-') then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Rec.CalcFields("Balance (LCY)", "ATM Transactions");
                                if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= Charges."Charge Amount" then
                                    Error('This Account does not have sufficient funds');

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No." + '-FSH';
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


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                end;

                                //Post New


                            end;
                            //Closure charges

                        end;

                        Rec."Shares Recovered" := true;
                        Rec."ClassB Shares" := -Charges."Charge Amount";
                        Rec.Modify;
                    end;
                }
                action("Charge ATM Card Placement")
                {
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    Visible = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to post the ATM Charges fee?') = false then
                            exit;


                        Rec.CalcFields("Balance (LCY)", "ATM Transactions");
                        if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: ' + Rec."Card No.";
                        GenJournalLine.Amount := 550;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := 'BNK000001';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: No.' + Rec."Card No.";
                        GenJournalLine.Amount := -500;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Comms to Commissions account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := '4-11-000310';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges' + 'No.' + Rec."Card No.";
                        GenJournalLine.Amount := -50;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        end;
                        //Post New
                    end;
                }
                action("Charge ATM Card Replacement")
                {
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    Visible = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to post the ATM Charges fee?') = false then
                            exit;


                        Rec.CalcFields("Balance (LCY)", "ATM Transactions");
                        if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: ' + Rec."Card No.";
                        GenJournalLine.Amount := 600;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := 'BNK000001';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: No.' + Rec."Card No.";
                        GenJournalLine.Amount := -500;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Comms to Commissions account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := '4-11-000310';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges' + 'No.' + Rec."Card No.";
                        GenJournalLine.Amount := -100;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        end;
                        //Post New
                    end;
                }
                action("Charge Pass Book")
                {
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to charge Pass book fee? This will recover passbook fee.', false) = false then
                            exit;

                        Rec.CalcFields("Balance (LCY)", Rec."ATM Transactions");
                        if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin

                            //Closure charges
                            Charges.Reset;
                            Charges.SetRange(Charges.Code, AccountTypes."Statement Charge");
                            if Charges.Find('-') then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No." + '-STM';
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


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                end;

                                //Post New


                            end;
                            //Closure charges

                        end;
                    end;
                }
                action("Account Signatories")
                {
                    RunObject = Page "Account Signatories Card";
                    RunPageLink = "Account No" = field("No.");
                    Visible = false;
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
                action("Freeze Amount")
                {
                    Caption = 'Freeze Amount';
                    Image = Lock;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    PromotedOnly = true;
                    RunObject = Page "New Account Freeze Amount";
                    RunPageLink = "Account No" = field("No."),
                                  "Member No" = field("BOSA Account No");
                }
                action("New Sweeping Instruction")
                {
                    Caption = 'New Sweeping Instruction';
                    Image = TransferFunds;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Sweeping Instructions List";
                    RunPageLink = "Member No" = field("BOSA Account No"),
                                  "Monitor Account" = field("No.");
                }
                action(Correct)
                {
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction() begin
                        // Rec.TestField("G/L Account No.", '200-000-152');
                        if Confirm('Do you wish to rectify this erroneous account creation?', true) = false then exit;
                        Customer.Reset();
                        Customer.SetRange("No.", Rec."BOSA Account No");
                        if Customer.Find('-') then begin
                            Vend.Reset();
                            Vend.SetRange("BOSA Account No", Cust."No.");
                            Vend.SetRange("Account Type", '103');
                            if Vend.Find('-') then begin
                                Customer."FOSA Account No." := Vend."No.";
                                Customer."Ordinary Savings Acc" := Vend."No.";
                                Customer.Modify;
                            end;
                        end;
                        Rec.Delete;
                    end;
                }
                action("Send Member Statement")
                {
                    Caption = 'Send Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."BOSA Account No");
                        if Cust.Find('-') then
                            Report.run(172073, true, false, Cust);
                    end;
                }
                action("Send Account Statement")
                {
                    Caption = 'Send Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            //Report.run(172890,TRUE,FALSE,Vend);
                            Report.run(172072, true, false, Vend);
                    end;
                }

            }
        }
    }

    trigger OnAfterGetCurrRecord() begin
        // hrEmployees.Reset();
        // hrEmployees.SetRange("No.", Rec."Personal No.");
        // if hrEmployees.Find('-') then begin
        //     UserSetup.Reset();
        //     UserSetup.SetRange("User ID", UserId);
        //     if UserSetup.Find('-') then begin
        //         if UserSetup."Can View Staff Accounts" then begin
        //             // staffView := true;
        //         end else begin
        //             Rec.SetRange("Personal No.", hrEmployees."No.");
        //         end;
        //     end else Error('The user: %1, does not have permissions to view other staff accounts.', UserId);
        // end else Error('The user: %1, does not have permissions to view other staff accounts.', UserId);

        Vend.Reset();
        Vend.SetRange("No.", Rec."No.");
        if Vend.Find('-') then begin
            // Message('Balance %1', Vend.GetAvailableBalance());
        end;
    end;

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

        fdVisisble := false;
        if rec."Account Type" = '108' then begin
            fdVisisble:= true;
        end;
        childVisisble := false;
        if rec."Account Type" = '109' then begin
            childVisisble:= true;
        end;
        storeVisible := false;
        if rec."Account Type" = '111' then begin
            storeVisible:= true;
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
        
        fdVisisble := false;
        if rec."Account Type" = '108' then begin
            fdVisisble:= true;
        end;
        childVisisble := false;
        if rec."Account Type" = '109' then begin
            childVisisble:= true;
        end;
        storeVisible := false;
        if rec."Account Type" = '111' then begin
            storeVisible:= true;
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

        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if user."Freeze Amount" = true
            then begin
                canfreezeamt := true;
            end;

        Vend.Reset();
        Vend.SetRange("No.", Rec."No.");
        if Vend.Find('-') then begin
            // Message('Balance %1', Vend.GetAvailableBalance());
        end;
    end;
    end;

    var
        canfreezeamt: Boolean;
        User: Record "User Setup";
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
        hrEmployees: Record "HR Employees";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record "Members Register";
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        customer: Record Customer;
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
        fdVisisble: Boolean;
        childVisisble: Boolean;
        storeVisible: Boolean;
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




