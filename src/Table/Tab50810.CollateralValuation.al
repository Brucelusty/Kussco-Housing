table 50810 "Collateral Valuation"
{
    Caption = 'Collateral Valuation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Collateral ID"; Code[30])
        {
            Caption = 'Collateral ID';
            TableRelation = "Loan Collateral Register"."Document No";
            ;
        }

        field(3; "Valuation Date"; Date)
        {
            Caption = 'Valuation Date';
        }

        field(4; "Market Value"; Decimal)
        {
            Caption = 'Market Value';
        }

        field(5; "Valuation Description"; Text[100])
        {
            Caption = 'Valuation Description';
        }

        field(6; "Valued By"; Code[50])
        {
            Caption = 'Valued By';
            TableRelation = "Collateral Valuer"."Valuer Code";
            // Editable = false;
            trigger OnValidate()
            var
                CollateralValuer: Record "Collateral Valuer";
            begin
                CollateralValuer.Reset();
                CollateralValuer.SetRange(CollateralValuer."Valuer Code", "Valued By");
                if CollateralValuer.Find('-') then begin
                    "Valuer Name" := CollateralValuer."Valuer Name";
                    "Valuer Phone" := CollateralValuer."Phone No.";
                end;
            end;
        }
        field(7; "Valuer Name"; Text[100])
        {
            Caption = 'Valuer Name';
            Editable = false;
        }
        field(8; "Valuer Phone"; Text[100])
        {
            Caption = 'Valuer Phone';
            Editable = false;
        }
        field(9; "Current Valuation"; Boolean)
        {
            Caption = 'Current Valuation';

        }
        field(10; "Forced Sale Value"; Decimal)
        {
            Caption = 'Forced Sale Value';
        }
    }

    keys
    {
        key(PK; "Entry No.", "Collateral ID")
        {
            Clustered = true;
        }

        key(CollateralKey; "Collateral ID", "Valuation Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Valuation Date" = 0D then
            "Valuation Date" := Today;

        // Auto-assign current user
        //"Valued By" := UserId;
    end;
}
