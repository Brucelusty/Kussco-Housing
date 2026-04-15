table 50046 WorkStations
{
    DataClassification = ToBeClassified;
    LookupPageId = "WorkStation List";
    DrillDownPageId = "WorkStation List";
    fields
    {
        field(1;EmployerCode;Code[40])
        {
            TableRelation = "Employers Register"."Employer Code";
        }
        field(2; Code; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Region; Code[30])
        {
            // TableRelation = Regions."Region Code";
        }
    }

    keys
    {
        key(Key1; EmployerCode,Code)
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
