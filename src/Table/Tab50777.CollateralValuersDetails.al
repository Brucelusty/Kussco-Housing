table 50777 "Collateral Valuers Details"
{
    Caption = 'Collateral Valuers Details';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Valuer Code"; Code[60])
        {
            Caption = 'Valuer Code';
        }
        field(2; Name; Text[120])
        {
            Caption = 'Name';
        }
        field(3; "Phone No."; Code[60])
        {
            Caption = 'Phone No.';
        }
        field(4; "E-Mail  "; Text[80])
        {
            Caption = 'E-Mail  ';
        }
        field(5; Location; Text[80])
        {
            Caption = 'Location';
        }
        field(6; Address; Code[120])
        {
            Caption = 'Address';
        }
        field(7; "Physical Location"; Code[200])
        {
            Caption = 'Physical Location';
        }
    }
    keys
    {
        key(PK; "Valuer Code")
        {
            Clustered = true;
        }
    }
}
