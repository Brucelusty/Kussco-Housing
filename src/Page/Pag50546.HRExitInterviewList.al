//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50546 "HR Exit Interview List"
{
    ApplicationArea = All;
    CardPageID = "HR Employee Exit Interviews";
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Exit Interviews";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Exit Interview No";Rec."Exit Interview No")
                {
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Date Of Interview";Rec."Date Of Interview")
                {
                    Importance = Promoted;
                }
                field("Employee Name";Rec."Employee Name")
                {
                }
                field("Interview Done By";Rec."Interviewer Name")
                {
                }
                field("Reason For Leaving";Rec."Reason For Leaving")
                {
                    Importance = Promoted;
                }
                field("Date Of Leaving";Rec."Date Of Leaving")
                {
                    Importance = Promoted;
                }
                field("Re Employ In Future";Rec."Re Employ In Future")
                {
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004; Outlook)
            {
            }
            systempart(Control1102755006; Notes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Exit Interviews")
            {
                Caption = 'Exit Interviews';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                // RunObject = Report UnknownReport55594;
            }
        }
    }
}






