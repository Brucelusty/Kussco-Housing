page 50047 "ESS Refund ListPart"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "ESS Refund";
    SourceTableView = where(Registered = filter(true), Matured = filter(True));
    DeleteAllowed = false;
    
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
    }
    
    actions
    {
        area(Processing)
        {
            
        }
    }
}


