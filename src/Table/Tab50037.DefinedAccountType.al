Table 50037 "Defined Account Type"
{

    fields
    {
        field(1; "Defined Account Type"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Used In"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'BOSA,FOSA,ALL';
            OptionMembers = BOSA,FOSA,ALL;
        }
        field(3; "System Account Type"; Option)
        {
            OptionCaption = ' ,FOSA Account,Member BOSA Account';
            OptionMembers = " ","FOSA Account","Member BOSA Account";

        }

    }

    keys
    {
        key(Key1; "Defined Account Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

