//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50735 "BOSA Transfer List"
{
    ApplicationArea = All;
    CardPageID = "BOSA Transfer";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "BOSA Transfers";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Schedule Total";Rec."Schedule Total")
                {
                }
                field(Approved; Rec.Approved)
                {
                }
                field("Approved By";Rec."Approved By")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}






