//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50473 "POS Commissions"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Lower Limit"; Decimal)
        {
        }
        field(3; "Upper Limit"; Decimal)
        {
        }
        field(4; "Charge Amount"; Decimal)
        {
        }
        field(5; "Sacco charge"; Decimal)
        {
        }
        field(6; "Bank charge"; Decimal)
        {
        }
        field(7; "Total Charge"; Decimal)
        {
        }
        field(8; "Transaction Type";enum "ATM Transaction Types")
        {
           // OptionMembers = POS,"ATM Withdrawal";
        }
        field(9; "Excise Duty"; Decimal)
        {
        }

        field(10; "Sacco charge Account"; Code[40])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(11; "Bank charge Account";Code[40])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(12; "Excise Duty Account";Code[40])
        {
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Code", "Lower Limit","Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




