table 65707 "AU Product Setup"
{

    fields
    {
        field(1;"Product ID";Code[20])
        {
        }
        field(2;"Product Description";Text[30])
        {

            trigger OnValidate()
            begin
                IF "USSD Product Name" = '' THEN
                    "USSD Product Name" := "Product Description";
            end;
        }
        field(3;"Product Class Type";Option)
        {
            OptionMembers = " ",Loan,Savings,Charges,"G/L Account";
        }
        field(4;"Product Category";Option)
        {
            OptionMembers = "  ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard",Lukenya,Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","Loan Due","FOSA Shares","Loan Form Fee","PassBook Fee","Normal shares","SchFee Shares","Principle Unallocated","Interest Unallocated","Registration fees","Deposit Transfer Fees";
        }
        field(5;"USSD Product Name";Text[30])
        {
        }
        field(6;"Key Word";Code[10])
        {
        }
        field(7;"Mobile Transaction";Option)
        {
            OptionMembers = " ","Deposits Only","Withdrawals Only","Deposits & Withdrawals";
        }
        field(8;"Table Present";Option)
        {
            OptionMembers = Members,Vendor,"G/LAccount";
        }
        field(9;"Account Type";Code[30])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
    }

    keys
    {
        key(Key1;"Product ID")
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

