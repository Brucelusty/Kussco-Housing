table 50805 "Tranche Register"
{
    Caption = 'Tranche Register';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[40])
        {
            Caption = 'Document No';
            Editable = false;
        }
        field(2; "Loan No"; Code[40])
        {
            Caption = 'Loan No';
            TableRelation = "Loans Register"."Loan  No." where("Disburesment Type" = filter("Tranche/Multiple Disbursement"), Posted = filter(true));
            trigger OnValidate()
            var
                Loans: Record "Loans Register";
            begin
                Loans.Reset();
                Loans.SetRange(Loans."Loan  No.", "Loan No");
                if Loans.FindFirst() then begin
                    "Client Code" := Loans."Client Code";
                    "Client Name" := Loans."Client Name";
                end;
            end;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(4; "Client Code"; Code[40])
        {
            Caption = 'Client Code';
            Editable = false;
        }
        field(5; "Client Name"; Text[200])
        {
            Caption = 'Client Name';
            Editable = false;
        }
        field(6; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(7; "Posted By"; Code[40])
        {
            Caption = 'Posted By';
            Editable = false;
        }
        field(8; "Captured By"; Code[40])
        {
            Caption = 'Captured By';
            Editable = false;
        }
        field(9; "Description"; Text[200])
        {
            Caption = 'Description';
            // Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No")
        {
            Clustered = true;
        }
        key(PK2; "Loan No")
        {
            // Clustered = true;
        }
    }


    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Tranche Nos");
            "Document No" := NoSeriesMgt.GetNextNo(SalesSetup."Tranche Nos");
        end;
        "Document Date" := Today;
        "Captured By" := UserId;

    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
}
