//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50242 "Posted Petty Cash Payments"
{
    ApplicationArea = All;
    CardPageID = "Cash Payment Header";
    DeleteAllowed = false;
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
                field(Payee; rec.Payee)
                {
                }
                field(Amount; rec.Amount)
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
                field(Status; rec.Status)
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
        rec."Payment Type" := rec."payment type"::"Cash Purchase";
        if FundsSetup.Get then begin
            FundsSetup.TestField(FundsSetup."Cash Account");
            rec."Bank Account" := FundsSetup."Cash Account";
            rec.Validate("Bank Account");
        end;
    end;

    trigger OnOpenPage()
    begin
        rec.SetRange("User ID", UserId);
    end;

    var
        FundsSetup: Record "Funds General Setup";
}






