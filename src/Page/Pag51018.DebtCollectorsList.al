page 51018 "Debt Collectors List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Debt Collectors Table";
    CardPageId = "Debt Collectors Card";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("debtors code";Rec."debtors code")
                {
                    Editable = false;
                }
                field("Debt Collectors";Rec."Debt Collectors")
                {
                }
                field(Rate;Rec.Rate)
                {
                }
                field(UserID;Rec.UserID)
                {
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        
    }
}


