table 50762 "Sacco Committees"
{
    DrillDownPageId = "Sacco Committees";
    LookupPageId = "Sacco Committees";

    fields
    {
        field(1; "Committee No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Committee Name"; Text[500])
        {
            Editable = true;
        }
        field(3; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(4; "Is Board"; Boolean)
        {
        }
        field(5; "Is Supervisory"; Boolean)
        {
        }
        field(6; "Is Joint Board"; Boolean)
        {
        }
        field(7; "Is Other Committee"; Boolean)
        {
        }
        field(8; "Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sacco Committee Members" where("Committee" = field("Committee No.")));
        }
    }

    keys
    {
        key(Key1; "Committee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(DropDown; "Committee No.", "Committee Name", Members)
        { }
    }

    var
        myInt: Integer;
        noSeries: Codeunit "No. Series";
        insider: Record InsiderLending;
        hrSetup: Record "HR Setup";
        vend: Record Vendor;
        leave: Record "HR Leave Application";

    trigger OnInsert()
    begin
        if "Committee No." = '' then begin
            hrSetup.Get();
            hrSetup.TestField("Committee Nos");
            noSeries.GetNextNo(hrSetup."Committee Nos");
        end;
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

}
