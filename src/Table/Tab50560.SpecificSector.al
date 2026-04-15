//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50560 "Specific Sector"
{

    fields
    {

        field(1; "Main Sector"; Code[50])
        {
        }
        field(2; "Sub-Sector"; Code[50])
        {
        }
        field(3; "Code"; Code[50])
        {
        }
        field(4; Description; Text[1000])
        {
        }

        field(5; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Loans Register"."Approved Amount" where("Sector Specific" = field("code"), "Issued Date" = field("Date Filter")));
        }
        field(6; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(7; No; Code[50])
        {
            // FieldClass = FlowFilter;
        }

        field(8; Offsets; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Loans Register"."Total Offsets" where("Sector Specific" = field("code"), "Issued Date" = field("Date Filter")));
        }

    }

    keys
    {
        key(Key1; "Main Sector", "Sub-Sector", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




