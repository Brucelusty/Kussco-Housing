//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50632 "Member Account Signatory Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Account Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Member No.";Rec."Member No.")
                {
                    Caption = 'Member No.';
                }
                field("Account No";Rec."Account No")
                {
                    Caption = 'Group No.';
                }
                field(Names; Rec.Names)
                {
                    ShowMandatory = true;
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field("Staff/Payroll";Rec."Staff/Payroll")
                {
                }
                field("ID No.";Rec."ID No.")
                {
                    ShowMandatory = true;
                }
                field(Designation; Rec.Designation)
                {
                }
                field(Signatory; Rec.Signatory)
                {
                }
                field("Must Sign";Rec."Must Sign")
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






