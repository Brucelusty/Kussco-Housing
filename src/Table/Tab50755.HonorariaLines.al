table 50755 "BOD Honoraria Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "No Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "BOD"; Code[20])
        {
            TableRelation = InsiderLending."Member No" where("Position Held" = filter(Director));

            trigger OnValidate()
            begin
                vend.Reset();
                vend.SetRange("BOSA Account No", BOD);
                vend.SetRange("Account Type", '103');
                if vend.Find('-') then begin
                    "FOSA Account" := vend."No.";
                    "BOD Name" := vend.Name;
                    "Mobile Phone No" := vend."Mobile Phone No";
                end;
            end;
        }
        field(4; "FOSA Account"; Code[20])
        {
            Editable = false;
        }
        field(5; "BOD Name"; Text[500])
        {
            Editable = false;
        }
        field(6; "Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                fundSetup.Get();
                if Amount <> 0 then begin
                    "PAYE Amount" := Amount * (fundSetup."PAYE Percentage" / 100);
                    "Net Amount" := Amount - "PAYE Amount";
                end;
            end;
        }
        field(7; "PAYE Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(9; "Line No"; Integer)
        {
            Editable = false;
            AutoIncrement = true;
        }
        field(10; "Mobile Phone No"; Code[20])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", BOD)
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
        // if "No." = '' then begin
        //     fundSetup.Get();
        //     fundSetup.TestField("BOD Honoraria Nos");
        //     noSeries.TestManual(fundSetup."BOD Honoraria Nos");

        //     noSeries.InitSeries(fundSetup."BOD Honoraria Nos", xRec."No Series", 0D, "No.", "No Series");

        //     "Initiated By" := UserId;
        //     "Initiated On" := Today;
        // end;
        "Line No" := xRec."Line No" + 1000;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        // if "Approval Status" <> "Approval Status"::Open then Error('You cannot delete this record.');
    end;

    trigger OnRename()
    begin

    end;

}
