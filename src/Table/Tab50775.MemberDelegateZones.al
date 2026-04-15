table 50775 "Member Delegate Zones"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Delegate Zones";
    LookupPageId = "Member Delegate Zones";
    Caption='Member Regions';
    fields
    {
        field(1;Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Zone Region"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Regions."Region Code";
        }
        field(4;"Zone Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(InsiderLending where("Delegate Region" = field(Code)));
        }
    }
    
    keys
    {
        key(Key1; Code)
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
