table 50790 "Defaulter Case"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Case No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(2; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Borrower No."), Posted = filter(true));
            trigger OnValidate()
            var
                Loans: Record "Loans Register";
            begin
                Loans.Reset();
                Loans.SetRange(Loans."Loan  No.", "Loan No.");
                Loans.SetAutoCalcFields(Loans."Outstanding Balance");
                if Loans.FindFirst() then begin
                    "Outstanding Amount" := Loans."Outstanding Balance";
                    "Days in Arrears" := Loans."Days In Arrears";
                    "Loan Status":=Loans."Recovery Stage";
                end;
            end;
        }
        field(3; "Borrower No."; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetRange(Customer."No.", "Borrower No.");
                if Customer.FindFirst() then begin
                    "Borrower Name" := Customer.Name;
                end;
            end;
        }
        field(4; "Borrower Name"; Text[100]) { Editable = false; }

        field(5; "Outstanding Amount"; Decimal)
        {
            // CalcFormula = Lookup("Loan Ledger Entry".Amount WHERE("Loan No." = FIELD("Loan No.")));
            // FieldClass = FlowField;
            Editable = false;
        }

        field(6; "Days in Arrears"; Integer)
        {
            // FieldClass = FlowField;
            //  CalcFormula = Lookup("Loan Header"."Days in Arrears" WHERE("No." = FIELD("Loan No.")));
            Editable = false;
        }

        field(7; "Arrears Bucket"; Enum "Arrears Bucket") { }

        field(8; "Recovery Stage"; Enum "Recovery Stage") {}

        field(9; "Assigned Officer"; Code[50]) { TableRelation = "Debt Collectors Table"."Debtors Code"; }

        field(10; "Collateral No."; Code[20])
        {
            TableRelation = "Loan Collateral Register"."Document No";
            trigger OnValidate()
            var
                Register: Record "Loan Collateral Register";
            begin
                Register.Reset();
                Register.SetRange(Register."Document No", "Collateral No.");
                if Register.FindFirst() then begin
                    FSV := Register."Forced Sale Value";
                    "Market Value":=Register."Market Value";
                end;

            end;

        }

        field(11; "FSV"; Decimal) {Editable=false; }
        field(12; "Market Value"; Decimal) { Editable=false; }

        field(13; "Loan Status"; Enum "Recovery Stage") {Editable=false;  }

        field(14; "Under Payment Plan"; Boolean) { }

        field(15; "Stage Last Modified"; DateTime) { Editable=false; }
    }

    keys
    {
        key(PK; "Case No.") { Clustered = true; }
        key(Key2; "Loan No.") { }
    }
    trigger OnInsert()
    var
        noSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        noSeries.Get();
        if "Case No." = '' then
            "Case No." := NoSeriesMgt.GetNextNo(noSeries."Defaulter Case No");

        if "Recovery Stage" = "Recovery Stage"::"In-house" then
            "Recovery Stage" := "Recovery Stage"::"In-house";

        UpdateArrearsBucket;

        "Stage Last Modified" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        if xRec."Recovery Stage" <> "Recovery Stage" then begin
            ValidateStageChange(xRec."Recovery Stage", "Recovery Stage");
            "Stage Last Modified" := CurrentDateTime;
            //   LogStageChange;
        end;
    end;


    local procedure UpdateArrearsBucket()
    begin
        if "Days in Arrears" <= 30 then
            "Arrears Bucket" := "Arrears Bucket"::"1-30 Days"
        else if "Days in Arrears" <= 90 then
            "Arrears Bucket" := "Arrears Bucket"::"31-90 Days"
        else
            "Arrears Bucket" := "Arrears Bucket"::"90+ Days";
    end;

    local procedure ValidateStageChange(OldStage: Enum "Recovery Stage"; NewStage: Enum "Recovery Stage")
    begin
        case OldStage of
            OldStage::"In-house":
                if NewStage <> NewStage::"Statutory Notice" then
                    Error('Invalid stage transition.');

            OldStage::"Statutory Notice":
                if NewStage <> NewStage::Legal then
                    Error('Statutory Notice must proceed to Legal.');

            OldStage::Legal:
                if NewStage <> NewStage::"Forced Sale" then
                    Error('Legal stage must proceed to Forced Sale.');
        end;
    end;

    /*     local procedure LogStageChange()
        var
            AuditRec: Record "Recovery Audit Log";
        begin
            AuditRec.Init;
            AuditRec."Case No." := "Case No.";
            AuditRec."Action Type" := 'Stage Change';
            AuditRec."Old Value" := Format(xRec."Recovery Stage");
            AuditRec."New Value" := Format("Recovery Stage");
            AuditRec."User ID" := UserId;
            AuditRec."Date Time" := CurrentDateTime;
            AuditRec.Insert;
        end; */


}
