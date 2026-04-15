page 50217 "Event Attendance Subpage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Event Attendance";
    Caption = 'Event Attendance';


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Attendee Type"; Rec."Attendee Type") { }
                field("Member No."; Rec."Member No.") { }
                field("Guest Name"; Rec."Guest Name") { }
                field("Phone No."; Rec."Phone No.") { }
                field("Converted to Member"; Rec."Converted to Member") { }
                field("Linked Customer No."; Rec."Linked Customer No.") { }
                field("Marketing Officer"; Rec."Marketing Officer") { }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ImportAttendance)
            {
                Caption = 'Import Attendance';
                Image = Import;

                trigger OnAction()
                begin
                    XmlPort.Run(50789, false, true);
                    //  CurrPage.Update(false);
                end;
            }

            action(ExportAttendance)
            {
                Caption = 'Export Attendance';
                Image = Export;

                trigger OnAction()
                var
                    Attendance: Record "Event Attendance";
                begin
                    // Filter the attendance to the current Marketing Event
                    Attendance.SetRange("Campaign ID", Rec."Campaign ID");
                    Attendance.SetRange("Event ID", Rec."Event ID");
                    XmlPort.Run(50789, true, false);
                end;
            }
        }
    }


}


