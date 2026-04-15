page 50103 "InterestCharged"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Interest Buffer Table";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Loan No"; Rec."Loan No")
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


