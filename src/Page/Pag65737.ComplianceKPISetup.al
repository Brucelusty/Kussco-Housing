page 65737 "Compliance KPI Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Compliance KPI Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(KPIs)
            {
                field("KPI Code"; Rec."KPI Code")
                {
                }

                field("KPI Name"; Rec."KPI Name")
                {
                }

                field(Description; Rec.Description)
                {
                }

                field("Target Value"; Rec."Target Value")
                {
                }

                field("Measurement Unit"; Rec."Measurement Unit")
                {
                }

                field(Priority; Rec.Priority)
                {
                }

                field(Active; Rec.Active)
                {
                }
            }
        }
    }
}


