table 50784 "BD Activity Log"
{
    DataClassification = CustomerContent;

    fields
    {

        field(1; "Partner No."; Code[20])
        {
            TableRelation = "BD Partner"."Partner No.";
        }
        field(2; "Activity No."; Integer) { Editable = false; AutoIncrement = true; }
        field(3; "Activity Type"; Enum "BD Activity Type") { }

        field(4; "Activity Date"; Date) { }
        field(5; "BD Officer"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }

        field(6; Outcome; Text[250]) { }
        field(7; "Next Follow-Up Date"; Date) { }
    }

    keys
    {
        key(PK; "Partner No.", "Activity No.", "Activity Type","Activity Date") { Clustered = true; }
    }
    /*  trigger OnInsert()
 var
         BDSetup: Record "Sacco No. Series";
         NoSeries: Codeunit "No. Series";
 begin
     if "Activity No." = '' then begin
         BDSetup.Get();
         "Activity No." :=NoSeries.GetNextNo( BDSetup."BD Activity Nos.");
     end;
 end; */

}
