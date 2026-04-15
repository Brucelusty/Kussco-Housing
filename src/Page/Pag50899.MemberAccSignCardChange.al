//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50899 "Member Acc. Sign. Card Change"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Member Acc. Signatories Change";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    Caption = 'Member No.';
                }
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Group No.';
                }
                field(Names; Rec.Names)
                {
                    ShowMandatory = true;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field("ID No."; Rec."ID No.")
                {
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field("Must Sign"; Rec."Must Sign")
                {
                }
                field("Must be Present"; Rec."Must be Present")
                {
                }
                field("Withdrawal Limit"; Rec."Withdrawal Limit")
                {
                }
                field("Mobile Banking Limit"; Rec."Mobile Banking Limit")
                {
                }
                field("Signed Up For Mobile Banking"; Rec."Signed Up For Mobile Banking")
                {
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                }
                field("Email Address"; Rec."Email Address")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "AC_Signatory Picture-Uploaded")
            {
                Caption = 'Picture';
                SubPageLink = "Account No" = field("Account No");
            }
            part(Control1; "AC_Signatory Sign-Uploaded")
            {
                Caption = 'Signature';
                SubPageLink = "Account No" = field("Account No");
            }
        }
    }

    actions
    {
    }
}






