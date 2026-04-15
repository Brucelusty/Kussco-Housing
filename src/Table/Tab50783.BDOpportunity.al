table 50783 "BD Opportunity"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Opportunity No."; Code[20]) { Editable = false; }
        field(2; "Partner No."; Code[20])
        {
            TableRelation = "BD Partner"."Partner No.";
        }

        field(3; "Opportunity Type"; Option)
        {
            OptionMembers = Savings,Mortgage,Mixed;
        }

        field(4; "Estimated Value"; Decimal) { }

        field(5; Stage; Option)
        {
            OptionMembers = Identified,Negotiation,Approved;
        }

        field(6; "Expected Start Date"; Date) { }
        field(7; Probability; Decimal) { }
        field(8; Converted; Boolean) { }
        field(9; "Created By"; Code[50])
        {
            TableRelation = User."User Name";
        }
    }

    keys
    {
        key(PK; "Opportunity No.") { Clustered = true; }
        key(Key2; "Partner No.")
        {
        }
    }
    trigger OnInsert()
    var
        BDSetup: Record "Sacco No. Series";
        NoSeries: Codeunit "No. Series";
    begin
        if "Opportunity No." = '' then begin
            BDSetup.Get();
            "Opportunity No." := NoSeries.GetNextNo(BDSetup."BD Opportunity Nos.");
        end;
    end;

}
