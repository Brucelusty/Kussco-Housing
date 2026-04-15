//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50560 "HR Leave Family Employees List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Family Employees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Family; Rec.Family)
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}






