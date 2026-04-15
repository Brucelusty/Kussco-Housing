page 50105 "controlInfor"
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
                field("Primary Key"; Rec."Primary Key")
                {

                }
                field(Name; Rec.Name)
                {

                }
                field("Phone No."; Rec."Phone No.")
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


