//************************************************************************
tableextension 50027 "GlentryExt" extends "G/L Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Staff Account"; Boolean)
        {
            CalcFormula = lookup(Vendor."Staff Account" where("No." = field("Bal. Account No.")));
            FieldClass = FlowField;
        }
        field(50001; "Remaining Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(50004; "Application Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(50005; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "GL Account Found"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "Transaction Types"; Option)
        {
            OptionCaption = ' ,Registration Fee,Shares Capital,Interest Paid,Repayment,Deposit Contribution,Insurance Contribution,BBF Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Loan Penalty Charged,Loan Penalty Paid,HouseHold Savings,Housing Coop Shares,Utafiti Housing,Holiday Savings,Dependant 1 Savings,Dependant 2 Savings,Dependant 3 Savings,Interest on Deposits,Share Boost Fee,Rejoining Fee,Dormant Reactivation Fee';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee";
            //FieldClass = FlowField;
            // CalcFormula = lookup("Detailed Cust. Ledg. Entry"."Transaction Type" where("Entry No." = field("Entry No."), "Entry Type" = const("Initial Entry")));

        }
    }

    var
        myInt: Integer;
}


