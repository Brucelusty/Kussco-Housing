table 50787 "Marketing Event"
{
    Caption = 'Marketing Event / Forum';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Event ID"; Code[20]) { Editable = false; }
        field(2; "Campaign ID"; Code[20])
        {
            TableRelation = "Marketing Campaign";
        }

        field(3; "Event Type"; Enum "Event Type") { }

        field(4; "Event Date"; Date) { }
        field(5; "Location"; Text[100]) { }

        field(6; "Budget Amount"; Decimal) { }

        field(7; "Actual Expenses"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Event Expense"."Amount"
                where("Event ID" = field("Event ID"), "Campaign ID" = field("Campaign ID")));
        }

        field(8; "Status"; Enum "Event Status") { }

        field(20; "Total Attendees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Event Attendance"
                where("Event ID" = field("Event ID"), "Campaign ID" = field("Campaign ID")));
        }

        field(21; "Converted Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer
                where("Lead Source ID" = field("Event ID")));
        }
        field(22; "Created By"; Code[50])
        {

        }
        field(23; "Created On"; DateTime)
        {

        }
        field(24; "Members Attended"; Integer)
        {
            CalcFormula = Count("Event Attendance" where(
                "Campaign ID" = field("Campaign ID"),
                "Event ID" = field("Event ID"),
                "Attendee Type" = const(Member),
           "Guest Name"=filter(<>'')));
            FieldClass = FlowField;
            // DataClassification = CustomerContent;
        }

        field(25; "Guests Attended"; Integer)
        {
            CalcFormula = Count("Event Attendance" where(
                "Campaign ID" = field("Campaign ID"),
                "Event ID" = field("Event ID"),
                "Attendee Type" = const(Guest),
           "Guest Name"=filter(<>'')));
            FieldClass = FlowField;
            //  DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK; "Event ID", "Campaign ID", "Event Type", "Event Date") { Clustered = true; }
    }

    trigger OnInsert()
    var
        MarketingSetup: Record "Crm General Setup.";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        // Auto-generate Campaign ID
        if "Event ID" = '' then begin
            if not MarketingSetup.Get() then
                Error('Marketing Setup is not configured.');

            MarketingSetup.TestField("Events Nos");
            "Event ID" := NoSeriesMgt.GetNextNo(MarketingSetup."Events Nos");
        end;

        // Default status
        // if Status = Status:: then
        Status := Status::Planned;

        // Audit fields
        "Created By" := UserId;
        "Created On" := CurrentDateTime;
    end;

}
