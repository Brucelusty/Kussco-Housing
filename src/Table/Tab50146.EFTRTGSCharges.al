table 50146 "EFT - RTGS Charges"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Charge Code"; Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Lower Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Upper Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Charge Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(6;"Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
    }
    
    keys
    {
        key(Key1; "Charge Code")
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
