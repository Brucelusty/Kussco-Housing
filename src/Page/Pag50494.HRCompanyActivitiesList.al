//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50494 "HR Company Activities List"
{
    ApplicationArea = All;
    CardPageID = "HR Company Activities Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Company Activities";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("Code";Rec.Code)
                {
                }
                field(Description;Rec.Description)
                {
                }
                field(Date;Rec.Date)
                {
                }
                field(Venue;Rec.Venue)
                {
                }
                field(Costs;Rec.Costs)
                {
                }
                field("Employee Responsible";Rec."Employee Name")
                {
                }
                field(Closed;Rec.Closed)
                {
                }
                field("Activity  Status>";Rec.Status)
                {
                    Caption = 'Activity  Status';
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004;"HR Company Activities Factbox")
            {
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Company Activities")
            {
                Caption = 'Company Activities';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                // RunObject = Report UnknownReport55588;
            }
        }
    }
}






