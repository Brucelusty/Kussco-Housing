table 50793 "Recovery Audit Log"
{
    DataClassification = ToBeClassified;
    Caption = 'Recovery Audit Log';
    DataPerCompany = true;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }

        field(2; "Case No."; Code[20])
        {
            Caption = 'Case No.';
        }

        field(3; "Action Type"; Text[50])
        {
            Caption = 'Action Type';
        }

        field(4; "Old Value"; Text[250])
        {
            Caption = 'Old Value';
        }

        field(5; "New Value"; Text[250])
        {
            Caption = 'New Value';
        }

        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }

        field(7; "Date Time"; DateTime)
        {
            Caption = 'Date & Time';
        }

        field(8; "Comments"; Text[250])
        {
            Caption = 'Comments';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(Pk2;"Case No.") // For quick lookup of all actions on a case
        {
            Clustered = false;
        }
    }
}
