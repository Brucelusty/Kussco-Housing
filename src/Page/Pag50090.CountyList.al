page 50090 "County List"
{
    ApplicationArea = All;
    Caption = 'County List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Counties;
    CardPageId = County;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("County Code"; Rec."County Code")
                {
                }
                field("County Name"; Rec."County Name")
                {
                }
                field(Region;Rec.Region)
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


