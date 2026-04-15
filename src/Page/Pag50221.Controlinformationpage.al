//************************************************************************
page 50221 "Controlinformationpage"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Control-Information.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Primary Key";Rec."Primary Key")
                {

                }
                field("Payslip Message";Rec."Payslip Message")
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




