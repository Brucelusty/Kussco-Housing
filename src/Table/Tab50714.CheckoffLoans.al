table 50714 "Checkoff Loans"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Entry No"; integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Member No"; code[40])
        {
            DataClassification = ToBeClassified;

        }

        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(4; Payroll; code[40])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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
