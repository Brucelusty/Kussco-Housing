//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50378 "Voucher Payment List"
{
    ApplicationArea = All;
    CardPageID = "Voucher Payment Header";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const(Normal),
                            Posted = const(false));

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
                field("Net Amount";Rec."Net Amount")
                {
                }
                field("Net Amount(LCY)";Rec."Net Amount(LCY)")
                {
                }
                field(Status; Rec.Status)
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
        if FundsSetup.Get then begin
            FundsSetup.TestField(FundsSetup."Cash Account");
            Rec."Bank Account" := FundsSetup."Cash Account";
            Rec.Validate("Bank Account");
        end;
    end;

    var
        FundsSetup: Record "Funds General Setup";
}






