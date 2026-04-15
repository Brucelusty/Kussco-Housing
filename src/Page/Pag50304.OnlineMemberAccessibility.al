page 50304 "Online Member Accessibility"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Online Portal Users";

    layout
    {
        area(Content)
        {

            repeater(List)
            {
                Editable = false;
                field("Member No."; Rec."Member No.")
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


