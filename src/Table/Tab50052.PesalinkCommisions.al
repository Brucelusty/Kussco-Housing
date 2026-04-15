table 50052 "Pesalink Commisions"
{
    Caption = 'Pesalink Commisions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
        }
        field(2; "Lower Limit"; Decimal)
        {
            Caption = 'Lower Limit';
        }
        field(3; "Upper Limit"; Decimal)
        {
            Caption = 'Upper Limit';
        }
        field(4; "Charge Amount"; Decimal)
        {
            Caption = 'Charge Amount';
        }
        field(5; "Sacco charge"; Decimal)
        {
            Caption = 'Sacco charge';
        }
        field(6; "Bank charge"; Decimal)
        {
            Caption = 'Bank charge';
        }
    }
    keys
    {
        key(PK; "Code", "Lower Limit")
        {
            Clustered = true;
        }
    }
}
