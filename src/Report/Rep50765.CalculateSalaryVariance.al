report 50765 "Calculate Salary Variance"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem("Salary Processing Lines";"Salary Processing Lines")
        {
            RequestFilterFields = "Salary Header No.";
            column("Salary_Header_No";"Salary Header No.")
            {}
            trigger OnPreDataItem() begin
                varianceBuffer.Reset();
                varianceBuffer.SetRange("Document No", "Salary Processing Lines"."Salary Header No.");
                if varianceBuffer.FindSet() then begin
                    varianceBuffer.DeleteAll();
                end;

                entryNo := 1;
            end;

            trigger OnAfterGetRecord() begin
                essContr:= 0;
                depContr:= 0;
                bbf:= 300;
                expectedContr:= 0;
                expectedLoanDed:= 0;
                expectedDed:= 0;
                actualDed:= 0;
                paymentVar:= 0;

                salaryNo := "Salary Processing Lines"."Salary Header No.";




                

                salaryHeader.Reset();
                salaryHeader.SetRange(No, "Salary Processing Lines"."Salary Header No.");
                if salaryHeader.Find('-') then begin
                    loanCutoff := salaryHeader."Loan CutOff";
                    loanRepayDate := CalcDate('<CM>', loanCutoff);
                end;

                stos.Reset();
                stos.SetRange("Source Account No.", "Salary Processing Lines"."Account No.");
                stos.SetRange("Is Active", true);
                stos.SetFilter("Effective/Start Date", '<=%1', loanCutoff);
                if stos.Find('-') then begin
                    repeat
                    stos.CalcFields("Allocated Amount");
                    stoContr := stos."Allocated Amount";
                    until stos.Next() = 0;
                end;
                expectedContr := stoContr;

                loansReg.Reset();
                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                loansReg.SetRange("Client Code", "Salary Processing Lines"."Member No");
                loansReg.SetFilter("Loan Disbursement Date", '<%1', loanCutoff);
                loansReg.SetFilter("Recovery Mode", '%1|%2', loansReg."Recovery Mode"::Salary, loansReg."Recovery Mode"::Pension);
                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                if loansReg.FindSet() then begin
                    repeat
                    loanRepay.Reset();
                    loanRepay.SetRange("Loan No.", loansReg."Loan  No.");
                    loanRepay.SetRange("Repayment Date", loanRepayDate);
                    if loanRepay.Find('-') then begin
                        expectedLoanDed := expectedLoanDed + loanRepay."Monthly Repayment";
                    end;
                    until loansReg.Next()=0;
                end;
                loansReg.Reset();
                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                loansReg.SetRange("Client Code", "Salary Processing Lines"."Member No");
                loansReg.SetFilter("Loan Disbursement Date", '<%1', loanCutoff);
                loansReg.SetRange("Loan Product Type", 'A03');
                loansReg.SetRange("Loans Category",loansReg."Loans Category"::Loss);
                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                if loansReg.FindSet() then begin
                    repeat
                    expectedLoanDed := expectedLoanDed + loansReg."Total Outstanding Balance";
                    until loansReg.Next()=0;
                end;

                expectedDed := expectedLoanDed + expectedContr + 144;

                RunningBalance := "Salary Processing Lines".Amount;
                loansReg.Reset;
                loansReg.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                loansReg.SetRange(loansReg."Client Code", "Salary Processing Lines"."Member No");
                loansReg.SetFilter(loansReg."Loan Disbursement Date", '..%1', loanCutoff);
                loansReg.SetAutoCalcFields(loansReg."Outstanding Interest");
                loansReg.SetFilter(loansReg."Outstanding Interest",'>%1',0);
                loansReg.SetRange(loansReg."Recovery Mode", loansReg."recovery mode"::Salary);
                if loansReg.FindSET then begin
                    repeat
                        if ObjLoanProducts.Get(loansReg."Loan Product Type") then begin
                            loansReg.CALCFIELDS(loansReg."Outstanding Interest");
                            if (SFactory.FnGetOutstandingInterest(loansReg."Loan  No.", loanCutoff)) > 0 then begin
                                if RunningBalance > 0 then begin
                                    AmountToDeduct := 0;
                                    AmountToDeduct := SFactory.FnGetOutstandingInterest(loansReg."Loan  No.", loanCutoff);
                                    if RunningBalance <= AmountToDeduct then
                                        AmountToDeduct := RunningBalance;
                                    RunningBalance := RunningBalance - AmountToDeduct;
                                end;
                            end;
                        end;
                    until loansReg.Next = 0;
                end;

                if RunningBalance > 0 then begin
                    varTotalRepay := 0;
                    varMultipleLoan := 0;
                    AmountPaid := 0;
                    MonthlyArrears := 0;
                    MonthlyRepayment := 0;
                    OutstandingInterest := 0;

                    loansReg.Reset;
                    loansReg.SetRange(loansReg."Client Code", "Salary Processing Lines"."Member No");
                    loansReg.SetAutoCalcFields(loansReg."Outstanding Balance");
                    loansReg.SetFilter(loansReg."Outstanding Balance", '>%1', 0);
                    loansReg.SetFilter(loansReg."Expected Date of Completion", '<=%1',  CalcDate('CM',loanCutoff));
                    loansReg.SetRange(loansReg."Recovery Mode", loansReg."recovery mode"::Salary);
                    loansReg.SetFilter(loansReg."Loan Product Type", '<>%1', 'M_OD');
                    if loansReg.FindSet() then begin
                        repeat
                            if RunningBalance > 0 then begin
                                loansReg.CalcFields(loansReg."Outstanding Balance");
                                AmountToDeduct := 0;
                                varLRepayment := 0;
                                ScheduleAmount := 0;
                                MonthlyRepayment := 0;

                                varLRepayment := loansReg."Outstanding Balance";

                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end else AmountToDeduct := RunningBalance;
                                end;
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        until loansReg.Next = 0;
                    end;

                    loansReg.Reset;
                    loansReg.SetRange(loansReg."Client Code", "Salary Processing Lines"."Member No");
                    loansReg.SetAutoCalcFields(loansReg."Total Outstanding Balance");
                    loansReg.SetRange(loansReg."Recovery Mode", loansReg."recovery mode"::Salary, loansReg."Recovery Mode"::Pension);
                    loansReg.SetFilter(loansReg."Loan Disbursement Date", '..%1', CalcDate('CM',loanCutoff));
                    loansReg.SetFilter(loansReg."Total Outstanding Balance", '>%1', 0);
                    if loansReg.FindSet() then begin
                        repeat
                            if ObjLoanProducts.Get(loansReg."Loan Product Type") then begin
                                if (ObjLoanProducts."Charge Interest Upfront" = false) then begin
                                    if RunningBalance > 0 then begin
                                        AmountToDeduct := 0;
                                        varLRepayment := 0;
                                        ScheduleAmount := 0;
                                        MonthlyRepayment := 0;
                                        LSchedule.RESET;
                                        LSchedule.SetRange(LSchedule."Loan No.", loansReg."Loan  No.");
                                        LSchedule.setfilter(LSchedule."Repayment Date", '%1..%2', calcdate('-CM', loanCutoff), calcdate('CM', loanCutoff));
                                        if LSchedule.FindFirst() then begin
                                            LSchedule.CalcSums(LSchedule."Principal Repayment");
                                            ScheduleAmount := LSchedule."Loan Balance";
                                            MonthlyRepayment := LSchedule."Principal Repayment";
                                        end;
                                        if MonthlyRepayment > loansReg."Outstanding Balance" then varLRepayment := loansReg."Outstanding Balance"
                                        else varLRepayment := MonthlyRepayment;
                                        if RunningBalance > 0 then begin
                                            if RunningBalance > varLRepayment then begin
                                                AmountToDeduct := varLRepayment;
                                            end else AmountToDeduct := RunningBalance;
                                        end;
                                        RunningBalance := RunningBalance - AmountToDeduct;
                                    end;
                                end;
                            end;
                        until loansReg.Next = 0;
                    end;

                    loansReg.Reset;
                    loansReg.SetRange(loansReg."Client Code", "Salary Processing Lines"."Member No");
                    loansReg.SetAutoCalcFields(loansReg."Outstanding Balance");
                    loansReg.SetFilter(loansReg."Loan Product Type", '%1|%2', 'A16', 'M_OD');
                    loansReg.SetRange(loansReg."Recovery Mode", loansReg."recovery mode"::Salary);
                    loansReg.SetFilter(loansReg."Outstanding Balance", '>%1', 0);
                    if loansReg.FindSet() then begin
                        repeat
                            if ObjLoanProducts.Get(loansReg."Loan Product Type") then begin
                                if (ObjLoanProducts."Charge Interest Upfront" = true) then begin
                                    if RunningBalance > 0 then begin
                                        loansReg.CalcFields(loansReg."Outstanding Balance");
                                        AmountToDeduct := 0;
                                        varLRepayment := 0;
                                        ScheduleAmount := 0;
                                        MonthlyRepayment := 0;

                                        MonthlyRepayment := loansReg."Approved Amount" / loansReg.Installments;
                                        if MonthlyRepayment > loansReg."Outstanding Balance" then
                                            varLRepayment := loansReg."Outstanding Balance"
                                        else varLRepayment := MonthlyRepayment;

                                        if RunningBalance > 0 then begin
                                            if RunningBalance > varLRepayment then begin
                                                AmountToDeduct := varLRepayment;
                                            end else AmountToDeduct := RunningBalance;
                                        end;
                                        RunningBalance := RunningBalance - AmountToDeduct;
                                    end;
                                end;
                            end;
                        until loansReg.Next = 0;
                    end;
                end;

                if RunningBalance > 0 then begin
                    varTotalRepay := 0;
                    varMultipleLoan := 0;
                    stos.Reset;
                    stos.SetCurrentkey("No.", "Source Account No.");
                    stos.SetRange("Source Account No.", "Salary Processing Lines"."Account No.");
                    stos.SetRange(Status, stos.Status::Approved);
                    stos.SetRange("Is Active", true);
                    if stos.Find('-') then begin
                        repeat
                            if RunningBalance > 0 then begin
                                ObjReceiptTransactions.Reset;
                                ObjReceiptTransactions.SetRange("Document No", stos."No.");
                                if ObjReceiptTransactions.Find('-') then begin
                                    stos.Reset();
                                    stos.SetRange(stos."No.", ObjReceiptTransactions."Document No");
                                    if stos.FindFirst() then begin
                                        repeat
                                            if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::Member then begin
                                                if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::Repayment then begin
                                                    //-------------RECOVER principal-----------------------
                                                    if LoansReg.Get(ObjReceiptTransactions."Loan No.") then begin
                                                        if LoansReg."Recovery Mode" = LoansReg."Recovery Mode"::Salary then begin
                                                            PrincipleBal := 0;

                                                            if RunningBalance > (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") then
                                                                PrincipleBal := (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount")
                                                            else PrincipleBal := RunningBalance;

                                                            RunningBalance := RunningBalance - PrincipleBal;
                                                        end;

                                                        if LoansReg."Recovery Mode" <> LoansReg."Recovery Mode"::Salary then begin
                                                            RemainBal := 0;
                                                            InterestBal := 0;
                                                            RemainBal := ObjReceiptTransactions.Amount;
                                                            LoansReg.CalcFields(LoansReg."Outstanding Interest");

                                                            if RemainBal > LoansReg."Outstanding Interest" then
                                                                InterestBal := LoansReg."Outstanding Interest"
                                                            else InterestBal := RemainBal;

                                                            if InterestBal > RunningBalance then
                                                                InterestBal := RunningBalance
                                                            else InterestBal := InterestBal;
                                                            RunningBalance := RunningBalance - InterestBal;

                                                            if RemainBal > 0 then begin
                                                                RunningBalance := RunningBalance - (RemainBal);
                                                            end;
                                                        end;
                                                    end;
                                                end else begin
                                                    FAmount := 0;
                                                    if RunningBalance > ObjReceiptTransactions.Amount then
                                                        FAmount := ObjReceiptTransactions.Amount
                                                    else FAmount := RunningBalance;
                                                    RunningBalance := RunningBalance - FAmount;

                                                end;
                                            end else begin
                                                if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::"FOSA Account" then begin
                                                    FAAAmount := 0;
                                                    if RunningBalance > ObjReceiptTransactions.Amount then
                                                        FAAAmount := ObjReceiptTransactions.Amount
                                                    else FAAAmount := RunningBalance;
                                                    
                                                    RunningBalance := RunningBalance - FAAAmount;
                                                end;
                                            end;
                                        until ObjReceiptTransactions.Next = 0;
                                    end;
                                end;
                            end;
                        until stos.Next = 0;
                    end;
                end;

                detVend.Reset();
                detVend.SetRange("Vendor No.", "Salary Processing Lines"."Account No.");
                detVend.SetRange("Document No.", "Salary Processing Lines"."Document No.");
                if detVend.FindSet() then begin
                    detVend.CalcSums("Debit Amount");
                    RunningBalance := detVend."Debit Amount";
                end;

                actualDed := (("Salary Processing Lines".Amount - 144) - RunningBalance);
                
                paymentVar := expectedDed - actualDed;

                varianceBuffer.Init;
                varianceBuffer."Entry No" := entryNo;
                varianceBuffer."Member No" := "Salary Processing Lines"."Member No";
                varianceBuffer.Validate("Member No");
                varianceBuffer."Member Salary" := "Salary Processing Lines".Amount;
                varianceBuffer."Expected Deduction" := expectedDed;
                varianceBuffer."Actual Deduction" := actualDed;
                varianceBuffer.Variance := paymentVar;
                varianceBuffer.Month := Date2DMY(loanCutoff, 2);
                varianceBuffer.Year := Date2DMY(loanCutoff, 3);
                varianceBuffer."Document No" := "Salary Processing Lines"."Salary Header No.";
                if not varianceBuffer.Insert then varianceBuffer.Modify;

                entryNo := entryNo + 1;
            end;

            trigger OnPostDataItem() begin
                varianceBuffer.Reset();
                varianceBuffer.SetRange("Document No", salaryNo);
                if varianceBuffer.FindSet() then begin
                    Report.Run(175108, false, true, varianceBuffer);
                end;
            end;
        }
    }
    
    var
    myInt: Integer;
    entryNo: Integer;
    bbf: Decimal;
    stoContr: Decimal;
    essContr: Decimal;
    depContr: Decimal;
    expectedContr: Decimal;
    actualContr: Decimal;
    expectedLoanDed: Decimal;
    actualLoanDed: Decimal;
    expectedDed: Decimal;
    actualDed: Decimal;
    paymentVar: Decimal;
    RunningBalance: Decimal;
    AmountToDeduct: Decimal;
    detVend: Record "Detailed Vendor Ledg. Entry";
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
        RemainBal: Decimal;
        InterestBal: Decimal;
        PrincipleBal: Decimal;
        StoHeader: record "Standing Orders";
        LSchedule: Record "Loan Repayment Schedule";
        AmountPaid: Decimal;
        ScheduleAmount: Decimal;
        Arrears: Decimal;
        LoanApps: Record "Loans Register";
        MonthlyRepayment: Decimal;
        MonthlyArrears: Decimal;
        OutstandingInterest: decimal;
        FAmount: Decimal;
        FAAAmount: Decimal;
    loanCutoff: Date;
    loanRepayDate: Date;
    salaryNo: Code[20];
    SFactory: Codeunit "Au Factory";
    varianceBuffer: Record "Member Salary Variance Buffer";
    salaryHeader: Record "Salary Processing Headerr";
    salaryLines: Record "Salary Processing Lines";
    cust: Record Customer;
    vend: Record Vendor;
    loansReg: Record "Loans Register";
    loanRepay: Record "Loan Repayment Schedule";
    stos: Record "Standing Orders";
    receiptAllocation: Record "Receipt Allocation";
    ObjLoanProducts: Record "Loan Products Setup";
    
}
