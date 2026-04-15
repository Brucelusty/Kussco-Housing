//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50572 "HR Medical Schemes List"
{
    ApplicationArea = All;
    CardPageID = "HR Medical Schemes Card";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme No";Rec."Scheme No")
                {
                }
                field("Medical Insurer";Rec."Medical Insurer")
                {
                }
                field("Scheme Name";Rec."Scheme Name")
                {
                }
                field("In-patient limit";Rec."In-patient limit")
                {
                }
                field("Out-patient limit";Rec."Out-patient limit")
                {
                }
                field("Area Covered";Rec."Area Covered")
                {
                }
                field("Dependants Included";Rec."Dependants Included")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
    }
}






