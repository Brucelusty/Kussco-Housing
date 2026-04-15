table 50178 "Funds Transfer Charges"
{
    Caption = '"Funds Transfer  Charges"';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[40])
        {
            Caption = 'Code';
        }
        field(2; "Min Band"; Decimal)
        {
            Caption = 'Min Band';
        }
        field(3; "Upper Band"; Decimal)
        {
            Caption = 'Upper Band';
        }
        field(4; "Sacco Comm"; Decimal)
        {
            Caption = 'Sacco Comm';
        }
        field(5; "Vendor Comm"; Decimal)
        {
            Caption = 'Vendor Comm';
        }
        field(6; "Excise Duty"; Decimal)
        {
            Caption = 'Excise Duty';
        }
        field(7; Total; Decimal)
        {
            Caption = 'Total';
        }
        field(8; Mpesa; Decimal)
        {
            Caption = 'Mpesa AMount';

        }

        field(9; "Sacco Comm G/L"; Code[20])
        {
            Caption = 'Sacco Comm Account';
            TableRelation = "G/L Account";
        }
        field(10; "Vendor Comm G/L"; Code[20])
        {
            Caption = 'Vendor Comm Account';
            TableRelation = Vendor."No.";
        }

        field(11; "Mpesa Account"; Code[20])
        {
            Caption = 'MPESA Account';
            TableRelation = "G/L Account";
        }
        field(12; "Percentage"; Text[80])
        {

        }
        field(13; "Use Percentage"; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
