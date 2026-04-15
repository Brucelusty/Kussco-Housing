//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50630 "Membership App Signatory Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Member App Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No";Rec."Account No")
                {
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                    Caption = 'Member No.';
                    Visible=false;
                }
                field(Names; Rec.Names)
                {
                    ShowMandatory = true;
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field("ID No.";Rec."ID No.")
                {
                    ShowMandatory = true;
                }
                field("Mobile No.";Rec."Mobile No.")
                {
                    ShowMandatory = true;
                }
                field(Designation; Rec.Designation)
                {
                    Caption = 'Designation';
                }
                field(Signatory; Rec.Signatory)
                {
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
                    Visible=false;
                }
                field("Email Address";Rec."Email Address")
                {
                }
                field("Maximum Withdrawal";Rec."Maximum Withdrawal")
                {
                    Visible=false;
                }
            }
        }
        area(factboxes)
        {
            part(Control4; "M_Signatory Picture-App")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control3; "M_Signatory Signature-App")
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






