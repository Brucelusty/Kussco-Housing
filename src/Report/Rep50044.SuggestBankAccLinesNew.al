report 50044 "Suggest Bank Acc.Lines New"
{
    ApplicationArea = All;
    Caption = 'Suggest Bank Acc. Recon. Lines New';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            var
                BankRecLine: Record "Bank Acc. Reconciliation Line";
            begin
                BankAccLedgEntry.Reset();
                BankAccLedgEntry.SetCurrentKey("Bank Account No.", "Posting Date");
                BankAccLedgEntry.SetRange("Bank Account No.", "No.");
                BankAccLedgEntry.SetRange("Posting Date", StartDate, EndDate);
                BankAccLedgEntry.SetRange(Open, true);
                BankAccLedgEntry.SetRange("Statement Status", BankAccLedgEntry."Statement Status"::Open);
                if ExcludeReversedEntries then
                    BankAccLedgEntry.SetRange(Reversed, false);
                EOFBankAccLedgEntries := not BankAccLedgEntry.Find('-');

                if IncludeChecks then begin
                    CheckLedgEntry.Reset();
                    CheckLedgEntry.SetCurrentKey("Bank Account No.", "Check Date");
                    CheckLedgEntry.SetRange("Bank Account No.", "No.");
                    CheckLedgEntry.SetRange("Check Date", StartDate, EndDate);
                    CheckLedgEntry.SetFilter(
                      "Entry Status", '%1|%2', CheckLedgEntry."Entry Status"::Posted,
                      CheckLedgEntry."Entry Status"::"Financially Voided");
                    CheckLedgEntry.SetRange(Open, true);
                    CheckLedgEntry.SetRange("Statement Status", BankAccLedgEntry."Statement Status"::Open);
                    EOFCheckLedgEntries := not CheckLedgEntry.Find('-');
                end;

                while (not EOFBankAccLedgEntries) or (IncludeChecks and (not EOFCheckLedgEntries)) do
                    case true of
                        not IncludeChecks:
                            begin
                                BankRecLine.Reset();
                                //BankRecLine.SetRange(BankRecLine."Entry No", BankAccLedgEntry."Entry No.");
                                if BankRecLine.Find() = false then
                                    EnterBankAccLine(BankAccLedgEntry);
                                EOFBankAccLedgEntries := BankAccLedgEntry.Next() = 0;
                            end;
                        (not EOFBankAccLedgEntries) and (not EOFCheckLedgEntries) and
                        (BankAccLedgEntry."Posting Date" <= CheckLedgEntry."Check Date"):
                            begin
                                CheckLedgEntry2.Reset();
                                CheckLedgEntry2.SetCurrentKey("Bank Account Ledger Entry No.");
                                CheckLedgEntry2.SetRange("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                                CheckLedgEntry2.SetRange(Open, true);
                                if not CheckLedgEntry2.FindFirst() then
                                    EnterBankAccLine(BankAccLedgEntry);
                                EOFBankAccLedgEntries := BankAccLedgEntry.Next() = 0;
                            end;
                        (not EOFBankAccLedgEntries) and (not EOFCheckLedgEntries) and
                        (BankAccLedgEntry."Posting Date" > CheckLedgEntry."Check Date"):
                            begin
                                EnterCheckLine(CheckLedgEntry);
                                EOFCheckLedgEntries := CheckLedgEntry.Next() = 0;
                            end;
                        (not EOFBankAccLedgEntries) and EOFCheckLedgEntries:
                            begin
                                CheckLedgEntry2.Reset();
                                CheckLedgEntry2.SetCurrentKey("Bank Account Ledger Entry No.");
                                CheckLedgEntry2.SetRange("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                                CheckLedgEntry2.SetRange(Open, true);
                                if not CheckLedgEntry2.FindFirst() then
                                    EnterBankAccLine(BankAccLedgEntry);
                                EOFBankAccLedgEntries := BankAccLedgEntry.Next() = 0;
                            end;
                        EOFBankAccLedgEntries and (not EOFCheckLedgEntries):
                            begin
                                EnterCheckLine(CheckLedgEntry);
                                EOFCheckLedgEntries := CheckLedgEntry.Next() = 0;
                            end;
                    end;
            end;

            trigger OnPreDataItem()
            begin
                //OnPreDataItemBankAccount(ExcludeReversedEntries);

                if EndDate = 0D then
                    Error(Text000);

                if BankAccRecon."Statement Date" <> 0D then
                    if BankAccRecon."Statement Date" < EndDate then
                        EndDate := BankAccRecon."Statement Date";

                BankAccReconLine.FilterBankRecLines(BankAccRecon);
                if not BankAccReconLine.FindLast() then begin
                    BankAccReconLine."Statement Type" := BankAccRecon."Statement Type";
                    BankAccReconLine."Bank Account No." := BankAccRecon."Bank Account No.";
                    BankAccReconLine."Statement No." := BankAccRecon."Statement No.";
                    BankAccReconLine."Statement Line No." := 0;
                end;

                SetRange("No.", BankAccRecon."Bank Account No.");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group("Statement Period")
                    {
                        Caption = 'Statement Period';
                        field(StartingDate; StartDate)
                        {
                            Caption = 'Starting Date';
                            ToolTip = 'Specifies the date from which the report or batch job processes information.';
                            ApplicationArea = All;
                        }
                        field(EndingDate; EndDate)
                        {
                            Caption = 'Ending Date';
                            ToolTip = 'Specifies the date to which the report or batch job processes information.';
                            ApplicationArea = All;
                        }
                    }
                    field(IncludeChecks; IncludeChecks)
                    {
                        Caption = 'Include Checks';
                        ToolTip = 'Specifies if you want the report to include check ledger entries. If you choose this option, check ledger entries are suggested instead of the corresponding bank account ledger entries.';
                        ApplicationArea = All;
                    }
                    field(ExcludeReversedEntries; ExcludeReversedEntries)
                    {
                        Caption = 'Exclude Reversed Entries';
                        ToolTip = 'Specifies if you want to exclude reversed entries from the report.';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Text000: Label 'Enter the Ending Date.';
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        CheckLedgEntry2: Record "Check Ledger Entry";
        BankAccRecon: Record "Bank Acc. Reconciliation";
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        BankAccSetStmtNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        CheckSetStmtNo: Codeunit "Check Entry Set Recon.-No.";
        StartDate: Date;
        EndDate: Date;
        IncludeChecks: Boolean;
        EOFBankAccLedgEntries: Boolean;
        EOFCheckLedgEntries: Boolean;
        ExcludeReversedEntries: Boolean;

    procedure SetStmt(var BankAccRecon2: Record "Bank Acc. Reconciliation")
    begin
        BankAccRecon := BankAccRecon2;
        EndDate := BankAccRecon."Statement Date";
    end;

    local procedure EnterBankAccLine(var BankAccLedgEntry2: Record "Bank Account Ledger Entry")
    var
        BankAccount: Record "Bank Account";
    begin
        BankAccReconLine.Init();
        BankAccReconLine."Statement Line No." := BankAccReconLine."Statement Line No." + 10000;
        BankAccReconLine."Transaction Date" := BankAccLedgEntry2."Posting Date";
        BankAccReconLine.Description := BankAccLedgEntry2.Description;
        BankAccReconLine."Document No." := BankAccLedgEntry2."Document No.";
        BankAccReconLine."Check No." := BankAccLedgEntry2."External Document No.";
        // BankAccReconLine."Cash In" := BankAccLedgEntry2."Debit Amount";
        // BankAccReconLine.Payment := BankAccLedgEntry2."Credit Amount";
        // BankAccReconLine."Statement Amount" := BankAccLedgEntry2."Remaining Amount";
        // BankAccReconLine."Entry No" := BankAccLedgEntry2."Entry No.";
        if BankAccount.Get(BankAccLedgEntry2."Bank Account No.") then
            if not BankAccount."Disable Automatic Pmt Matching" then begin
                //BankAccReconLine.Type := BankAccReconLine.Type::"Bank Account Ledger Entry";
                BankAccReconLine."Applied Amount" := BankAccReconLine."Statement Amount";
                BankAccReconLine."Applied Entries" := 1;
                BankAccSetStmtNo.SetReconNo(BankAccLedgEntry2, BankAccReconLine);
            end;
        OnBeforeInsertBankAccReconLine(BankAccReconLine, BankAccLedgEntry2);
        BankAccReconLine.Insert();
    end;

    local procedure EnterCheckLine(var CheckLedgEntry3: Record "Check Ledger Entry")
    var
        BankAccLedg: Record "Bank Account Ledger Entry";
        BankAccount: Record "Bank Account";
    begin
        BankAccReconLine.Init();
        BankAccReconLine."Statement Line No." := BankAccReconLine."Statement Line No." + 10000;
        BankAccReconLine."Transaction Date" := CheckLedgEntry3."Check Date";
        BankAccReconLine.Description := CheckLedgEntry3.Description;
        BankAccReconLine."Statement Amount" := -CheckLedgEntry3.Amount;
        if BankAccLedg.Get(CheckLedgEntry3."Bank Account Ledger Entry No.") then
            BankAccReconLine."Document No." := BankAccLedg."Document No.";
        if BankAccount.Get(CheckLedgEntry3."Bank Account No.") then
            if not BankAccount."Disable Automatic Pmt Matching" then begin
                //  BankAccReconLine.Type := BankAccReconLine.Type::"Check Ledger Entry";
                BankAccReconLine."Applied Amount" := BankAccReconLine."Statement Amount";
                BankAccReconLine."Check No." := CheckLedgEntry3."Check No.";
                BankAccReconLine."Applied Entries" := 1;
                CheckSetStmtNo.SetReconNo(CheckLedgEntry3, BankAccReconLine);
            end;
        BankAccReconLine.Insert();
    end;

    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewIncludeChecks: Boolean)
    begin
        StartDate := NewStartDate;
        if (BankAccRecon."Statement Date" = 0D) or (NewEndDate < BankAccRecon."Statement Date") then
            EndDate := NewEndDate
        else
            EndDate := BankAccRecon."Statement Date";
        IncludeChecks := NewIncludeChecks;
        ExcludeReversedEntries := false;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertBankAccReconLine(var BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var BankAccLedgEntry: Record "Bank Account Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure OnPreDataItemBankAccount(var ExcludeReversedEntries: Boolean)
    begin
        // ExcludeReversedEntries = FALSE by default
    end;
}



