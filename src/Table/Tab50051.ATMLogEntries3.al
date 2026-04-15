table 50051 "ATM Log Entries3"
{
    Caption = 'ATM Log Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "Date Time"; DateTime)
        {
            Caption = 'Date Time';
        }
        field(3; "Account No"; Code[20])
        {
            Caption = 'Account No';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "ATM No"; Code[20])
        {
            Caption = 'ATM No';
        }
        field(6; "ATM Location"; Text[1024])
        {
            Caption = 'ATM Location';
        }
        field(7; "Transaction Type"; Option)
        {
            OptionCaption = 'MPESA B2C,KPLC PostPaid,KPLC Prepaid,DSTV,ZUKU,Safaricom Airtime Purchase,Pesalink,POS Cash deposit,Cash Withdrawal,Cardless ATM withdrawal,Safaricom C2B,Ministatement Sacco direct,Airtel Airtime purchase,Balance Enquiry_Sacco_Direct,Nairobi water bill payment,Bank Account to sacco account,Sacco account to bank account,Airtel B2C,TELKOM B2C,Sacco account to Virtual Card,Virtual card to SACCO,Sacco to other Sacco,Other sacco to Sacco,TELCOM C2B,Reversal,POS Cash Withdrawal, VISA Cash withdrawal';
            OptionMembers = "MPESA B2C","KPLC PostPaid","KPLC Prepaid",DSTV,ZUKU,"Safaricom Airtime Purchase",Pesalink,"POS Cash deposit","Cash Withdrawal","Cardless ATM withdrawal","Safaricom C2B","Ministatement Sacco direct","Airtel Airtime purchase","Balance Enquiry_Sacco_Direct","Nairobi water bill payment","Bank Account to sacco account","Sacco account to bank account","Airtel B2C","TELKOM B2C","Sacco account to Virtual Card","Virtual card to SACCO","Sacco to other Sacco","Other sacco to Sacco","TELCOM C2B",Reversal,"POS Cash Withdrawal","VISA Cash withdrawal";

        }
        field(8; "Return Code"; Code[100])
        {
            Caption = 'Return Code';
        }
        field(9; "Trace ID"; Code[100])
        {
            Caption = 'Trace ID';
        }
        field(10; "Account No."; Code[100])
        {
            Caption = 'Account No.';
        }
        field(11; "Card No."; Code[100])
        {
            Caption = 'Card No.';
        }
        field(12; "ATM Amount"; Decimal)
        {
            Caption = 'ATM Amount';
        }
        field(13; "Withdrawal Location"; Text[1024])
        {
            Caption = 'Withdrawal Location';
        }
        field(14; "Reference No"; Text[100])
        {
            Caption = 'Reference No';
        }
        field(15; "Code Description"; Text[250])
        {
            Caption = 'Code Description';
        }
        field(16; "Credit account"; Code[100])
        {
            Caption = 'Credit account';
        }
        field(17; "Institutional code"; Text[100])
        {
            Caption = 'Institutional code';
        }
        field(18; "institution Name"; Text[100])
        {
            Caption = 'institution Name';
        }
        field(19; Channel; Code[50])
        {
            Caption = 'Channel';
        }
        field(20; "Connection Mode"; Code[100])
        {
            Caption = 'Connection Mode';
        }
        field(21; Narrative1; Text[250])
        {
            Caption = 'Narrative1';
        }
        field(22; Narrative2; Text[250])
        {
            Caption = 'Narrative2';
        }

        field(23; "Message ID"; Text[250])
        {
            //Caption = 'Narrative2';
        }
        field(24; "Reversed"; Boolean)
        {
            //Caption = 'Narrative2';
        }
          field(25; "Terminal ID"; text[26])
        {

        }
        field(26;"Transaction Code"; Text[20])
        {

        }
        field(27; "Account Name"; Text[300])
        {
            Caption = 'Account Name';
        }
        field(28; "Posted Date"; Date)
        {
        }
        field(29; "Posted Time"; Time)
        {
        }
        field(30; "Account Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Account No"), Reversed = filter(false)));
        }
        field(31; "Bank Doc_No"; Code[20])
        {
            // FieldClass = FlowField;
            // CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Account No"), Reversed = filter(false)));
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }

    }
}
