table 50789 "Event Attendance"
{
    Caption = 'Event Attendance';

    fields
    {
        field(1; "Campaign ID"; Code[20]) { }

        field(2; "Event ID"; Code[20]) { }
        field(3; "Entry No."; Integer) { AutoIncrement = true; }
        field(4; "Attendee Type"; Enum "Attendee Type") { }


        field(5; "Member No."; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
        }

        field(6; "Guest Name"; Text[100]) { }
        field(7; "Phone No."; Text[30]) { }

        field(8; "Converted to Member"; Boolean) {Caption='Convert to Member Application?'; }
        field(9; "Linked Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(10; "Marketing Officer"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }


    }

    keys
    {
        key(PK; "Campaign ID", "Event ID", "Entry No.", "Attendee Type", "Member No.", "Guest Name", "Phone No.") { }
    }
}
