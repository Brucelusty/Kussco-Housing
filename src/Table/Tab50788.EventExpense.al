table 50788 "Event Expense"
{
    Caption = 'Event Expense';

    fields
    {

        field(1; "Campaign ID"; Code[20]) { }
        field(2; "Event ID"; Code[20]) { }
        field(3; "Entry No."; Integer) { AutoIncrement = true; }
        field(4; "Expense Category"; Enum "Expense Category") { }
        field(5; "Description"; Text[100]) { }
        field(6; "Amount"; Decimal) { }
        field(7; "Posting Date"; Date) { }
    }

    keys
    {
        key(PK; "Campaign ID", "Event ID", "Entry No.", "Expense Category", Description) { }
    }
}
