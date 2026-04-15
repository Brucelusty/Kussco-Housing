table 50753 "ESS Refund Batch"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "ESS Refund Batch List";
    LookupPageId = "ESS Refund Batch List";

    fields
    {
        field(1; "ESSRef Batch No."; Code[20])
        {
            Editable = false;
        }
        field(2; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "Captured On"; Date)
        {
            Editable = false;
        }
        field(4; "Posted On"; Date)
        {
            Editable = false;
        }
        field(5; "Posted"; Boolean)
        {
            Editable = false;
        }
        field(6; "Total Disbursed"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("ESS Refund"."ESS Refund" where("Refund Batch No" = field("ESSRef Batch No.")));

        }
        field(7; "Captured By"; Code[20])
        {
            Editable = false;

        }
        field(8; "Approved By"; Code[20])
        {
            Editable = false;

        }
        field(9; "Description"; Text[500])
        {

        }
        field(10; "Posted By"; Code[20])
        {
            Editable = false;

        }
        field(11; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
            Editable = false;
        }
        field(12; "Approved On"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "ESSRef Batch No.")
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
        saccoNoseries: Record "Sacco No. Series";
        cust: Record Customer;
        vend: Record Vendor;
        loansReg: Record "Loans Register";
        essBatch: Record "ESS Refund Batch";

    trigger OnInsert()
    begin
        essBatch.Reset();
        essBatch.SetRange("ESSRef Batch No.", xrec."ESSRef Batch No.");
        if essBatch.Find('-') then begin
            essBatch.CalcFields("Total Disbursed");
            if essBatch."Total Disbursed" = 0 then Error('A batch with no refunds already exists, Batch no: %1.', essBatch."ESSRef Batch No.");
        end;

        if "ESSRef Batch No." = '' then begin
            saccoNoseries.Get();
            saccoNoseries.TestField("ESS Refund Batch Nos");
            noSeries.GetNextNo(saccoNoseries."ESS Refund Batch Nos");
        end;

        "Captured By" := UserId;
        "Captured On" := Today;
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
