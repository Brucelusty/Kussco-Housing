//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50389 "Claim Types Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Funds Transaction Types";

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
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Claim;
    end;
}






