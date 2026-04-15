//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50758 "Cheque Receipts List"
{
    ApplicationArea = All;
    CardPageID = "Cheque Receipts Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Cheque Receipts";

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
            }
        }
    }

    actions
    {
    }
}






