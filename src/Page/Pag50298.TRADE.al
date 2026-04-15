page 50298 "TRADE"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Type of Trade";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Type of Trade"; Rec."Type of Trade")
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


