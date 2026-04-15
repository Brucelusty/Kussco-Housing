Table 50012 "Member Transactions"
{

    fields
    {
        field(1;EntryNo;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Posting Date";date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Document Number";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Transaction Description";text[2000])
        {
            DataClassification = ToBeClassified;
           
        }
        field(5;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Transaction Type";text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Member No";code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"FOSA Account No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;EntryNo,"Posting Date","Document Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

