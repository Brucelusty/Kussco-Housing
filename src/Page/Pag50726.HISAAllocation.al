//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50726 "HISA Allocation"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HISA Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";Rec."Member No")
                {
                }
                field("Document No";Rec."Document No")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Loan No.";Rec."Loan No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Interest Amount";Rec."Interest Amount")
                {
                }
                field("Total Amount";Rec."Total Amount")
                {
                }
                field("Amount Balance";Rec."Amount Balance")
                {
                }
                field("Interest Balance";Rec."Interest Balance")
                {
                }
                field("Share Mode of Payment";Rec."Share Mode of Payment")
                {
                }
                field("Total Allocation";Rec."Total Allocation")
                {
                }
            }
        }
    }

    actions
    {
    }
}






