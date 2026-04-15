//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50998 "New House Change Request"
{
    ApplicationArea = All;
    CardPageID = "House Change Request Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "House Group Change Request";
    SourceTableView = where("Change Effected" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("House Group";Rec."House Group")
                {
                }
                field("House Group Name";Rec."House Group Name")
                {
                }
                field("Destination House";Rec."Destination House")
                {
                }
                field("Destination House Group Name";Rec."Destination House Group Name")
                {
                }
                field("Reason For Changing Groups";Rec."Reason For Changing Groups")
                {
                }
                field("Deposits on Date of Change";Rec."Deposits on Date of Change")
                {
                }
                field("Captured By";Rec."Captured By")
                {
                }
                field("Captured On";Rec."Captured On")
                {
                }
            }
        }
    }

    actions
    {
    }
}






