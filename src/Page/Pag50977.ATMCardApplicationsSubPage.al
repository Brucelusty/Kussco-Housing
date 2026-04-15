//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50977 "ATM Card Applications SubPage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order ATM Card";Rec."Order ATM Card")
                {
                }
                field("No.";Rec."No.")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Branch Code";Rec."Branch Code")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Request Type";Rec."Request Type")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Card No";Rec."Card No")
                {
                }
                field("Date Issued";Rec."Date Issued")
                {
                }
                field("Card Status";Rec."Card Status")
                {
                }
                field("Ordered By";Rec."Ordered By")
                {
                    Editable = false;
                }
                field("Ordered On";Rec."Ordered On")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






