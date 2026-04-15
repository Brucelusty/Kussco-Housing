table 50760 "Sacco Committee Members"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Committee"; Code[20])
        {
            Editable = false;
        }
        field(3; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where("Member Type" = filter(Board), "Insider Status" = filter("Board Member"), ISNormalMember = filter(true));
            trigger OnValidate()
            begin
                insider.Reset();
                insider.SetRange("Member No", "Member No");
                if insider.Find('-') then begin
                    "Member Name" := insider."Member Name";
                    "ID No" := insider."ID No.";
                end else begin
                    Error('The member %1 is not a board member under insider lending.', "Member No");
                end;
            end;
        }
        field(4; "Member Name"; Text[500])
        {
            Editable = false;
        }
        field(5; "Position Name"; Enum "Committee Positions")
        { }
        field(6; "ID No"; Code[20])
        {
            Editable = false;
        }
        field(7; "Is Active"; Boolean)
        {
            Editable = true;
            trigger OnValidate()
            begin
            end;
        }
        field(8; "Sitting Allowance"; Decimal)
        {

        }
        field(9; "Transport Allowance"; Decimal)
        {

        }
        field(10; "Sitting Allowance Special"; Decimal)
        {

        }
        field(11; "Transport Allowance Special"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Committee", "Member No")
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
        fundSetup: Record "Funds General Setup";
        insider: Record InsiderLending;
        vend: Record Vendor;
        leave: Record "HR Leave Application";

    trigger OnInsert()
    begin

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
