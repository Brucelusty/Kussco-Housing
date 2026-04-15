//<---------------------------------------------------------------------->															
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings															
Report 50276 "Payroll Net Pay Transfer Ver1"
{
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FnRunCreateLoansandNetPayCreditEntries("No.", "Loan Settlement Account", "Payroll No", "Bank Account No");
            end;

            trigger OnPostDataItem()
            begin
                Message('Net Pay Journal Entries Created in # General Journals # Batch - NETPAY');
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'NETPAY');
                if GenJournalLine.FindSet then begin
                    GenJournalLine.DeleteAll
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(VarPayrollPeriod; VarPayrollPeriod)
                {
                    Caption = 'Payroll Period';
                    ApplicationArea = All;
                    TableRelation = "Payroll Calender."."Date Opened";
                }

                field(DOCUMENT_NO; DOCUMENT_NO)
                {
                    Caption = 'Document Number';
                    ApplicationArea = All;

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
        VarPayrollPeriod: Date;
        ObjPayrollPeriodTransactions: Record "prPeriod Transactions.";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[40];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
        ObjPayrollPostingGroup: Record "Payroll Posting Groups.";
        VarTotalGrossPay: Decimal;
        VarTotalDebitTransactions: Decimal;
        VarNSSF: Decimal;
        VarNHIF: Decimal;
        VarPAYE: Decimal;
        VarNETPay: Decimal;
        VarBasicPay: Decimal;
        VarLoanRepayments: Decimal;
        ObjMemberAccount: Record Vendor;
        VarDepositsContribution: Decimal;
        VarDepositsAccountNo: Code[30];
        VarAmounttoDebitNetPay: Decimal;
        ObjPayrollEmployee: Record "Payroll Employee.";
        ObjPayrollGeneralSetup: Record "Payroll General Setup.";

    local procedure FnRunCreateLoansandNetPayCreditEntries(VarEmployeeCode: Code[30]; VarLoanSettlement: Code[30]; VarMemberNo: Code[30]; VarFOSAAccount: Code[30])
    begin
        ObjPayrollPostingGroup.Get('PAYROLL');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'NETPAY';
        //DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

        VarLoanRepayments := 0;
        VarDepositsContribution := 0;
        VarNETPay := 0;
        VarAmounttoDebitNetPay := 0;

        //==============================================================================Loan Repayments															
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Employee Code", VarEmployeeCode);
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Loan Number", '<>%1', '');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarLoanRepayments := ObjPayrollPeriodTransactions.Amount;

            /*             LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, VarLoanSettlement, WorkDate, VarLoanRepayments * -1, 'FOSA', '',
                        'Loan Repayment Deduction - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS); */

        end;

        //==============================================================================Deposits Contribution															
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Employee Code", VarEmployeeCode);
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."coop parameters", ObjPayrollPeriodTransactions."coop parameters"::shares);
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarDepositsContribution := ObjPayrollPeriodTransactions.Amount;

            ObjMemberAccount.Reset;
            ObjMemberAccount.SetRange(ObjMemberAccount."BOSA Account No", VarMemberNo);
            ObjMemberAccount.SetRange(ObjMemberAccount."Account Type", '102');
            ObjMemberAccount.SetFilter(ObjMemberAccount.Status, '<>%1&<>%2', ObjMemberAccount.Status::Closed, ObjMemberAccount.Status::Deceased);
            if ObjMemberAccount.FindSet then begin
                VarDepositsAccountNo := ObjMemberAccount."No.";
            end;

            /*             LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, VarDepositsAccountNo, WorkDate, VarDepositsContribution * -1, 'FOSA', '',
                        'Deposit Contribution - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS); */

        end;

        //==============================================================================Net Pay															
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Employee Code", VarEmployeeCode);
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", 'NPAY');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            VarNETPay := ObjPayrollPeriodTransactions.Amount;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarFOSAAccount, WorkDate, VarNETPay * -1, 'FOSA', '',
            'Net Pay For' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);

        end;


        //==============================================================================Debit Total Net Pay Account															
        ObjPayrollGeneralSetup.Get;
        ObjPayrollEmployee.Reset;
        ObjPayrollEmployee.SetRange(ObjPayrollEmployee."No.", VarEmployeeCode);
        if ObjPayrollEmployee.FindSet then begin
            //VarAmounttoDebitNetPay := VarLoanRepayments + VarDepositsContribution + VarNETPay;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollGeneralSetup."Staff Net Pay G/L Account", WorkDate, VarNETPay, 'FOSA', '',
            DOCUMENT_NO + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);
        end;

        FnRunStandingOrders(VarFOSAAccount, VarNETPay);

    end;

    var
        ObjSTORegister: Record "Standing Order Register";
        DedStatus: Option Successfull,"Partial Deduction",Failed;


    local procedure FnRunStandingOrders(SourceNo: Code[60]; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";

    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            ObjStandingOrders.Reset;
            ObjStandingOrders.SetCurrentkey("No.", "Source Account No.");
            ObjStandingOrders.SetRange("Source Account No.", SourceNo);
            ObjStandingOrders.SetRange(Status, ObjStandingOrders.Status::Approved);
            ObjStandingOrders.SetRange("Is Active", true);
            //ObjStandingOrders.SetRange("Standing Order Dedution Type", ObjStandingOrders."standing order dedution type"::Salary);
            if ObjStandingOrders.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        // if ObjStandingOrders."Next Run Date" = 0D then
                        //   ObjStandingOrders."Next Run Date" := ObjStandingOrders."Effective/Start Date";

                        //ObjStandingOrders.CALCFIELDS("Allocated Amount");
                        if RunningBalance >= ObjStandingOrders.Amount then begin
                            AmountToDeduct := ObjStandingOrders.Amount;
                            DedStatus := Dedstatus::Successfull;
                            if AmountToDeduct >= ObjStandingOrders.Balance then begin
                                AmountToDeduct := ObjStandingOrders.Balance;
                                ObjStandingOrders.Balance := 0;
                                //  ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                                ObjStandingOrders.Unsuccessfull := false;
                            end
                            else begin
                                ObjStandingOrders.Balance := ObjStandingOrders.Balance - AmountToDeduct;
                                ObjStandingOrders.Unsuccessfull := true;
                            end;
                        end
                        else begin
                            if ObjStandingOrders."Don't Allow Partial Deduction" = true then begin
                                AmountToDeduct := 0;
                                DedStatus := Dedstatus::Failed;
                                ObjStandingOrders.Balance := ObjStandingOrders.Amount;
                                ObjStandingOrders.Unsuccessfull := true;
                            end
                            else begin
                                DedStatus := Dedstatus::"Partial Deduction";
                                ObjStandingOrders.Balance := ObjStandingOrders.Amount - AmountToDeduct;
                                ObjStandingOrders.Unsuccessfull := true;
                            end;
                        end;



                        //if ObjStandingOrders."Destination Account Type" <> ObjStandingOrders."destination account type"::"Other Banks Account" then
                        // RunningBalance := FnNonBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                        // else begin
                        RunningBalance := FnBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance);
                        //end;


                        ObjStandingOrders.Effected := true;
                        ObjStandingOrders."Date Reset" := Today;
                        //ObjStandingOrders."Next Run Date" := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 2), Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 3))));
                        ObjStandingOrders.Modify;

                        FnRegisterProcessedStandingOrder(ObjStandingOrders, AmountToDeduct);
                    end;
                until ObjStandingOrders.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
        LoanApp: record "Loans Register";
    begin
        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                repeat
                    if ObjReceiptTransactions."Account Type" = ObjReceiptTransactions."Account Type"::Member then begin
                        if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::Repayment then begin
                            //-------------RECOVER principal-----------------------
                            if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", WorkDate, (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") * -1,
                                'FOSA', ObjRcptBuffer."No.", 'STO Recovery ', ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                //-------------PAY Principal----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", WorkDate,
                                ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                 ObjReceiptTransactions."Loan Product Name" + ' STO Recovery Salary', '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                RunningBalance := RunningBalance - (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");

                                //-------------RECOVER Interest-----------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", WorkDate, ObjReceiptTransactions."Interest Amount" * -1,
                                'FOSA', ObjRcptBuffer."No.", ' STO Recovery Salary', ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                //-------------PAY Interest----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", WorkDate,
                                ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                ' STO Recovery Salary', '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                RunningBalance := RunningBalance - ObjReceiptTransactions."Interest Amount";
                            end;

                        end
                        else begin
                            //-------------RECOVER BOSA NONLoan Transactions-----------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                            GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", WorkDate, ObjReceiptTransactions.Amount * -1,
                            'FOSA', ObjRcptBuffer."No.", ' STO Recovery Salary', '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                            //-------------PAY BOSA NONLoan Transaction----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", WorkDate, ObjReceiptTransactions.Amount,
                            'FOSA', ObjRcptBuffer."No.", ' STO Recovery Salary', '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                            RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;

                        end;
                    end else begin
                        if ObjReceiptTransactions."Account Type" = ObjReceiptTransactions."Account Type"::Vendor then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                            GenJournalLine."account type"::Vendor, ObjReceiptTransactions."Member No", WorkDate, ObjReceiptTransactions.Amount * -1,
                            'FOSA', ObjRcptBuffer."No.", ' STO Recovery Salary', '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                            //-------------PAY BOSA NONLoan Transaction----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", WorkDate, ObjReceiptTransactions.Amount,
                            'FOSA', ObjRcptBuffer."No.", ' STO Recovery Salary', '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                            RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;
                        end;

                    end;

                until ObjReceiptTransactions.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRegisterProcessedStandingOrder(ObjStandingOrders: Record "Standing Orders"; AmountToDeduct: Decimal)
    begin
        ObjSTORegister.Reset;
        ObjSTORegister.SetRange("Document No.", DOCUMENT_NO);
        if ObjSTORegister.Find('-') then
            ObjSTORegister.DeleteAll;

        ObjSTORegister.Init;
        ObjSTORegister."Register No." := '';
        ObjSTORegister.Validate(ObjSTORegister."Register No.");
        ObjSTORegister."Standing Order No." := ObjStandingOrders."No.";
        ObjSTORegister."Source Account No." := ObjStandingOrders."Source Account No.";
        ObjSTORegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
        ObjSTORegister.Date := Today;
        ObjSTORegister."Account Name" := ObjStandingOrders."Account Name";
        ObjSTORegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
        ObjSTORegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
        ObjSTORegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
        ObjSTORegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
        ObjSTORegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
        ObjSTORegister."End Date" := ObjStandingOrders."End Date";
        ObjSTORegister.Duration := ObjStandingOrders.Duration;
        ObjSTORegister.Frequency := ObjStandingOrders.Frequency;
        ObjSTORegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
        ObjSTORegister."Deduction Status" := DedStatus;
        ObjSTORegister.Remarks := ObjStandingOrders."Standing Order Description";
        ObjSTORegister.Amount := ObjStandingOrders.Amount;
        ObjSTORegister."Amount Deducted" := AmountToDeduct;
        if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Member Account" then
            ObjSTORegister.EFT := true;
        ObjSTORegister."Document No." := DOCUMENT_NO;
        ObjSTORegister.Insert(true);
    end;
}







