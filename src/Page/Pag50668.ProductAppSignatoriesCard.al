//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50668 "Product App Signatories Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Product App Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field("Staff/Payroll";Rec."Staff/Payroll")
                {
                }
                field("ID No.";Rec."ID No.")
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
                field(Picture; Rec.Picture)
                {
                }
                field(Signature; Rec.Signature)
                {
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Account Signatorie Picture-App")
            {
                Caption = 'Picture';
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control2; "Account Signator Signature-App")
            {
                Caption = 'Signature';
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
    }
}






