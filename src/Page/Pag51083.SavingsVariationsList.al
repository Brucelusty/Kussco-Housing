page 51083 "Savings Variations List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Savings Variation";
    CardPageId = "Savings Variations Card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Variation No";Rec."Variation No")
                {}
                field("Member No";Rec."Member No")
                {}
                field("Member Name";Rec."Member Name")
                {}
                field("Savings Account Type";Rec."Savings Account Type")
                {}
                field("Old Savings";Rec."Old Savings")
                {}
                field("New Savings";Rec."New Savings")
                {}
                field("Approval Status";Rec."Approval Status")
                {}
            }
        }
        area(Factboxes)
        {
            
        }
    }
}


