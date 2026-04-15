//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50422 "Closed RFQ List"
{
    ApplicationArea = All;
    CardPageID = "Released Internal Requisitions";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote), DocApprovalType = FILTER(Requisition), Status = CONST(Released), PR = CONST(true), Completed = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                {
                }
                field("Posting Description";Rec."Posting Description")
                {
                }
                field("Ship-to Code";Rec."Ship-to Code")
                {
                }
                field("Ship-to Name";Rec."Ship-to Name")
                {
                }
                // field("Expected Closing Date";"Expected Closing Date")
                // {
                // }
                field("Location Code";Rec."Location Code")
                {
                }
                field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Currency Code";Rec."Currency Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}






