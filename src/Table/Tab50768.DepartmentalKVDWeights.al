table 50768 "Departmental KVD Weights"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;KVD; Code[20])
        {
            TableRelation = "Key Value Drivers"."Key Value Driver";

            trigger OnValidate() begin
                kvds.Reset();
                kvds.SetRange("Key Value Driver", KVD);
                if kvds.Find('-') then begin
                    "Value Driver" := kvds.Description;
                end;
            end;
        }
        field(2;"Department code"; Code[20])
        {
            
        }
        field(3;"Total Weight"; Decimal)
        {
            trigger OnValidate() begin
                departments.Reset();
                departments.SetRange(Code, "Department code");
                if departments.Find('-') then begin
                    departments.CalcFields("Total KVD Weights");
                    if ((departments."Total KVD Weights"-xRec."Total Weight") + "Total Weight") > 100 then Error('The total weights can only go up to 100%');
                end;
            end;
        }
        field(4;"Value Driver"; Text[500])
        {

        }
        field(5;"Total KPI Weights"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Departmental KPIs".Weight where("Parent KVD" = field(KVD), "Department Code" = field("Department code")));
        }
    }
    
    keys
    {
        key(Key1; KVD, "Department code")
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
        kvds: Record "Key Value Drivers";
        departments: Record "Responsibility Center";
        kpis: Record "Departmental KPIs";
    
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
