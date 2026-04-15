table 65706 "AU Safcom Corporate Charges"
{

    fields
    {
        field(2;Minimum;Decimal)
        {
        }
        field(3;Maximum;Decimal)
        {
        }
        field(4;Charge;Decimal)
        {
        }
        field(5;"Code";Code[20])
        {
        }
        field(6;"Use Percentage";Boolean)
        {
        }
        field(7;Percentage;Decimal)
        {
            DecimalPlaces = 4:4;
        }
        field(8;VAT;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;Minimum,"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

