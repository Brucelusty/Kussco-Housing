table 65700 "Sacco Setup"
{

    fields
    {
        field(1;"No.";Code[20])
        {
        }
        field(9;"Excise Duty G/L";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11;"Excise Duty (%)";Decimal)
        {
        }
        field(12;"Sacco SMS Expense GL";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(13;"Mobile Vendor Account";Code[20])
        {
            TableRelation = Vendor;
        }
        field(14;"Sacco SMS Income GL";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(15;"Vendor SMS Split Amount";Decimal)
        {
        }
        field(16;"Maximum Mobile Loan Limit";Decimal)
        {
        }
        field(17;"Minimum Share Capital";Decimal)
        {
        }
        field(18;"Initial Loan Limit";Decimal)
        {
        }
        field(19;"Defaulter Initial Limit";Decimal)
        {
        }
        field(20;"Loan Increment";Decimal)
        {
        }
        field(21;"Defaulter Loan Increment";Decimal)
        {
        }
        field(22;"Loan Penalty %";Decimal)
        {
        }
        field(50001;"MBanking Application Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50014;"SMS Sender ID";BigInteger)
        {
        }
        field(50015;"SMS Sender Name";Text[30])
        {
        }
        field(50016;"Virtual Members Images Path";Text[250])
        {
        }
        field(50017;"Loan Interest Expense GL";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50018;"Mbanking Application Name";Text[30])
        {
        }
        field(50019;"USSD Code";Text[30])
        {
        }
        field(50020;"Max Posting Attempts";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RestrictAccess(USERID)
    end;

    trigger OnInsert()
    begin
        RestrictAccess(USERID)
    end;

    trigger OnModify()
    begin
        RestrictAccess(USERID)
    end;

    trigger OnRename()
    begin
        RestrictAccess(USERID)
    end;

    procedure RestrictAccess(UserNo: Code[100])
    var
        StatusPermission: Record //"51516310"
        "Status Change Permision";
        ErrorOnRestrictViewTxt: Label 'You do not have permissions to MODIFY or DELETE on this Page. Contact your system administrator for further details';
    begin
        /*
        StatusPermission.RESET;
        StatusPermission.SETRANGE("User ID",UserNo);
        StatusPermission.SETRANGE("Edit Setup",TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
          ERROR(ErrorOnRestrictViewTxt);
          END;
          */

    end;
}

