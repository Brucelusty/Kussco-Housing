table 50047 Designation
{
    DataClassification = ToBeClassified;
    LookupPageId = "Designation List";
    DrillDownPageId = "Designation List";
    fields
    {
        field(1;Designation;Code[40])
        {
            DataClassification = ToBeClassified;
        }
    
        field(3; Description; Text[150])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; Designation)
        {
            Clustered = true;
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
