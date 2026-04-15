//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50501 "HR Trainings Factbox"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            group(Control1102755018)
            {
                label(Control1102755019)
                {
                    CaptionClass = Text1;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Application No";Rec."Application No")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Course Title";Rec."Course Title")
                {
                }
                field(Location;Rec.Location)
                {
                }
                field("Provider Name";Rec."Provider Name")
                {
                }
                field(Description;Rec.Description)
                {
                }
                field("From Date";Rec."From Date")
                {
                }
                field("To Date";Rec."To Date")
                {
                }
                field("Duration Units";Rec."Duration Units")
                {
                }
                field(Duration;Rec.Duration)
                {
                }
                field("Cost Of Training";Rec."Cost Of Training")
                {
                }
                field(Status;Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Training Details';
    // Text2: ;
    // Text3: ;
}






