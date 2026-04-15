table 50759 "Sacco Meetings"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Meeting No"; Code[20])
        {
            DataClassification = ToBeClassified;
            // Editable = false;
        }
        field(2; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Meeting Description"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Meeting Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                dateCalc: Codeunit "Dates Calculation";
            begin
                if "Registered On" = 0D then "Registered On" := Today;
                if "Meeting Date" < CalcDate('<-3M>', "Registered On") then Error('You cannot book meeting earlier than %1', CalcDate('<-3M>', "Registered On"));
                Month := dateCalc.DetermineMonthText("Meeting Date");
            end;
        }
        field(12; "Uploaded By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Uploaded"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Uploaded On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Meeting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Staff, Board, Delegates, Other';
            OptionMembers = "","Staff Meeting","Board Meeting","Delegates","Other";

            trigger OnValidate()
            var
                position: Option Employee,Director,Delegate;
            begin
                if "Meeting Type" = "Meeting Type"::"Staff Meeting" then begin
                    position := position::Employee;
                    FnInsertIntendedMeetingAttendees(position);
                end else if "Meeting Type" = "Meeting Type"::Delegates then begin
                    position := position::Delegate;
                    FnInsertIntendedMeetingAttendees(position);
                end;
            end;
        }
        field(16; "Committee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sacco Committees";
            trigger OnValidate()
            begin
                saccoCommittees.Reset();
                saccoCommittees.SetRange("Committee No.", "Committee No");
                if saccoCommittees.Find('-') then begin
                    "Committee Name" := saccoCommittees."Committee Name";
                end;

                committeeMembers.Reset();
                committeeMembers.SetRange(Committee, "Committee No");
                if committeeMembers.FindSet() then begin
                    repeat
                        attendees.Init();
                        attendees."Doc No." := "Meeting No";
                        attendees."Member No" := committeeMembers."Member No";
                        attendees."Member Name" := committeeMembers."Member Name";
                        if not attendees.Insert() then attendees.Modify();
                    until committeeMembers.Next() = 0;
                end;

            end;
        }
        field(17; "Allowance Expected"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        field(18; "Total Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        field(19; "Total Actual Allowance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Meeting Lines".Allowance where("Doc No." = field("Meeting No"), "Member Present" = filter(true)));
        }
        field(20; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Test; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Posted By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Posted On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Special Meeting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Registered On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(26; "Approved By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Approved On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Completed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Month; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Committee Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Delegate Zone"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Delegate Zones".Code;

            trigger OnValidate()
            var
                delZone: Record "Member Delegate Zones";
                saccoMeet: Record "Sacco Meetings";
            begin
                saccoMeet.Reset();
                saccoMeet.SetRange("Delegate Zone", "Delegate Zone");
                saccoMeet.SetRange(Month, Month);
                saccoMeet.SetRange(Year, Year);
                saccoMeet.SetFilter("Meeting No", '<>%1', "Meeting No");
                if saccoMeet.Find('-') then begin
                    Error('The meetings for %1 for the month of %2 %3 have already been submitted.', "Delegate Zone", Month, Format(Year));
                end;

                if delZone.Get("Delegate Zone") then begin
                    "Delegate Zone Name" := delZone.Description;
                    "Delegate Zone Region" := delZone."Zone Region";
                end;
            end;
        }
        field(33; "Delegate Zone Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Delegate Zone Region"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Meeting No")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        noSeries: Codeunit "No. Series";
        saccoNo: Record "Sacco No. Series";
        attendees: Record "Meeting Lines";
        insiders: Record InsiderLending;
        committeeMembers: Record "Sacco Committee Members";
        saccoCommittees: Record "Sacco Committees";

    trigger OnInsert()
    begin
        saccoNo.Get();
        if "Meeting No" = '' then begin
            saccoNo.TestField("Meeting Nos");
            if "Meeting Type" <> "Meeting Type"::"Board Meeting" then begin
                noSeries.GetNextNo(saccoNo."Meeting Nos");
            end else begin
                noSeries.GetNextNo('BOD');
            end;
        end;

        "Meeting Date" := Today;
        "Registered On" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    local procedure FnInsertIntendedMeetingAttendees(memberType: Option Employee,Director,Delegate)
    var
        myInt: Integer;
    begin
        insiders.Reset();
        insiders.SetRange("Position Held", memberType);
        if insiders.FindSet() then begin
            attendees.Init();
            attendees."Doc No." := "Meeting No";
            attendees."Member No" := insiders."Member No";
            attendees."Member Name" := insiders."Member Name";
            if not attendees.Insert() then attendees.Modify();
        end;
    end;

}
