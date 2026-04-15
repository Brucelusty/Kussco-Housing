table 65703 "AU Black-Listed Phone Nos"
{

    fields
    {
        field(1;"Transactional Phone No.";Code[20])
        {
        }
        field(2;"Black-Listed";Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Reason);
                "Black-Listed By":=USERID;
                "Date Black-Listed":=TODAY;
            end;
        }
        field(3;"Black-Listed By";Code[50])
        {
            Editable = false;
        }
        field(4;"Date Black-Listed";Date)
        {
            Editable = false;
        }
        field(5;Reason;Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Transactional Phone No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        ERROR('Action not Allowed');
    end;

    trigger OnInsert()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE("User ID",USERID);
        StatusPermission.SETRANGE("Black-List Accounts",TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You do not have the following permission: "Black-List Accounts"');
        END;

        "Black-Listed By" := USERID;
        "Date Black-Listed" := TODAY;
    end;

    trigger OnModify()
    begin

        StatusPermission.RESET;
        StatusPermission.SETRANGE("User ID",USERID);
        StatusPermission.SETRANGE("Black-List Accounts",TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You do not have the following permission: "Black-List Accounts"');
        END;


        "Black-Listed By" := USERID;
        "Date Black-Listed" := TODAY;
    end;

    var
        StatusPermission: Record //"51516702"
        "AU Permissions";
}

