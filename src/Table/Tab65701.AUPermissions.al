table 65701 "AU Permissions"
{

    fields
    {
        field(1;"User ID";Code[80])
        {
            Caption = 'User ID.';
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(48;"Reset Mpesa Pin";Boolean)
        {
        }
        field(49;"Update Paybill Transaction";Boolean)
        {
        }
        field(50000;"Update Transactional Mobile No";Boolean)
        {
        }
        field(50050;"Sky Mobile Setups";Boolean)
        {
        }
        field(50051;"Reverse Sky Transactions";Boolean)
        {
        }
        field(50052;"Black-List Accounts";Boolean)
        {
        }
        field(50053;"Generate CRB";Boolean)
        {
        }
        field(50054;"Edit Batches";Boolean)
        {
        }
        field(50055;"Update Loan Sectors";Boolean)
        {
        }
        field(50056;"Update MPESA Withdrawal";Boolean)
        {
        }
        field(50057;"Micro Applications";Boolean)
        {
        }
        field(50058;"Micro Transactions";Boolean)
        {
        }
        field(50059;"Micro Loans";Boolean)
        {
        }
        field(50060;"View BlackListed Accounts";Boolean)
        {
        }
        field(50061;"Export GL Entries";Boolean)
        {
        }
        field(50062;"Clear Transactional Mobile";Boolean)
        {
        }
        field(50063;"Upload Loan Sectorial";Boolean)
        {
        }
        field(50064;"Loan Rescheduling";Boolean)
        {
        }
        field(50065;"Interest Due Period";Boolean)
        {
        }
        field(50066;"Undo Mahitaji BlackList";Boolean)
        {
        }
        field(50067;"Approve Mobile Banking";Boolean)
        {
        }
        field(50068;"Create MBanking Applications";Boolean)
        {
        }
        field(50069;"Mpesa Reconciliation";Boolean)
        {
        }
        field(50070;"Reverse M Bank Transfer";Boolean)
        {
        }
        field(50071;"ATM Permisions";Boolean)
        {
        }
        field(50072;"T-Kash Accounts";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"User ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RestrictAccess(USERID);
    end;

    trigger OnInsert()
    begin
        RestrictAccess(USERID);
    end;

    trigger OnModify()
    begin
        RestrictAccess(USERID);
    end;

    var
        UserMgt: Codeunit 5700;
        Temp: Record 91;

    procedure RestrictAccess(UserNo: Code[100])
    var
        StatusPermission: Record //"51516709"
        "AU USSD Auth";
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

