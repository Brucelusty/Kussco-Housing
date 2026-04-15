pageextension 50004 "Posted Bank Rec" extends "Bank Account Statement"
{
    layout
    {
        // Add changes to page layout here
        addafter("Statement Ending Balance")
        {
            field("Reconciled Amount"; Rec."Reconciled Amount")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Unreconciled; Rec.Unreconciled)
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("Cleared Cheques and Payments"; Rec."Cleared Cheques and Payments") { ApplicationArea = All; Editable = false; }
            field("Cleared Deposit and Credits"; Rec."Cleared Deposit and Credits") { ApplicationArea = All; Editable = false; }
            field("UnCleared Cheques and Payments"; Rec."UnCleared Cheques and Payments") { ApplicationArea = All; Editable = false; }
            field("UnCleared Deposit and Credits"; Rec."UnCleared Deposit and Credits") { ApplicationArea = All; Editable = false; }
            field(Difference; Rec.Difference)
            {
                ApplicationArea = All;
                Editable = false;
                trigger OnValidate()
                var
                    bankrec: Record "Bank Acc. Reconciliation";
                    Difference: Decimal;
                begin
                    bankrec.Reset();
                    bankrec.SetRange(bankrec."Statement No.", bankrec."Statement No.");
                    if bankrec.FindFirst() then
                        bankrec.Difference := bankrec."Balance Last Statement" - bankrec."Reconciled Amount";

                end;
            }
            field("Test Report Generated"; Rec."Test Report Generated") { ApplicationArea = All; }
        }

    }

    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        // Add changes to page actions here
        // addbefore(Print)
        // {


        //     action("Posted Bank Rec Report")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Caption = 'Posted Bank Rec Report';
        //         Ellipsis = true;
        //         Image = Transactions;
        //         ToolTip = 'Preview the resulting bank account reconciliations to see the Posted Bank Rec Report.';

        //         trigger OnAction()
        //         var
        //             BankRecon: Record "Bank Account Statement";
        //         begin

        //             BankRecon.Reset();
        //             BankRecon.SetRange("Statement No.", Rec."Statement No.");
        //             BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
        //             report.Run(80078, true, false, BankRecon);
        //         end;
        //     }

        // }
        addBefore(Print)
        {
            action(ConvRep)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Converted Print';
                // Ellipsis = true;
                Image = TestReport;
                Promoted = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Preview the resulting bank account reconciliations to see the Posted Bank Rec Report.';
                trigger OnAction()
                begin
                    bankRec.Reset();
                    bankRec.SetRange("Bank Account No.", rec."Bank Account No.");
                    bankRec.SetRange("Statement No.", rec."Statement No.");
                    if bankRec.Find('-') then
                        Report.Run(175073, true, false, bankRec);
                end;
            }
        }
    }

    var
        myInt: Integer;
        bankRec: Record "Bank Account Statement";
}
