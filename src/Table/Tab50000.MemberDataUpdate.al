table 50000 "Member Data Update"
{
    Caption = 'Member Data Update';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member  No"; Code[30])
        {
            Caption = 'Member  No';
        }
        field(2; "Old FOSA no"; Code[30])
        {
            Caption = 'Old FOSA no';
        }
        field(3; "New FOSA No"; Code[30])
        {
            Caption = 'New FOSA No';
        }
        field(4; "Employer Code"; Code[100])
        {
            Caption = 'Employer Code';
        }
        field(5; "Employer Name"; Text[200])
        {
            Caption = 'Employer Name';
        }

        field(7; "atm no"; code[200])
        {

        }
    }
    keys
    {
        key(PK; "Member  No")
        {
            Clustered = true;
        }
    }
}
