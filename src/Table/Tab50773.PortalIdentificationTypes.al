table 50773 "Portal Identification Types"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Portal Identification Types";
    LookupPageId = "Portal Identification Types";
    
    fields
    {
        field(1;Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Type of Identification"; Enum "Portal Identification Types")
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Registration Fee,Shares Capital,Interest Paid,Repayment,Deposit Contribution,Insurance Contribution,BBF Fund,Loan,Coop Shares,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Loan Penalty Charged,Loan Penalty Paid,HouseHold Savings,Housing Coop Shares,Utafiti Housing,Holiday Savings,Dependant 1 Savings,Dependant 2 Savings,Dependant 3 Savings,Interest on Deposits,Share Boost Fee,Rejoining Fee,Dormant Reactivation Fee';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Coop Shares",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee";
        }
        field(5;"STO Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Date Based,Salary,Pension,Bonus,Dividend,Other Income,PaytoFOSA';
            OptionMembers = "Date Based",Salary,Pension,Bonus,Dividend,"Other Income",PaytoFOSA;
        }
        field(6;"Staff Options"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}
