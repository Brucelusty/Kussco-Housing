//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50394 "Portfolio Performance Bands"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Portfolio Summary Bands";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field(Band; Rec.Band)
                {
                }
                field("Band Description"; Rec."Band Description")
                {
                }
                field(Classification; Rec.Classification)
                {
                }
            }
        }
    }

    actions
    {
    }
}






