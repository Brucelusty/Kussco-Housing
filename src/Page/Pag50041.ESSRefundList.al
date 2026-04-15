page 50041 "ESS Refund List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "ESS Refund";
    SourceTableView = where(Registered = filter(false));
    CardPageId = "ESS Refund Card";
    DeleteAllowed = false;
    Editable = false;

    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("ESSRef No.";Rec."ESSRef No.")
                {
                    
                }
                field("Member No";Rec."Member No")
                {
                    
                }
                field("Member Name";Rec."Member Name")
                {
                    
                }
                field("PF No";Rec."PF No")
                {
                    
                }
                field("Captured On";Rec."Captured On")
                {
                    
                }
                field("Registered On";Rec."Registered On")
                {
                    
                }
                field("Maturing On";Rec."Maturing On")
                {
                    
                }
                field("Has Active ESS Loan";Rec."Has Active ESS Loan")
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
        area(Processing)
        {
            
        }
    }
}


