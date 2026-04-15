page 50201 "Designation List"
{
    ApplicationArea = All;
    Caption = 'Designation List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Designation;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Designation;Rec.Designation)
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


