page 65738 "Compliance KPI Entries"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Compliance KPI Entry";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(Entries)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }

                field("Staff ID"; Rec."Staff ID")
                {
                }

                field("KPI Code"; Rec."KPI Code")
                {
                }

                field("Period Start Date"; Rec."Period Start Date")
                {
                }

                field("Period End Date"; Rec."Period End Date")
                {
                }

                field(Target; Rec.Target)
                {
                }

                field(Achieved; Rec.Achieved)
                {
                }

                field("Performance Score"; Rec."Performance Score")
                {
                }
            }
        }
    }
}


