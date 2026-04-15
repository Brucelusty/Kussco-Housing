//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50712 "Relationship list"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Relationship Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("code"; Rec.code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Min Age";Rec."Min Age")
                {
                }
                field("Max Age";Rec."Max Age")
                {
                }
            }
        }
    }

    actions
    {
    }
}






