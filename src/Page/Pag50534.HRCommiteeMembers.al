//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50534 "HR Commitee Members"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Commitee Members";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Member No.";Rec."Member No.")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field(Role; Rec.Role)
                {
                }
                field("Date Appointed";Rec."Date Appointed")
                {
                }
                field(Active; Rec.Active)
                {
                }
            }
        }
    }

    actions
    {
    }
}






