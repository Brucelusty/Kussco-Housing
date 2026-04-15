//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50307 "Membership App Signatories"
{
    ApplicationArea = All;
    CardPageID = "Membership App Signatory Card";
    Editable = false;
    PageType = Card;
    SourceTable = "Member App Signatories";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Names; Rec.Names)
                {
                }
                field("ID No."; Rec."ID No.")
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
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field(Designation; Rec.Designation)
                {
                    
                }
                field(Control1102760009; Rec.Signatory)
                {
                    Visible=false;
                }
                field("Must Sign";Rec."Must Sign")
                {
                    Visible=false;
                }
                field("Must be Present";Rec."Must be Present")
                {
                    Visible=false;
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                    Editable = false;
                    Caption='Member No.';
                    Visible=false;
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field(Title; Rec.Title)
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
                   // Visible=false;
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






