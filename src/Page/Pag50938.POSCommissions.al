page 50938 "POS Commissions"
{
    ApplicationArea = All;
    Caption = 'POS Commissions';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "POS Commissions";
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code;Rec.Code)
                {
                }
                                field("Lower Limit";Rec."Lower Limit")
                {
                }
                                field("Upper Limit";Rec."Upper Limit")
                {
                }
                                                field("Charge Amount";Rec."Charge Amount")
                {
                }
                                                field("Sacco charge";Rec."Sacco charge")
                {
                }
                                field("Bank charge";Rec."Bank charge")
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
                
                trigger OnAction();
                begin
                    
                end;
            }
        }
    }
}


