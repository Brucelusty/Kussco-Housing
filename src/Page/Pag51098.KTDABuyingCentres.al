page 51098 "KTDA Buying Centres"
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
                    Caption = 'Factory Region';
                }
                field("Buying Centre";Rec."Buying Centre")
                {
                    ShowMandatory = true;
                }
                field(Description;Rec.Description)
                {
                    
                }
                field("Workstation County";Rec."Workstation County")
                {
                    Caption = 'Factory County';
                }
                field("Workstation Sub-County";Rec."Workstation Sub-County")
                {
                    Caption = 'Factory Sub-County';
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


