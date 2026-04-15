Table 50054 "Workstation Buying Centers"
{
    DrillDownPageId = "KTDA Buying Centres";
    LookupPageId = "KTDA Buying Centres";

    fields
    {
        field(1; Factory; Code[50])
        {
            TableRelation = WorkStations.Code;
        }
        field(2; "Buying Centre"; Code[50])
        {
        }
        field(3; Description; Text[2048])
        {
        }
        field(4; "Workstation Region"; Code[50])
        {
            TableRelation = Regions."Region Code";
        }
        field(5; "Workstation County"; Code[50])
        {
            TableRelation = Counties."County Code" where(Region = field("Workstation Region"));
        }
        field(6; "Workstation Sub-County"; Code[50])
        {
            TableRelation = "Sub-County"."Sub-County" where("County Code" = field("Workstation County"));
        }
    }

    keys
    {
        key(Key1; Factory, "Buying Centre")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    employer: Record "Employers Register";
    factory: Record WorkStations;
}

