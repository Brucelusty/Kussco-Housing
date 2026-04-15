//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50616 "Account Signatories Details"
{
    ApplicationArea = All;
    CardPageID = "Account Signatories Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "FOSA Account Sign. Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No.";Rec."Member No.")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field("Mobile No";Rec."Mobile No")
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("Must Sign";Rec."Must Sign")
                {
                }
                field("Must be Present";Rec."Must be Present")
                {
                }
                field("Email Address";Rec."Email Address")
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
                    Caption = 'Signed Up For MBanking';
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Account Signatorie Picture")
            {
                Caption = 'Picture';
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control1; "Account Signator Signature")
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






