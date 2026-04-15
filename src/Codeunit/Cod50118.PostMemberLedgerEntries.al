codeunit 50118 "Post Member Ledger Entries"
{
    trigger OnRun()
    begin
        FnPopulateJournalLines();
    end;
    
    procedure FnPopulateJournalLines()
    var
        myInt: Integer;
    begin
        BATCH_TEMPLATE := 'GENERAL';
        // BATCH_NAME := 'LEDGERBREG';
        BATCH_NAME := 'LEDGERBBBF';

        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll();
        end;

        GenBatches.Reset();
        GenBatches.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenBatches.SetRange(Name, BATCH_NAME);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init();
            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
            GenBatches.Name := BATCH_NAME;
            GenBatches.Description := 'NAV Member BBF Ledger Entries Posting';
            GenBatches.Insert();
        end;

        LineNo := 0;
        totalAmount := 0;
        saccoGen.Get();

        finalMemberLedgerBuffer.Reset();
        finalMemberLedgerBuffer.SetFilter(Amount, '<>%1', 0);
        if finalMemberLedgerBuffer.FindSet() then begin
            repeat
                DOCUMENT_NO := finalMemberLedgerBuffer."Document No";
                if cust.Get(finalMemberLedgerBuffer."Member No") then begin
                    LineNo := LineNo + 1000;
                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Customer, cust."No.", saccoGen."Go Live Date", finalMemberLedgerBuffer.Amount, '', '',
                    'BBF Bal AsAt-'+Format(saccoGen."Go Live Date"), '', GenJournalLine."Application Source"::" ");
                end;
                totalAmount := totalAmount + ((finalMemberLedgerBuffer.Amount)*-1);
            until finalMemberLedgerBuffer.Next() = 0;

            LineNo := LineNo + 1000;
            AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
            '200-000-170', saccoGen."Go Live Date", totalAmount, '', '', 'BBF Bal AsAt-'+Format(saccoGen."Go Live Date"), '',
            GenJournalLine."Application Source"::" ");
        end;
    end;
    var
    LineNo: Integer;
    totalAmount: Decimal;
    BATCH_TEMPLATE: Code[60];
    BATCH_NAME: Code[80];
    DOCUMENT_NO: Code[40];
    AUFactory: Codeunit "Au Factory";
    saccoGen: Record "Sacco General Set-Up";
    finalMemberLedgerBuffer: Record "Final CustLedgerEntries Buffer";
    cust: Record Customer;
    GenJournalLine: Record "Gen. Journal Line";
    GenBatches: Record "Gen. Journal Batch";
}
