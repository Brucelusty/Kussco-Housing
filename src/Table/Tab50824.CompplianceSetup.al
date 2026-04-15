table 50824 "Compliance KPI Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "KPI Code"; Code[20]) { }
        field(2; "KPI Name"; Text[100]) { }
        field(3; "Description"; Text[250]) { }

        field(4; "Target Value"; Decimal) { }

        field(5; "Measurement Unit"; Option)
        {
            OptionMembers = Percentage,Number,Score;
        }

        field(6; "Priority"; Option)
        {
            OptionMembers = Low,Medium,High;
        }

        field(7; "Active"; Boolean) { }
    }

    keys
    {
        key(PK; "KPI Code")
        {
            Clustered = true;
        }
    }
}
