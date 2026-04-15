table 50718 "Loans Disbursement Buffer"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Loan Number"; Code[40])
        {
            //Caption = 'MyField';
            DataClassification = ToBeClassified;
        }

                field(2;"Disbursement Date"; Date)
        {
           // Caption = 'MyField';
            DataClassification = ToBeClassified;
        }
        
    }
    
    keys
    {
        key(Key1; "Loan Number")
        {
            
        }
    }
    
}
