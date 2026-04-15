//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50788 "Cheque Receipt List-Family"
{
    ApplicationArea = All;
    CardPageID = "Cheque Receipt Header-Family";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheque Receipts-Family";
    SourceTableView = where(Closed = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Refference Document";Rec."Refference Document")
                {
                }
                field("Transaction Time";Rec."Transaction Time")
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Unpaid By";Rec."Unpaid By")
                {
                }
                field(Unpaid; Rec.Unpaid)
                {
                }
            }
        }
    }

    actions
    {
    }
}






