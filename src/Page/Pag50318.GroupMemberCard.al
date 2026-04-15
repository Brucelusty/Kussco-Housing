//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50318 "Group Member Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                // Editable =
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    //Editable = EditableField;
                    // OptionCaption = 'Group';

                    trigger OnValidate()
                    // var
                    // Joint2DetailsVisible: Boolean;
                    begin
                        // Joint2DetailsVisible := false;

                        // if Rec."Account Category" = Rec."account category"::Joint then begin
                        //     Joint2DetailsVisible := true;
                        // end;
                        // if Rec."Account Category" <> Rec."account category"::Group then begin
                        //     NumberofMembersEditable := false
                        // end else
                        //     NumberofMembersEditable := true;
                    end;
                }
                field("Group Category";Rec."Group Category")
                {

                }
                field("Name of the Group/Corporate"; Rec."Name of the Group/Corporate")
                {
                    // Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Certificate No"; Rec."Certificate No")
                {
                    // Enabled = EditableField;
                    ShowMandatory = true;
                }
                field(Pin;Rec.Pin)
                {
                    Caption = 'KRA Pin';
                    // Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; Rec."Group Mobile Phone No")
                {
                    // Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Old Ordinary Account NAV2016";Rec."Old Ordinary Account NAV2016")
                {
                }
                field("FOSA Account No."; Rec."FOSA Account No.")
                {
                    //Editable = false;
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Address';
                    //Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Post Code";Rec."Post Code")
                {
                    //  Editable = EditableField;
                }
                field(Town; Rec.Town)
                {
                    //  Editable = TownEditable;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    // Editable = CountryEditable;
                }
                field(City; Rec.City)
                {
                }
                field(County; Rec.County)
                {
                    LookupPageId = County;
                }
                field(District; Rec.District)
                {
                    Visible = false;
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    Visible = false;
                }
                field("Date of Registration"; Rec."Date of Registration")
                {
                    // Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("No of Members"; Rec."No of Members")
                {
                    // Editable = EditableField;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    // Enabled = EditableField;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    // Editable = EditableField;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    // Editable = CustPostingGroupEdit;
                }
                field("Membership Status";Rec."Membership Status")
                {
                    Editable = false;
                }
                field("Transactional Status";Rec.Status)
                {
                    Editable = false;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    // Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
            }
            group("Referee Details")
            {
                field("Referee Member No"; Rec."Referee Member No")
                {
                    // Editable = RefereeEditable;
                }
                field("Referee Name"; Rec."Referee Name")
                {
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {
                }
            }
            group("Savings Accounts & Contributions")
            {
                Editable = false;
                field("Ordinary Savings Acc";Rec."Ordinary Savings Acc")
                {
                    Editable = false;
                }
                field("Chamaa Savings Acc";Rec."Chamaa Savings Acc")
                {
                    Editable = false;
                }
                field("Fixed Deposit Acc";Rec."Fixed Deposit Acc")
                {
                    Editable = false;
                }
                field("Business Account Acc";Rec."Business Account Acc")
                {
                    Editable = false;
                }
                field("Share Capital No"; Rec."Share Capital No")
                {
                    Editable = false;
                }
                field("Share Capital Contribution";Rec."Share Capital Contribution")
                {
                    Editable = false;
                }
                field("Deposits Account No"; Rec."Deposits Account No")
                {
                    Editable = false;
                }
                field("Deposits Contribution";Rec."Monthly Contribution")
                {
                    Editable = false;
                    Caption = 'BOSA Deposits Contribution';
                }
                field("School Fees Shares Account"; Rec."School Fees Shares Account")
                {
                    Editable = false;
                    Caption = 'ESS Shares Account No';
                }
                field("ESS Contribution."; Rec."ESS Contribution")
                {
                    Editable = false;
                }
                field("Wezesha Savings Acc";Rec."Wezesha Savings Acc")
                {
                    Editable = false;
                }
                field("Wezesha Savings Contribution";Rec."Wezesha Savings Contribution")
                {
                    Editable = false;
                }
                field("Jibambe Savings Acc";Rec."Jibambe Savings Acc")
                {
                    Editable = false;
                }
                field("Jibambe Savings Contribution";Rec."Jibambe Savings Contribution")
                {
                    Editable = false;
                }
                field("Mdosi Junior Acc";Rec."Mdosi Junior Acc")
                {
                    Editable = false;
                }
                field("Mdosi Jr Contribution";Rec."Mdosi Jr Contribution")
                {
                    Editable = false;
                }
                field("Pension Akiba";Rec."Pension Akiba")
                {
                    Editable = false;
                }
                field("Pension Akiba Contribution";Rec."Pension Akiba Contribution")
                {
                    Editable = false;
                }
            }
            group("Communication Info")
            {
                Caption = 'Communication Info';
                // Editable = EditableField;
                field("Office Telephone No."; Rec."Office Telephone No.")
                {
                    // Enabled = EditableField;
                    Editable = true;
                }
                // field("Office Extension"; Rec."Office Extension")
                // {
                //     Enabled = EditableField;
                // }

                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    // Editable = EmailEdiatble;
                    // Enabled = EditableField;
                }
                field("Home Address"; Rec."Home Address")
                {
                }
                field("Home Postal Code"; Rec."Home Postal Code")
                {
                    // Editable = HomeAddressPostalCodeEditable;
                }
                field("Home Town"; Rec."Home Town")
                {
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    // Editable = ContactPEditable;
                    ShowMandatory = true;
                }
                field("Contact Person Phone"; Rec."Contact Person Phone")
                {
                    // Editable = ContactPPhoneEditable;
                    ShowMandatory = true;
                }
                field("ContactPerson Relation"; Rec."ContactPerson Relation")
                {
                    // Editable = ContactPRelationEditable;
                }
            }
            group("Trade Information")
            {
                Caption = 'Trade Information';
                field("Group/Corporate Trade"; Rec."Group/Corporate Trade")
                {
                    // Enabled = EditableField;
                    ShowMandatory = true;
                    LookupPageId = TRADE;
                }
                field(Occupation; Rec.Occupation)
                {
                }
                field("Others Details"; Rec."Others Details")
                {
                    // Editable = OthersEditable;
                }
            }
            group("Member Risk Ratings")
            {
                Visible = false;
                group("Member Risk Rate")
                {
                    field("Individual Category"; Rec."Individual Category")
                    {
                        ShowMandatory = true;
                    }
                    field("Member Residency Status"; Rec."Member Residency Status")
                    {
                        ShowMandatory = true;
                    }
                    field(Entities; Rec.Entities)
                    {
                    }
                    field("Industry Type"; Rec."Industry Type")
                    {
                        ShowMandatory = true;
                    }
                    field("Length Of Relationship"; Rec."Length Of Relationship")
                    {
                        ShowMandatory = true;
                    }
                    field("International Trade"; Rec."International Trade")
                    {
                        ShowMandatory = true;
                    }
                }
                group("Product Risk Rating")
                {
                    field("Electronic Payment"; Rec."Electronic Payment")
                    {
                        ShowMandatory = true;
                    }
                    field("Accounts Type Taken"; Rec."Accounts Type Taken")
                    {
                        ShowMandatory = true;
                    }
                    field("Cards Type Taken"; Rec."Cards Type Taken")
                    {
                        ShowMandatory = true;
                    }
                    field("Others(Channels)"; Rec."Others(Channels)")
                    {
                        ShowMandatory = true;
                    }
                    field("Member Risk Level"; Rec."Member Risk Level")
                    {
                        Caption = 'Risk Level';
                        Editable = false;
                        // Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; Rec."Due Diligence Measure")
                    {
                        Editable = false;
                        //  Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }
                part(Control20; "Member Due Diligence Measure")
                {
                    Caption = 'Due Diligence Measure';
                    SubPageLink = "Member No" = field("No.");
                    SubPageView = sorting("Due Diligence No");
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000107; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000106; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000155; "Member FrontID-Uploaded")
            {
                Caption = 'Front ID';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000156; "Member BackID-Uploaded")
            {
                Caption = 'Back ID';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                }
                action("Insert School Fees Shares")
                {
                    Caption = 'Update the ESS shares';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ObjCust: Record Customer;
                        ObjAccounts: Record Vendor;
                    begin
                        if Confirm('Updating the member ESS Shares...', false) = true then begin
                            begin

                                ObjAccounts.Reset;
                                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", rec."No.");
                                ObjAccounts.SetFilter(ObjAccounts."Account Type", '104');
                                ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
                                if ObjAccounts.FindFirst() then begin
                                    rec."School Fees Shares Account" := ObjAccounts."No.";
                                    rec.Modify(true);
                                end;
                            end;
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
                    begin
                        //question:= Dialog.
                        if Confirm('Are you sure you wish to change the member account status?', false) = true then begin
                            if Cust.Get(rec."No.") then begin
                                if Cust.status = Cust.status::Active then begin
                                    Cust.status := cust.status::Dormant;
                                    Cust.Modify();
                                    Message('The member status is now  %1', cust.status);
                                end
                                else if Cust.status <> Cust.status::Active then begin
                                    Cust.Status := cust.status::Active;
                                    Cust.Modify();
                                    Message('The member status is now , %1', cust.status);
                                end;
                            end;
                        end
                        else begin
                            Message('Cancelled');
                        end;
                    end;
                }
                action("Change Transaction Status")
                {
                    Caption = 'Change Transaction Status';
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = false;
                    trigger
                    OnAction()
                    begin
                        //question:= Dialog.
                        if Confirm('Are you sure you wish to change the Transaction status?', false) = true then begin
                            if Mem.Get(rec."No.") then begin
                                if Mem.status = Mem.status::Active then begin
                                    Mem.status := Mem.status::Dormant;
                                    Mem.Modify();
                                    Message('The account status is now  %1', Mem.status);
                                end
                                else
                                    if Mem.status <> Mem.status::Active then begin
                                        Mem.Status := Mem.status::Active;
                                        Mem.Modify();
                                        Message('The account status is now , %1', Mem.status);
                                    end;
                            end;
                        end
                        else begin
                            Message('Cancelled');
                        end;
                    end;
                }

                action("Update Member FOSA Accounts")
                {
                    Caption = 'Display Member''s FOSA Accounts.';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedOnly = true;
                    trigger
                    OnAction()
                    begin
                        //question:= Dialog.
                        if Confirm('Are you sure you wish to update the member''s FOSA accounts?', false) = true then begin
                            Vend.Reset();
                            Vend.SetRange("BOSA Account No", Rec."No.");
                            if Vend.Find('-') then begin
                                repeat
                                    if Vend."Account Type" = '101' then begin
                                        Rec."Share Capital No" := Vend."No.";
                                        Rec.Modify(true);
                                    end else
                                        if Vend."Account Type" = '102' then begin
                                            Rec."Deposits Account No" := Vend."No.";
                                            Rec.Modify(true);
                                        end else
                                            if Vend."Account Type" = '103' then begin
                                                Rec."FOSA Account No." := Vend."No.";
                                                Rec."Ordinary Savings Acc" := Vend."No.";
                                                Rec.Modify(true);
                                            end else
                                            if Vend."Account Type" = '104' then begin
                                                Rec."School Fees Shares Account" := Vend."No.";
                                                Rec.Modify(true);
                                            end else
                                            if Vend."Account Type" = '105' then begin
                                                Rec."Chamaa Savings Acc" := Vend."No.";
                                                Rec.Modify(true);
                                            end else
                                            if Vend."Account Type" = '106' then begin
                                                Rec."Jibambe Savings Acc" := Vend."No.";
                                                Rec.Modify(true);
                                            end else
                                            if Vend."Account Type" = '107' then begin
                                                Rec."Wezesha Savings Acc" := Vend."No.";
                                                Rec.Modify(true);
                                            end else
                                            if Vend."Account Type" = '108' then begin
                                                Rec."Fixed Deposit Acc" := Vend."No.";
                                                Rec.Modify(true);
                                            end else
                                            if Vend."Account Type" = '109' then begin
                                                Rec."Mdosi Junior Acc" := Vend."No.";
                                                Rec.Modify(true);
                                            end else
                                            if Vend."Account Type" = '110' then begin
                                                Rec."Pension Akiba Acc" := Vend."No.";
                                                Rec.Modify(true);
                                            end else
                                            if Vend."Account Type" = '111' then begin
                                                Rec."Business Account Acc" := Vend."No.";
                                                Rec.Modify(true);
                                            end 
                                until Vend.Next() = 0;
                            end;
                        end
                        else begin
                            Message('Cancelled');
                        end;
                    end;
                }
                action("Rejoin Member")
                {
                    ToolTip = 'Reactivate an exited or closed member''s account.';
                    Image = NewCustomer;
                    Enabled = (Rec."Membership Status" = rec."Membership Status"::Closed);
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    
                    trigger OnAction() 
                    var
                        ObjGenSetUp: Record "Sacco General Set-Up";
                        GenJournalLine: Record "Gen. Journal Line";
                        LineNo: Integer;
                        page: page 9305;
                        Options: Text[250];
                        Selected: Integer;
                        Text000: Label 'M-Pesa Paybill,FOSA Account';
                        Text001: Label 'You selected option %1.';
                        Text002: Label 'Choose one of the following payment options:';
                        SFactory: CodeUnit "Au Factory";
                        transactionTypeEnum: Enum TransactionTypesEnum;
                        template: Text[250];
                        batch: Text[250];
                        docNo: Code[30];
                    begin

                        if (Rec."Membership Status" <> rec."Membership Status"::Closed) then begin
                            Error('The member''s status is %1. It should be %2 or %3.', Rec."Membership Status", Cust."Membership Status"::"Fully Exited", Cust."Membership Status"::Closed);
                        end;
                        
                        if Confirm('The member will be charged a re-activation fee. Do you wish to proceed with re-activating this member?', true) = false then exit;

                        // ObjGenSetUp.Get();

                        // template:= 'GENERAL';
                        // batch:= 'REACTIVE';
                        // docNo:= 'REJOINING FEE-'+Format(Rec."No.");

                        // GenJournalLine.Reset;
                        // GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        // GenJournalLine.SetRange("Journal Batch Name", 'REACTIVE');
                        // GenJournalLine.DeleteAll;

                        // //Charge Reactivation Fee

                        // Options := Text000;
                        // Selected := Dialog.StrMenu(Options, 1, Text002);
                        // // Message(Text001, Selected);
                        // if Selected = 1 then begin

                        //     LineNo := LineNo + 10000;

                        //     SFactory.FnCreateGnlJournalLine(template, batch, docNo, LineNo, GenJournalLine."Transaction Type"::"Rejoining Fee", GenJournalLine."Account Type"::Customer, Rec."No.", Today, ObjGenSetUp."Rejoining Fee", 'BOSA', '', (Format(Rec."No.")+'-REJOIN_FEE-'+Rec.Name), '', GenJournalLine."Application Source"::" ");

                        // end else if Selected = 2 then begin
                            
                        //     LineNo := LineNo + 10000;

                        //     SFactory.FnCreateGnlJournalLine(template, batch, docNo, LineNo, GenJournalLine."Transaction Type"::"Rejoining Fee", GenJournalLine."Account Type"::Customer, Rec."No.", Today, ObjGenSetUp."Rejoining Fee", 'BOSA', '', (Format(Rec."No.")+'-REJOIN_FEE-'+Rec.Name), '', GenJournalLine."Application Source"::" ");
                            
                        // end else begin
                        //     Message('Process Stopped.');
                        // end;

                        // GenJournalLine.Reset;
                        // GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        // GenJournalLine.SetRange("Journal Batch Name", 'REACTIVE');
                        // if GenJournalLine.Find('-') then begin
                        //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        // end;

                        Rec."Membership Status" := Rec."Membership Status"::Dormant;
                        Rec.Rejoined := True;
                        Rec."Rejoining Date" := Today;
                        Rec."Rejoined By" := UserId;
                        Rec.Modify;
                    end;
                }
                action("Change Loan Category")
                {
                    Caption = 'Change Loans Category';
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedOnly = true;
                    trigger
                    OnAction()
                    begin
                        if userSetup.Get(UserId) then begin
                            if (Rec."Employer Code" = 'POSTAL CORP') or (Rec."Employer Code" = 'KENYA POSTAL') then begin
                                if userSetup."Change Defaulter Status" = false then begin
                                    Error('You cannot change this member''s loan status to performing.');
                                end;
                            end else begin
                                if (userSetup."Change Defaulter Status" = false) or (userSetup."Is Manager" = false) then begin
                                    Error('You cannot change this member''s loan status to performing.');
                                end;
                            end;
                        end;
                        if Confirm('Are you sure you wish to change all of this member''s loan status to performing?', false) = true then begin
                            LoanApp.Reset();
                            LoanApp.SetRange("Client Code", Rec."No.");
                            if LoanApp.FindSet() then begin
                                repeat
                                    LoanApp."Loans Category" := LoanApp."Loans Category"::Perfoming;
                                    LoanApp.Modify();
                                until LoanApp.Next() = 0;
                                Message('The loan categories are now , %1', LoanApp."Loans Category");
                            end;
                        end
                        else begin
                            Message('Cancelled');
                        end;
                    end;
                }
                action("Change Defaulted Status")
                {
                    Caption = 'Change Loan Defaulted Status';
                    Image = NewStatusChange;
                    Promoted = true;
                    PromotedOnly = true;
                    trigger
                    OnAction()
                    begin
                        if userSetup.Get(UserId) then begin
                            if (Rec."Employer Code" = 'POSTAL CORP') or (Rec."Employer Code" = 'KENYA POSTAL') then begin
                                if userSetup."Change Defaulter Status" = false then begin
                                    Error('You cannot change this  member''s defaulted status.');
                                end;
                            end else begin
                                if (userSetup."Change Defaulter Status" = false) or (userSetup."Is Manager" = false) then begin
                                    Error('You cannot change this  member''s defaulted status.');
                                end;
                            end;
                        end;
                        if Confirm('Are you sure you wish to change the member''s defaulted status?', false) = true then begin
                            LoanApp.Reset();
                            LoanApp.SetRange("Client Code", Rec."No.");
                            LoanApp.SetRange("Loan Product Type", 'A03');
                            LoanApp.SetFilter("Total Outstanding Balance", '>%1', 0);
                            LoanApp.SetFilter("Expected Date of Completion", '<%1', Today);
                            if LoanApp.Find('-') then begin
                                LoanApp.CalcFields("Total Outstanding Balance");
                                Error('The member has a defaulted mobile loan advance: %1 with a balance of %2.', LoanApp."Loan  No.", LoanApp."Total Outstanding Balance");
                            end;
                            if rec.Defaulter = true then begin
                                rec.Defaulter := false;
                                rec."Loan Defaulter" := false;
                                rec.Modify();
                            end else if rec.Defaulter = false then begin
                                rec.Defaulter := true;
                                rec."Loan Defaulter" := true;
                                rec.Modify();
                            end;

                            LoanApp.Reset();
                            LoanApp.SetRange("Client Code", Rec."No.");
                            if LoanApp.FindSet() then begin
                                repeat
                                    if LoanApp.Defaulted = true then begin
                                        LoanApp.Defaulted := false;
                                        LoanApp.Modify();
                                    end else if LoanApp.Defaulted = false then begin
                                        LoanApp.Defaulted := true;
                                        LoanApp.Modify();
                                    end
                                until LoanApp.Next() = 0;
                                Message('Default status updated successfully');
                            end;
                        end
                        else begin
                            Message('Cancelled');
                        end;
                    end;
                }
                action("Correct Reg Date")
                {
                    Caption = 'Correct Registration Date';
                    Image = ChangeDates;
                    Promoted = true;
                    PromotedOnly = true;
                    
                    trigger
                    OnAction()
                    var
                    member: Record Customer;
                    useSetup: Record "User Setup";
                    begin
                        if useSetup.Get(UserId) then begin
                            if useSetup."Send Red Flagged SMS" = false then Error('You cannot change the registration date.');
                            member.Reset();
                            member.SetRange("No.", rec."No.");
                            if member.Find('-') then begin
                                Report.Run(175066, true, false, member);
                            end;
                        end;
                    end;
                }
                action("UpdateStatusforExit")
                {
                    Caption = 'Update Status';
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = false;
                    
                    trigger
                    OnAction()
                    var
                    member: Record Customer;
                    useSetup: Record "User Setup";
                    begin
                        if useSetup.Get(UserId) then begin
                            if useSetup."Can edit recovery mode" = false then Error('You cannot change the member''s status.');
                            rec."Membership Status" := rec."Membership Status"::Active;
                            rec.modify;
                            Message('Membership status changed successfully.');
                        end;
                    end;
                }
                action(Dimensions)
                {
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Bank Account")
                {
                    Image = Card;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    Visible = false;
                }
                action(Contacts)
                {
                    Image = ContactPerson;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                action("Go to FOSA Accounts")
                {
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("No.");
                    Visible = false;
                }
                action("Member Savings")
                {
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page MemberSavings;
                    RunPageLink = MemberNo = field("No.");
                }
            }
            group(ActionGroup1102755023)
            {
                action("Members Kin Details List")
                {
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Member Next of Kin List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    Caption = 'Signatories Details';
                    Image = CustomerContact;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    // RunObject = Page "Member Account Signatory list";
                    RunObject = Page "Account Signatories Card";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Agent Account list";
                    RunPageLink = "Account No" = field("No.");
                    Visible = false;
                }
                action("Members Statistics")
                {
                    Caption = 'Member Details';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                action("Member is  a Guarantor")
                {
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(80009, true, false, Cust);
                    end;
                }
                action("Member is  Guaranteed")
                {
                    Caption = 'Member is  Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(80010, true, false, Cust);
                    end;
                }
                action("Create Withdrawal Application")
                {
                    Image = Document;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to create a Withdrawal Application for this Member', false) = true then begin
                            SurestepFactory.FnCreateMembershipWithdrawalApplication(Rec."No.", Rec."Withdrawal Application Date", Rec."Reason For Membership Withdraw", Rec."Withdrawal Date");
                        end;
                    end;
                }
                action("Member Risk Ratings.")
                {
                    Image = View;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Individual Member Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin
                        /*//Risk Rating Options Default
                        ObjMembershipApp.RESET;
                        ObjMembershipApp.SETRANGE(ObjMembershipApp."Assigned No.","No.");
                        IF ObjMembershipApp.FINDSET THEN
                          BEGIN
                          "Electronic Payment":=ObjMembershipApp."Electronic Payment";
                          "Cards Type Taken":=ObjMembershipApp."Cards Type Taken";
                          "Others(Channels)":=ObjMembershipApp."Others(Channels)";
                          "Individual Category":=ObjMembershipApp."Individual Category";
                          "Member Residency Status":=ObjMembershipApp."Member Residency Status";
                          "Industry Type":=ObjMembershipApp."Industry Type";
                          "Length Of Relationship":=ObjMembershipApp."Length Of Relationship";
                          Entities:=ObjMembershipApp.Entities;
                          END;
                        */

                        SFactory.FnGetMemberAMLRiskRating(Rec."No.");

                    end;
                }
                action("Account Statement Transactions ")
                {
                    Image = Form;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Statement Buffe";
                    RunPageLink = "Loan No" = field("No.");
                }
                action("Member Deposit Saving History")
                {
                    Image = Form;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Member Deposit Saving History";
                    RunPageLink = "Loan No" = field("No.");
                }

                action("Update Member Ledger Entry")
                {
                    Image = Form;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = xmlport "Update Member Data";

                }
                action("Charge Rgistration Fee")
                {
                    Image = Form;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ObjGenSetUp: Record "Sacco General Set-Up";
                        GenJournalLine: Record "Gen. Journal Line";
                        LineNo: Integer;
                    begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                        GenJournalLine.DeleteAll;

                        ObjGenSetUp.Get();

                        //Charge Registration Fee
                        if confirm('Are you sure you want to Charge Member Registration Fee?', false) = true then begin
                            ObjGenSetUp.Get();

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'REGFee';
                            GenJournalLine."Document No." := Rec."No.";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := Rec."No.";
                            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Registration Fee";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine."External Document No." := 'REGFEE/' + Format(Rec."Payroll No");
                            GenJournalLine.Description := 'Registration Fee';
                            GenJournalLine.Amount := ObjGenSetUp."BOSA Registration Fee Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := ObjGenSetUp."BOSA Registration Fee Account";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            //Message('%1- %2- %3', GenJournalLine.Amount, GenJournalLine."Bal. Account No.", GenJournalLine."Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;



                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;
                        end;
                    end;
                }
                action("Load Account Statement Details")
                {
                    Image = InsertAccount;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
                        ObjStatementB: Record "Loan Appraisal Statement Buffe";
                        StatementStartDate: Date;
                        StatementDateFilter: Date;
                        StatementEndDate: Date;
                        VerStatementAvCredits: Decimal;
                        VerStatementsAvDebits: Decimal;
                        VerMonth1Date: Integer;
                        VerMonth1Month: Integer;
                        VerMonth1Year: Integer;
                        VerMonth1StartDate: Date;
                        VerMonth1EndDate: Date;
                        VerMonth1DebitAmount: Decimal;
                        VerMonth1CreditAmount: Decimal;
                        VerMonth2Date: Integer;
                        VerMonth2Month: Integer;
                        VerMonth2Year: Integer;
                        VerMonth2StartDate: Date;
                        VerMonth2EndDate: Date;
                        VerMonth2DebitAmount: Decimal;
                        VerMonth2CreditAmount: Decimal;
                        VerMonth3Date: Integer;
                        VerMonth3Month: Integer;
                        VerMonth3Year: Integer;
                        VerMonth3StartDate: Date;
                        VerMonth3EndDate: Date;
                        VerMonth3DebitAmount: Decimal;
                        VerMonth3CreditAmount: Decimal;
                        VerMonth4Date: Integer;
                        VerMonth4Month: Integer;
                        VerMonth4Year: Integer;
                        VerMonth4StartDate: Date;
                        VerMonth4EndDate: Date;
                        VerMonth4DebitAmount: Decimal;
                        VerMonth4CreditAmount: Decimal;
                        VerMonth5Date: Integer;
                        VerMonth5Month: Integer;
                        VerMonth5Year: Integer;
                        VerMonth5StartDate: Date;
                        VerMonth5EndDate: Date;
                        VerMonth5DebitAmount: Decimal;
                        VerMonth5CreditAmount: Decimal;
                        VerMonth6Date: Integer;
                        VerMonth6Month: Integer;
                        VerMonth6Year: Integer;
                        VerMonth6StartDate: Date;
                        VerMonth6EndDate: Date;
                        VerMonth6DebitAmount: Decimal;
                        VerMonth6CreditAmount: Decimal;
                        VarMonth1Datefilter: Text;
                        VarMonth2Datefilter: Text;
                        VarMonth3Datefilter: Text;
                        VarMonth4Datefilter: Text;
                        VarMonth5Datefilter: Text;
                        VarMonth6Datefilter: Text;
                        ObjMemberCellG: Record "Member House Groups";
                        TrunchDetailsVisible: Boolean;
                        ObjTranch: Record "Tranch Disburesment Details";
                        GenSetUp: Record "Sacco General Set-Up";
                    begin
                        //Clear Buffer
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."No.");
                        if ObjStatementB.FindSet then begin
                            ObjStatementB.DeleteAll;
                        end;



                        //Initialize Variables
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;


                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        GenSetUp.Get();

                        //Month 1
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth1Date := Date2dmy(StatementStartDate, 1);
                        VerMonth1Month := Date2dmy(StatementStartDate, 2);
                        VerMonth1Year := Date2dmy(StatementStartDate, 3);


                        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
                        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

                        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."No.";
                            ObjStatementB."Transaction Date" := VerMonth1EndDate;
                            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
                            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
                            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;


                        //Month 2
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth2Date := Date2dmy(StatementStartDate, 1);
                        VerMonth2Month := (VerMonth1Month + 1);
                        VerMonth2Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth2Month > 12 then begin
                            VerMonth2Month := VerMonth2Month - 12;
                            VerMonth2Year := VerMonth2Year + 1;
                        end;

                        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
                        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
                        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."No.";
                            ObjStatementB."Transaction Date" := VerMonth2EndDate;
                            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
                            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
                            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;

                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        //Month 3
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth3Date := Date2dmy(StatementStartDate, 1);
                        VerMonth3Month := (VerMonth1Month + 2);
                        VerMonth3Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth3Month > 12 then begin
                            VerMonth3Month := VerMonth3Month - 12;
                            VerMonth3Year := VerMonth3Year + 1;
                        end;

                        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
                        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
                        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."No.";
                            ObjStatementB."Transaction Date" := VerMonth3EndDate;
                            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
                            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
                            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 4
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth4Date := Date2dmy(StatementStartDate, 1);
                        VerMonth4Month := (VerMonth1Month + 3);
                        VerMonth4Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth4Month > 12 then begin
                            VerMonth4Month := VerMonth4Month - 12;
                            VerMonth4Year := VerMonth4Year + 1;
                        end;

                        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
                        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
                        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."No.";
                            ObjStatementB."Transaction Date" := VerMonth4EndDate;
                            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
                            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
                            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 5
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth5Date := Date2dmy(StatementStartDate, 1);
                        VerMonth5Month := (VerMonth1Month + 4);
                        VerMonth5Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth5Month > 12 then begin
                            VerMonth5Month := VerMonth5Month - 12;
                            VerMonth5Year := VerMonth5Year + 1;
                        end;

                        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
                        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
                        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."No.";
                            ObjStatementB."Transaction Date" := VerMonth5EndDate;
                            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
                            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
                            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 6
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth6Date := Date2dmy(StatementStartDate, 1);
                        VerMonth6Month := (VerMonth1Month + 5);
                        VerMonth6Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth6Month > 12 then begin
                            VerMonth6Month := VerMonth6Month - 12;
                            VerMonth6Year := VerMonth6Year + 1;
                        end;

                        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
                        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
                        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat

                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."No.";
                            ObjStatementB."Transaction Date" := VerMonth6EndDate;
                            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
                            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
                            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Get Statement Avarage Credits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementAvCredits := VerStatementAvCredits + ObjStatementB."Amount In";
                            //"Bank Statement Avarage Credits":=VerStatementAvCredits/6;
                            //MODIFY/
                            until ObjStatementB.Next = 0;
                        end;

                        //Get Statement Avarage Debits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementsAvDebits := VerStatementsAvDebits + ObjStatementB."Amount Out";
                            //"Bank Statement Avarage Debits":=VerStatementsAvDebits/6;
                            //MODIFY;
                            until ObjStatementB.Next = 0;
                        end;

                        //"Bank Statement Net Income":="Bank Statement Avarage Credits"-"Bank Statement Avarage Debits";
                        //MODIFY;
                    end;
                }
                action("Member Case History")
                {
                    Image = Reconcile;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Member Case History";
                    RunPageLink = "Member No." = field("No.");
                }
                action("CRB Query Charge")
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    RunObject = Page "CRB Check Charge List";
                    RunPageLink = "Member No" = field("No.");
                }
                group(Reports)
                {
                    Caption = 'Reports';
                }
                action("&Card")
                {
                    Caption = 'FOSA Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Card View";
                    RunPageLink = "No." = FIELD("FOSA Account No.");
                    ShortCutKey = 'Shift+F7';

                }
                action("Detailed Statement")
                {
                    Caption = 'Detailed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;
                        end;

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(80007, true, false, Cust);
                    end;
                }
                action("Detailed Salary Statement")
                {
                    Caption = 'Detailed Salary Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;
                        end;

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(175055, true, false, Cust);
                    end;
                }

                action("Detailed Statement Old")
                {
                    Caption = 'Detailed Statement Old';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;
                        end;

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50231, true, false, Cust);
                    end;
                }

                // action("Detailed Statement Old")
                // {
                //     Caption = 'Detailed Statement Old';
                //     Image = "Report";
                //     Promoted = true;
                //     PromotedCategory = "Report";
                //     PromotedOnly = true;

                //     trigger OnAction()
                //     begin
                //         if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                //             if UserSetup.Get(UserId) then begin
                //                 if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                //             end;
                //         end;

                //         Cust.Reset;
                //         Cust.SetRange(Cust."No.", Rec."No.");
                //         if Cust.Find('-') then
                //             Report.Run(80046, true, false, Cust);
                //     end;
                // }

                action("Dividend Slip")
                {
                    Caption = 'Dividend Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        DivProg: Record "Dividends Progression";
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50012, true, false, Cust);
                    end;
                }
                action("Loan Statement BOSA")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(80027, true, false, Cust);
                    end;
                }
                action("Member Deposit Statement")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange("BOSA Account No", Rec."No.");
                        if Vend.Find('-') then
                            Report.Run(175068, true, false, Vend);
                    end;
                }
                action("Detailed Interest Statement")
                {
                    Caption = 'Detailed Interest Statement';
                    Image = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Loan Statement FOSA")
                {
                    Caption = 'Loan Statement FOSA';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(172533, true, false, Cust);

                        /*
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(172474,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("FOSA Statement")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."FOSA Account No.");
                        if Vend.Find('-') then begin
                            Report.Run(172890, true, false, Vend);
                        end;


                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."FOSA Account No.","FOSA Account No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(172890,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Group Statement")
                {
                    Caption = 'House Group Statement';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.Run(172920, true, false, ObjCellGroups);
                    end;
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Visible = false;
                }
                action("Account Closure Slip")
                {
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Cust: Record Customer;
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(80008, true, false, Cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        FosaName: Text;
        Vend: Record Vendor;
        lblIDVisible: Boolean;
        lblDOBVisible: Boolean;
        lblRegNoVisible: Boolean;
        lblRegDateVisible: Boolean;
        lblGenderVisible: Boolean;
        txtGenderVisible: Boolean;
        lblMaritalVisible: Boolean;
        txtMaritalVisible: Boolean;

        OurMem: Record "Members Register";
        Cust: Record Customer;
    begin
        FosaName := '';

        if Rec."FOSA Account No." <> '' then begin
            if Vend.Get(Rec."FOSA Account No.") then begin
                FosaName := Vend.Name;
            end;
        end;

        lblIDVisible := true;
        lblDOBVisible := true;
        lblRegNoVisible := false;
        lblRegDateVisible := false;
        lblGenderVisible := true;
        txtGenderVisible := true;
        lblMaritalVisible := true;
        txtMaritalVisible := true;

        if Rec."Account Category" <> Rec."account category"::Individual then begin
            lblIDVisible := false;
            lblDOBVisible := false;
            lblRegNoVisible := true;
            lblRegDateVisible := true;
            lblGenderVisible := false;
            txtGenderVisible := false;
            lblMaritalVisible := false;

            OnAfterGetCurrRecords();
            Statuschange.Reset;
            Statuschange.SetRange(Statuschange."User ID", UserId);
            Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
            if not Statuschange.Find('-') then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;

            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
            if Rec."Account Category" <> Rec."account category"::Corporate then begin
                Joint2DetailsVisible := false;
            end else
                Joint2DetailsVisible := true;

            if Rec."Account Category" <> Rec."account category"::Corporate then begin
                Joint3DetailsVisible := false;
            end else
                Joint3DetailsVisible := true;

            EmployedVisible := false;
            SelfEmployedVisible := false;
            OtherVisible := false;

            if (Rec."Occupation Details" = Rec."occupation details"::Employed) or (Rec."Occupation Details" = Rec."occupation details"::"Employed & Self Employed") then begin
                EmployedVisible := true;
            end;

            if (Rec."Occupation Details" = Rec."occupation details"::"Self-Employed") or (Rec."Occupation Details" = Rec."occupation details"::"Employed & Self Employed") then begin
                SelfEmployedVisible := true;
            end;

            if (Rec."Occupation Details" = Rec."occupation details"::Others) or (Rec."Occupation Details" = Rec."occupation details"::Contracting) then begin
                OtherVisible := true;
            end;

            SetStyles();
        end;
        Cust.reset();
        Cust.setRange(Cust."ID No.", OurMem."ID No.");
        if Cust.FindSet() then begin
            rec."Referee name" := rec."Referee Name";
        end;

        //Validating Membership Status
        // Vend.Reset();
        // Vend.SetRange(Vend."BOSA Account No", Rec."No.");
        // if Vend.Find('-') then begin
        //     // Rec."Membership Status" := Vend."Membership Status";
        // end;

        // rec.CalcFields("Current Shares", "Shares Retained", "Total Loan Balance");
        // if (rec.Status = rec.status::Closed) and (rec."Current Shares">1) and (rec."Shares Retained">1) and (rec."Total Loan Balance">1) then begin
        //     rec."Membership Status" := rec."Membership Status"::Closed;
        // end;
        
        //getting the school fee shares account no
        Vend.Reset();
        Vend.SetRange(Vend."BOSA Account No", Rec."No.");
        Vend.SetFilter(Vend."Account Type", '104');
        if Vend.findSet() then begin
            if Vend."Account Type" = '104' then begin
                rec."School Fees Shares Account" := Vend."No.";
            end;
        end;
    end;

    trigger OnAfterGetCurrRecord() begin
        // hrEmployees.Reset();
        // hrEmployees.SetRange("No.", Rec."Payroll No");
        // if hrEmployees.Find('-') then begin
        //     UserSetup.Reset();
        //     UserSetup.SetRange("User ID", UserId);
        //     if UserSetup.Find('-') then begin
        //         if UserSetup."Can View Staff Accounts" then begin
        //             // staffView := true;
        //         end else begin
        //             Rec.SetRange("Payroll No", hrEmployees."No.");
        //         end;
        //     end else Error('The user: %1, does not have permissions to view other staff accounts.', UserId);
        // end else Error('The user: %1, does not have permissions to view other staff accounts.', UserId);
    end;

    /*     trigger OnFindRecord(which)Boolean;
        var
        RecordFound: Boolean;
        begin
            RecordFound := Rec.Find(Which);
            CurrPage.Editable := RecordFound or (Rec.GetFilter(Rec."No.") = '');
            exit(RecordFound);
        end; */

    trigger OnInit()
    begin
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Customer Type" := Rec."customer type"::Member;
        Rec.Status := Rec.Status::Active;
        Rec."Customer Posting Group" := 'BOSA';
        Rec."Registration Date" := Today;
        Rec.Advice := true;
        Rec."Advice Type" := Rec."advice type"::"New Member";
        if GeneralSetup.Get(0) then begin
            Rec."Welfare Contribution" := GeneralSetup."Welfare Contribution";
            Rec."Registration Fee" := GeneralSetup."Registration Fee";
        end;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if Rec."Account Category" <> Rec."account category"::Corporate then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if Rec."Account Category" <> Rec."account category"::Corporate then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;

        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if (Rec."Occupation Details" = Rec."occupation details"::Employed) or (Rec."Occupation Details" = Rec."occupation details"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if (Rec."Occupation Details" = Rec."occupation details"::"Self-Employed") or (Rec."Occupation Details" = Rec."occupation details"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if (Rec."Occupation Details" = Rec."occupation details"::Others) or (Rec."Occupation Details" = Rec."occupation details"::Contracting) then begin
            OtherVisible := true;
        end;


        if (Rec."Assigned System ID" <> '') and (Rec."Assigned System ID" <> UserId) then begin
            Error('You do not have permission to view account');
        end;
        CUeMgt.GetVisitFrequency(ObjCueControl.Activity::BOSA, Rec."No.", Rec.Name);


       

    end;

    var
        RefferredbyEdit: Boolean;
        CustomizedCalEntry: Record "Customized Calendar Entry";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        CustomizedCalendar: Record "Customized Calendar Change";
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        // GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        // Vend: Record Vendor;
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        hrEmployees: Record "HR Employees";
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        Mem: Record Customer;
        // FosaName: Text[50];
        [InDataSet]
        //lblIDVisible: Boolean;
        [InDataSet]
        ///lblDOBVisible: Boolean;
        [InDataSet]
        //lblRegNoVisible: Boolean;
        [InDataSet]
        //lblRegDateVisible: Boolean;
        [InDataSet]
        //lblGenderVisible: Boolean;
        [InDataSet]
        //txtGenderVisible: Boolean;
        [InDataSet]
        //lblMaritalVisible: Boolean;
        [InDataSet]
        // txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
        "WITHDRAWAL FEE": Decimal;
        "AMOUNTTO BE RECOVERED": Decimal;
        "Remaining Amount": Decimal;
        TotalInsuarance: Decimal;
        PrincipInt: Decimal;
        LoanApp: Record "Loans Register";
        TotalLoansOut: Decimal;
        FileMovementTracker: Record "File Movement Tracker";
        EntryNo: Integer;
        ApprovalsSetup: Record "Approvals Set Up";
        MovementTracker: Record "Movement Tracker";
        ApprovalUsers: Record "Approvals Users Set Up";
        "Change Log": Integer;
        openf: File;
        FMTRACK: Record "File Movement Tracker";
        CurrLocation: Code[30];
        "Number of days": Integer;
        Approvals: Record "Approvals Set Up";
        Description: Text[30];
        Section: Code[10];
        station: Code[10];
        MoveStatus: Record "File Movement Status";
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GuarantorAllocationAmount: Decimal;
        CummulativeGuaranteeAmount: Decimal;
        UserSetup: Record "User Setup";
        JointNameVisible: Boolean;
        SurestepFactory: Codeunit "Au Factory";
        ReasonforWithdrawal: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        SFactory: Codeunit "Au Factory";
        ObjMembershipApp: Record "Membership Applications";
        ObjCellGroups: Record "Member House Groups";
        CoveragePercentStyle: Text[50];
        EmployedVisible: Boolean;
        SelfEmployedVisible: Boolean;
        OtherVisible: Boolean;
        CUeMgt: Codeunit "Cue Management";
        ObjCueControl: Record "Control Cues";

    var
        FosaName: Text;
        Vend: Record Vendor;
        lblIDVisible: Boolean;
        lblDOBVisible: Boolean;
        lblRegNoVisible: Boolean;
        lblRegDateVisible: Boolean;
        lblGenderVisible: Boolean;
        txtGenderVisible: Boolean;
        lblMaritalVisible: Boolean;
        txtMaritalVisible: Boolean;

    procedure ActivateFields()
    begin
    end;

    local procedure OnAfterGetCurrRecords()
    begin
        xRec := Rec;
        ActivateFields;
    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;

}
