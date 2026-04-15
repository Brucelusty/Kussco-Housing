//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50412 "S-Mobile charge Tarrifs"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "S-Mobile Tarrifs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Minimum; Rec.Minimum)
                {
                }
                field(Maximum; Rec.Maximum)
                {
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}






