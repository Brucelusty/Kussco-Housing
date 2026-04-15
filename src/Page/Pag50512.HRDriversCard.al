//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50512 "HR Drivers Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Drivers";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code";Rec.Code)
                {
                    Importance = Promoted;
                }
                field("Driver Name";Rec."Driver Name")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Driver License Number";Rec."Driver License Number")
                {
                    Importance = Promoted;
                }
                field("Last License Renewal";Rec."Last License Renewal")
                {
                    Importance = Promoted;
                }
                field("Renewal Interval";Rec."Renewal Interval")
                {
                    Importance = Promoted;
                }
                field("Renewal Interval Value";Rec."Renewal Interval Value")
                {
                    Importance = Promoted;
                }
                field("Next License Renewal";Rec."Next License Renewal")
                {
                    Importance = Promoted;
                }
                field("Year Of Experience";Rec."Year Of Experience")
                {
                    Importance = Promoted;
                }
                field(Grade;Rec.Grade)
                {
                    Importance = Promoted;
                }
                field(Active;Rec.Active)
                {
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013;Outlook)
            {
            }
            systempart(Control1102755014;Notes)
            {
            }
        }
    }

    actions
    {
    }
}






