table 50807 "Performance Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20]) { }
        field(2; "Line No."; Integer) { }
        field(3; "KPI Code"; Code[20]) { }
        field(4; "KPI Type"; Enum "KPI Type") { }
        field(5; Target; Decimal) { }
        field(6; Actual; Decimal) { }
        field(7; Weight; Decimal) { }
        field(8; Score; Decimal) { }
        field(9; "Weighted Score"; Decimal) { }
    }

    keys
    {
        key(PK; "Document No.", "Line No.") { Clustered = true; }
    }
}

