//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50836 "Posted Guar Recovery List"
{
    ApplicationArea = All;
    CardPageID = "Loan Recovery Header";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Recovery Header";
    SourceTableView = where(Posted = filter(true));

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
                field("Recovery Type";Rec."Recovery Type")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
            }
        }
    }

    actions
    {
    }
}






