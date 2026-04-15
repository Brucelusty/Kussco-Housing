//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50776 "Product Graduated Interest"
{

    fields
    {
        field(1; "Minimum Installment"; Integer)
        {
        }//
        field(2; "Maximum Installment"; Integer)
        {
        }
        field(3; Percentage; Decimal)
        {
        }
        field(4; "Product Code"; Code[60])
        {
        }
 
    }

    keys
    {
        key(Key1; "Minimum Installment", "Maximum Installment","Product Code", Percentage)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




