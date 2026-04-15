//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50717 "Transaction Charges"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Transaction Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Charge Code";Rec."Charge Code")
                {
                }
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Charge Amount";Rec."Charge Amount")
                {
                }
                field("Percentage of Amount";Rec."Percentage of Amount")
                {
                }
                field("Use Percentage";Rec."Use Percentage")
                {
                }
                field("G/L Account";Rec."G/L Account")
                {
                }
                field("Minimum Amount";Rec."Minimum Amount")
                {
                }
                field("Maximum Amount";Rec."Maximum Amount")
                {
                }
                field("Due Amount";Rec."Due Amount")
                {
                }
                field("Due to Account";Rec."Due to Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}






