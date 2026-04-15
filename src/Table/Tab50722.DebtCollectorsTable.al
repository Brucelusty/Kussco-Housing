table 50722 "Debt Collectors Table"
{
    // DataClassification = ToBeClassified;
    DrillDownPageId = "Debt Collectors List";
    LookupPageId = "Debt Collectors List";

    fields
    {
        field(1; "Debtors Code"; Code[50])
        {}
        field(2; "Debt Collectors"; Text[500])
        {
        }
        field(3; Rate; Decimal)
        {

        }
        field(4; UserID; code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
    }
    
    keys
    {
        key(Key1; "Debtors code", "Debt Collectors")
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
