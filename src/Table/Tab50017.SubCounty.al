table 50017 "Sub-County"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sub-County"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "County Code"; Code[100])
        {
            DataClassification = ToBeClassified;

        }


    }

    keys
    {
        key(Key1; "Sub-County")
        {
            Clustered = true;
        }
        key(Key2; "County Code")
        {
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sub-County", "County Code")
        {
        }
    }
    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
