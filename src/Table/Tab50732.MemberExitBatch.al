table 50732 "Member Exit Batch"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Exit Batch List";
    LookupPageId = "Member Exit Batch List";

    fields
    {
        field(1; "Exit Batch No."; code[20])
        {
            DataClassification = ToBeClassified;

            NotBlank = false;

            trigger OnValidate()
            begin
                if "Exit Batch No." <> xRec."Exit Batch No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Exit Batch Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(3; "Description/Remarks"; Text[150])
        {
        }
        field(4; Posted; Boolean)
        {
            Editable = true;
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",,Approved,Rejected;
        }
        field(6; "Date Created"; Date)
        {
        }
        field(7; "Posting Date"; Date)
        {
        }
        field(8; "Posted By"; Code[250])
        {
        }
        field(9; "Prepared By"; Code[20])
        {
        }
        field(10; Date; Date)
        {
        }
        field(11; "Approved By"; Code[40])
        {
            Editable = false;
        }
        field(12; "Mode Of Disbursement"; Option)
        {
            OptionCaption = 'FOSA Account';
            OptionMembers = "FOSA Account";
        }
        field(13; "Document No."; code[20])
        {

        }
        field(24; Source; Option)
        {
            OptionCaption = 'FOSA';
            OptionMembers = FOSA;
        }
        field(25; "Total to Disburse"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Membership Exist"."Amount To Disburse" where("Exit Batch No." = field("Exit Batch No."), "Fully Paid" = filter(false)));
        }
        field(26; "Authorised By"; Code[20])
        { }
        field(27; "Total Refund"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Membership Exist"."Total Refund" where("Exit Batch No." = field("Exit Batch No.")));
        }
        field(28; "Fully Paid"; Boolean)
        {

        }
        field(29; "Batch Status"; Option)
        {
            OptionCaption = ',Not Fully Paid,Fully Paid';
            OptionMembers = " ","Not Fully Paid","Fully Paid";
        }
        field(30; "Total Remainder"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Membership Exist".Remainder where("Exit Batch No." = field("Exit Batch No.")));

            trigger OnValidate()
            begin
                CalcFields("Total Remainder");
                if "Total Remainder" = 0 then begin
                    "Fully Paid" := true;
                    Posted := true;
                end else begin
                    "Fully Paid" := false;
                    Posted := false;
                end;
            end;
        }

    }

    keys
    {
        key(Key1; "Exit Batch No.")
        {
            Clustered = true;
        }
        key(key2; "Description/Remarks")
        { }
        key(key3; Date) { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Exit Batch No.", "Description/Remarks", "Posting Date")
        {
        }
    }

    var
        myInt: Integer;
        membExit: Record "Membership Exist";
        exitBatch: Record "Member Exit Batch";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        EntryNo: Integer;

    trigger OnInsert()
    begin
        exitBatch.Reset();
        exitBatch.SetRange("Exit Batch No.", xrec."Exit Batch No.");
        if exitBatch.Find('-') then begin
            exitBatch.CalcFields("Total Refund");
            if exitBatch."Total Refund" = 0 then Error('A batch with no exits already exists, Batch no: %1.', exitBatch."Exit Batch No.");
        end;

        if "Exit Batch No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Exit Batch Nos");
            NoSeriesMgt.GetNextNo(SalesSetup."Exit Batch Nos");
            "Document No." := "Exit Batch No.";
        end;
        //ERROR('You dont have permission to create %1 batches',"Batch Type")
        "Mode Of Disbursement" := "mode of disbursement"::"FOSA Account";
        "Date Created" := Today;
        "Prepared By" := UserId;
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
