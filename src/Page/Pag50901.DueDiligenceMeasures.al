//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50901 "Due Diligence Measures"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Due Diligence Measures";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Risk Rating Level";Rec."Risk Rating Level")
                {
                }
                field("Risk Rating Scale";Rec."Risk Rating Scale")
                {
                }
                field("Due Diligence Type";Rec."Due Diligence Type")
                {
                }
                field("Due Diligence No";Rec."Due Diligence No")
                {
                }
                field("Due Diligence Measure";Rec."Due Diligence Measure")
                {
                }
            }
        }
    }

    actions
    {
    }
}






