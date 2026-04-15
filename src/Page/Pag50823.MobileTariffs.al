//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50823 "MOBILE Tariffs"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Mobile Tariffs";
    Caption = 'Mobile Tariffs';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Charge amount"; Rec."Charge amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}






