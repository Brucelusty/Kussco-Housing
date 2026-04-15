page 50219 "Bank Acc. Reconciliation2"
{
    ApplicationArea = All;
    Caption = 'Bank Acc. Reconciliation';
    PageType = Card;
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Bank,Matching,Posting';
    SaveValues = false;
    SourceTable = "Bank Reconciliation Header";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                    ToolTip = 'Specifies the number of the bank account that you want to reconcile with the bank''s statement.';
                    trigger OnValidate()
                    begin
                        CreateEmptyListNotification();
                    end;
                }
                field(StatementNo; Rec."Statement No.")
                {
                    Caption = 'Statement No.';
                    ToolTip = 'Specifies the number of the bank account statement.';
                }
                field(StatementDate; Rec."Statement Date")
                {
                    Caption = 'Statement Date';
                    ToolTip = 'Specifies the date on the bank account statement.';
                    trigger OnValidate()
                    begin
                        UpdateBankAccountLedgerEntrySubPage(Rec."Statement Date");
                    end;
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                    Caption = 'Balance Last Statement';
                    ToolTip = 'Specifies the ending balance shown on the last bank statement, which was used in the last posted bank reconciliation for this bank account.';
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                    Caption = 'Statement Ending Balance';
                    ToolTip = 'Specifies the ending balance shown on the bank''s statement that you want to reconcile with the bank account.';
                }
                field("Reconciled Amount"; Rec."Reconciled Amount")
                {
                    Editable = false;
                }
                field(Unreconciled; Rec.Unreconciled)
                {
                    Editable = false;
                }

                field("Cleared Cheques and Payments"; Rec."Cleared Cheques and Payments") { Editable = false; }
                field("Cleared Deposit and Credits"; Rec."Cleared Deposit and Credits") { Editable = false; }
                field("UnCleared Cheques and Payments"; Rec."UnCleared Cheques and Payments") { Editable = false; }
                field("UnCleared Deposit and Credits"; Rec."UnCleared Deposit and Credits") { Editable = false; }
                field(Difference; Rec.Difference)
                {
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
            }
            group(Control8)
            {
                ShowCaption = false;

                part(ApplyBankLedgerEntries; "Posted Recon Ledger Entries3")
                {
                    Caption = 'Posted Recon Ledger Entries';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = field("Statement No.");


                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Recon.")
            {
                Caption = '&Recon.';
                Image = BankAccountRec;
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category4;
                    RunObject = Page "Bank Account Card";
                    RunPageLink = "No." = FIELD("Bank Account No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the record that is being processed on the journal line.';
                }
            }
            action("Posted Bank Recon.")
            {
                Caption = 'Katiba Bank Rec. Report';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Report;
                Image = Transactions;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Reconciliation Header";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80090, true, false, BankRecon);//80074
                end;
            }
        }
        area(processing)
        {



        }
    }

    trigger OnClosePage()
    begin
        RefreshSharedTempTable;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        RefreshSharedTempTable;
    end;

    trigger OnModifyRecord(): Boolean
    begin

        RefreshSharedTempTable;
    end;

    trigger OnOpenPage()
    begin
        CreateEmptyListNotification();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        RecallEmptyListNotification();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if UpdatedBankAccountLESystemId <> Rec.SystemId then begin
            UpdateBankAccountLedgerEntrySubpage(Rec."Statement Date");
            UpdatedBankAccountLESubpageStementDate := Rec."Statement Date";
            UpdatedBankAccountLESystemId := Rec.SystemId;
        end;
    end;

    local procedure GetImportBankStatementNotificatoinId(): Guid
    begin
        exit('aa54bf06-b8b9-420d-a4a8-1f55a3da3e2a');
    end;

    local procedure CreateEmptyListNotification()
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        ImportBankStatementNotification: Notification;
    begin
        // ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
        // if ImportBankStatementNotification.Recall then;
        // if not BankAccReconciliationLine.BankStatementLinesListIsEmpty("Statement No.", "Statement Type", "Bank Account No.") then
        //     exit;

        ImportBankStatementNotification.Message := ListEmptyMsg;
        ImportBankStatementNotification.Scope := NotificationScope::LocalScope;
        ImportBankStatementNotification.Send();
    end;

    local procedure RecallEmptyListNotification()
    var
        ImportBankStatementNotification: Notification;
    begin
        ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
        if ImportBankStatementNotification.Recall then;
    end;

    procedure SetSharedTempTable(var TempBankAccReconciliationOnList: Record "Bank Acc. Reconciliation" temporary)
    begin
        TempBankAccReconciliationDataset.Copy(TempBankAccReconciliationOnList, true);
    end;

    local procedure RefreshSharedTempTable()
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        TempBankAccReconciliationDataset.DeleteAll();
        //BankAccReconciliation.GetTempCopy(TempBankAccReconciliationDataset);
    end;

    local procedure CheckStatementDate()
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        BankAccReconciliationLine.SetFilter("Bank Account No.", Rec."Bank Account No.");
        BankAccReconciliationLine.SetFilter("Statement No.", Rec."Statement No.");
        BankAccReconciliationLine.SetCurrentKey("Transaction Date");
        BankAccReconciliationLine.Ascending := false;
        if BankAccReconciliationLine.FindFirst() then begin
            BankAccReconciliation.GetBySystemId(Rec.SystemId);
            if BankAccReconciliation."Statement Date" = 0D then begin
                if Confirm(StrSubstNo(StatementDateEmptyMsg, Format(BankAccReconciliationLine."Transaction Date"))) then begin
                    Rec."Statement Date" := BankAccReconciliationLine."Transaction Date";
                    Rec.Modify();
                end;
            end else
                if BankAccReconciliation."Statement Date" < BankAccReconciliationLine."Transaction Date" then
                    Message(ImportedLinesAfterStatementDateMsg);
        end;
    end;

    local procedure UpdateBankAccountLedgerEntrySubpage(StatementDate: Date)
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        FilterDate: Date;
    begin
        // BankAccountLedgerEntry.SetRange("Bank Account No.", "Bank Account No.");
        // BankAccountLedgerEntry.SetRange(Open, true);
        // BankAccountLedgerEntry.SetRange(Reversed, false);
        // BankAccountLedgerEntry.SetFilter("Statement Status", StrSubstNo('%1|%2|%3', Format(BankAccountLedgerEntry."Statement Status"::Open), Format(BankAccountLedgerEntry."Statement Status"::"Bank Acc. Entry Applied"), Format(BankAccountLedgerEntry."Statement Status"::"Check Entry Applied")));
        // FilterDate := MatchCandidateFilterDate();
        // if StatementDate > FilterDate then
        //     FilterDate := StatementDate;
        // if FilterDate <> 0D then
        //     BankAccountLedgerEntry.SetFilter("Posting Date", StrSubstNo('<=%1', FilterDate));
        // if BankAccountLedgerEntry.FindSet() then;
        // CurrPage.ApplyBankLedgerEntries.Page.SetTableView(BankAccountLedgerEntry);
        // CurrPage.ApplyBankLedgerEntries.Page.Update();
    end;

    var
        SuggestBankAccStatement: Report "Suggest Bank Acc. Recon. Lines";
        TransferToGLJnl: Report "Trans. Bank Rec. to Gen. Jnl.";
        TempBankAccReconciliationDataset: Record "Bank Acc. Reconciliation" temporary;
        ReportPrint: Codeunit "Test Report-Print";
        ListEmptyMsg: Label 'No bank statement lines exist. Choose the Import Bank Statement action to fill in the lines from a file, or enter lines manually.';
        ImportedLinesAfterStatementDateMsg: Label 'Imported bank statement has lines dated after the statement date.';
        StatementDateEmptyMsg: Label 'Statement date is empty. The latest bank statement line is %1. Do you want to set the statement date to this date?', Comment = '%1 - statement date';
        NoBankAccReconcilliationLineWithDiffSellectedErr: Label 'Select the bank statement lines that have differences to transfer to the general journal.';
        UpdatedBankAccountLESubpageStementDate: Date;
        UpdatedBankAccountLESystemId: Guid;
}
