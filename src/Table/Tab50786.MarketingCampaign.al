table 50786 "Marketing Campaign"
{
    Caption = 'Marketing Campaign';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Campaign ID"; Code[20])
        {
            Caption = 'Campaign ID';
            Editable = false;
        }

        field(2; "Description"; Text[100]) { }

        field(3; "Start Date"; Date) { }
        field(4; "End Date"; Date) { }

        field(5; "Budget Amount"; Decimal)
        {
            Caption = 'Campaign Budget';
        }

        field(6; "Status"; Enum "Campaign Status") { }

        field(7; "Owner User ID"; Code[50]) { }

        field(20; "Total Events"; Integer)
        {
            /*             FieldClass = FlowField;
                        CalcFormula = count("Marketing Event"
                            where("Campaign ID" = field("Campaign ID"))); */
        }

        field(21; "Actual Expenses"; Decimal)
        {
            /*             FieldClass = FlowField;
                        CalcFormula = sum("Event Expense"."Amount"
                            where("Campaign ID" = field("Campaign ID"))); */
        }
        field(22; "Created By"; Code[50])
        {

        }
        field(23; "Created On"; DateTime)
        {

        }
    }

    keys
    {
        key(PK; "Campaign ID") { Clustered = true; }
    }
    trigger OnInsert()
    var
        MarketingSetup: Record "Crm General Setup.";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "Campaign ID" = '' then begin
            if not MarketingSetup.Get() then
                Error('Marketing Setup is not configured.');

            MarketingSetup.TestField("Campaign Nos");
            "Campaign ID" := NoSeriesMgt.GetNextNo(MarketingSetup."Campaign Nos");
        end;

        // Default status
        // if Status = Status:: then
        Status := Status::Planned;

        // Audit fields
        "Created By" := UserId;
        "Created On" := CurrentDateTime;
    end;
}
