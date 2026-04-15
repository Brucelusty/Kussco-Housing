//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50191 "Payment Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Payment Line";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Type; rec.Type)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ShowMandatory = true;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = true;
                }
                field(Remarks; rec.Remarks)
                {
                    Caption = 'Description';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    Visible = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    Visible = false;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    Visible = false;
                }
                field("W/Tax Rate"; Rec."W/Tax Rate")
                {
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        rec.TestField("Global Dimension 1 Code");
                        rec.TestField("Shortcut Dimension 2 Code");

                        //check if the payment reference is for farmer purchase
                        if rec."Payment Reference" = rec."payment reference"::"Farmer Purchase" then begin
                            if rec.Amount <> xRec.Amount then begin
                                Error('Amount cannot be modified');
                            end;
                        end;

                        rec."Amount With VAT" := rec.Amount;


                    end;
                }

                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Editable = false;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                }
                field("Net Amount"; Rec."Net Amount")
                {
                }
                field("VAT Code"; Rec."VAT Code")
                {
                }
                field("VAT Rate"; Rec."VAT Rate")
                {
                }
                field("Withholding TaxAmount"; Rec."Withholding Tax Amount")
                {
                }

            }
        }
    }

    actions
    {
    }

    var
        RecPayTypes: Record Logos;
        TarriffCodes: Record "Item Groups";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Quote Specifications";
        LineNo: Integer;
        CustLedger: Record "Vendor Ledger Entry";
        CustLedger1: Record "Vendor Ledger Entry";
        Amt: Decimal;
        TotAmt: Decimal;
        ApplyInvoice: Codeunit "Purchase Header Apply";
        AppliedEntries: Record "Payments Header";
        VendEntries: Record "Vendor Ledger Entry";
        PInv: Record "Purch. Inv. Header";
        VATPaid: Decimal;
        VATToPay: Decimal;
        PInvLine: Record "Purch. Inv. Line";
        VATBase: Decimal;
}






