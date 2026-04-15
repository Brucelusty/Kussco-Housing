//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50771 "Account Agent App List"
{
    ApplicationArea = All;
    CardPageID = "Account Agent App Card";
    PageType = Card;
    SourceTable = "Account Agents App Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
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
                    Caption = 'agent Name';
                }
                field("ID No.";Rec."ID No.")
                {

                    trigger OnValidate()
                    begin
                        CUST.Reset;
                        CUST.SetRange(CUST."ID No.", Rec."ID No.");
                        if CUST.Find('-') then begin
                            Rec."BOSA No." := CUST."No.";
                           Rec.Modify;
                        end;
                    end;
                }
                field("Mobile No.";Rec."Mobile No.")
                {
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
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
                field(Designation; Rec.Designation)
                {
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control8; "Account Agent Picture-App")
            {
                Caption = 'Picture';
            }
            part(Control7; "Account Agent Signature-App")
            {
                Caption = 'Signature';
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
                    RunObject = Page "HR Training Application List";
                    RunPageLink = "Application No" = field("Account No"),
                                  "Course Title" = field(Names);
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






