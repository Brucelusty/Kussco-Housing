table 50811 "Marketers Commission Header"
{
    Caption = 'Marketers Commission Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }

        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }

        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
        }

        field(4; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }

        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(10; "Total Commission"; Decimal)
        {
            CalcFormula = Sum("Commission Lines"."Commission Amount"
        where("Document No." = field("Document No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(11; "Posted"; Boolean)
        {
            //Caption = 'User ID';
            Editable = false;
        }
        field(12; "Posted By"; Code[60])
        {
            //Caption = 'User ID';
            Editable = false;
        }
        field(13; "Account Type"; enum "Gen. Journal Account Type")
        {
            //Caption = 'User ID';

        }
        field(14; "Account No."; Code[20])
        {
            TableRelation=if ("Account Type" = const(Customer)) Customer."No." where(ISNormalMember = const(true))
            else
            if ("Account Type" = const(Debtor)) Customer."No." where(ISNormalMember = const(false))
            else
             if ("Account Type" = const("Bank Account")) "Bank Account"."No."
             else
            if ("Account Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Account Type" = const(Vendor)) Vendor."No." where("Creditor Type" = filter("FOSA Account"),
                                                                                     Status = filter(<> Closed | Deceased), Blocked = filter(<> Payment | All))
            else
            if ("Account Type" = const(Member)) "Members Register"."No.";

        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
        SaccoSeries: Record "Sacco No. Series";
    begin

        SaccoSeries.Get();
        SaccoSeries.TestField("Commission Nos");
        if "Document No." = '' then
            "Document No." := NoSeriesMgt.GetNextNo(SaccoSeries."Commission Nos");

        "User ID" := UserId;
        "Application Date" := Today;
    end;


}
