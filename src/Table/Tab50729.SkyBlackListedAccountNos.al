table 50729 "Sky Black-Listed Account Nos"
{

    fields
    {
        field(1;"Account No.";Code[20])
        {
            TableRelation = Vendor;
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
        field(8;"BlackList on Loan";Boolean)
        {
        }
        field(9;"BlackList on Deposit";Boolean)
        {
        }
        field(10;"BlackList on Withdrawal";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Account No.")
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
       // StatusPermission.RESET;
       // StatusPermission.SETRANGE("User ID",USERID);
        //StatusPermission.SETRANGE("Black-List Accounts",TRUE);
        //IF NOT StatusPermission.FIND('-') THEN BEGIN
        //    ERROR('You do not have the following permission: "Black-List Accounts"');
        //END;



        "Black-Listed By" := USERID;
        "Date Black-Listed" := TODAY;
    end;

    trigger OnModify()
    begin

       // StatusPermission.RESET;
       // StatusPermission.SETRANGE("User ID",USERID);
        //StatusPermission.SETRANGE("Black-List Accounts",TRUE);
       // IF NOT StatusPermission.FIND('-') THEN BEGIN
        //    ERROR('You do not have the following permission: "Black-List Accounts"');
       // END;

        "Black-Listed By" := USERID;
        "Date Black-Listed" := TODAY;
    end;

    var
      //  StatusPermission: Record "51516702";
}

