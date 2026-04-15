//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50247 "Posted Receipt Header Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Bank Code";Rec."Bank Code")
                {
                }
                field("Bank Name";Rec."Bank Name")
                {
                }
                field("Bank Balance";Rec."Bank Balance")
                {
                }
                field("Currency Code";Rec."Currency Code")
                {
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                }
                field("Amount Received";Rec."Amount Received")
                {
                }
                field("Amount Received(LCY)";Rec."Amount Received(LCY)")
                {
                }
                field("Total Amount";Rec."Total Amount")
                {
                }
                field("Total Amount(LCY)";Rec."Total Amount(LCY)")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Received From";Rec."Received From")
                {
                }
                field("On Behalf of";Rec."On Behalf of")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID";Rec."User ID")
                {
                }
            }
            part(Control23;"Posted Receipt Line")
            {
                SubPageLink = "Document No"=field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Reprint Receipt")
            {
                Image = PrintVoucher;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    DocNo := rec."No.";
                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange(ReceiptHeader."No.", DocNo);
                    if ReceiptHeader.FindFirst then begin
                        Report.RunModal(Report::"Receipt Header", true, false, ReceiptHeader);
                        // Report.run(172005, true, true, ReceiptHeader);

                    end;
                end;
            }
        }
    }

    var
        BillNoVisible: Boolean;
        AccNoVisible: Boolean;
        ok: Boolean;
        ReceiptLine: Record "Receipt Line";
        LineNo: Integer;
        FundsTransTypes: Record "Funds Transaction Types";
        Amount: Decimal;
        "Amount(LCY)": Decimal;
        ReceiptLines: Record "Receipt Line";
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        FundsUser: Record "Funds User Setup";
        PostingVisible: Boolean;
        MoveVisible: Boolean;
        PageEditable: Boolean;
        ReverseVisible: Boolean;
        DocNo: Code[20];
        ReceiptHeader: Record "Receipt Header";

    local procedure CheckReceiptRequiredFields()
    begin
        Rec.CalcFields("Total Amount");

        Rec.TestField("Total Amount");
        Rec.TestField("Amount Received");
        Rec.TestField("Bank Code");
        Rec.TestField(Date);
        Rec.TestField("Posting Date");
        Rec.TestField(Description);
        Rec.TestField("Received From");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Global Dimension 2 Code");

        if Rec."Amount Received" <> Rec."Total Amount" then
            Error('Amount Received must be Equal to the total Amount');
    end;

    local procedure CheckLines()
    begin
        ReceiptLines.Reset;
        ReceiptLines.SetRange(ReceiptLines."Document No", Rec."No.");
        if ReceiptLines.FindSet then begin
            repeat
                ReceiptLines.TestField(ReceiptLines."Account Code");
                ReceiptLines.TestField(ReceiptLines."Account Code");
                ReceiptLines.TestField(ReceiptLines.Amount);
            until ReceiptLines.Next = 0;
        end else begin
            Error('Empty Receipt Lines');
        end;
    end;
}




