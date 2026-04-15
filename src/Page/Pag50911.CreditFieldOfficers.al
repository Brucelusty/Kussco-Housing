//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50911 "Credit/Field Officers"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Credit/Field Officers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID";Rec."User ID")
                {
                }
                field(Branch; Rec.Branch)
                {
                    Editable = false;
                }
                field("Credit Officer";Rec."Credit Officer")
                {
                    Editable = false;
                }
                field("Field Officer";Rec."Field Officer")
                {
                }
            }
        }
    }

    actions
    {
    }
}






