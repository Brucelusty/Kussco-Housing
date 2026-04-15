table 50713 "Audit Trail"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            Editable=false;
            
        }
        field(2;"User Id"; Code[60])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
        field(3;"Transaction Type"; text[150])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
        field(4;Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
        field(5;Source; code[80])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
        field(6;Date; date)
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
        field(7;Time; time)
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
        field(8;"Loan Number"; code[80])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
         field(9;"Document Number"; code[80])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
         field(10;"Account Number"; code[80])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
         field(11;"ATM Card"; code[80])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
         field(12;"Computer Name"; text[250])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
         field(13;"IP Address"; code[200])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
         field(14;MACAddress; code[200])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
         field(15;UserName; code[60])
        {
            DataClassification = ToBeClassified;
            Editable=false;
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
