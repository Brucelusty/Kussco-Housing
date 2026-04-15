//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50559 "Sub Sector"
{

    fields
    {
        field(1; "Main Sector"; Code[50])
        {
        }
        field(2; Code; Code[50])
        {
        }
        field(3; Description; Text[1000])

        {
        }
        field(4; No; Code[50])
        {
            Caption = 'Noded';
        }

    }

    keys
    {
        key(Key1; "Main Sector", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




