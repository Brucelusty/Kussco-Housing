//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50437 "Fixed Deposit Type"
{
    DrillDownPageId="Fixed deposit Types list View";
    LookupPageId="Fixed deposit Types list View";
    // //nownPage51516470;

    fields
    {
        field(1; "Code"; Code[30])
        {
            NotBlank = true;
        }
        field(2; Duration; DateFormula)
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "No. of Months"; Integer)
        {
        }
        field(5; "Maximum Amount"; Decimal)
        {
        }
                field(6; "Interest Rate"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code,Duration,Description,"No. of Months","Maximum Amount")
        {
        }
    }
}




