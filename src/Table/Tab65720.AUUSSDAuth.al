table 65720 "AU USSD Auth"
{

    fields
    {
        field(1; "Mobile No."; Code[30])
        {
        }
        field(2; "Account No."; Code[30])
        {
            Editable = true;
        }
        field(3; "PIN No."; Text[250])
        {
            Editable = true;
        }
        field(4; "Reset PIN"; Boolean)
        {

            trigger OnValidate()
            begin


                Vend.GET("Account No.");

                PINChangeLog.INIT;
                PINChangeLog.Date := CURRENTDATETIME;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := USERID;
                PINChangeLog."Old Value" := FORMAT(xRec."Reset PIN");
                PINChangeLog."New Value" := FORMAT("Reset PIN");
                PINChangeLog."Field Modified" := 'Reset PIN';
                PINChangeLog.INSERT;
            end;
        }
        field(5; "User Status"; Option)
        {
            OptionCaption = 'Active,Inactive, ';
            OptionMembers = Active,Inactive," ";

            trigger OnValidate()
            begin

                Vend.GET("Account No.");

                PINChangeLog.INIT;
                PINChangeLog.Date := CURRENTDATETIME;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := USERID;
                PINChangeLog."Old Value" := FORMAT(xRec."User Status");
                PINChangeLog."New Value" := FORMAT("User Status");
                PINChangeLog."Field Modified" := 'User Status';
                PINChangeLog.INSERT;
            end;
        }
        field(6; "Date Created"; Date)
        {
        }
        field(7; "Date Updated"; Date)
        {
        }
        field(8; "Initial PIN Sent"; Boolean)
        {
        }
        field(9; "Force PIN"; Boolean)
        {

            trigger OnValidate()
            begin

                "Reset PIN" := "Force PIN";

                Vend.GET("Account No.");

                PINChangeLog.INIT;
                PINChangeLog.Date := CURRENTDATETIME;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := USERID;
                PINChangeLog."Old Value" := FORMAT(xRec."Force PIN");
                PINChangeLog."New Value" := FORMAT("Force PIN");
                PINChangeLog.INSERT;
            end;
        }
        field(10; "Pin Sent"; Boolean)
        {
        }
        field(11; IMSI; Text[250])
        {
        }
        field(12; IMEI; Text[250])
        {
        }
        field(13; "Mobile App Activated"; Boolean)
        {
        }
        field(15; "Mobile App KYC Login Enabled"; Boolean)
        {

            trigger OnValidate()
            begin

                Vend.GET("Account No.");

                PINChangeLog.INIT;
                PINChangeLog.Date := CURRENTDATETIME;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := USERID;
                PINChangeLog."Old Value" := FORMAT(xRec."Mobile App KYC Login Enabled");
                PINChangeLog."New Value" := FORMAT("Mobile App KYC Login Enabled");
                PINChangeLog."Field Modified" := 'Mobile App KYC Login Enabled';
                PINChangeLog.INSERT;
            end;
        }
        field(16; "PIN Encrypted"; Boolean)
        {
        }
        field(17; "Login Attempts Count"; Integer)
        {
        }
        field(18; "Login Attempts Tag"; Text[30])
        {
        }
        field(19; "Login Attempts Action"; Text[50])
        {
        }
        field(20; "Login Attempts Action Expiry"; DateTime)
        {
        }
        field(21; "OTP Attempts Count"; Integer)
        {
        }
        field(22; "OTP Attempts Tag"; Text[30])
        {
        }
        field(23; "OTP Attempts Action"; Text[50])
        {
        }
        field(24; "OTP Attempts Action Expiry"; DateTime)
        {
        }
        field(25; "Reset IMSI"; Boolean)
        {

            trigger OnValidate()
            begin

                Vend.GET("Account No.");

                PINChangeLog.INIT;
                PINChangeLog.Date := CURRENTDATETIME;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := USERID;
                PINChangeLog."Old Value" := FORMAT(xRec."Reset IMSI");
                PINChangeLog."New Value" := FORMAT("Reset IMSI");
                PINChangeLog."Field Modified" := 'Reset IMSI';
                PINChangeLog.INSERT;
            end;
        }
        field(26; "Clear M-Banking Suspension"; Boolean)
        {
        }
        field(27; "Member Name"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE(//"Transactional Mobile No"
            "Mobile Phone No." = FIELD("Mobile No.")));
        }
        field(28; "ID No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor."ID No." WHERE(//"Transactional Mobile No"
            "Mobile Phone No." = FIELD("Mobile No.")));
        }
    }

    keys
    {
        key(Key1; "Mobile No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PINChangeLog: Record //"51516710"
        "AU Pin Change Log";
        Vend: Record 23;
}

