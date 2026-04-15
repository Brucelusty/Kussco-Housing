table 50763 "Non MOU Employers"
{
    DataClassification = ToBeClassified;

    DrillDownPageId = "Non MOU Employers";
    LookupPageId = "Non MOU Employers";

    fields
    {
        field(1; "Employer No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Employer Name"; Text[500])
        {
            Editable = true;
        }
        field(3; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(4; "Registered on"; Date)
        {
        }
        field(5; "Registered By"; Code[20])
        {
        }
        field(6; "MOU Signed"; Boolean)
        {
        }
        field(7; "MOU Signed On"; Date)
        {
        }
        field(8; "MOU Captured By"; Code[20])
        {
        }
        field(9; "MOU Captured On"; Date)
        {
        }
        field(10; "Employees"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Employer Code" = field("Employer No.")));
        }
        field(11; "Employer Address"; Code[50])
        {
        }
        field(12; "Employer Physical Location"; Text[250])
        {
        }
        field(13; "Employer Email"; Text[50])
        {
        }
        field(14; "Employer Phone No"; Code[30])
        {
        }
        field(15; "Contact Person"; Text[100])
        {
        }
        field(16; "Contact Person Mobile No"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Employer No.")
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
        insider: Record InsiderLending;
        hrSetup: Record "HR Setup";
        vend: Record Vendor;
        leave: Record "HR Leave Application";

    trigger OnInsert()
    begin
        "Registered By" := UserId;
        "Registered on" := Today;
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
