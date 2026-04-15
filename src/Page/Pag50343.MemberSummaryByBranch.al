//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50343 "Member Summary By Branch"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member Summary By Branch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Branch Code";Rec."Branch Code")
                {
                }
                field("Active Members";Rec."Active Members")
                {
                }
                field("Awaiting Exit Members";Rec."Awaiting Exit Members")
                {
                }
                field("Exited Members";Rec."Exited Members")
                {
                }
                field("Dormant Members";Rec."Dormant Members")
                {
                }
                field("Deceased Members";Rec."Deceased Members")
                {
                }
                field("Total Members";Rec."Total Members")
                {
                }
            }
        }
    }

    actions
    {
    }
}






