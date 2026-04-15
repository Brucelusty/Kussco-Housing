table 50766 "Old Member Ledger Entries"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Old Member Ledger Entries";
    
    fields
    {
        field(1;"Entry No."; Integer)
        {}
        field(2;"Member No."; Code[50])
        {}
        field(3;"Posting Date"; Date)
        {}
        field(4;Amount; Decimal)
        {}
        field(5;Reveresed; Text[100])
        {}
        field(6;Transaction; Text[2000])
        {}
        field(7;Rectified;Boolean)
        {}
        field(8;"Rectified Date"; Date)
        {}
    }
    
    keys
    {
        key(Key1; "Entry No.")
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
