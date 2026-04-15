codeunit 50097 "AU Paybill Automations Copy"
{
    trigger OnRun()
    begin
        // UpdateSchedule();
        FnPostPaybillTransaction();
    end;

    var
        myInt: Integer;

    Procedure FnInsertPaybillTransactions(TransID: Code[40]; TransactionType: Code[40]; TransAmount: Decimal; BusinessShortCode: code[40]; BillRefNumber: Code[40]; InvoiceNumber: code[40]; OrgAccountBalance: Decimal; ThirdPartyTransID: Code[40]; MSIDN: Code[40]; FirstName: Text[150]; MiddleName: Text[150]; LastName: Text[150]; Keyword: code[40])
    var
        PaybillTransactions: Record "Paybill Transactions";
    begin
        PaybillTransactions.Init();
        PaybillTransactions.TransID := TransID;
        PaybillTransactions.TransactionType := TransactionType;
        PaybillTransactions.TransTime := CurrentDateTime;
        PaybillTransactions.TransAmount := TransAmount;
        PaybillTransactions.BusinessShortCode := BusinessShortCode;
        PaybillTransactions.BillRefNumber := BillRefNumber;
        PaybillTransactions.InvoiceNumber := InvoiceNumber;
        PaybillTransactions.OrgAccountBalance := OrgAccountBalance;
        PaybillTransactions.ThirdPartyTransID := ThirdPartyTransID;
        PaybillTransactions.MSIDN := MSIDN;
        PaybillTransactions.FirstName := FirstName;
        PaybillTransactions.MiddleName := MiddleName;
        PaybillTransactions.LastName := LastName;
        PaybillTransactions.Status := PaybillTransactions.Status::Pending;
        PaybillTransactions.Keyword := Keyword;
        PaybillTransactions.Insert(true);

        FnPostPaybillTransaction();

        //AUFactory.RecoverMobileLoans();
        UpdateSchedule();
    end;

    Procedure FnInsertPaybillTransactionsMobile(TransID: Code[40]; TransactionType: Code[40]; TransAmount: Decimal; BusinessShortCode: code[40]; BillRefNumber: Code[40]; InvoiceNumber: code[40]; OrgAccountBalance: Decimal; ThirdPartyTransID: Code[40]; MSIDN: Code[40]; FirstName: Text[150]; MiddleName: Text[150]; LastName: Text[150]; Keyword: code[40]; IDNumber: Code[40])
    var
        PaybillTransactions: Record "Paybill Transactions";
    begin
        PaybillTransactions.Init();
        PaybillTransactions.TransID := TransID;
        PaybillTransactions.TransactionType := TransactionType;
        PaybillTransactions.TransTime := CurrentDateTime;
        PaybillTransactions.TransAmount := TransAmount;
        PaybillTransactions.BusinessShortCode := BusinessShortCode;
        PaybillTransactions.BillRefNumber := BillRefNumber;
        PaybillTransactions.InvoiceNumber := InvoiceNumber;
        PaybillTransactions.OrgAccountBalance := OrgAccountBalance;
        PaybillTransactions.ThirdPartyTransID := ThirdPartyTransID;
        PaybillTransactions.MSIDN := MSIDN;
        PaybillTransactions.FirstName := FirstName;
        PaybillTransactions.IDNo := IDNumber;
        PaybillTransactions.MiddleName := MiddleName;
        PaybillTransactions.LastName := LastName;
        PaybillTransactions.Status := PaybillTransactions.Status::Posted;
        PaybillTransactions.Keyword := Keyword;
        PaybillTransactions.Insert(true);
    end;

    Procedure FnPostPaybillTransaction()
    var
        PaybillTransactions: Record "Paybill Transactions";
        Customer: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "SURESTEP FactoryMobile";
        RunBal: Decimal;
        LoansR: Record "Loans Register";
        PenAmount: Decimal;
        IntAmount: Decimal;
        TotalPaid: Decimal;
        TotalPaidSchedule: Decimal;
        Schedule: Record "Loan Repayment Schedule";
        saccoGen: Record "Sacco General Set-Up";
        sto: Record "Standing Orders";
        LoanArrears: Decimal;
        LineNo: Integer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        ObjGenSetup: Record "Sacco General Set-Up";
        Bname: Codeunit "Send Birthday SMS";
        dateCalc: Codeunit "Dates Calculation";
        RunningBalance: Decimal;
        AUSal: Codeunit "Au Factory";
        DOCUMENT_NO: Code[40];
        GenBatches: Record "Gen. Journal Batch";
        LoanProductType: Record "Loan Products Setup";
        stoLines: Record "Receipt Allocation";
        repaySchedule: Record "Loan Repayment Schedule";
        ExciseDutyP: Decimal;
        Vendor: Record Vendor;
        cust: Record Customer;
        salDate: Text[250];
        FosaBal: Decimal;
    begin
        SaccoGen.Get();

        PaybillTransactions.Reset();
        PaybillTransactions.SetCurrentKey(TransTime);
        PaybillTransactions.SetAscending(TransTime, false);
        PaybillTransactions.SetRange(PaybillTransactions.TransID, 'CB0477546_19072025_2');
        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Pending);
        if PaybillTransactions.Find('-') then begin
            repeat
                postingDate := 0D;

                if FnCheckIfExists(PaybillTransactions.TransID) = false then begin
                    DOCUMENT_NO := PaybillTransactions.TransID;
                    postingDate := DT2Date(PaybillTransactions.TransTime);
                    FirstStr := '';
                    SecondStr := '';
                    ParentStr := Format(PaybillTransactions.BillRefNumber);
                    FirstStr := CopyStr(ParentStr, 1, 2);
                    SecondStr := CopyStr(ParentStr, 3, 100);

                    PaybillTransactions.TransType := FirstStr;
                    PaybillTransactions.IDNo := SecondStr;
                    PaybillTransactions.Modify();

                    if ParentStr = '' then exit;
                    // if FirstStr = saccoGen."Bulk Payment Paybill Code" then exit;

                    if PaybillTransactions.MSIDN = saccoGen."Co-Op PaytoFOSA" then begin
                        lastStr := CopyStr(ParentStr, 1, 8);
                        cust.Reset();
                        cust.SetRange("ID No.", lastStr);
                        if cust.Find('-') = false then begin
                            if (CopyStr(lastStr, 8)) = Format(0) then begin
                                lastStr := CopyStr(ParentStr, 1, 7);
                            end;
                        end;
                        FosaBal := 0;

                        PaybillTransactions.IDNo := lastStr;
                        PaybillTransactions.TransType := 'PaytoFOSA';
                        PaybillTransactions.Modify();

                        // salDate:= dateCalc.ConvertDate(CalcDate('<-1M>', Today));
                        salDate := dateCalc.ConvertDate(Today);
                        Customer.Reset();
                        Customer.SetRange("ID No.", lastStr);
                        Customer.SetFilter("Membership Status", '%1|%2', Customer."Membership Status"::Active, Customer."Membership Status"::Dormant);
                        if Customer.Find('-') then begin

                            AUSal.ClearCheckoffData(PaybillTransactions.TransID);
                            Saldetails.Reset();
                            Saldetails.SetRange(Saldetails."Document Number", DOCUMENT_NO);
                            if Saldetails.FindSet() then begin
                                Saldetails.DeleteAll();
                            end;
                            SalNo := 0;
                            Sal.Reset();
                            if Sal.FindLast() then
                                SalNo := Sal."Entry No" + 1
                            else
                                SalNo := 1;

                            BATCH_TEMPLATE := 'GENERAL';
                            BATCH_NAME := 'PAY2FOSA';

                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.FindSet() then begin
                                GenJournalLine.DELETEALL;
                            end;
                            Error('lastStr%1', Customer."Ordinary Savings Acc");
                            /*                             GenBatches.Reset;
                                                        GenBatches.SetRange(GenBatches."Journal Template Name", BATCH_TEMPLATE);
                                                        GenBatches.SetRange(GenBatches.Name, BATCH_NAME);
                                                        if GenBatches.Find('-') = false then begin
                                                            GenBatches.Init;
                                                            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
                                                            GenBatches.Name := BATCH_NAME;
                                                            GenBatches.Insert;
                                                        end; */


                            //Vendor.Reset();
                            if Vendor.Get(Customer."Ordinary Savings Acc") then begin
                                FosaBal := Vendor.GetAvailableBalance();

                                if PaybillTransactions.TransAmount <= 1000 then begin
                                    LineNo := LineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, PaybillTransactions.TransAmount * -1, 'FOSA',
                                    EXTERNAL_DOC_NO, 'PaytoFOSA - ' + salDate, '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::" ");

                                    LineNo := LineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."Account Type"::"Bank Account",
                                    'BNK00003', Today, PaybillTransactions.TransAmount, 'FOSA', EXTERNAL_DOC_NO, 'PaytoFOSA-' + PaybillTransactions.TransID, '', GenJournalLine."application source"::" ");
                                end else begin
                                    LineNo := LineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, PaybillTransactions.TransAmount * -1, 'FOSA',
                                    EXTERNAL_DOC_NO, 'PaytoFOSA - ' + salDate, '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"1-Gross salary");

                                    AUSal.FnInsertSalarydata(PaybillTransactions.TransID, Customer."No.", Customer."Ordinary Savings Acc", 'Gross Salary', PaybillTransactions.TransAmount, PaybillTransactions.TransAmount);

                                    ObjGenSetup.Get();
                                    if ObjGenSetup."Salary Processing Fee" > 0 then begin
                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, ObjGenSetup."Salary Processing Fee", 'FOSA',
                                        EXTERNAL_DOC_NO, 'Salary processing fee - Pay2FOSA', '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
                                        RunningBalance := (PaybillTransactions.TransAmount + FosaBal) - ObjGenSetup."Salary Processing Fee";

                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Today, -ObjGenSetup."Salary Processing Fee", 'FOSA',
                                        EXTERNAL_DOC_NO, 'Salary processing fee - Pay2FOSA', '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");


                                        AUSal.FnInsertSalarydata(PaybillTransactions.TransID, Customer."No.", Customer."Ordinary Savings Acc", 'Salary Processing Fee', ObjGenSetup."Salary Processing Fee", ObjGenSetup."Salary Processing Fee");

                                        ExciseDutyP := ROUND((ObjGenSetup."Salary Processing Fee" * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, ExciseDutyP, 'FOSA',
                                        EXTERNAL_DOC_NO, 'Excise Duty on salary - Pay2FOSA', '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

                                        LineNo := LineNo + 10000;
                                        AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Today, -ExciseDutyP, 'FOSA',
                                        EXTERNAL_DOC_NO, 'Excise Duty on salary - Pay2FOSA', '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

                                        AUSal.FnInsertSalarydata(PaybillTransactions.TransID, Customer."No.", Customer."Ordinary Savings Acc", 'Salary Processing Fee', ExciseDutyP, ExciseDutyP);
                                        RunningBalance := RunningBalance - ExciseDutyP;
                                    end;

                                    LineNo := LineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."Account Type"::"Bank Account",
                                    'BNK00003', Today, PaybillTransactions.TransAmount, 'FOSA', EXTERNAL_DOC_NO, 'PaytoFOSA-' + PaybillTransactions.TransID, '', GenJournalLine."application source"::" ");

                                    LoansR.Reset();
                                    LoansR.SetRange("Client Code", Customer."No.");
                                    LoansR.SetFilter("Recovery Mode", '%1|%2', LoansR."Recovery Mode"::PaytoFOSA, LoansR."Recovery Mode"::Salary);
                                    LoansR.SetAutoCalcFields("Total Outstanding Balance");
                                    LoansR.SetFilter("Total Outstanding Balance", '>%1', 0);
                                    LoansR.SetRange(Posted, true);
                                    if LoansR.FindSet() then begin
                                        repeat
                                            if AUSal.CheckIfScheduleIsGenerated(LoansR."Loan  No.") = false then begin
                                                AUSal.FnGenerateLoanRepaymentSchedule(LoansR."Loan  No.");

                                            end;
                                            principleRepay := 0;
                                            repaySchedule.Reset();
                                            repaySchedule.SetCurrentKey("Loan No.");
                                            repaySchedule.SetAscending("Repayment Date", true);
                                            repaySchedule.SetRange("Loan No.", LoansR."Loan  No.");
                                            repaySchedule.SetFilter("Repayment Date", '<=%1', Today);
                                            if repaySchedule.FindLast() then begin
                                                principleRepay := repaySchedule."Principal Repayment";
                                            end;
                                            LoansR.CalcFields("Total Outstanding Balance");
                                            // if RunningBalance > (principleRepay + LoansR."Outstanding Interest") then begin
                                            EXTERNAL_DOC_NO := LoansR."Loan  No.";
                                            LoanProductType.Reset();
                                            if LoanProductType.Get(LoansR."Loan Product Type") then begin//
                                                loanProduct := LoanProductType."Product Description";
                                            end;
                                            LoansR.CalcFields("Outstanding Balance", "Outstanding Interest");
                                            if LoansR."Outstanding Interest" > 0 then begin
                                                LineNo := LineNo + 10000;
                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                                GenJournalLine."account type"::Customer, Customer."No.", Today, -LoansR."Outstanding Interest", 'BOSA',
                                                EXTERNAL_DOC_NO, 'Interest Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
                                                Customer."No.", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");
                                                LineNo := LineNo + 10000;
                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, LoansR."Outstanding Interest", 'FOSA',
                                                EXTERNAL_DOC_NO, 'Interest Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
                                                Customer."No.", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");

                                                AUSal.FnInsertSalarydata(PaybillTransactions.TransID, Customer."No.", Customer."Ordinary Savings Acc", 'Interest Paid', LoansR."Outstanding Interest", LoansR."Outstanding Interest");
                                                RunningBalance := RunningBalance - LoansR."Outstanding Interest";
                                            end;

                                            if (RunningBalance > 0) and (LoansR."Outstanding Balance" > 0) then begin
                                                PrincRepay := 0;
                                                if RunningBalance > principleRepay then
                                                    PrincRepay := principleRepay
                                                else
                                                    PrincRepay := RunningBalance;
                                                LineNo := LineNo + 10000;
                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                                GenJournalLine."account type"::Customer, Customer."No.", Today, -PrincRepay, 'BOSA',
                                                EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
                                                Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                                LineNo := LineNo + 10000;
                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, PrincRepay, 'FOSA',
                                                EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
                                                Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

                                                AUSal.FnInsertSalarydata(PaybillTransactions.TransID, Customer."No.", Customer."Ordinary Savings Acc", 'Repayment', PrincRepay, LoansR."Outstanding Balance");
                                                RunningBalance := RunningBalance - PrincRepay;
                                            end;
                                            /*                                             if RunningBalance > principleRepay then begin


                                                                                            if principleRepay > LoansR."Outstanding Balance" then begin
                                                                                                LineNo := LineNo + 10000;
                                                                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                                                                                GenJournalLine."account type"::Customer, Customer."No.", Today, -LoansR."Outstanding Balance", 'BOSA',
                                                                                                EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
                                                                                                Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                                                                                LineNo := LineNo + 10000;
                                                                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                                                                GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, LoansR."Outstanding Balance", 'FOSA',
                                                                                                EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
                                                                                                Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

                                                                                                AUSal.FnInsertSalarydata(PaybillTransactions.TransID, Customer."No.", Customer."Ordinary Savings Acc", 'Repayment', LoansR."Outstanding Balance", LoansR."Outstanding Balance");
                                                                                                RunningBalance := RunningBalance - LoansR."Outstanding Balance";
                                                                                            end else begin
                                                                                                LineNo := LineNo + 10000;
                                                                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                                                                                GenJournalLine."account type"::Customer, Customer."No.", Today, -principleRepay, 'BOSA',
                                                                                                EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
                                                                                                Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                                                                                LineNo := LineNo + 10000;
                                                                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                                                                GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, principleRepay, 'FOSA',
                                                                                                EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
                                                                                                Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

                                                                                                AUSal.FnInsertSalarydata(PaybillTransactions.TransID, Customer."No.", Customer."Ordinary Savings Acc", 'Repayment', principleRepay, principleRepay);
                                                                                                RunningBalance := RunningBalance - principleRepay;
                                                                                            end;
                                                                                        end; */
                                            // end;
                                            if LoansR."Recovery Mode" = LoansR."Recovery Mode"::Salary then begin
                                                LoansR."Recovery Mode" := LoansR."Recovery Mode"::PaytoFosa;
                                                LoansR.Modify;
                                            end;
                                        until LoansR.Next() = 0;
                                    end;
                                    sto.Reset();
                                    sto.SetRange("BOSA Account No.", Customer."No.");
                                    sto.SetRange(Status, sto.Status::Approved);
                                    sto.SetRange("Is Active", true);
                                    sto.SetRange("Standing Order Dedution Type", sto."Standing Order Dedution Type"::PaytoFOSA);
                                    // sto.SetFilter("Next Run Date", '<=%1', Today);
                                    sto.SetFilter("Effective/Start Date", '<=%1', Today);
                                    if sto.Find('-') then begin
                                        repeat
                                            stoLines.Reset();
                                            stoLines.SetRange("Document No", sto."No.");
                                            if stoLines.Find('-') then begin
                                                sto.CalcFields("Allocated Amount");
                                                EXTERNAL_DOC_NO := sto."No.";
                                                if sto."Allocated Amount" < RunningBalance then begin
                                                    repeat
                                                        if stoLines."STO Account Type" = stoLines."STO Account Type"::Member then begin
                                                            if stoLines."Transaction Type" = stoLines."Transaction Type"::" " then begin
                                                                LineNo := LineNo + 10000;
                                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                                GenJournalLine."account type"::Customer, Customer."No.", Today, -stoLines.Amount, 'BOSA',
                                                                EXTERNAL_DOC_NO, 'BBF Contribution - Pay2FOSA', '', GenJournalLine."application source"::" ",
                                                                    Customer."No.", GenJournalLine."Salary Receipt Type"::"6-STO");
                                                                LineNo := LineNo + 10000;
                                                                AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                                GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, stoLines.Amount, 'BOSA',
                                                                EXTERNAL_DOC_NO, 'BBF Contribution - Pay2FOSA', '', GenJournalLine."application source"::" ",
                                                                    Customer."No.", GenJournalLine."Salary Receipt Type"::"6-STO");
                                                            end;
                                                        end else if stoLines."STO Account Type" = stoLines."STO Account Type"::"FOSA Account" then begin
                                                            accountType := getAccountType(stoLines."Member No");
                                                            LineNo := LineNo + 10000;
                                                            AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                            GenJournalLine."account type"::Vendor, stoLines."Member No", Today, -stoLines.Amount, 'FOSA',
                                                            EXTERNAL_DOC_NO, accountType + ' Contribution - Pay2FOSA', '', GenJournalLine."application source"::" ",
                                                            Customer."No.", GenJournalLine."Salary Receipt Type"::"6-STO");
                                                            LineNo := LineNo + 10000;
                                                            AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                            GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, stoLines.Amount, 'FOSA',
                                                            EXTERNAL_DOC_NO, accountType + ' Contribution - Pay2FOSA', '', GenJournalLine."application source"::" ",
                                                            Customer."No.", GenJournalLine."Salary Receipt Type"::"6-STO");
                                                        end;
                                                        sto."Next Run Date" := CalcDate('<1M>', Today);
                                                        sto.Effected := true;
                                                        sto."Date Reset" := Today;
                                                        sto.Modify;
                                                        DedStatus := DedStatus::Successfull;
                                                        FnRegisterProcessedStandingOrder(sto, DOCUMENT_NO, sto."Allocated Amount", DedStatus);

                                                        AUSal.FnInsertSalarydata(PaybillTransactions.TransID, Customer."No.", Customer."Ordinary Savings Acc", 'Standing Order', sto."Allocated Amount", sto."Allocated Amount");
                                                        RunningBalance := RunningBalance - sto."Allocated Amount";
                                                    until stoLines.Next() = 0;
                                                end else begin
                                                    DedStatus := DedStatus::Failed;
                                                    FnRegisterProcessedStandingOrder(sto, DOCUMENT_NO, sto."Allocated Amount", DedStatus);
                                                end;
                                            end;
                                        until sto.Next() = 0;
                                    end;
                                    Saldetails.Init();
                                    Saldetails."Entry No" := SalNo;
                                    Saldetails."FOSA Account No" := Customer."Ordinary Savings Acc";
                                    Saldetails."Net Salary" := RunningBalance;
                                    Saldetails."Gross Amount" := PaybillTransactions.TransAmount;
                                    Saldetails."Posting Date" := Today;
                                    Saldetails.Validate("Posting Date");
                                    Saldetails."Document Number" := PaybillTransactions.TransID;
                                    Saldetails."Salary Type" := salType::Salary;
                                    Saldetails."Member No" := Customer."No.";
                                    Saldetails."Payroll No" := Customer."Payroll No";
                                    Saldetails."Member Name" := Customer.Name;
                                    if not Saldetails.Insert(true) then Saldetails.Modify(true);
                                    SalNo := SalNo + 1;
                                end;
                            end;

                            //Post New
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;

                            PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                            PaybillTransactions.Modify();

                            if Customer."Mobile Phone No" <> '' then begin
                                SMSstr := 'Dear ' + Bname.NameStyle(Customer."No.") + ', your cash amount of Ksh.' + Format(PaybillTransactions.TransAmount) + ' has been posted to your FOSA on ' + Format(PaybillTransactions.TransTime) + '. "A penny saved is a penny earned."';
                                smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Customer."Mobile Phone No", SMSstr, Customer."No.", Customer."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                            end;
                        end;
                    end else begin
                        bizPhoneNo := '';
                        bizPhoneName := '';
                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'PAYBILL';

                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.FindSet() then begin
                            GenJournalLine.DELETEALL;
                        end;

                        if FirstStr = 'BS' then begin
                            Vendor.Reset();
                            Vendor.SetRange("Business Short Code(Store)", ParentStr);
                            if Vendor.Find('-') then begin
                                SecondStr := Vendor."ID No.";
                                bizPhoneNo := Vendor."Business Phone(Store)";
                                bizPhoneName := Vendor."Business Name(Store)";
                                PaybillTransactions.IDNo := SecondStr;
                                PaybillTransactions."Paybill Dest No" := bizPhoneNo;
                                PaybillTransactions."Paybill BST" := true;
                                PaybillTransactions.Modify();
                            end;
                        end;

                        if (FirstStr <> 'LN') or (FirstStr <> 'FL') then begin
                            cust.Reset();
                            cust.SetRange("No.", SecondStr);
                            if cust.Find('-') then begin
                                PaybillTransactions.IDNo := cust."ID No.";
                                PaybillTransactions.Modify();
                            end;
                        end;

                        Customer.Reset();
                        Customer.SetRange(Customer."ID No.", PaybillTransactions.IDNo);
                        Customer.SetRange("Membership Status", Customer."Membership Status"::Active);
                        if Customer.FindFirst() then begin
                            //Balancing Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Bank Account", 'BNK00010', postingDate, PaybillTransactions.TransAmount, 'FOSA', DOCUMENT_NO,
                            'Paybill Deposit' + ' ' + PaybillTransactions.TransID, '');

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                            'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');
                            ChargeAmount := 0;

                            GraduatedCharge.Reset;
                            if GraduatedCharge.Find('-') then begin
                                repeat
                                    if (PaybillTransactions.TransAmount >= GraduatedCharge."Min Band") and (PaybillTransactions.TransAmount <= GraduatedCharge."Upper Band") then begin

                                        if GraduatedCharge."Use Percentage" = true then begin
                                            PercentageGra := 0;
                                            Evaluate(PercentageGra, GraduatedCharge.Percentage);
                                            VendorComm := 0;
                                            ChargeAmount := 0;
                                            ExciseDuty := 0;
                                            MpesaComm := 0;
                                            TotalAmount := 0;
                                            ChargeAmount := GraduatedCharge.Total;
                                            VendorComm := PaybillTransactions.TransAmount * PercentageGra / 100;
                                            SaccoCommission := GraduatedCharge."Sacco Comm";
                                            MpesaComm := GraduatedCharge.Mpesa;
                                            ExciseDuty := GraduatedCharge."Excise Duty";
                                            TotalAmount := GraduatedCharge."Sacco Comm" + VendorComm;
                                            MpesaCommAccount := GraduatedCharge."Mpesa Account";
                                            VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                                            SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                                        end else begin
                                            VendorComm := 0;
                                            ChargeAmount := 0;
                                            ExciseDuty := 0;
                                            MpesaComm := 0;
                                            TotalAmount := 0;
                                            ChargeAmount := GraduatedCharge.Total;
                                            VendorComm := GraduatedCharge."Vendor Comm";
                                            SaccoCommission := GraduatedCharge."Sacco Comm";
                                            MpesaComm := GraduatedCharge.Mpesa;
                                            ExciseDuty := GraduatedCharge."Excise Duty";
                                            TotalAmount := GraduatedCharge.Total;
                                            MpesaCommAccount := GraduatedCharge."Mpesa Account";
                                            VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                                            SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                                        end;
                                    end;
                                until GraduatedCharge.Next = 0;
                                NetCharges := 0;
                                NetCharges := PaybillTransactions.TransAmount - TotalAmount;
                            end;

                            Vendor.Reset();
                            Vendor.SetRange(Vendor."No.", Customer."FOSA Account No.");
                            if Vendor.FindFirst() then begin
                                Vendor.CalcFields(Vendor.Balance);
                                MBuffer.Reset();
                                MBuffer.SetRange(MBuffer."Vendor No", Customer."FOSA Account No.");
                                MBuffer.SetRange(MBuffer.Posted, false);
                                MBuffer.SetRange(MBuffer.Reversed, false);
                                if MBuffer.FindSet() then begin
                                    MBuffer.CalcSums(MBuffer."Amount Requested");
                                    PendingAmount := MBuffer."Amount Requested";
                                end;
                                AvailableBalance := 0;
                                // AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Frozen Amount");
                                AvailableBalance := Vendor.GetAvailableBalance();
                            end;

                            accountType := '';
                            accountTypename := '';
                            FOSAPaybillCode := '';
                            accTypes.Reset();
                            accTypes.SetRange("Paybill Code", FirstStr);
                            if accTypes.Find('-') then begin
                                accountType := accTypes.Code;
                                accountTypename := accTypes.Description + ' Contribution';

                                if FirstStr = 'BS' then begin
                                    Vendor.Reset();
                                    Vendor.SetRange("BOSA Account No", Customer."No.");
                                    Vendor.SetRange("Account Type", '111');
                                    if Vendor.Find('-') then begin
                                        accountTypename := 'To ' + Vendor."Business Name(Store)";
                                    end;
                                end;
                                FOSAPaybillCode := accTypes."Paybill Code";
                            end;

                            saccoGen.Get();
                            if saccoGen."Reg Fee Paybill Code" = FirstStr then begin
                                Vendor.Reset();
                                Vendor.SetRange("BOSA Account No", Customer."No.");
                                Vendor.SetRange("Account Type", '102');
                                if Vendor.FindFirst() then begin
                                    if AvailableBalance >= TotalAmount then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, PaybillTransactions.TransAmount, '', DOCUMENT_NO,
                                        'Paybill Registration Fee Payment ' + ' ' + PaybillTransactions.TransID, '');

                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Registration Fee",
                                        GenJournalLine."Account Type"::Customer, Customer."No.", postingDate, PaybillTransactions.TransAmount * -1, '', DOCUMENT_NO,
                                        'Paybill Registration Fee Payment ' + ' ' + PaybillTransactions.TransID, '');
                                    end;
                                    if AvailableBalance < TotalAmount then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, NetCharges, '', DOCUMENT_NO,
                                        'Paybill Registration Fee Payment ' + ' ' + PaybillTransactions.TransID, '');

                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Registration Fee",
                                        GenJournalLine."Account Type"::Customer, Customer."No.", postingDate, NetCharges * -1, '', DOCUMENT_NO,
                                        'Paybill Registration Fee Payment ' + ' ' + PaybillTransactions.TransID, '');
                                    end;
                                end;
                            end;

                            if FirstStr = FOSAPaybillCode then begin
                                Vendor.Reset();
                                Vendor.SetRange(Vendor."BOSA Account No", Customer."No.");
                                Vendor.SetRange(Vendor."Account Type", accountType);
                                if Vendor.FindFirst() then begin
                                    if AvailableBalance >= TotalAmount then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, PaybillTransactions.TransAmount, '', DOCUMENT_NO,
                                        'Paybill ' + accountTypename + '-' + PaybillTransactions.TransID, '');

                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Vendor."No.", postingDate, PaybillTransactions.TransAmount * -1, '', DOCUMENT_NO,
                                        'Paybill ' + accountTypename + '-' + PaybillTransactions.TransID, '');
                                    end;
                                    if AvailableBalance < TotalAmount then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, NetCharges, '', DOCUMENT_NO,
                                        'Paybill ' + accountTypename + '-' + PaybillTransactions.TransID, '');

                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Vendor."No.", postingDate, NetCharges * -1, '', DOCUMENT_NO,
                                        'Paybill ' + accountTypename + '-' + PaybillTransactions.TransID, '');
                                    end;
                                end;
                            end;


                            if FirstStr = 'BF' then begin
                                if AvailableBalance >= TotalAmount then begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, PaybillTransactions.TransAmount, '', DOCUMENT_NO,
                                    'Paybill BBF Contribution' + ' ' + PaybillTransactions.TransID, '');
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Customer, Customer."No.", postingDate, PaybillTransactions.TransAmount * -1, '', DOCUMENT_NO,
                                    'Paybill BBF Contribution' + ' ' + PaybillTransactions.TransID, '');
                                end;

                                if AvailableBalance < TotalAmount then begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, NetCharges, '', DOCUMENT_NO,
                                    'Paybill BBF Contribution' + ' ' + PaybillTransactions.TransID, '');
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Customer, Customer."No.", postingDate, NetCharges * -1, '', DOCUMENT_NO,
                                    'Paybill BBF Contribution' + ' ' + PaybillTransactions.TransID, '');
                                end;
                            end;

                            LoanProductType.Reset();
                            LoanProductType.SetRange(LoanProductType."Paybill Code", FirstStr);
                            if LoanProductType.FindFirst() then begin
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, TotalAmount, 'FOSA', DOCUMENT_NO,
                                'Mobile Deposit Charges' + ' ' + Customer."No.", '');

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, VendorCommAccount, postingDate, VendorComm * -1, 'FOSA', DOCUMENT_NO,
                                'Vendor Commission' + ' ' + Customer."No.", '');

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, postingDate, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
                                'Sacco Commission' + ' ' + Customer."No.", '');

                                if AvailableBalance < (PaybillTransactions.TransAmount + TotalAmount) then begin
                                    RunBal := PaybillTransactions.TransAmount - TotalAmount;
                                end else
                                    RunBal := PaybillTransactions.TransAmount;

                                LoansR.reset;
                                LoansR.setrange(LoansR."Client Code", Customer."No.");
                                LoansR.SetRange(LoansR."Loan Product Type", LoanProductType.Code);
                                LoansR.SetAutoCalcFields(LoansR."Total Outstanding Balance");
                                LoansR.SetFilter(LoansR."Total Outstanding Balance", '>%1', 0);
                                if LoansR.FindFirst() then begin

                                    LoansR.CalcFields(LoansR."Outstanding Penalty");
                                    if LoansR."Outstanding Penalty" > 0 then begin
                                        PenAmount := 0;
                                        if RunBal > LoansR."Outstanding Penalty" then
                                            PenAmount := LoansR."Outstanding Penalty"
                                        else
                                            PenAmount := RunBal;
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, PenAmount, '', DOCUMENT_NO,
                                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Loan Penalty Paid"), loansR."Loan  No.");

                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Paid",
                                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", postingDate, PenAmount * -1, 'BOSA', DOCUMENT_NO,
                                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Loan Penalty Paid"), loansR."Loan  No.");
                                        RunBal := RunBal - PenAmount;
                                    end;
                                    LoansR.CalcFields(LoansR."Outstanding Interest");
                                    if LoansR."Outstanding Interest" > 0 then begin
                                        IntAmount := 0;
                                        if RunBal > LoansR."Outstanding Interest" then
                                            IntAmount := LoansR."Outstanding Interest"
                                        else
                                            IntAmount := RunBal;
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, IntAmount, '', DOCUMENT_NO,
                                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.");

                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", postingDate, IntAmount * -1, 'BOSA', DOCUMENT_NO,
                                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.");
                                        RunBal := RunBal - IntAmount;
                                    end;
                                    if RunBal > 0 then begin
                                        LoansR.CalcFields(LoansR."Outstanding Balance");
                                        Excess := 0;
                                        if RunBal > LoansR."Outstanding Balance" then
                                            Excess := LoansR."Outstanding Balance"
                                        else
                                            Excess := RunBal;

                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                        GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, Excess, '', DOCUMENT_NO,
                                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");

                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", postingDate, Excess * -1, 'BOSA', DOCUMENT_NO,
                                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");
                                        RunBal := RunBal - Excess;
                                        // end;
                                    end;

                                    /*                                 if RunBal > 0 then begin
                                                                        LineNo := LineNo + 10000;
                                                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                                        GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", Today, Excess, '', DOCUMENT_NO,
                                                                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");

                                                                        LineNo := LineNo + 10000;
                                                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                                                        GenJournalLine."Account Type"::Customer, Customer."No.", Today, Excess * -1, 'BOSA', DOCUMENT_NO,
                                                                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");
                                                                        RunBal := RunBal - Excess;
                                                                    end; */

                                end;
                            end;

                            //Post New
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'PAYBILL');
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;

                            PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                            PaybillTransactions.Modify();

                            if FirstStr = 'BS' then begin
                                if bizPhoneNo <> '' then begin
                                    SMSstr := 'Dear ' + bizPhoneName + ', you have received Ksh. ' + Format(PaybillTransactions.TransAmount) + ', MPESA REF: ' + PaybillTransactions.ThirdPartyTransID + ' to your account ' + bizPhoneNo + ' from ' + PaybillTransactions.FirstName + '-' + AUFactory.FnMaskString(PaybillTransactions.MSIDN, 7, 5, '*') + ' on ' + Format(PaybillTransactions.TransTime) + '. "A penny saved is a penny earned".';
                                    smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, bizPhoneNo, SMSstr, Customer."No.", Customer."FOSA Account No.", True, 200, True, 'CBS', CreateGuid(), 'CBS');
                                end;
                                if PaybillTransactions.MSIDN <> '' then begin
                                    SMSstr := 'MPESA deposit of Ksh. ' + Format(PaybillTransactions.TransAmount) + ' to ' + bizPhoneName + ' has been received on ' + Format(PaybillTransactions.TransTime) + ', MPESA REF: ' + PaybillTransactions.ThirdPartyTransID + '. "A penny saved is a penny earned".';
                                    smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, PaybillTransactions.MSIDN, SMSstr, Customer."No.", Customer."FOSA Account No.", True, 200, True, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end else begin
                                if Customer."Mobile Phone No" <> '' then begin
                                    postingDateTwo := DT2Date(PaybillTransactions.TransTime);
                                    postingDateTime := DT2Time(PaybillTransactions.TransTime);
                                    SMSstr := 'Dear ' + Bname.NameStyle(Customer."No.") + ', MPESA deposit of Ksh. ' + Format(PaybillTransactions.TransAmount) + ' has been received on ' + Format(postingDateTwo) + ' ' + Format(postingDateTime) + '. "A penny saved is a penny earned"';
                                    smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Customer."Mobile Phone No", SMSstr, Customer."No.", Customer."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;
                        end else begin
                            ChargeAmount := 0;
                            GraduatedCharge.Reset;
                            if GraduatedCharge.Find('-') then begin
                                repeat
                                    if (PaybillTransactions.TransAmount >= GraduatedCharge."Min Band") and (PaybillTransactions.TransAmount <= GraduatedCharge."Upper Band") then begin

                                        if GraduatedCharge."Use Percentage" = true then begin
                                            PercentageGra := 0;
                                            Evaluate(PercentageGra, GraduatedCharge.Percentage);
                                            VendorComm := 0;
                                            ChargeAmount := 0;
                                            ExciseDuty := 0;
                                            MpesaComm := 0;
                                            TotalAmount := 0;
                                            ChargeAmount := GraduatedCharge.Total;
                                            VendorComm := PaybillTransactions.TransAmount * PercentageGra / 100;
                                            SaccoCommission := GraduatedCharge."Sacco Comm";
                                            MpesaComm := GraduatedCharge.Mpesa;
                                            ExciseDuty := GraduatedCharge."Excise Duty";
                                            TotalAmount := GraduatedCharge."Sacco Comm" + VendorComm;
                                            MpesaCommAccount := GraduatedCharge."Mpesa Account";
                                            VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                                            SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                                        end else begin
                                            VendorComm := 0;
                                            ChargeAmount := 0;
                                            ExciseDuty := 0;
                                            MpesaComm := 0;
                                            TotalAmount := 0;
                                            ChargeAmount := GraduatedCharge.Total;
                                            VendorComm := GraduatedCharge."Vendor Comm";
                                            SaccoCommission := GraduatedCharge."Sacco Comm";
                                            MpesaComm := GraduatedCharge.Mpesa;
                                            ExciseDuty := GraduatedCharge."Excise Duty";
                                            TotalAmount := GraduatedCharge.Total;
                                            MpesaCommAccount := GraduatedCharge."Mpesa Account";
                                            VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                                            SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                                        end;
                                    end;
                                until GraduatedCharge.Next = 0;
                                NetCharges := 0;
                                NetCharges := PaybillTransactions.TransAmount - TotalAmount;
                            end;

                            LoansR.reset;
                            LoansR.setrange(LoansR."Loan  No.", ParentStr);
                            LoansR.SetAutoCalcFields(LoansR."Total Outstanding Balance");
                            LoansR.SetFilter(LoansR."Total Outstanding Balance", '>%1', 0);
                            if LoansR.FindFirst() then begin
                                Cust.Get(LoansR."Client Code");

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"Bank Account", 'BNK00010', postingDate, PaybillTransactions.TransAmount, 'FOSA', DOCUMENT_NO,
                                'Paybill Deposit' + ' ' + PaybillTransactions.TransID, '');

                                if cust."FOSA Account No." = '' then begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."Ordinary Savings Acc", postingDate, PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                                    'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');
                                end else begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                                    'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');
                                end;

                                //Check Balance
                                Vendor.Reset();
                                Vendor.SetRange(Vendor."No.", Cust."FOSA Account No.");
                                if Vendor.FindFirst() then begin
                                    Vendor.CalcFields(Vendor.Balance);
                                    MBuffer.Reset();
                                    MBuffer.SetRange(MBuffer."Vendor No", Cust."FOSA Account No.");
                                    MBuffer.SetRange(MBuffer.Posted, false);
                                    MBuffer.SetRange(MBuffer.Reversed, false);
                                    if MBuffer.FindSet() then begin
                                        MBuffer.CalcSums(MBuffer."Amount Requested");
                                        PendingAmount := MBuffer."Amount Requested";
                                    end;
                                    AvailableBalance := 0;
                                    // AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PaybillTransactions.TransAmount + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Frozen Amount");
                                    AvailableBalance := Vendor.GetAvailableBalance();

                                    if AvailableBalance + PaybillTransactions.TransAmount <= 0 then begin
                                        AvailableBalance := 0;
                                    end else begin
                                        AvailableBalance := AvailableBalance + PaybillTransactions.TransAmount;
                                    end;
                                end;

                                RunBal := 0;

                                // LineNo := LineNo + 10000;
                                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                // GenJournalLine."Account Type"::Vendor, Customer."FOSA Account No.", postingDate, TotalAmount, 'FOSA', DOCUMENT_NO,
                                // 'Mobile Deposit Charges' + ' ' + Cust."No.", '');

                                // LineNo := LineNo + 10000;
                                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                // GenJournalLine."Account Type"::Vendor, VendorCommAccount, postingDate, VendorComm * -1, 'FOSA', DOCUMENT_NO,
                                // 'Vendor Commission' + ' ' + Cust."No.", '');

                                // LineNo := LineNo + 10000;
                                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                // GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, postingDate, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
                                // 'Sacco Commission' + ' ' + Cust."No.", '');

                                if AvailableBalance > PaybillTransactions.TransAmount then
                                    RunBal := PaybillTransactions.TransAmount
                                else
                                    RunBal := AvailableBalance;

                                ChargeAmount := 0;
                                LoansR.CalcFields(LoansR."Outstanding Penalty");
                                if LoansR."Outstanding Penalty" > 0 then begin
                                    PenAmount := 0;
                                    if RunBal > LoansR."Outstanding Penalty" then
                                        PenAmount := LoansR."Outstanding Penalty"
                                    else
                                        PenAmount := RunBal;

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, PenAmount, '', DOCUMENT_NO,
                                    DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Loan Penalty Paid"), loansR."Loan  No.");

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Paid",
                                    GenJournalLine."Account Type"::Customer, LoansR."Client Code", postingDate, PenAmount * -1, 'BOSA', DOCUMENT_NO,
                                    DOCUMENT_NO + ' Paybill ' + LoansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Loan Penalty Paid"), loansR."Loan  No.");
                                    RunBal := RunBal - PenAmount;
                                end;
                                LoansR.CalcFields(LoansR."Outstanding Interest");
                                if LoansR."Outstanding Interest" > 0 then begin
                                    IntAmount := 0;
                                    if RunBal > LoansR."Outstanding Interest" then
                                        IntAmount := LoansR."Outstanding Interest"
                                    else
                                        IntAmount := RunBal;
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, IntAmount, '', DOCUMENT_NO,
                                    DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.");

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                    GenJournalLine."Account Type"::Customer, LoansR."Client Code", postingDate, IntAmount * -1, 'BOSA', DOCUMENT_NO,
                                    DOCUMENT_NO + ' Paybill ' + LoansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.");
                                    RunBal := RunBal - IntAmount;
                                end;
                                if RunBal > 0 then begin
                                    LoansR.CalcFields(LoansR."Outstanding Balance");
                                    Excess := 0;
                                    if RunBal > LoansR."Outstanding Balance" then
                                        Excess := LoansR."Outstanding Balance"
                                    else
                                        Excess := RunBal;

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, Excess, '', DOCUMENT_NO,
                                    DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                    GenJournalLine."Account Type"::Customer, LoansR."Client Code", postingDate, Excess * -1, 'BOSA', DOCUMENT_NO,
                                    DOCUMENT_NO + ' Paybill ' + LoansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");
                                    RunBal := RunBal - Excess;
                                    // end;
                                end;

                                // Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'PAYBILL');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                end;

                                PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                                PaybillTransactions.Modify();
                                if Cust."Mobile Phone No" <> '' then begin
                                    SMSstr := 'Dear ' + Bname.NameStyle(Cust."No.") + ', MPESA deposit of ' + Format(PaybillTransactions.TransAmount) + ' has been received on ' + Format(PaybillTransactions.TransTime) + ' ."A penny saved is a penny earned"';
                                    smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Cust."Mobile Phone No", SMSstr, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;

                            Cust.Reset();
                            Cust.SetRange(Cust."ID No.", ParentStr);
                            if Cust.FindFirst() then begin

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"Bank Account", 'BNK00010', postingDate, PaybillTransactions.TransAmount, 'FOSA', DOCUMENT_NO,
                                'Paybill Deposit' + ' ' + PaybillTransactions.TransID, '');

                                if cust."FOSA Account No." = '' then begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."Ordinary Savings Acc", postingDate, PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                                    'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');
                                end else begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                                    'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');
                                end;

                                //Check Balance
                                Vendor.Reset();
                                Vendor.SetRange(Vendor."No.", Cust."FOSA Account No.");
                                if Vendor.FindFirst() then begin
                                    Vendor.CalcFields(Vendor.Balance);
                                    MBuffer.Reset();
                                    MBuffer.SetRange(MBuffer."Vendor No", Cust."FOSA Account No.");
                                    MBuffer.SetRange(MBuffer.Posted, false);
                                    MBuffer.SetRange(MBuffer.Reversed, false);
                                    if MBuffer.FindSet() then begin
                                        MBuffer.CalcSums(MBuffer."Amount Requested");
                                        PendingAmount := MBuffer."Amount Requested";
                                    end;
                                    AvailableBalance := 0;
                                    AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PaybillTransactions.TransAmount + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Frozen Amount");
                                end;

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, TotalAmount, 'FOSA', DOCUMENT_NO,
                                'Mobile Deposit Charges' + ' ' + Cust."No.", '');

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, VendorCommAccount, postingDate, VendorComm * -1, 'FOSA', DOCUMENT_NO,
                                'Vendor Commission' + ' ' + Cust."No.", '');

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, postingDate, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
                                'Sacco Commission' + ' ' + Cust."No.", '');

                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'PAYBILL');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                end;

                                PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                                PaybillTransactions.Modify();
                                if Cust."Mobile Phone No" <> '' then begin
                                    SMSstr := 'Dear ' + Bname.NameStyle(Cust."No.") + ', MPESA deposit of ' + Format(PaybillTransactions.TransAmount) + ' has been received on ' + Format(PaybillTransactions.TransTime) + ' ."A penny saved is a penny earned"';
                                    smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Cust."Mobile Phone No", SMSstr, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;

                            vend.Reset();
                            vend.SetRange("No.", ParentStr);
                            if vend.FindFirst() then begin

                                cust.Get(Vend."BOSA Account No");
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"Bank Account", 'BNK00010', postingDate, PaybillTransactions.TransAmount, 'FOSA', DOCUMENT_NO,
                                'Paybill Deposit' + ' ' + PaybillTransactions.TransID, '');

                                if cust."FOSA Account No." = '' then begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."Ordinary Savings Acc", postingDate, PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                                    'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."Ordinary Savings Acc", postingDate, PaybillTransactions.TransAmount, 'BOSA', DOCUMENT_NO,
                                    'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');
                                end else begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                                    'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, PaybillTransactions.TransAmount, 'BOSA', DOCUMENT_NO,
                                    'Paybill Credit FOSA' + ' ' + PaybillTransactions.TransID, '');
                                end;

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, ParentStr, postingDate, PaybillTransactions.TransAmount * -1, 'FOSA', DOCUMENT_NO,
                                'Paybill Deposit' + ' ' + PaybillTransactions.TransID, '');

                                //Check Balance
                                Vendor.Reset();
                                Vendor.SetRange(Vendor."No.", Cust."FOSA Account No.");
                                if Vendor.FindFirst() then begin
                                    Vendor.CalcFields(Vendor.Balance);
                                    MBuffer.Reset();
                                    MBuffer.SetRange(MBuffer."Vendor No", Cust."FOSA Account No.");
                                    MBuffer.SetRange(MBuffer.Posted, false);
                                    MBuffer.SetRange(MBuffer.Reversed, false);
                                    if MBuffer.FindSet() then begin
                                        MBuffer.CalcSums(MBuffer."Amount Requested");
                                        PendingAmount := MBuffer."Amount Requested";
                                    end;
                                    AvailableBalance := 0;
                                    AvailableBalance := Vendor.Balance - ((Vendor."Uncleared Cheques" - Vendor."Cheque Discounted Amount") + PaybillTransactions.TransAmount + PendingAmount + Vendor."ATM Transactions" + Vendor."EFT Transactions" + 1000 + Vendor."Mobile Transactions" + Vendor."Frozen Amount");
                                end;

                                // LineNo := LineNo + 10000;
                                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                // GenJournalLine."Account Type"::Vendor, Cust."FOSA Account No.", postingDate, TotalAmount, 'FOSA', DOCUMENT_NO,
                                // 'Mobile Deposit Charges' + ' ' + Cust."No.", '');

                                // LineNo := LineNo + 10000;
                                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                // GenJournalLine."Account Type"::Vendor, VendorCommAccount, postingDate, VendorComm * -1, 'FOSA', DOCUMENT_NO,
                                // 'Vendor Commission' + ' ' + Cust."No.", '');

                                // LineNo := LineNo + 10000;
                                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                // GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, postingDate, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
                                // 'Sacco Commission' + ' ' + Cust."No.", '');

                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'PAYBILL');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                end;

                                PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                                PaybillTransactions.Modify();
                                if Cust."Mobile Phone No" <> '' then begin
                                    SMSstr := 'Dear ' + Bname.NameStyle(Cust."No.") + ', MPESA deposit of Ksh.' + Format(PaybillTransactions.TransAmount) + ' has been received on ' + Format(PaybillTransactions.TransTime) + '. "A penny saved is a penny earned"';
                                    if Vend."Account Type" = '109' then begin
                                        SMSstr := 'Dear ' + Bname.NameStyle(Cust."No.") + ', MPESA deposit of Ksh.' + Format(PaybillTransactions.TransAmount) + ' to ' + Vend."Child Name" + '''S Mdosi Junior account has been received on ' + Format(PaybillTransactions.TransTime) + '. "A penny saved is a penny earned"';
                                    end;
                                    smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Cust."Mobile Phone No", SMSstr, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;
                        end;
                    end;
                end else if FnCheckIfExists(PaybillTransactions.TransID) = true then begin
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify();
                end;
            until PaybillTransactions.Next() = 0;
        end;
    end;

    var
        FirstStr: text[250];
        SecondStr: text[250];
        lastStr: Text[250];
        Cust: Record Customer;
        GraduatedCharge: Record "MPESA  Deposits";
        MpesaComm: Decimal;
        RunBal: decimal;
        SaccoCommission: Decimal;
        VendorComm: Decimal;
        ExciseDuty: Decimal;
        PercentageGra: decimal;
        ChargeAmount: Decimal;
        accTypes: Record "Account Types-Saving Products";
        Excess: Decimal;
        TotalAmount: Decimal;
        VendorCommAccount: Code[50];
        AUFactory: Codeunit "Au Factory";
        ExciseDutyAccount: Code[50];
        MBuffer: Record "Mpesa Withdawal Buffer";
        TotalAmountAccount: Code[50];
        SaccoCommissionAccount: Code[50];
        MpesaCommAccount: Code[50];
        bizPhoneNo: Code[50];
        bizPhoneName: Text[1250];
        SaccoGen: Record "Sacco General Set-Up";
        NetCharges: Decimal;
        PendingAmount: Decimal;
        AvailableBalance: Decimal;
        ParentStr: text[250];
        Vend: Record Vendor;
        SMSstr: Text[1500];
        smsManagement: Codeunit "Sms Management";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
        FOSAPaybillCode: Code[50];
        EXTERNAL_DOC_NO: Code[40];
        p2fNo: Code[30];
        loanProduct: Code[50];
        principleRepay: Decimal;

        PrincRepay: decimal;
        Sal: Record "Salary Details";
        Saldetails: Record "Salary Details";
        SalNo: Integer;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        salType: Option ,,Milk,Tea,Bonus,Dividends,Pension,Salary;
        accountType: Code[50];
        accountTypename: Code[200];
        postingDate: Date;
        postingDateTwo: Date;
        postingDateTime: Time;

    local procedure FnCheckIfExists(PaybillCode: Code[40]) Response: Boolean;
    var
        BankAccL: Record "Bank Account Ledger Entry";
    begin
        Response := false;
        BankAccL.Reset();
        BankAccL.SetRange(BankAccL."Document No.", CopyStr(PaybillCode, 1, 20));
        if BankAccL.FindFirst() then begin
            Response := true;
        end;
        exit(Response);
    end;

    local procedure UpdateSchedule()
    var
        RSchedule: Record "Loan Repayment Schedule";
        Loans: Record "Loans Register";
        AUFactory: Codeunit "Au Factory";
    begin
        Loans.Reset();
        Loans.SetRange(Loans.Posted, true);
        Loans.SetRange(Loans."Loan Disbursement Date", TODAY);
        if loans.findset then begin
            repeat
                RSchedule.Reset();
                RSchedule.SetRange(RSchedule."Loan No.", Loans."Loan  No.");
                if not RSchedule.FindFirst() then begin
                    AuFactory.FnGenerateLoanRepaymentSchedule(Loans."Loan  No.");
                end;

                RSchedule.Reset();
                RSchedule.SetRange(RSchedule."Loan No.", Loans."Loan  No.");
                if RSchedule.FindFirst() then begin
                    Loans."Loan Principle Repayment" := Round(RSchedule."Principal Repayment", 1, '>');
                    Loans."Loan Interest Repayment" := Round(RSchedule."Monthly Interest", 1, '>');
                    Loans.Repayment := Round(RSchedule."Monthly Repayment", 1, '>');
                    Loans.Modify();
                end;

            until loans.Next() = 0;
        end;
    end;

    local procedure getAccountType(account: Code[50]) Type: Code[50]
    begin
        Vend.Reset();
        Vend.SetRange("No.", account);
        if Vend.Find('-') then begin
            if accTypes.Get(Vend."Account Type") then begin
                Type := accTypes.Description;
            end;
        end;
    end;

    local procedure FnRegisterProcessedStandingOrder(sto: Record "Standing Orders"; docNo: Code[50]; AmountToDeduct: Decimal; DedStatus: Option Successfull,"Partial Deduction",Failed)
    var
        stoReg: Record "Standing Order Register";
    begin
        stoReg.Reset;
        stoReg.SetRange("Document No.", docNo);
        if stoReg.Find('-') then
            stoReg.DeleteAll;

        stoReg.Init;
        stoReg."Register No." := '';
        stoReg.Validate(stoReg."Register No.");
        stoReg."Standing Order No." := sto."No.";
        stoReg."Source Account No." := sto."Source Account No.";
        stoReg."Staff/Payroll No." := sto."Staff/Payroll No.";
        stoReg.Date := Today;
        stoReg."Account Name" := sto."Account Name";
        stoReg."Destination Account Type" := sto."Destination Account Type";
        stoReg."Destination Account No." := sto."Destination Account No.";
        stoReg."Destination Account Name" := sto."Destination Account Name";
        stoReg."BOSA Account No." := sto."BOSA Account No.";
        stoReg."Effective/Start Date" := sto."Effective/Start Date";
        stoReg."End Date" := sto."End Date";
        stoReg.Duration := sto.Duration;
        stoReg.Frequency := sto.Frequency;
        stoReg."Don't Allow Partial Deduction" := sto."Don't Allow Partial Deduction";
        stoReg."Deduction Status" := DedStatus;
        stoReg.Remarks := sto."Standing Order Description";
        stoReg.Amount := sto.Amount;
        stoReg."Amount Deducted" := AmountToDeduct;
        if sto."Destination Account Type" = sto."destination account type"::"Member Account" then
            stoReg.EFT := true;
        stoReg."Document No." := docNo;
        if not stoReg.Insert(true) then stoReg.Modify(true);
    end;


}

