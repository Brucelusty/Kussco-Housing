table 50061 "Risk Incident Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Risk ID"; Code[20])
        {
            TableRelation = "Risk Register"."Risk ID";
        }

        field(3; "Incident Date"; Date)
        {
        }

        field(4; Description; Text[250])
        {
        }

        field(5; "Reported By"; Code[50])
        {
        }
    }

    keys
    {
        key(PK; "Entry No.","Risk ID","Incident Date",Description)
        {
            Clustered = true;
        }
    }
}
