//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50472 "HR Appraisal Assignment List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Appraisal Assignment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field("Categorize As"; Rec."Categorize As")
                {
                }
                field(No; Rec.No)
                {
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






