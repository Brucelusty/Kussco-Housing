table 50739 "Final CustLedgerEntries Buffer"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Amount"; Decimal)
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
