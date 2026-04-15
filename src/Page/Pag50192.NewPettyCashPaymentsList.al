//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50192 "New Petty Cash Payments List"
{
    ApplicationArea = All;
    CardPageID = "Cash Payment Header";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const("Petty Cash"),
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
                field("Document Date";Rec."Document Date")
                {
                }
                field("User ID";Rec."User ID")
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
        rec."Payment Type" := rec."payment type"::"Petty Cash";
        if FundsSetup.Get then begin
            FundsSetup.TestField(FundsSetup."PettyCash Account");
            rec."Bank Account" := FundsSetup."PettyCash Account";
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






