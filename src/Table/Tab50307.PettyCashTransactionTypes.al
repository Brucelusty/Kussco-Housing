table 50307 "Petty Cash Transaction Types"
{
    LookupPageId = "Petty Cash Transaction Types";
    DrillDownPageId = "Petty Cash Transaction Types";
    
    fields
    {
        field(1;Code; Code[20])
        {}
        field(2;Description; Text[2000])
        {}
        field(3;"Destination Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
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
