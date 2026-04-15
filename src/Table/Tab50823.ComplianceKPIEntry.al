table 50823 "Compliance KPI Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Staff ID"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }

        field(3; "KPI Code"; Code[20])
        {
            TableRelation = "Compliance KPI Setup"."KPI Code";
        }

        field(4; "Period Start Date"; Date) { }

        field(5; "Period End Date"; Date) { }

        field(6; "Target"; Decimal) { }

        field(7; "Achieved"; Decimal) { }

        field(8; "Performance Score"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
