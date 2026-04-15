table 50781 "Collateral Valuer"
{
    Caption = 'Collateral Valuer';
    DataClassification = CustomerContent;
    DrillDownPageId = "Collateral Valuers";
    LookupPageId = "Collateral Valuers";
    fields
    {
        field(1; "Valuer Code"; Code[20])
        {
            Caption = 'Valuer Code';
        }

        field(2; "Valuer Name"; Text[100])
        {
            Caption = 'Valuer Name';
        }

        field(3; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }

        field(4; "Email"; Text[100])
        {
            Caption = 'Email';
        }

        field(5; "Physical Address"; Text[150])
        {
            Caption = 'Physical Address';
        }

        field(6; "Town"; Text[50]) { }

        field(7; "Active"; Boolean)
        {
            InitValue = true;
        }

        field(8; "Notes"; Text[250]) { }
    }

    keys
    {
        key(PK; "Valuer Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Valuer Code", "Valuer Name", "Phone No.", "Email", "Physical Address", "Town", "Active", "Notes")
        {
        }
    }
}

