//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50468 "HR Company Targets"
{
    ApplicationArea = All;
    CardPageID = "HR AppraisalCompanyTarget list";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Appraisal Company Target";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Rec.Code)
                {
                }
                field(Description;Rec.Description)
                {
                }
                field(Score;Rec.Score)
                {
                }
                field(Recommendations;Rec.Recommendations)
                {
                }
                field("Description 2";Rec."Description 2")
                {
                }
            }
        }
    }

    actions
    {
    }
}






