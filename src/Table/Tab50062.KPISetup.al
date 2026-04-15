table 50062 "KPI Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "KPI Code"; Code[20]) { }
        field(2; Description; Text[100]) { }
        field(3; "KPI Type"; Enum "KPI Type") { }
        field(4; "Calculation Type"; Enum "KPI Calc Type") { }
        field(5; Weight; Decimal) { }
        field(6; Target; Decimal) { }
        field(7; "Reverse Score"; Boolean) { Caption = 'Lower is Better'; }
        field(8; Active; Boolean) { }
    
    }

    keys
    {
        key(PK; "KPI Code") { Clustered = true; }
    }
}
