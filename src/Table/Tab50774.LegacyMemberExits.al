table 50774 "Legacy Member Exits"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Serial No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;No; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Member No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Member Name"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Staff  No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Notice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7;Deposits; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;ESS; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Total Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(Key1; "Serial No")
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
