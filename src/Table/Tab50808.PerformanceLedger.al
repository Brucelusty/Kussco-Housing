table 50808 "Performance Ledger"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; }
        field(2; "Period"; Date) { }
        field(3; "Scope"; Enum "Performance Scope") { }
        field(4; "Officer ID"; Code[20]) { }
        field(5; "Branch Code"; Code[20]) { }
        field(6; "KPI Code"; Code[20]) { }
        field(7; Actual; Decimal) { }
        field(8; Score; Decimal) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
}
