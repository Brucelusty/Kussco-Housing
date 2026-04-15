Page 50077 "Leave Planner"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Leave Planner";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("No of Days"; Rec."No of Days")
                {
                }
            }
        }
    }

    actions
    {
    }
}



