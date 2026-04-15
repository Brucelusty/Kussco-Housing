table 50746 "Old Det Vendor Ledger Entries"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Entry No."; Code[50])
        {
        }
        field(2;"Vendor Ledger Entry No."; Code[50])
        {
        }
        field(3;"Entry Type"; Text[1500])
        {
        }
        field(4;"Posting Date"; Date)
        {
        }
        field(5;"Document Type"; Text[1500])
        {
        }
        field(6;"Document No."; Code[50])
        {
        }
        field(7;Amount; Decimal)
        {
        }
        field(8;"Amount (LCY)"; Decimal)
        {
        }
        field(9;"Vendor No."; Code[50])
        {
        }
        field(10;"User ID"; Code[50])
        {
        }
        field(11;"Debit Amount"; Decimal)
        {
        }
        field(12;"Credit Amount"; Decimal)
        {
        }
        field(13;"Debit Amount (LCY)"; Decimal)
        {
        }
        field(14;"Credit Amount (LCY)"; Decimal)
        {
        }
        field(15;"Initial Entry Due Date"; Date)
        {
        }
        field(16;"Initial Entry Global Dim. 1"; Code[50])
        {
        }
        field(17;"Initial Entry Global Dim. 2"; Code[50])
        {
        }
        field(18;"Initial Document Type"; Text[1500])
        {
        }
        field(19;"Ledger Entry Amount"; Boolean)
        {
        }
    }
    
    keys
    {
        key(Key1; "Entry No.", "Vendor Ledger Entry No.")
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
