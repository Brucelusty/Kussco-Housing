table 50757 "Import Buffer"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Payroll No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Employee Name"; Text[800])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Region"; Text[800])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Mobile Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Town"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Workstation"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"PF No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(Key1; "Payroll No")
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
