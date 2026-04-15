//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50773 "Account Agent List"
{
    ApplicationArea = All;
    CardPageID = "Account Agent Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Account Agent Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                    Caption = 'Agent Member No';
                    Editable = false;
                }
                field(Names; Rec.Names)
                {
                    Caption = 'Agent Name';
                }
                field("ID No.";Rec."ID No.")
                {

                    trigger OnValidate()
                    begin
                        /*CUST.RESET;
                        CUST.SETRANGE(CUST."ID No.","ID No.");
                        IF CUST.FIND('-')  THEN BEGIN
                        "BOSA No.":=CUST."No.";
                        MODIFY;
                        END;*/

                    end;
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field("Mobile No.";Rec."Mobile No.")
                {
                }
                field("Allowed Balance Enquiry";Rec."Allowed Balance Enquiry")
                {
                }
                field("Allowed  Correspondence";Rec."Allowed  Correspondence")
                {
                }
                field("Allowed FOSA Withdrawals";Rec."Allowed FOSA Withdrawals")
                {
                }
                field("Allowed Loan Processing";Rec."Allowed Loan Processing")
                {
                }
                field("Allow Cheque Processing";Rec."Allow Cheque Processing")
                {
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control8;"Account Agent Picture-Uploaded")
            {
                Caption = 'Picture';
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control7;"Account AgenSignatory-Uploaded")
            {
                Caption = 'Signature';
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Signatory)
            {
                Caption = 'Signatory';
                action("Page Account Signatories Card")
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "HR Employment History";
                    RunPageLink = "No." = field("Account No"),
                                  "First Name" = field(Names);
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        MemberApp.Reset;
        MemberApp.SetRange(MemberApp."No.", Rec."Account No");
        if MemberApp.Find('-') then begin
            if MemberApp."Membership Approval Status" = MemberApp."Membership Approval Status"::Approved then begin
                CurrPage.Editable := false;
            end else
                CurrPage.Editable := true;
        end;
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record "Members Register";
}






