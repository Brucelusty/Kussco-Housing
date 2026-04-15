table 50719 "Member Salary Variance Buffer"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Entry No"; Integer)
        {
            Editable = false;
        }
        field(2;"Member No"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
            trigger OnValidate() begin
                if cust.Get("Member No") then begin
                    "Payroll No" := cust."Payroll No";
                    "Member Name" := cust.Name;
                end;
            end;
        }
        field(3;"Payroll No"; Code[20])
        {
        }
        field(4;"Member Name"; Text[1800])
        {
        }
        field(5;"Member Salary"; Decimal)
        {
        }
        field(6;"Expected Deduction"; Decimal)
        {
        }
        field(7;"Actual Deduction"; Decimal)
        {
            
        }
        field(8;"Variance"; Decimal)
        {
        }
        field(9;"Month"; Integer)
        {
        }
        field(10;"Year"; Integer)
        {
        }
        field(11;"Document No"; Code[20])
        {
        }
    }
    
    keys
    {
        key(Key1; "Member No", "Document No")
        {
            Clustered = true;
        }
        key(Key2; "Member No")
        {
        }
        key(Key3; Month, Year)
        {
        }
        key(Key4; "Entry No")
        {
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
    myInt: Integer;
    cust: Record Customer;
    
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
