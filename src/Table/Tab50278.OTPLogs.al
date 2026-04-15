table 50278 "OTP Logs"
{
    Caption = 'OTP Logs';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "User Id"; Code[20])
        {
            Caption = 'User Id';
        }
        field(2; OTP; Integer)
        {
            Caption = 'OTP';
        }
        field(3; "Generated On"; DateTime)
        {
            Caption = 'Generated On';
        }
        field(4; "Session ID"; Integer)
        {
            Caption = 'Session ID';
        }
        field(5; "Entry No"; Integer)
        {

        }
        field(6; "Expiration Time"; DateTime)
        {

        }
    }
    keys
    {
        key(PK; "User Id", "Session ID", "Entry No")
        {
            Clustered = true;
        }
    }
}
