page 51038 "ATM Pin Replacement"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    CardPageId = "ATM Pin Replacement Card";
    SourceTable = "ATM Card Applications";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
                field("ATM Card No.";Rec."Previous Card No")
                {
                }
                field("Pin Received";Rec."Pin Received")
                {
                }
                field("Pin Received By";Rec."Pin Received By")
                {
                }
                field("Pin Received On";Rec."Pin Received On")
                {
                }
            }
        }
    }
}


