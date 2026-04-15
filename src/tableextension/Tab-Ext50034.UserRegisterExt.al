tableextension 50034 "UserRegister_Ext" extends "User Time Register"
{
    fields
    {
        field(50000; "Login Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(50001; "Logout Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
        // key(Key2; "Login Time", "Logout Time")
        // {

        // }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        loginTime: Time;
        userTimereg: Record "User Time Register";
}
