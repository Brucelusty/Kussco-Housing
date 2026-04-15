//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50635 "Applied Member Entries"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Document Type";Rec."Document Type")
                {
                }
                field("Document No.";Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                }
                field("Salesperson Code";Rec."Salesperson Code")
                {
                }
                field("Currency Code";Rec."Currency Code")
                {
                }
                field("Original Amt. (LCY)";Rec."Original Amt. (LCY)")
                {
                }
            }
        }
    }

    actions
    {
    }
}






