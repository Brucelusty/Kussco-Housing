page 50197 "CountriesLookup"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Countries;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Rec."Name")
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


