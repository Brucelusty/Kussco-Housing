//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50844 "Receipt Allocation(Posted)"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Receipt Allocation";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Mpesa Account Type";Rec."Mpesa Account Type")
                {
                    Visible = false;
                }
                field("Mpesa Account No";Rec."Mpesa Account No")
                {
                    Visible = false;
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
                field("Cummulative Total Payment Loan";Rec."Cummulative Total Payment Loan")
                {
                    Caption = 'Cummulative Total Payment Loan';
                }
                field("Cash Clearing Charge";Rec."Cash Clearing Charge")
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
                    Editable = true;
                }
                field("Interest Balance";Rec."Interest Balance")
                {
                    Editable = false;
                }
                field("Prepayment Date";Rec."Prepayment Date")
                {
                }
                field("Loan Insurance";Rec."Loan Insurance")
                {
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
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

    trigger OnOpenPage()
    begin
        sto.Reset;
        sto.SetRange(sto."No.", Rec."Document No");
        if sto.Find('-') then begin
            if sto.Status = sto.Status::Approved then begin
                CurrPage.Editable := false;
            end else
                CurrPage.Editable := true;
        end;
    end;

    var
        sto: Record "Standing Orders";
        Loan: Record "Loans Register";
        ReceiptAllocation: Record "Receipt Allocation";
        ReceiptH: Record "Receipts & Payments";
}




