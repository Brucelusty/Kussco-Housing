Table 50048 "Key Performance Indicators"
{

    fields
    {
        field(1;No;Integer)
        {
            Editable = false;
        }
        field(2;Indicator;Code[250])
        {
        }
        field(3;"Key Value Drivers";Code[50])
        {
            TableRelation = "Key Value Drivers"."Key Value Driver";

            trigger OnValidate() begin
                KeyValuDrivers.Reset();
                KeyValuDrivers.SetRange("Key Value Driver", "Key Value Drivers");
                if KeyValuDrivers.Find('-') then begin
                    "KVD Description" := KeyValuDrivers.Description;
                end;
            end;
        }
        field(4;"KVD Description";Text[500])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;No,"Key Value Drivers",Indicator)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(G1;No,"Key Value Drivers",Indicator)
        {
        }
    }

    trigger OnInsert()
    begin
        if KeyPerformanceIndicators.FindLast then
        No:=KeyPerformanceIndicators.No+1
        else
        No:=1;
    end;

    var
        KeyValuDrivers: Record "Key Value Drivers";
        KeyPerformanceIndicators: Record "Key Performance Indicators";
}

