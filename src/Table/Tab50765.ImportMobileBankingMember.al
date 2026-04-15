table 50765 "Import Mobile Banking Member"
{
    Caption = 'Import Mobile Banking Member';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
        }
        field(2; "ID No."; Code[20])
        {
            Caption = 'ID No.';
        }
        field(3; Mobile; Boolean)
        {
            Caption = 'Mobile';
        }
        field(4; Internet; Boolean)
        {
            Caption = 'Internet';
        }
        field(5; Status; Text[50])
        {
            Caption = 'Status';
        }
    }
    keys
    {
        key(PK; "Phone No.")
        {
            Clustered = true;
        }
    }
}
