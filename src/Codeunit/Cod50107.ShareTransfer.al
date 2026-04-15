codeunit 50107 "Share Transfer"
{

    trigger OnRun()
    var
        myInt: Integer;
    begin
        RecoverSharesFromDeposits();
    end;

    procedure RecoverSharesFromDeposits()
    var
        Loans: Record "Loans Register";
        Vendor: Record Vendor;
        LineNo: integer;
        VBalance: Decimal;
        BATCH_TEMPLATE: code[100];
        BATCH_NAME: code[100];
        DOCUMENT_NO: code[100];
        OutstandingInterest: Decimal;
        OutstandingBalance: Decimal;
        TotalRepay: Decimal;
        Vend: Record Vendor;
        DetVend: Record "Detailed Vendor Ledg. Entry";
        DepositAmount: Decimal;
        AsAt: Date;
        RemainingAmount: Decimal;
    begin

        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'SHARERECOV';
        DOCUMENT_NO := 'SHARERECOV ' + Format(Today);

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'SHARERECOV');
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll
        end;

        SaccoGen.Get();

        Vendor.Reset();
        Vendor.SetFilter(Vendor."Account Type", '101');
        Vendor.SetAutoCalcFields(Vendor.Balance);
        Vendor.SetFilter(Vendor.Balance, '<%1', SaccoGen."Retained Shares");
        if Vendor.FindSet() then begin
            
            repeat
                RemainingAmount := 0;
                RemainingAmount := SaccoGen."Retained Shares" - Vendor.Balance;
                Vend.Reset();
                Vend.SetRange(Vend."BOSA Account No", Vendor."BOSA Account No");
                Vend.SetRange(Vend."Account Type", '102');
                if Vend.FindFirst() then begin
                    AsAt := CalcDate('-3M', Today);
                    Detvend.Reset();
                    DetVend.SetRange(DetVend."Vendor No.", Vend."No.");
                    DetVend.SetFilter(DetVend."Posting Date", '%1..%2', AsAt, Today);
                    // DetVend.SetFilter(DetVend."Posting Date", '..%1', Today);
                    DetVend.SetRange(Reversed, false);
                    if DetVend.FindSet() then begin
                        DetVend.CalcSums(DetVend.Amount);
                        DepositAmount := -DetVend.Amount;
                        If DepositAmount >= 25000 then begin
                            RemainingAmount := RemainingAmount;
                            if RemainingAmount <= DepositAmount then begin
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, Vendor."No.", today, RemainingAmount * -1, '', '',
                                'Share Capital recovery', '', GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, Vend."No.", today, RemainingAmount, ' ', '',
                                'Share Capital recovery', '', GenJournalLine."Application Source"::" ");
                            end;
                        end else
                        if DepositAmount < 25000 then begin
                            if RemainingAmount > 3000 then
                                RemainingAmount := 3000
                            else
                                RemainingAmount := RemainingAmount;

                            if RemainingAmount <= DepositAmount then begin
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, Vendor."No.", today, RemainingAmount * -1, '', '',
                                'Share Capital recovery', '', GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Member DEPOSIT Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, Vend."No.", today, RemainingAmount, ' ', '',
                                'Share Capital recovery', '', GenJournalLine."Application Source"::" ");
                            end;
                        end;
                    end;
                end;
            until Vendor.Next() = 0;
            
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
        END;
    end;


    var
        AUFactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
        ChargeAmount: Decimal;
        GraduatedCharge: Record "MPESA  Withdrawal";
        GraduatedCharges: Record "Airtime Purchase Charges";
        GraduatedChargeB: Record "External Transfer Charges";
        MpesaComm: Decimal;
        SaccoCommission: Decimal;
        NameStyle: Codeunit "Send Birthday SMS";
        VendorComm: Decimal;
        ExciseDuty: Decimal;
        TotalAmount: Decimal;
        SaccoGen: Record "Sacco General Set-Up";
        Category: Text;
        VendorCommAccount: Code[20];
        ExciseDutyAccount: Code[20];
        TotalAmountAccount: Code[20];
        SaccoCommissionAccount: Code[20];
        Members: Record Customer;
        MpesaCommAccount: Code[20];
        smsManagement: Codeunit "Sms Management";
        CreationMessage: Text[2500];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
}
