page 50239 "MemberSavings"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = MemberSavings;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(MemberNo; rec.MemberNo)
                {

                }
                field(Type; rec.Type)
                {
                }
                field(Amount; rec.Amount)
                {
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                }
                field("Amount On"; rec."Amount On")
                {
                }
                field("Amount Off"; rec."Amount Off")
                {
                    Editable = false;
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


