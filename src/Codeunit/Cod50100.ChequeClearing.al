Codeunit 50100 "Cheque Clearing"
{

    trigger OnRun()
    begin
    end;

    local procedure FnClearChequeDeposit()
    begin
        ObjTransactions.Reset;
        //ObjTransactions.SetRange(ObjTransactions.No, ObjClearingLine."Transaction No");
        if ObjTransactions.FindSet then begin

            IF ObjTransactions."Cheque Destination Type" = ObjTransactions."Cheque Destination Type"::BOSA THEN BEGIN
                ReceiptAllocations.Reset();
                ReceiptAllocations.SetRange(ReceiptAllocations."Document No", ObjTransactions.No);
                if ReceiptAllocations.FindFirst() then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    GenJournalLine.DeleteAll;


                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := ObjTransactions.No;
                    GenJournalLine."External Document No." := ObjTransactions."Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := ObjTransactions."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := ObjTransactions."Cheque Date";
                    GenJournalLine.Description := 'BT-' + ObjTransactions."Account No." + '-' + ObjTransactions."Account Name";
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := ObjTransactions.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    repeat




                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := ObjTransactions.No;
                        GenJournalLine."External Document No." := ObjTransactions."Cheque No";
                        GenJournalLine."Posting Date" := ObjTransactions."Cheque Date";
                        if ReceiptAllocations."Account No" <> '' then begin
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := ReceiptAllocations."Member No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                        end else begin
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := ReceiptAllocations."Member No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                        end;

                        GenJournalLine."Posting Date" := ObjTransactions."Cheque Date";
                        GenJournalLine.Description := 'BT-' + ObjTransactions."Account No." + '-' + ObjTransactions."Account Name";
                        GenJournalLine.Amount := -ReceiptAllocations.Amount;
                        GenJournalLine."Shortcut Dimension 1 Code" := ReceiptAllocations."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := ReceiptAllocations."Global Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine.Description := CopyStr(
                        Format(ReceiptAllocations."Transaction Type") + '-' + ObjTransactions."Account Name" + '-' + ObjTransactions."Cheque No"
                        , 1, 50);
                        GenJournalLine."Transaction Type" := ReceiptAllocations."Transaction Type";
                        GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                    until ReceiptAllocations.next = 0;



                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                END;
            end;
            ObjTransactions."Cheque Processed" := true;
            ObjTransactions."Date Cleared" := WorkDate;
            ObjTransactions.Modify;
        end;
    end;



    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        ReceiptAllocations: record "Receipt Allocation";
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record "Members Register";
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
        BATCH_TEMPLATE: Code[20];
        BATCH_NAME: Code[20];
        DOCUMENT_NO: Code[20];
        ObjTransactions: Record Transactions;
        SFactory: Codeunit "Au Factory";
        ProcessChequeClearingEnabled: Boolean;
        VarBankCharge: Decimal;
        VarBankCode: Code[30];
        VarSaccoIncome: Decimal;
        VarBankPosting: Decimal;
}

