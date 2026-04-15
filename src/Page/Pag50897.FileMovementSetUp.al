//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50897 "File Movement SetUp"
{
    ApplicationArea = All;
    CardPageID = "File Location SetUp Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "File Locations Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Location; Rec.Location)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Custodian Name"; Rec."Custodian Name")
                {
                }
                field("Custodian UserId"; Rec."Custodian UserId")
                {
                }
                field("Custodian Department";Rec."Custodian Department")
                {
                }
            }
        }
    }

    actions
    {
    }
}






