//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50868 "Posted New Internal PV List"
{
    ApplicationArea = All;
    CardPageID = "Posted Internal PV Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Internal PV Header";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Date Entered";Rec."Date Entered")
                {
                }
                field("Time Entered";Rec."Time Entered")
                {
                }
                field("Entered By";Rec."Entered By")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Date Posted";Rec."Date Posted")
                {
                }
                field("Time Posted";Rec."Time Posted")
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field("Total Debits";Rec."Total Debits")
                {
                }
                field("Total Count";Rec."Total Count")
                {
                }
                field("Total Credits";Rec."Total Credits")
                {
                }
            }
        }
    }

    actions
    {
    }
}






