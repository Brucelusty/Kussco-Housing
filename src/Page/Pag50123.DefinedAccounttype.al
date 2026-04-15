page 50123 "Defined Account Type"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Defined Account Type";
    Editable = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Defined Account Type"; Rec."Defined Account Type")
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


