//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50344 "Posted Mobile Payment List"
{
    ApplicationArea = All;
    CardPageID = "Posted Payment Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const(Mobile));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Document Type";Rec."Document Type")
                {
                }
                field("Document Date";Rec."Document Date")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount(LCY)";Rec."Amount(LCY)")
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
        Rec."Payment Type" := Rec."payment type"::Mobile;
    end;
}






