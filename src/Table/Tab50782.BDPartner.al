table 50782 "BD Partner"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Partner No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(2; "Partner Name"; Text[150])
        {
            DataClassification = CustomerContent;
        }

        field(3; "Partner Type"; Enum "BD Partner Type")
        {
            DataClassification = CustomerContent;
        }

        field(4; Status; Enum "BD Partner Status")
        {
            DataClassification = CustomerContent;
        }

        field(5; "Region Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Member Delegate Zones".Code;
        }

        field(6; "Assigned BD Officer"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }

        field(7; "Activation Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(8; "Last Activity Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(9; "Dormant"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(10; Notes; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Activity Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("BD Activity Log"
        where("Partner No." = field("Partner No.")));
        }

        field(21; "Activities (30 Days)"; Integer)
        {
            //FieldClass = FlowField;
            //   CalcFormula = Count("BD Activity Log"
            //  where("Partner No." = field("Partner No."), "Activity Date" = filter(>= CalcDate('-30D', Today()))));
        }
        field(22; "Date Created"; date)
        {
            DataClassification = ToBeClassified;
            EDITABLE = false;
        }
        field(23; "Date Converted"; date)
        {
            DataClassification = ToBeClassified;
            EDITABLE = false;
        }
        field(24; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            EDITABLE = false;
        }
        field(25; "Converted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            EDITABLE = false;
        }


    }
    keys
    {
        key(PK; "Partner No.")
        {
            Clustered = true;
        }
  
    }
    trigger OnInsert()
    var
        BDSetup: Record "Sacco No. Series";
        NoSeries: Codeunit "No. Series";
    begin
        if "Partner No." = '' then begin
            BDSetup.Get();
            "Partner No." := NoSeries.GetNextNo(BDSetup."BD Partner Nos.");
        end;
        "Created By" := USERID();
        "Date Created" := TODAY();
    end;
}
