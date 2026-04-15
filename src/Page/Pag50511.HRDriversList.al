//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50511 "HR Drivers List"
{
    ApplicationArea = All;
    CardPageID = "HR Drivers Card";
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Drivers";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Code";Rec.Code)
                {
                }
                field("Driver Name";Rec."Driver Name")
                {
                }
                field("Driver License Number";Rec."Driver License Number")
                {
                }
                field("Last License Renewal";Rec."Last License Renewal")
                {
                }
                field("Renewal Interval";Rec."Renewal Interval")
                {
                }
                field("Renewal Interval Value";Rec."Renewal Interval Value")
                {
                }
                field("Next License Renewal";Rec."Next License Renewal")
                {
                }
                field("Year Of Experience";Rec."Year Of Experience")
                {
                }
                field(Grade;Rec.Grade)
                {
                }
                field(Active;Rec.Active)
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
    }
}






