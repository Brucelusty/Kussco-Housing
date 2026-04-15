Table 50032 "Defined Transaction Type"
{

    fields
    {
        field(1; "Defined Transaction Type"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Used In"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'BOSA,FOSA,ALL';
            OptionMembers = BOSA,FOSA,ALL;
        }
        field(3; "System Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Shares Capital,Interest Paid,Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Loan Penalty Charged,Loan Penalty Paid,HouseHold Savings,Housing Coop Shares,Utafiti Housing,Holiday Savings,Dependant 1 Savings,Dependant 2 Savings,Dependant 3 Savings,Interest on Deposits,Share Boost Fee,Rejoining Fee,Dormant Reactivation Fee';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee";

        }

    }

    keys
    {
        key(Key1; "Defined Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

