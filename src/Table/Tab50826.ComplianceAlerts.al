table 50826 "Compliance Alerts"
{
    fields
    {
        field(1; "Alert ID"; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Staff ID"; Code[20]) { }

        field(3; "Alert Type"; Option)
        {
            OptionMembers = Deadline,Breach,HighRisk;
        }

        field(4; "Description"; Text[250]) { }

        field(5; "Alert Date"; DateTime) { }

        field(6; "Resolved"; Boolean) { }
    }

    keys
    {
        key(PK; "Alert ID")
        {
            Clustered = true;
        }
    }
}
