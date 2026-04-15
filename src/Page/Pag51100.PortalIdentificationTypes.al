page 51100 "Portal Identification Types"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Portal Identification Types";
    
    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field(Code;Rec.Code)
                {
                    
                }
                field(Description;Rec.Description)
                {
                    
                }
                field("Type of Identification";Rec."Type of Identification")
                {
                    
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    
                }
                field("STO Type";Rec."STO Type")
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
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}


