//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50345 "Posted Mobile Payment Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const(Mobile));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                }
                field("Document Date";Rec."Document Date")
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Payment Mode";Rec."Payment Mode")
                {
                }
                field("Currency Code";Rec."Currency Code")
                {
                }
                field("Bank Account";Rec."Bank Account")
                {
                }
                field("Bank Account Name";Rec."Bank Account Name")
                {
                }
                field("Bank Account Balance";Rec."Bank Account Balance")
                {
                }
                field("Cheque Type";Rec."Cheque Type")
                {
                }
                field("Cheque No";Rec."Cheque No")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field("On Behalf Of";Rec."On Behalf Of")
                {
                }
                field("Payment Description";Rec."Payment Description")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount(LCY)";Rec."Amount(LCY)")
                {
                }
                field("VAT Amount";Rec."VAT Amount")
                {
                }
                field("VAT Amount(LCY)";Rec."VAT Amount(LCY)")
                {
                }
                field("WithHolding Tax Amount";Rec."WithHolding Tax Amount")
                {
                }
                field("WithHolding Tax Amount(LCY)";Rec."WithHolding Tax Amount(LCY)")
                {
                }
                field("Net Amount";Rec."Net Amount")
                {
                }
                field("Net Amount(LCY)";Rec."Net Amount(LCY)")
                {
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posted By";Rec."Posted By")
                {
                }
                field("Date Posted";Rec."Date Posted")
                {
                }
                field("Time Posted";Rec."Time Posted")
                {
                }
                field(Cashier; Rec.Cashier)
                {
                }
            }
            part(Control35;"Posted Mobile Payment Line")
            {
                SubPageLink = Cashier = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PHeader.Reset;
                    PHeader.SetRange(PHeader."No.", Rec."No.");
                    if PHeader.FindFirst then begin
                        //  Report.RunModal(Report::"Mobile Money Voucher", true, false, PHeader);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."payment type"::Mobile;
    end;

    var
        PHeader: Record "Payment Header.";
}




