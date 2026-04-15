//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50992 "Collateral Movement Register"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Collateral Movement Register.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No";Rec."Entry No")
                {
                }
                field("Document No";Rec."Document No")
                {
                }
                field("Current Location";Rec."Current Location")
                {
                }
                field("Date Actioned";Rec."Date Actioned")
                {
                }
                field("Action By";Rec."Action By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






