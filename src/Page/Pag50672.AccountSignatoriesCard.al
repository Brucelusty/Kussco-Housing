//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50672 "Account Signatories Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "FOSA Account Sign. Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                    Editable = false;
                }
                field("Member No.";Rec."Member No.")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field("Mobile No";Rec."Mobile No")
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
                field("Expiry Date";Rec."Expiry Date")
                {
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field("Limit Amount";Rec."Limit Amount")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control5;"Account Signatorie Picture")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control4;"Account Signator Signature")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
    }
}




