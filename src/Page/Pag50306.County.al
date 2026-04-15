page 50306 "County"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = Counties;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("County Code";Rec."County Code")
                {
                }
                field("County Name";Rec."County Name")
                {
                }
                field(Region;Rec.Region)
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

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}


