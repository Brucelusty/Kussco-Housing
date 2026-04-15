table 50772 "NOK Applications"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Date Applied"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Time Applied"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Captured By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '" ",Open,Pending,Cancelled,Approved,Updated';
            OptionMembers = " ",Open,Pending,Cancelled,Approved,Updated;
        }
        field(8; Identification; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Portal Identification Types" where("Type of Identification" = filter(NoK));
        }
        field(9; "Identification Value"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Full Names"; Text[800])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Relationship; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Relationship Types";
        }
        field(12; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Address; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Mobile Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Email Address"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Is Next of Kin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Is Beneficiary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Is Contact Person"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Is Nominee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "% Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Member % Allocation"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Members Next of Kin"."%Allocation" where("Account No" = field("Member No")));
        }
        field(22; "Application Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '" ",New,Update';
            OptionMembers = " ",New,Update;
        }
        field(23; "NoK No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Old Identification"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Old Identification Value"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Old Full Names"; Text[800])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Old Relationship"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Relationship Types";
        }
        field(28; "Old Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Old Address"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Old Mobile Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Old Email Address"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Old Is Next of Kin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Old Is Beneficiary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Old Is Contact Person"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Old Is Nominee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Old % Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Application No")
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
        saccoGen: Record "Sacco No. Series";

    trigger OnInsert()
    begin
        saccoGen.Get();
        if "Application No" = '' then begin
            saccoGen.TestField("NOK Application Nos");
            noSeries.GetNextNo(saccoGen."NOK Application Nos");
        end;

        "Date Applied" := Today;
        "Time Applied" := Time;
        "Captured By" := UserId;
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
