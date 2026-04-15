table 50794 "Risk Register"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Risk ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(2; "Risk Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(3; "Risk Category"; Enum "Risk Category")
        {
        }

        field(4; "Likelihood"; Enum "Risk Likelihood")
        {
        }

        field(5; "Impact"; Integer)
        {
            MinValue = 1;
            MaxValue = 5;
        }

        field(6; "Risk Score"; Integer)
        {
            Editable = false;
        }

        field(7; "Owner ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }

        field(8; "Mitigation Plan"; Text[250])
        {
        }

        field(9; Status; Enum "Risk Status")
        {
            Editable=false;
        }

        field(10; "Date Identified"; Date)
        {
        }

        field(11; "Last Updated"; DateTime)
        {
            Editable = false;
        }

        field(12; "Due Date"; Date)
        {
        }

        field(13; "Escalated"; Boolean)
        {
        }

        field(14; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }

        field(15; "Closed Date"; Date)
        {
        }
    }

    keys
    {
        key(PK; "Risk ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
        RiskSetup: Record "Sacco No. Series"; // Replace with Risk Setup if created
    begin
        // Auto-numbering (replace with Risk Setup if created)
        RiskSetup.Get();
        if "Risk ID" = '' then
            "Risk ID" := NoSeriesMgt.GetNextNo(RiskSetup."Risk Nos");

        "Date Identified" := Today;
        "Last Updated" := CurrentDateTime;



        CalcRiskScore();
    end;

    trigger OnModify()
    begin
        "Last Updated" := CurrentDateTime;
        CalcRiskScore;
    end;

    local procedure CalcRiskScore()
    var
        LikelihoodValue: Integer;
    begin
        case Likelihood of
            Likelihood::Low:
                LikelihoodValue := 1;
            Likelihood::Medium:
                LikelihoodValue := 2;
            Likelihood::High:
                LikelihoodValue := 3;
        end;

        "Risk Score" := LikelihoodValue * Impact;

        if "Risk Score" >= 10 then begin
            Escalated := true;
            Status := Status::Escalated;
        end;
    end;
}
