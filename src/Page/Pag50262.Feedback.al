page 50262 "Feedback"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    // SourceTable = Response;
    SourceTable = Regions;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // field("Member No."; Rec.MemberNo)
                // {
                // }
                field("Region Code";Rec."Region Code")
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


