page 51127 "Marketing Event Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Marketing Event";
    Caption = 'Marketing Event / Forum';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Event ID"; Rec."Event ID") { }
                field("Campaign ID"; Rec."Campaign ID") { }
                field("Event Type"; Rec."Event Type") { }
                field("Status"; Rec."Status") { }
            }



            group(Details)
            {
                field("Event Date"; Rec."Event Date") { }
                field("Location"; Rec."Location") { }
            }
            group(AttendanceSummary)
            {
                Caption = 'Attendance Summary';

                field("Members Attended"; Rec."Members Attended")
                {
                    Editable = false;
                }

                field("Guests Attended"; Rec."Guests Attended")
                {
                    Editable = false;
                }

            }
            group(Budget)
            {
                field("Budget Amount"; Rec."Budget Amount") { }
                field("Actual Expenses"; Rec."Actual Expenses")
                {
                    Editable = false;
                }
            }
            group(EventExpenses)
            {
                part(Expenses; "Event Expense Subpage")
                {
                    SubPageLink = "Event ID" = field("Event ID"),
                                  "Campaign ID" = field("Campaign ID");
                }
            }

            group("Event Attendance")
            {
                part(Attendance; "Event Attendance Subpage")
                {
                    SubPageLink = "Event ID" = field("Event ID"),
                                  "Campaign ID" = field("Campaign ID");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ViewROI)
            {
                Caption = 'View ROI';
                Image = Statistics;
                // Placeholder for ROI page
            }


            action(ConvertLeads)
            {
                Caption = 'Convert Leads';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Attendance: Record "Event Attendance";
                    Noseries: Codeunit "No. Series";
                    Salessetup: Record "Sacco No. Series";
                    Contacts: Record "Customer Contact";
                    intNo: Code[60];
                begin
                    Attendance.Reset();
                    Attendance.SetRange(Attendance."Campaign ID", Rec."Campaign ID");
                    Attendance.SetRange(Attendance."Event ID", Rec."Event ID");
                    Attendance.SetRange(Attendance."Attendee Type", Attendance."Attendee Type"::Guest);
                    if Attendance.FindFirst() then begin
                        repeat
                            Salessetup.Get();
                            intNo := '';
                            intNo := Noseries.GetNextNo(Salessetup."Contact Nos");
                            Contacts.Init();
                            Contacts."No." := intNo;
                            Contacts.Name := Attendance."Guest Name";
                            Contacts."Mobile Phone No" := Attendance."Phone No.";
                            Contacts."Sales Agent Code" := Attendance."Marketing Officer";
                            Contacts."Marketing Event ID" := Attendance."Event ID";
                            Contacts."Marketing Campaign ID" := Attendance."Campaign ID";
                            Contacts.Insert(true);

                        until Attendance.Next() = 0;
                        Message('Leads Created successfully');
                    end;
                end;

            }
        }
    }
}


