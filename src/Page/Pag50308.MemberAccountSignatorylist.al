//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50308 "Member Account Signatory list"
{
    ApplicationArea = All;
    CardPageID = "Member Account Signatory Card";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Account Signatories";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Names; Rec.Names)
                {
                }
                field("ID No.";Rec."ID No.")
                {

                    trigger OnValidate()
                    begin
                        CUST.Reset;
                        CUST.SetRange(CUST."ID No.", Rec."ID No.");
                        if CUST.Find('-') then begin
                            Rec."Member No." := CUST."No.";
                            Rec.Modify;
                        end;
                    end;
                }
                field("Staff/Payroll";Rec."Staff/Payroll")
                {
                    Caption = 'Staff/Payroll No';
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field(Control1102760009; Rec.Signatory)
                {
                }
                field("Must Sign";Rec."Must Sign")
                {
                }
                field("All To sign";Rec."All To sign")
                {
                }
                field("Both To sign";Rec."Both To sign")
                {
                }
                field("Any To sign";Rec."Any To sign")
                {
                }
                field("Must be Present";Rec."Must be Present")
                {
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
                field("Email Address";Rec."Email Address")
                {
                }
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






