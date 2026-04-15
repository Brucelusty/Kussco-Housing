page 50097 "Licence Information"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "License Information";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Text; Rec.Text)
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


