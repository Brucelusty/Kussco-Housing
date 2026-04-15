table 50769 "Departmental KPIs"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;KPI; Code[75])
        {
            TableRelation = "Key Performance Indicators".Indicator where("Key Value Drivers" = field("Parent KVD"));
        }
        field(2;"Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3;Weight; Decimal)
        {
            trigger OnValidate() begin
                kvds.Reset();
                kvds.SetRange(KVD, "Parent KVD");
                kvds.SetRange("Department code", "Department Code");
                if kvds.Find('-') then begin
                    kvds.CalcFields("Total KPI Weights");
                    if ((kvds."Total KPI Weights"-xRec.Weight) + Weight) > kvds."Total Weight" then Error('The total weights can only go up to %1%', kvds."Total Weight");
                end;
            end;
        }
        field(4;"KPI Target"; Text[2048])
        {

        }
        field(5;"Parent KVD"; Code[20])
        {

        }
        field(6;"Department Code"; Code[20])
        {

        }
    }
    
    keys
    {
        key(Key1; KPI, "Entry No", "Parent KVD", "Department Code")
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
        kvds: Record "Departmental KVD Weights";
    
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
