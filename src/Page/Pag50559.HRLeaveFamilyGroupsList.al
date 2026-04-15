//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50559 "HR Leave Family Groups List"
{
    ApplicationArea = All;
    CardPageID = "HR Leave Family Groups Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Family Groups";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Max Employees On Leave"; Rec."Max Employees On Leave")
                {
                }
            }
        }
    }

    actions
    {
    }
}






