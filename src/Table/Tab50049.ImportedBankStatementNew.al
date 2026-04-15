table 50049 "Imported Bank Statement New"
{
    Caption = 'Imported Bank Statement';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Transaction ID"; Code[100])
        {
            Caption = 'Transaction ID';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Bank Statement No"; Code[20])
        {
            Caption = 'Bank Statement No';
        }
        field(4; Description; Text[1000])
        {
            Caption = 'Description';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
        }
    }
    keys
    {
        key(PK; "Transaction ID")
        {
            Clustered = true;
        }
    }
}
