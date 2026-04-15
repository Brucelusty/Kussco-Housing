table 50747 "Old Vendor"
{
    fields
    {
        field(1 ;"No."; Code[20])
        {}
        field(2 ;Name; Text[2000])
        {}
        field(3 ;"Creditor Type"; Option)
        {
            OptionMembers = ,Account;
        }
        field(4 ;"Staff No"; Code[20])
        {}
        field(5 ;"BOSA Account No"; Code[20])
        {}
        field(6 ;"Account Type"; Code[20])
        {}
        field(7 ;"Uncleared Cheques"; Decimal)
        {}
        field(8 ;"Balance (LCY)"; Decimal)
        {}
        field(9 ;"Global Dimensional Code 1"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(10;"Global Dimensional Code 2"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(11;"Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12 ;"Global Dimensional 1 Filter"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            FieldClass = FlowFilter;
        }
        field(13 ;"Global Dimensional 2 Filter"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            FieldClass = FlowFilter;
        }
    }
    
    keys
    {
        key(Key1; "No.")
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
