//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50723 "Cheque Clearing Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Cheque Clearing Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    Editable = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    Editable = false;
                }
                field("Expected Date Of Clearing"; Rec."Expected Date Of Clearing")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                    Enabled = ProcessChequeClearingEnabled;
                }
                field("Total Count"; Rec."Total Count")
                {
                    Editable = false;
                }
                field("Cleared  By"; Rec."Cleared  By")
                {
                }
                field("Document No"; Rec."Document No")
                {
                    Editable = ProcessChequeClearingEnabled;
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    Caption = 'Total Cheques Value';
                }
            }
            part(ApplyBankLedgerEntries; "Cheque Clearing Lines")
            {
                Caption = 'Banked Cheques';
                SubPageLink = "Expected Maturity Date" = field("Expected Date Of Clearing");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ProcessChequeClearing)
            {
                Caption = 'Process Cheque Clearing';
                Ellipsis = true;
                Enabled = ProcessChequeClearingEnabled;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                ToolTip = 'Reverse an erroneous vendor ledger entry.';

                trigger OnAction()
                var
                    ReversalEntry: Record "Reversal Entry";
                    ObjClearingLine: Record "Cheque Clearing Lines";
                    GenJournalLine: Record "Gen. Journal Line";
                    SFactory: Codeunit "Au Factory";
                    ObjChequeType: Record "Cheque Types";
                    VarBouncedChqFee: Decimal;
                    VarBouncedChequeAcc: Code[20];
                    ObjGensetup: Record "Sacco General Set-Up";
                begin
                    ObjClearingLine.Reset;
                    ObjClearingLine.SetRange(ObjClearingLine."Expected Maturity Date", Rec."Expected Date Of Clearing");
                    ObjClearingLine.SetRange(ObjClearingLine."Cheque Clearing Status", ObjClearingLine."cheque clearing status"::Bounced);
                    if ObjClearingLine.FindSet then begin
                        repeat

                            ObjClearingLine.CalcFields(ObjClearingLine."Ledger Entry No", ObjClearingLine."Ledger Transaction No.");
                            Clear(ReversalEntry);
                            if ObjClearingLine."Cheque Bounced" then
                                ReversalEntry.AlreadyReversedEntry(Rec.TableCaption, ObjClearingLine."Ledger Entry No");
                            ObjClearingLine.TestField(ObjClearingLine."Ledger Transaction No.");
                            // ReversalEntry.ReverseTransactionBouncedCheques(ObjClearingLine."Ledger Transaction No.");

                            //Post Bounced Cheque fee
                            BATCH_TEMPLATE := 'GENERAL';
                            BATCH_NAME := 'FTRANS';
                            DOCUMENT_NO := ObjClearingLine."Cheque No";
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;
                            ObjGensetup.Get();

                            //Get Cheque Charges
                            ObjChequeType.Reset;
                            ObjChequeType.SetRange(ObjChequeType.Code, ObjClearingLine."Cheque Type");
                            if ObjChequeType.FindSet then begin
                                VarBouncedChqFee := ObjChequeType."Bounced Charges";
                                VarBouncedChequeAcc := ObjChequeType."Bounced Charges GL Account";
                                VarBankCharge := ObjChequeType."Bounced Cheque Bank Charge";
                                VarSaccoIncome := ObjChequeType."Bounced Cheque Sacco Income";
                                VarBankCode := ObjChequeType."Clearing Bank Account";
                                VarBankPosting := (VarBouncedChqFee - VarSaccoIncome) + ((VarBouncedChqFee - VarSaccoIncome) * ObjGensetup."Excise Duty(%)" / 100);
                            end;
                            //MESSAGE('BouncedChqFee %1, BankCharge %2, SaccoIncome %3',VarBouncedChqFee,VarBankCharge,VarSaccoIncome);
                            //------------------------------------1. DEBIT MEMBER A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjClearingLine."Account No", Today, VarBouncedChqFee, 'FOSA', ObjClearingLine."Cheque No",
                            'Bounced Cheque Fee #' + ObjClearingLine."Cheque No", '', GenJournalLine."application source"::CBS);
                            //--------------------------------(Debit Member Account)---------------------------------------------

                            //------------------------------------2. DEBIT MEMBER A/C EXCISE DUTY---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjClearingLine."Account No", Today, (VarBouncedChqFee * (ObjGensetup."Excise Duty(%)" / 100)), 'FOSA', ObjClearingLine."Cheque No",
                            'Tax: Bounced Cheque Fee #' + ObjClearingLine."Cheque No", '', GenJournalLine."application source"::CBS);
                            //--------------------------------(Debit Member Account)---------------------------------------------


                            //------------------------------------3. CREDIT Bank A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"Bank Account", VarBankCode, Today, VarBankPosting * -1, 'FOSA', ObjClearingLine."Cheque No",
                            'Bounced Cheque Fee #' + ObjClearingLine."Cheque No" + ' Acc. ' + ObjClearingLine."Account No", '', GenJournalLine."application source"::CBS);
                            //----------------------------------(Credit Income G/L Account)------------------------------------------------

                            //------------------------------------4. CREDIT INCOME G/L A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", VarBouncedChequeAcc, Today, VarSaccoIncome * -1, 'FOSA', ObjClearingLine."Cheque No",
                            'Bounced Cheque Fee #' + ObjClearingLine."Cheque No" + ' Acc. ' + ObjClearingLine."Account No", '', GenJournalLine."application source"::CBS);
                            //----------------------------------(Credit Income G/L Account)------------------------------------------------

                            //------------------------------------5. CREDIT EXCISE DUTY G/L A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", Today, (VarSaccoIncome * (ObjGensetup."Excise Duty(%)" / 100)) * -1, 'FOSA', ObjClearingLine."Cheque No",
                            'Tax: Bounced Cheque Fee #' + ObjClearingLine."Cheque No" + ' Acc. ' + ObjClearingLine."Account No", '', GenJournalLine."application source"::CBS);
                            //----------------------------------(Credit Excise Duty G/L Account)------------------------------------------------

                            //CU posting                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);


                            ObjTransactions.Reset;
                            ObjTransactions.SetRange(ObjTransactions.No, ObjClearingLine."Transaction No");
                            if ObjTransactions.FindSet then begin
                                ObjTransactions."Cheque Processed" := true;
                                ObjTransactions."Cheque Status":= ObjTransactions."Cheque Status"::Bounced;
                                ObjTransactions."Date Cleared" := WorkDate;
                                ObjTransactions.Modify;
                            end;
                        until ObjClearingLine.Next = 0;
                    end;

                    ObjClearingLine.Reset;
                    ObjClearingLine.SetRange(ObjClearingLine."Expected Maturity Date", Rec."Expected Date Of Clearing");
                    ObjClearingLine.SetRange(ObjClearingLine."Cheque Clearing Status", ObjClearingLine."cheque clearing status"::Cleared);
                    if ObjClearingLine.FindSet then begin
                        repeat
                            ObjTransactions.Reset;
                            ObjTransactions.SetRange(ObjTransactions.No, ObjClearingLine."Transaction No");
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

                            end;
                            ObjTransactions."Cheque Processed" := true;
                            ObjTransactions."Cheque Status":= ObjTransactions."Cheque Status"::Cleared;
                            ObjTransactions."Date Cleared" := WorkDate;
                            ObjTransactions."Banking Posted":=true;
                            ObjTransactions.Modify;
                            SFactory.FnRunAfterCashDepositProcess(ObjClearingLine."Account No");
                        until ObjClearingLine.Next = 0;
                    end;
                    Message('Cheque Clearing Processed Succesfully');
                    Rec.Posted := true;
                    Rec."Cleared  By" := UserId;
                    Rec.Modify();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ProcessChequeClearingEnabled := true;
        if Rec.Posted = true then
            ProcessChequeClearingEnabled := false;
    end;

    trigger OnAfterGetRecord()
    begin
        ProcessChequeClearingEnabled := true;
        if Rec.Posted = true then
            ProcessChequeClearingEnabled := false;
    end;

    trigger OnOpenPage()
    begin
        ProcessChequeClearingEnabled := true;
        if Rec.Posted = true then
            ProcessChequeClearingEnabled := false;
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






