//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50690 "Banks"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Banks Ver2";

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Branch Code"; Rec."Branch Code")
                {
                }
                field("Branch Name"; Rec."Branch Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}






