table 50749 "Old Vendor Details"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Vendor No"; Code[20])
        {
        }
        field(2;"last Trans Date"; Date)
        {
        }
        field(3;"last Trans Text"; Text[250])
        {
        }
    }
    
    keys
    {
        key(Key1; "Vendor No")
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
