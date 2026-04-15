page 51099 "Duty Stations"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Workstation Buying Centers";
    
    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field(Factory;Rec.Factory)
                {
                    
                }
                field("Workstation Region";Rec."Workstation Region")
                {
                    
                }
                field("Buying Centre";Rec."Buying Centre")
                {
                    Caption = 'Duty Station';
                    ShowMandatory = true;
                }
                field(Description;Rec.Description)
                {
                    
                }
                field("Workstation County";Rec."Workstation County")
                {

                }
                field("Workstation Sub-County";Rec."Workstation Sub-County")
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


