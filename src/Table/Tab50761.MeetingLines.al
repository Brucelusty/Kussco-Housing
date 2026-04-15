table 50761 "Meeting Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Doc No."; Code[20])
        {
            Editable = false;
            TableRelation = "Sacco Meetings"."Meeting No";
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
            Editable = false;
            trigger OnValidate()
            begin
                cust.Reset();
                cust.SetRange("No.", "Member No");
                if cust.Find('-') then begin
                    "Member Name" := cust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Text[500])
        {
            Editable = false;
        }
        field(4; "Member Present"; Boolean)
        {
        }
        field(5; "Allowance"; Decimal)
        {

        }
        field(6; Defaulter; Boolean)
        {

        }
        field(7; Dormant; Boolean)
        {

        }
        field(8; "Already Paid"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Doc No.", "Member No")
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
        cust: Record Customer;
        insider: Record InsiderLending;
        vend: Record Vendor;

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
