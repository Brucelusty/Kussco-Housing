table 50754 "BOD Honoraria"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Honoraria No"; Code[20])
        {
            Editable = false;
        }
        field(2; "No Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "Initiated By"; Code[20])
        {
            Editable = false;
        }
        field(4; "Posted By"; Code[20])
        {
            Editable = false;
        }
        field(5; "Initiated On"; Date)
        {
            Editable = false;
        }
        field(6; "Posted On"; Date)
        {
            Editable = false;
        }
        field(7; "Total Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("BOD Honoraria Lines"."Net Amount" where("No." = field("Honoraria No")));
        }
        field(8; "Total Count"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("BOD Honoraria Lines" where("No." = field("Honoraria No")));
        }
        field(9; "Description"; Text[1080])
        {

        }
        field(10; "Paid"; Boolean)
        {
            Editable = false;
        }
        field(11; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
            Editable = false;
        }
        field(12; "Cheque No"; Code[20])
        {

        }
        field(13; "Total Expected Amount"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Honoraria No")
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



    trigger OnInsert()
    begin
        if "Honoraria No" = '' then begin
            fundSetup.Get();
            fundSetup.TestField("BOD Honoraria Nos");
            noSeries.GetNextNo(fundSetup."BOD Honoraria Nos");

            "Initiated By" := UserId;
            "Initiated On" := Today;
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        if "Approval Status" <> "Approval Status"::Open then Error('You cannot delete this record.');
    end;

    trigger OnRename()
    begin

    end;

}
