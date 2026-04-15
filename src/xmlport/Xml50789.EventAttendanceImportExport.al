xmlport 50789 "Event Attendance Import Export"
{
    Caption = 'Event Attendance Import/Export';
    Direction = Both;
    Format = VariableText;
    FieldDelimiter = ',';
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(EventAttendance; "Event Attendance")
            {
                fieldelement(CampaignID; EventAttendance."Campaign ID") { }
                fieldelement(EventID; EventAttendance."Event ID") { }
                fieldelement(AttendeeType; EventAttendance."Attendee Type") { }
                fieldelement(MemberNo; EventAttendance."Member No.") { }
                fieldelement(GuestName; EventAttendance."Guest Name") { }
                fieldelement(PhoneNo; EventAttendance."Phone No.") { }
                fieldelement(ConvertedToMember; EventAttendance."Converted to Member") { }
                fieldelement(LinkedCustomerNo; EventAttendance."Linked Customer No.") { }
                fieldelement(MarketingOfficer; EventAttendance."Marketing Officer") { }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }
    }
}
