page 50199 Denominationss
{
    ApplicationArea = All;
    Caption = 'Denominationss';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Denominations;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Value; Rec.Value)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Priority; Rec.Priority)
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


