page 50096 "Object Ranges"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "License Permission";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Object Type"; Rec."Object Type")
                {

                }
                field("Object Number"; Rec."Object Number")
                {
                    
                }
            }
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


