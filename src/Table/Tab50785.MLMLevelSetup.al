table 50785 "MLM Level Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Level Code"; Code[10])
        {
            Caption = 'Level Code';
        }

        field(2; "Level No."; Integer)
        {
            Caption = 'Level No.';
        }

        field(3; Description; Text[100])
        {
        }

        field(4; "Bonus Type"; Option)
        {
            OptionMembers = OneTime,Recurring;
        }

        field(5; "Commission %"; Decimal)
        {
        }

        field(6; "Fixed Amount"; Decimal)
        {
        }

        field(7; "Min Contribution Amount"; Decimal)
        {
        }

        field(8; "Eligible"; Boolean)
        {
            InitValue = true;
        }

        field(9; Active; Boolean)
        {
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Level Code")
        {
            Clustered = true;
        }

        key(LevelNo; "Level No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Level Code", "Level No.", Description, "Bonus Type", "Commission %", "Fixed Amount") { }
    }
    
}
