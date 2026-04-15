Page 50081 "Timesheet List"
{
    ApplicationArea = All;
    CardPageID = "Timesheet Header";
    PageType = List;
    SourceTable = "TE Time Sheet1";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}



