//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50722 "Cheque Clearing List"
{
    ApplicationArea = All;
    CardPageID = "Cheque Clearing Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheque Clearing Header";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Cleared  By";Rec."Cleared  By")
                {
                }
                field("Date Entered";Rec."Date Entered")
                {
                }
                field("Entered By";Rec."Entered By")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Date Filter";Rec."Date Filter")
                {
                }
                field("Time Entered";Rec."Time Entered")
                {
                }
                field("Expected Date Of Clearing";Rec."Expected Date Of Clearing")
                {
                }
                field("Document No";Rec."Document No")
                {
                }
                field("Scheduled Amount";Rec."Scheduled Amount")
                {
                }
                field("Total Count";Rec."Total Count")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Reports)
            {
                Caption = 'Reports';
                action("Cheques on Processing")
                {
                    Caption = 'Cheques on Processing';
                    RunObject = report "Cheques on Processing Report";
                }
                action("Cleared & Bounced Cheques")
                {
                    Caption = 'Cleared & Bounced Cheques';
                    RunObject = report "Cleared&Bounced Cheques Report";
                }
            }
        }
    }
}






