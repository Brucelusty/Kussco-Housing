table 50740 "BSS Businesses"
{
    LookupPageId = "BSS Businesses";
    DrillDownPageId = "BSS Businesses";
    
    fields
    {
        field(1;"Business Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Business Name"; Text[800])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Business Description"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Business Main Sector"; Text[1800])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Sector".Description;
            Editable = false;
        }
        field(5;"Business Sub-Sector"; Text[1800])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub Sector".Description where("Main Sector" = field("Business Main Sector"));
            Editable = false;
        }
        field(6;"Business Specific Sector"; Text[1800])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Specific Sector".Description;

            trigger OnValidate() begin
                specificSector.Reset();
                specificSector.SetRange(Description, "Business Specific Sector");
                if specificSector.Find('-') then begin
                    mainSector.Reset();
                    mainSector.SetRange(Code, specificSector."Main Sector");
                    if mainSector.Find('-') then begin
                        "Business Main Sector" := specificSector."Main Sector";
                    end;
                    subSector.Reset();
                    subSector.SetRange(Code, specificSector."Main Sector");
                    if mainSector.Find('-') then begin
                        "Business Sub-Sector" := specificSector."Sub-Sector";
                    end;
                end;
            end;
        }
        field(7;"Business Physical Location"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Business Year of Commence"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate() begin
                if "Business Year of Commence" > Today then Error('A business cannot start in the future.');
            end;
        }
    }
    
    keys
    {
        key(Key1; "Business Code", "Business Name")
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(dropdown; "Business Code", "Business Name", "Business Specific Sector", "Business Year of Commence")
        {}
    }
    
    var
        myInt: Integer;
        specificSector: Record "Specific Sector";
        subSector: Record "Sub Sector";
        mainSector: Record "Main Sector";
    
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
