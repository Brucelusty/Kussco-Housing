pageextension 50003 "Bank Account Recon" extends "Bank Acc. Reconciliation"
{

    layout
    {

        // Add changes to page layout here
        modify(StmtLine)
        {
            Visible = false;
        }
        modify(BalanceLastStatement)

        {
            Enabled = false;
        }

        addafter(StatementEndingBalance)
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

            field("Difference Btw Statements"; Rec."Difference Btw Statements")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Total Unreconciled"; Rec."Total Unreconciled")
            {
                ApplicationArea = All;
            }
            field("Total Reconciled"; Rec."Total Reconciled")
            {
                ApplicationArea = All;
            }
        }

        addafter(Control8)
        {
            part(StmtLine2; "Bank Acc. Statement Lines")
            {
                ApplicationArea = All;
                Caption = 'Bank Statement Lines';
                SubPageLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            Visible = false;
        }
        modify(SuggestLines)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        addbefore(SuggestLines)
        {
            action("Statement Lines")
            {
                ApplicationArea = All;
                Caption = 'Statement Lines';
                Image = Splitlines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bank Acc. Statement Lines";
                RunPageLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
            }
        }
        addbefore(MatchAutomatically)
        {
            action(MatchAutoConv)
            {
                ApplicationArea = All;
                Caption = 'AutoMatch';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ReconCount := 0;
                    ReconcilliationBuffer.RESET;
                    ReconcilliationBuffer.SETRANGE(ReconcilliationBuffer."Bank Account No.", Rec."Bank Account No.");
                    ReconcilliationBuffer.SETRANGE(ReconcilliationBuffer."Statement No.", Rec."Statement No.");
                    IF ReconcilliationBuffer.FIND('-') THEN BEGIN
                        // IF ReconcilliationBuffer."Check No."='NAV9JFYZ6Z' THEN BEGIN

                        REPEAT
                            ObjReconcilliationLine.RESET;
                            ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Bank Account No.", ReconcilliationBuffer."Bank Account No.");
                            ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Statement No.", ReconcilliationBuffer."Statement No.");
                            ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Document No.", ReconcilliationBuffer."Check No.");
                            // ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Transaction Date",ReconcilliationBuffer."Transaction Date");
                            ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Statement Amount", ReconcilliationBuffer."Statement Amount");

                            IF ObjReconcilliationLine.FIND('-') THEN BEGIN
                                // REPEAT
                                ObjReconcilliationLine.Reconciled := TRUE;
                                ObjReconcilliationLine."Reconciling Date" := TODAY;
                                ObjReconcilliationLine."Applied Amount" := ReconcilliationBuffer."Statement Amount";
                                ObjReconcilliationLine.Difference := 0;
                                ObjReconcilliationLine."Applied Entries" := 1;
                                ObjReconcilliationLine.MODIFY;
                                ReconCount := ReconCount + 1;

                                ReconcilliationBuffer2.RESET;
                                ReconcilliationBuffer2.SETRANGE(ReconcilliationBuffer2."Bank Account No.", ObjReconcilliationLine."Bank Account No.");
                                ReconcilliationBuffer2.SETRANGE(ReconcilliationBuffer2."Statement No.", ObjReconcilliationLine."Statement No.");
                                ReconcilliationBuffer2.SETRANGE(ReconcilliationBuffer2."Check No.", ObjReconcilliationLine."Document No.");
                                ReconcilliationBuffer2.SETRANGE(ReconcilliationBuffer2."Statement Amount", ObjReconcilliationLine."Statement Amount");
                                IF ReconcilliationBuffer2.FINDFIRST() THEN BEGIN
                                    ReconcilliationBuffer2.Reconciled := TRUE;
                                    ReconcilliationBuffer2."Reconciling Date" := TODAY;
                                    ReconcilliationBuffer2.Difference := 0;
                                    ReconcilliationBuffer2."Applied Entries" := 1;
                                    ReconcilliationBuffer2.MODIFY;
                                END;

                                //UNTIL ObjReconcilliationLine.NEXT=0;
                            END;
                        UNTIL ReconcilliationBuffer.NEXT = 0;

                        //END//Testing
                    END;
                    MESSAGE('Process Completed successfully. %1 items found a match', ReconCount);
                end;
            }
        }


        addbefore("&Test Report")
        {

            action("Custom Bank Recon.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Rec. Report';
                Ellipsis = true;
                Visible = false;
                Image = Transactions;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Acc. Reconciliation";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80071, true, false, BankRecon);
                end;
            }
            action("Telepost Bank Recon.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Telepost Bank Rec. Report';
                Ellipsis = true;
                Image = Transactions;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Acc. Reconciliation";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80074, true, false, BankRecon);//80074
                end;
            }

        }
        addbefore(SuggestLines)
        {
            action(SuggestLinesNew)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Suggest Lines New';
                Ellipsis = true;
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create bank account ledger entries suggestions and enter them automatically.';

                trigger OnAction()
                begin
                    //RecallEmptyListNotification();
                    SuggestBankAccStatement.SetStmt(Rec);
                    SuggestBankAccStatement.RunModal();
                    Clear(SuggestBankAccStatement);
                end;
            }


            action("Import Bank Statement")
            {
                ApplicationArea = Basic, Suite;
                Ellipsis = true;

                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                Caption = 'Import Bank Statement';
                RunObject = xmlport "Import Bank Statement";
                ToolTip = 'Open the chart of accounts.';
            }
            action("Imported Bank Statement")
            {
                ApplicationArea = Basic, Suite;
                Ellipsis = true;

                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                Caption = 'Bank Statement Imported';
                RunObject = page "Bank Statement Imported";
                ToolTip = 'Open the chart of accounts.';
            }
            action("Validate Data")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Validate Data';
                Ellipsis = true;

                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                Image = Transactions;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Account Ledger Entry";
                begin
                    Rec.TestField("Bank Account No.");
                    Rec.TestField("Statement No.");
                    Rec.TestField("Statement Date");
                    Rec.TestField("Statement Ending Balance");
                    BankRecon.Reset();
                    //BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    //  BankAccLedgEntry.Open := false;
                    // BankAccLedgEntry."Statement Status"
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    BankRecon.SetRange(Open, true);
                    BankRecon.SetRange("Statement Status", BankRecon."Statement Status"::Open, BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    BankRecon.SetFilter("Posting Date", '%1..%2', Rec."Statement Start Date", Rec."Statement Date");
                    if BankRecon.Find('-') then begin
                        repeat
                            BankRecon."Statement No." := Rec."Statement No.";
                            BankRecon."Statement Status" := BankRecon."Statement Status"::"Bank Acc. Entry Applied";
                            BankRecon.Modify(true);
                        until BankRecon.Next() = 0;
                    end;
                    Message('Validation Process complete');
                end;
            }
            action("Validate Imported Data")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Validate Imported Data';
                Ellipsis = true;

                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                Image = Transactions;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Account Ledger Entry";
                    ImportedStatement: Record "Imported Bank Statement New";
                begin

                    ImportedStatement.SetRange(ImportedStatement."Bank Code", Rec."Bank Account No.");
                    ImportedStatement.SetRange(ImportedStatement."Bank Statement No", Rec."Statement No.");
                    ImportedStatement.SetRange(ImportedStatement."Transaction ID", BankRecon."Document No.");
                    ImportedStatement.SetRange(ImportedStatement.Amount, BankRecon.Amount);
                    if ImportedStatement.Find('-') then begin

                        BankRecon.Reconciled := true;
                        BankRecon.Modify(true);

                    end;
                    Message('Validation Process complete');
                end;
            }
            //Import Bank Statement


            action("Bank Reconcilliation Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Reconcilliation Report';
                Ellipsis = true;
                Image = Transactions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Acc. Reconciliation";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80074, true, false, BankRecon);//80074
                end;
            }
            action("Bank Reconcilliation Report V2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Reconcilliation Report V2';
                Ellipsis = true;
                Image = Transactions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Acc. Reconciliation";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80075, true, false, BankRecon);//80074
                end;
            }
            action(MatchManually2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Match Manually Custom';
                Image = CheckRulesSyntax;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Manually match selected lines in both panes to link each bank statement line to one or more related bank account ledger entries.';

                trigger OnAction()
                var
                    TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                    MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                    TempBankAccReconciliationLine2: Record 274;
                    BankAccountLedgerEntry: Record 271;
                    bankAccountRec: record "Bank Acc. Reconciliation Line";
                begin
                    CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                    bankAccountRec.Reset();
                    bankAccountRec.SetRange(bankAccountRec.Reconciled, true);
                    if bankAccountRec.Find('-') then
                        Message('f%1-%2', BankAccountLedgerEntry."Entry No.", bankAccountRec."Entry No");
                    BankAccountLedgerEntry.RESET;
                    BankAccountLedgerEntry.SETRANGE("Entry No.", bankAccountRec."Entry No");
                    IF BankAccountLedgerEntry.FIND('-') THEN
                        Message('%1-%2', BankAccountLedgerEntry."Entry No.", TempBankAccReconciliationLine2."Entry No");
                    //MatchBankRecLines.MatchManually(TempBankAccReconciliationLine2, BankAccountLedgerEntry);
                    // CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                    // CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                    // MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                end;
            }
            action(RemoveMatch2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Remove Match Custom';
                Image = RemoveContacts;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Remove selection of matched bank statement lines.';

                trigger OnAction()
                var
                    TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                    MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                    TempBankAccReconciliationLine2: Record 274;
                    BankAccountLedgerEntry: Record 271;
                begin
                    CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine2);
                    BankAccountLedgerEntry.RESET;
                    BankAccountLedgerEntry.SETRANGE("Entry No.", TempBankAccReconciliationLine2."Entry No");
                    IF BankAccountLedgerEntry.FINDSET THEN
                        MatchBankRecLines.RemoveMatch(TempBankAccReconciliationLine2, BankAccountLedgerEntry);
                end;
            }
        }
        addbefore(Post)
        {
            action(PostCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post Bank Rec';
                PromotedCategory = Process;
                Image = PostOrder;
                Promoted = true;

                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    BankAccStmt: Record "Bank Account Statement";
                    BankAccStmtLine: Record "Bank Account Statement Line";
                    BankAccountPosted: Record 50122;
                begin
                    if Rec.Difference <> 0 then Error('Reconciliation is not complete kindly review your reconciliation');
                    Rec.TestField("Test Report Generated", true);
                    // CODEUNIT.Run(CODEUNIT::"Bank Acc. Recon Posting", Rec);//Bank Acc. Reconciliation Post2
                    // exit;
                    BankAccLedgEntry.Reset();
                    BankAccLedgEntry.SetCurrentKey("Bank Account No.", Open);
                    BankAccLedgEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
                    BankAccLedgEntry.SetRange(Open, true);
                    BankAccLedgEntry.SetRange("Statement Status", BankAccLedgEntry."Statement Status"::Open);
                    BankAccLedgEntry.SetRange(Reconciled, true);

                    if BankAccLedgEntry.FindSet() then begin
                        repeat

                            BankAccLedgEntry."Statement No." := Rec."Statement No.";
                            Rec.Modify(true);
                        until BankAccLedgEntry.Next() = 0;
                    end;
                    //cpoy bankrec line

                    //insert copy table
                    BankAccLedgEntry.Reset();
                    BankAccLedgEntry.SetCurrentKey("Bank Account No.", Open);
                    BankAccLedgEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
                    BankAccLedgEntry.SetRange(Open, true);
                    BankAccLedgEntry.SetRange(Reversed, false);
                    BankAccLedgEntry.SetRange(
                      "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    BankAccLedgEntry.SetRange("Statement No.", Rec."Statement No.");

                    if BankAccLedgEntry.FindSet() then begin
                        repeat
                            copyBankEntry.TransferFields(BankAccLedgEntry);

                            // if copyBankEntry."Statement No." <> '' then
                            copyBankEntry.Insert(true);

                        until BankAccLedgEntry.Next() = 0;
                    end;
                    ///  BankAccountPosted.Insert(true);








                    //end insertion
                    BankAccLedgEntry.Reset();
                    BankAccLedgEntry.SetCurrentKey("Bank Account No.", Open, "Statement Status", "Statement No.");
                    BankAccLedgEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
                    BankAccLedgEntry.SetRange(Open, true);
                    BankAccLedgEntry.SetRange("Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    BankAccLedgEntry.SetRange("Statement No.", Rec."Statement No.");
                    BankAccLedgEntry.SetRange(Reconciled, true);
                    if BankAccLedgEntry.FindSet() then begin
                        repeat
                            BankAccLedgEntry."Remaining Amount" := 0;
                            BankAccLedgEntry.Open := false;
                            BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Closed;
                            BankAccLedgEntry."Statement No." := Rec."Statement No.";

                            BankAccLedgEntry.Modify();


                        until BankAccLedgEntry.Next() = 0;

                    end;

                    BankAccStmt.Init();
                    BankAccStmt.TransferFields(Rec);
                    BankAccStmt."Statement No." := Rec."Statement No.";
                    //bank account statement line
                    BankAccLedgEntry.Reset();
                    BankAccLedgEntry.SetCurrentKey("Bank Account No.");
                    BankAccLedgEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
                    //BankAccLedgEntry.SetRange(Open, true);
                    // BankAccLedgEntry.SetRange("Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    BankAccLedgEntry.SetRange("Statement No.", Rec."Statement No.");
                    if BankAccLedgEntry.FindSet() then begin
                        repeat
                            //BankAccStmtLine."Entry No" := BankAccStmtLine."Entry No" + 100;
                            //BankAccStmtLine."Statement Line No." := BankAccStmtLine."Statement Line No." + 1000;
                            BankAccStmtLine."Bank Account No." := BankAccLedgEntry."Bank Account No.";
                            BankAccStmtLine."Statement No." := BankAccStmt."Statement No.";
                            BankAccStmtLine."Document No." := BankAccLedgEntry."Document No.";
                            BankAccStmtLine."Transaction Date" := BankAccLedgEntry."Posting Date";
                            BankAccStmtLine.Description := BankAccLedgEntry.Description;
                            BankAccStmtLine."Entry No" := BankAccLedgEntry."Entry No.";
                            BankAccStmtLine."Cash In" := BankAccLedgEntry.Amount;
                            BankAccStmtLine."Statement Line No." := BankAccLedgEntry."Statement Line No.";
                            BankAccStmtLine.Reconciled := BankAccLedgEntry.Reconciled;
                            BankAccStmtLine."Statement Amount" := BankAccLedgEntry.Amount;
                            BankAccStmtLine.Type := BankAccLedgEntry."Statement Status";
                        //BankAccStmtLine.Insert(true);

                        until BankAccLedgEntry.Next() = 0;
                    end;
                    BankAccStmt.Insert();
                    BankAccReconciliation.Reset();
                    BankAccReconciliation.SetRange("Statement No.", Rec."Statement No.");
                    if BankAccReconciliation.Find('-') then begin
                        BankAccountPosted.Init();
                        BankAccountPosted.TransferFields(Rec);
                        // if BankAccountPosted.Find('-') then
                        //     BankAccountPosted.Modify(true)
                        // else
                        BankAccountPosted.Insert(true);
                        BankReconciliationHeader.Init();
                        BankReconciliationHeader.TransferFields(Rec);
                        // if BankAccReconciliation.Find('-') then
                        //     BankAccReconciliation.Modify(true)
                        // else
                        BankReconciliationHeader.Insert(true);
                    end;

                    BankAccount.Reset();
                    BankAccount.SetRange("No.", Rec."Bank Account No.");
                    if BankAccount.Find('-') then begin
                        BankAccount."Balance Last Statement" := Rec."Statement Ending Balance";
                        BankAccount.Modify(true);
                    end;
                    Rec.Posted := true;
                    Rec.Modify(true);
                    //CODEUNIT.Run(CODEUNIT::"Bank Acc. Reconciliation Post2", Rec);//Bank Acc. Reconciliation Post2

                end;
            }

        }
        addafter(PostAndPrint)
        {
            action("Bank Recon Report Conv")
            {
                ApplicationArea = All;
                Image = "Report";
                Caption = 'Bank Recon Report';
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;
                trigger OnAction()
                begin
                    //     ReportPrint.PrintBankAccRecon(Rec);   --To allow for the new format
                    //NewReport.getbankRec(Rec,"Statement Ending Balance");
                    // NewReport.RUN;

                    REPORT.RUN(175069, TRUE, FALSE, Rec);
                end;
            }
        }

    }

    var
        myInt: Integer;
        ReconCount: Decimal;
        copyBankEntry: Record "Bank Account Ledger Entry Rec";
        SuggestBankAccStatement: Report "Suggest Bank Acc.Lines New";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        BankReconciliationHeader: Record "Bank Reconciliation Header";
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccount: Record "Bank Account";
        ReconcilliationBuffer: Record "Bank Acc. Statement Linevb";
        ObjReconcilliationLine: Record "Bank Acc. Reconciliation Line";
        ReconcilliationBuffer2: Record "Bank Acc. Statement Linevb";
}
