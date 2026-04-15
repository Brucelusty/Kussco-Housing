//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50508 "HR Transport Requests List"
{
    ApplicationArea = All;
    CardPageID = "HR Staff Transport Requisition";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Transport Requisition";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Application Code";Rec."Application Code")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employee No";Rec."Employee No")
                {
                }
                field(Names;Rec.Names)
                {
                }
                field("Job Tittle";Rec."Job Tittle")
                {
                }
                field("Days Applied";Rec."Days Applied")
                {
                }
                field(Supervisor;Rec.Supervisor)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004;Outlook)
            {
            }
            systempart(Control1102755006;Notes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Transport Requests")
            {
                Caption = 'Transport Requests';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //  RunObject = Report UnknownReport55605;
            }
        }
    }
}






