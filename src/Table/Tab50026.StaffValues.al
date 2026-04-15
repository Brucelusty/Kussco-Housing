Table 50026 "Staff Values"
{

    fields
    {
        field(1;Value;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Weight;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Value)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

