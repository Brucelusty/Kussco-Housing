//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50332 "Posted Cash Payment List"
{
    ApplicationArea = All;
    CardPageID = "Posted Cash Payment Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const("Petty Cash"),
                            Posted = const(true));

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
                field("Payee Type";Rec."Payee Type")
                {
                }
                field("Payee No";Rec."Payee No")
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
                field("Net Amount";Rec."Net Amount")
                {
                }
                field("Net Amount(LCY)";Rec."Net Amount(LCY)")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
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
        Rec."Payment Type" := Rec."payment type"::"Cash Purchase";
    end;
}






