table 50727 "Sky Mobile Setup"
{

    fields
    {
        field(1;No;Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Vendor Commission Account";Code[20])
        {
            TableRelation = Vendor;
        }
        field(3;"Sacco Fee Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4;"Bank Account";Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(5;"Transaction Type";Option)
        {
            OptionCaption = ' ,Withdrawal,Deposit,Utility Payment,Loan Repayment,Balance Enquiry,Mini-Statement,Loan Disbursement,Account Transfer,Pay Loan From Account,Paybill,Mobile App Login,Bank Transfer,Airtime,T-Kash Loan Repayment,T-Kash Paybill,CoopDeposit';
            OptionMembers = " ",Withdrawal,Deposit,"Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer",Airtime,"T-Kash Loan Repayment","T-Kash Paybill",CoopDeposit;
        }
        field(6;"Vendor Commission";Decimal)
        {
        }
        field(7;"Sacco Fee";Decimal)
        {
        }
        field(8;"Safaricom Account";Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(9;"Safaricom Fee";Decimal)
        {
        }
        field(10;"Pre-Payment Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11;"SMS Charge";Decimal)
        {
        }
        field(12;"SMS Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(13;"Transaction Limit";Decimal)
        {

            trigger OnLookup()
            begin
                IF "Transaction Limit" > 0 THEN BEGIN
                    IF ("Transaction Type"<>"Transaction Type"::Withdrawal) AND ("Transaction Type"<>"Transaction Type"::"Utility Payment") THEN
                        ERROR('This option is not applicable for this transaction');
                END;
            end;
        }
        field(14;"Non-Member Debit Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(15;"Daily Limit";Decimal)
        {
        }
        field(16;"Weekly Limit";Decimal)
        {
        }
        field(17;"Monthly Limit";Decimal)
        {
        }
        field(18;"Restrict to Employer";Code[20])
        {
            TableRelation = "Sacco Employers";
        }
        field(19;Disable;Boolean)
        {
        }
        field(50063;"Use %";Boolean)
        {
        }
        field(50064;"% Charge";Decimal)
        {
        }
        field(50065;"Vendor Charge Type";Option)
        {
            OptionMembers = "Flat Amount",Percentage,Staggered;
        }
        field(50066;"Vendor Staggered Code";Code[20])
        {
            TableRelation = "Staggered Charges";
        }
        field(50067;"Sacco Charge Type";Option)
        {
            OptionMembers = "Flat Amount",Percentage,Staggered;
        }
        field(50068;"Sacco Staggered Code";Code[20])
        {
            TableRelation = "Staggered Charges";
        }
        field(50069;"3rd Party Charge Type";Option)
        {
            OptionMembers = "Flat Amount",Percentage,Staggered;
        }
        field(50070;"3rd Party Staggered Code";Code[20])
        {
            TableRelation = "Staggered Charges";
        }
        field(50071;"Network Service Provider";Option)
        {
            OptionMembers = Safaricom,Telkom;
        }
        field(50072;"Charge From Sacco";Boolean)
        {
        }
        field(50073;"VAT %";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }
}

