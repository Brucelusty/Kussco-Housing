//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51003 "Member Gross Risk Rating Scale"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member Gross Risk Rating Scale";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                }
                field("Minimum Risk Rate";Rec."Minimum Risk Rate")
                {
                }
                field("Maximum Risk Rate";Rec."Maximum Risk Rate")
                {
                }
                field("Risk Scale";Rec."Risk Scale")
                {
                }
            }
        }
    }

    actions
    {
    }
}






