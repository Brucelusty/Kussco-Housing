//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50369 "Payment Types Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Funds Transaction Types";
    SourceTableView = where("Transaction Type" = const(Payment));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Default Grouping";Rec."Default Grouping")
                {
                }
                field("Withholding Tax Chargeable";Rec."Withholding Tax Chargeable")
                {
                }
                field("Withholding Tax Code";Rec."Withholding Tax Code")
                {
                }
                field("VAT Chargeable";Rec."VAT Chargeable")
                {
                }
                field("VAT Code";Rec."VAT Code")
                {
                }
            }
            group("Other Setup")
            {
                field("Meeting Transaction";Rec."Meeting Transaction")
                {
                }
                field("Meeting Type";Rec."Meeting Type")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Payment;
    end;
}






