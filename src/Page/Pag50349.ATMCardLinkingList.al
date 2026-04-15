//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50349 "ATM Card Linking List"
{
    ApplicationArea = All;
    CardPageID = "ATM No Linking Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Card No";Rec."Card No")
                {
                }
            }
        }
    }

    actions
    {
    }
}






