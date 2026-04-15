table 50748 "Old Vendor Ledger"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Entry No."; Code[20])
        {}
        field(2;"Vendor No."; Code[50])
        {}
        field(3;"Posting Date"; Date)
        {}
        field(4;"Document Type"; Text[2000])
        {}
        field(5;"Document No."; Code[50])
        {}
        field(6;"Description"; Text[200])
        {}
        field(7;"Amount"; Decimal)
        {}
        field(8;"Amount (LCY)"; Decimal)
        {}
        field(9;"Remaining Amt. (LCY)"; Decimal)
        {}
        field(10;"Due Date"; Date)
        {}
        field(11;"External Document No."; Code[50])
        {}
        field(12;"Debit Amount"; Decimal)
        {}
        field(13;"Credit Amount"; Decimal)
        {}
        field(14;"Global Dimension 1 Code"; Code[50])
        {}
        field(15;"Global Dimension 2 Code"; Code[50])
        {}
        field(16;"User ID"; Code[50])
        {}
        field(17;"Date Filter"; Date)
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
