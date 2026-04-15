table 50050 "Employer Members"
{
    Caption = 'Employer Members';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[40])
        {

        }
        field(2; "Member No"; Code[40])
        {
            Caption = 'Member No';
        }

        field(3; "Transaction Type"; Option)
        {
            OptionCaption = ',Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Withdrawable Deposits,Holiday_Savers,Penalty Paid,Dev Shares,Fanikisha,Welfare Contribution 2,Loan Penalty,Loan Guard,Gpange,Junior,Juja,Housing Water,Housing Title,Housing Main,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement,SchFees Shares';
            OptionMembers = "","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits",Holiday_Savers,"Penalty Paid","Dev Shares",Fanikisha,"Welfare Contribution 2","Loan Penalty","Loan Guard",Gpange,Junior,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","SchFees Shares";
        }

        field(4; "Loan No"; Code[60])
        {

        }


        field(5; "Amount"; Decimal)
        {

        }



        field(7; "Vendor New"; Code[60])
        {

        }

        field(8; "Account Type"; Option)
        {
            OptionCaption = ',Vendor,Member,GL';
            OptionMembers = "",Vendor,member,GL;
        }

    }
    keys
    {
        key(PK; "Member No", "Document No", "Transaction Type")
        {
            Clustered = true;
        }
    }
}
