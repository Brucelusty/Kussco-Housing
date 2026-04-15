table 50825 "Compliance Task Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Task ID"; Code[20]) { }

        field(2; "Staff ID"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }

        field(3; "Task Description"; Text[250]) { }

        field(4; "Task Date"; Date) { }

        field(5; "Task Type"; Option)
        {
            OptionMembers = Audit,Inspection,Report,Approval,Other;
        }

        field(6; "Issues Detected"; Integer) { }

        field(7; "Resolution Status"; Option)
        {
            OptionMembers = Open,Pending,Closed;
        }

        field(8; "Comments"; Text[250]) { }
    }

    keys
    {
        key(PK; "Task ID")
        {
            Clustered = true;
        }
    }
}
