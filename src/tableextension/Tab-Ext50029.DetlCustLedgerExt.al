//************************************************************************
tableextension 50029 "DetlCustLedgerExt" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50002; "Transaction Type"; Enum TransactionTypesEnum)
        {
            /*             OptionCaption = ' ,Registration Fee,Shares Capital,Interest Paid,Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Loan Penalty Charged,Loan Penalty Paid,HouseHold Savings,Housing Coop Shares,Utafiti Housing,Holiday Savings,Dependant 1 Savings,Dependant 2 Savings,Dependant 3 Savings,Interest on Deposits,Share Boost Fee,Rejoining Fee,Dormant Reactivation Fee';
                        OptionMembers = " ","Registration Fee","Shares Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Repayment","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee" */
            //OptionCaption = ' ,Registration Fee,Shares Capital,Interest Paid,Repayment,Deposit Contribution,Insurance Contribution,BBF Fund,Loan,Coop Shares,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Loan Penalty Charged,Loan Penalty Paid,HouseHold Savings,Housing Coop Shares,Utafiti Housing,Holiday Savings,Dependant 1 Savings,Dependant 2 Savings,Dependant 3 Savings,Interest on Deposits,Share Boost Fee,Rejoining Fee,Dormant Reactivation Fee';
            // OptionMembers = " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Coop Shares",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee";
        }
        field(50003; "Loan No"; Code[20])
        {
        }
        field(50004; "Group Code"; Code[20])
        {
        }
        field(50005; Type; Option)
        {
            OptionCaption = ' ,Registration,PassBook,Loan Insurance,Loan Application Fee,Down Payment';
            OptionMembers = " ",Registration,PassBook,"Loan Insurance","Loan Application Fee","Down Payment";
        }
        field(50006; "Member Name"; Text[30])
        {
        }
        field(50007; "Loan Type"; Code[25])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(50008; "Prepayment Date"; Date)
        {
        }
        field(50009; Totals; Decimal)
        {
            CalcFormula = sum("Member Ledger Entry".Amount where("Document No." = filter('JUNE  15/06/14')));
            FieldClass = FlowField;
        }

        field(50010; "No Boosting"; Boolean)
        {
        }
        field(50011; "Posting Count"; Integer)
        {
        }
        field(50012; "Total Debits"; Decimal)
        {
            /*             CalcFormula = sum("Member Ledger Entry".Amount where("Transaction Type" = filter("Share Capital"),
                                                                              "Loan Type" = field("Loan Type"),
                                                                              "Posting Date" = field("Posting Date")));
                        FieldClass = FlowField; */
        }
        field(50013; "Total Credits"; Decimal)
        {
            CalcFormula = sum("Member Ledger Entry".Amount where("Transaction Type" = filter("Interest Paid"),
                                                                  "Loan Type" = field("Loan Type"),
                                                                  "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(50014; "Group Account No"; Code[20])
        {
        }
        field(50015; "FOSA Account No."; Code[60])
        {
        }
        field(50016; "Recovery Transaction Type"; Option)
        {
            OptionCaption = 'Normal,Guarantor Recoverd,Guarantor Paid';
            OptionMembers = Normal,"Guarantor Recoverd","Guarantor Paid";
        }
        field(50017; "Recoverd Loan"; Code[20])
        {
        }
        field(50018; "Share Boosting Fee Charged"; Boolean)
        {
        }
        field(50019; "Reversed Cust Entry"; Code[20])
        {
        }

        field(50020; "Correct Reversal Date"; Date)
        {
        }
        field(50021; "Reversal Date"; Date)
        {
        }
        field(50022; "Transaction Date"; Date)
        {
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(50023; "Application Source"; Option)
        {
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(50024; "Created On"; DateTime)
        {
        }
        field(50025; "Computer Name"; Text[30])
        {
        }
        field(50026; "Member House Group"; Code[30])
        {
        }
        field(50000; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key5; "Transaction Type", "Loan No")
        {

        }
    }
    var
        myInt: Integer;
}


