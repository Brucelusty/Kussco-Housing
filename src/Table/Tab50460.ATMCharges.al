//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50460 "ATM Charges"
{

    fields
    {
        field(1; "Transaction Type"; Option)
        {
            OptionCaption = 'MPESA B2C,KPLC PostPaid,KPLC Prepaid,DSTV,ZUKU,Safaricom Airtime Purchase,Pesalink,POS Cash deposit,Cash Withdrawal,Cardless ATM withdrawal,Safaricom C2B,Ministatement Sacco direct,Airtel Airtime purchase,Balance Enquiry_Sacco_Direct,Nairobi water bill payment,Bank Account to sacco account,Sacco account to bank account,Airtel B2C,TELKOM B2C,Sacco account to Virtual Card,Virtual card to SACCO,Sacco to other Sacco,Other sacco to Sacco,TELCOM C2B,Reversal,POS Cash Withdrawal, VISA Cash withdrawal,Cash Withdrawal - Coop ATM';
            OptionMembers = "MPESA B2C","KPLC PostPaid","KPLC Prepaid",DSTV,ZUKU,"Safaricom Airtime Purchase",Pesalink,"POS Cash deposit","Cash Withdrawal","Cardless ATM withdrawal","Safaricom C2B","Ministatement Sacco direct","Airtel Airtime purchase","Balance Enquiry_Sacco_Direct","Nairobi water bill payment","Bank Account to sacco account","Sacco account to bank account","Airtel B2C","TELKOM B2C","Sacco account to Virtual Card","Virtual card to SACCO","Sacco to other Sacco","Other sacco to Sacco","TELCOM C2B",Reversal,"POS Cash Withdrawal","VISA Cash withdrawal","Cash Withdrawal - Coop ATM";
        }
        field(2; "Total Amount"; Decimal)
        {
        }
        field(3; "Sacco Amount"; Decimal)
        {
        }
        field(4; Source; Option)
        {
            OptionMembers = ATM,POS;
        }
        field(5; "Atm Income A/c"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(6; "Atm Bank Settlement A/C"; Code[30])
        {
            TableRelation = "Bank Account";
        }
        field(7; "Excise Duty"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Transaction Description"; Text[100])
        {
        }
        field(9; Channel; Code[100])
        {
        }
        field(10; Code; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




