page 50122 "Defined Transaction Type"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Defined Transaction Type";
    Editable = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Defined Transaction Type"; Rec."Defined Transaction Type")
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


