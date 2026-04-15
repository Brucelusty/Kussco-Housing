//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50902 "Member Due Diligence Measure"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Member Due Diligence Measures";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Due Diligence Measure";Rec."Due Diligence Measure")
                {
                    Editable = false;
                }
                field("Due Diligence Done";Rec."Due Diligence Done")
                {
                }
                field("Due Diligence Done By";Rec."Due Diligence Done By")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






