//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50729 "Data Sheet Periods"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Data Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code";Rec."Period Code")
                {
                }
                field("Begin Date";Rec."Begin Date")
                {
                }
                field("End Date";Rec."End Date")
                {
                }
                field(Month; Rec.Month)
                {
                }
                field("Payroll Month";Rec."Payroll Month")
                {
                }
            }
        }
    }

    actions
    {
    }
}






