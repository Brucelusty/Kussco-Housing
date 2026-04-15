//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50265 "Member Acc. Signatory Change"
{
    ApplicationArea = All;
    CardPageID = "Member Acc. Sign. Card Change";
    PageType = ListPart;
    SourceTable = "Member Acc. Signatories Change";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Member No.";Rec."Member No.")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field("Mobile Phone No";Rec."Mobile Phone No")
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
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field("Must Sign";Rec."Must Sign")
                {
                }
                field("Must be Present";Rec."Must be Present")
                {
                }
                field("Withdrawal Limit";Rec."Withdrawal Limit")
                {
                }
                field("Mobile Banking Limit";Rec."Mobile Banking Limit")
                {
                }
                field("Signed Up For Mobile Banking";Rec."Signed Up For Mobile Banking")
                {
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
            }
        }
    }

    actions
    {
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
        CUST: Record Customer;
}






