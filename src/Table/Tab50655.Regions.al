//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50655 "Regions"
{

    fields
    {
        field(1; "Region Code"; Code[30])
        {
        }
        field(2; "Region Name"; Text[500])
        {
        }
    }

    keys
    {
        key(Key1; "Region Code", "Region Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Region Name", "Region Code")
        {
        }
    }

    trigger OnInsert()
    begin
        /* IF No='' THEN
          BEGIN
            NoSetups.GET;
            NoSetups.TESTFIELD(NoSetups."County Nos");
            NoSeriesMgt.InitSeries(NoSetups."County Nos", xRec.No, 0D, No, "No.Series");
          END;
          */

    end;

    var
        NoSetups: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
}




