//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50761 "Member Parish"
{
    ApplicationArea = All;
    Caption = 'Member Zone';
    CardPageID = "Member Parishes";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member's Parishes";

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
            }
        }
    }

    actions
    {
    }
}






