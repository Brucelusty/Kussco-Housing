codeunit 50104 "Classify Loans"
{
    trigger OnRun()
    var
        myInt: Integer;
    begin
        classifyLoansSASRA();
    end;

    procedure classifyLoansSASRA()
    var
        "0Day": Decimal;
        "1Day": Decimal;
        "2Day": Decimal;
        "3Day": Decimal;
        Over3Day: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        RepaymentPeriod: Date;
        Loans: Record "Loans Register";
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        "No.ofMonthsinArrears": Integer;
        SFactory: Codeunit "Au Factory";
        ExpectedBalance: Decimal;
        Numberofdays: Integer;
        varRepayment: Decimal;
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        Cust: Record Customer;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
    begin
        ExpectedBalance := 0;
        GrandTotal := 0;
        varRepayment := 0;
        "0Month" := 0;
        Over3Month := 0;
        "1Month" := 0;
        "3Month" := 0;
        "2Month" := 0;
        LBal := 0;
        ExpectedBalance := 0;
        varRepayment := 0;
        Arrears := 0;
        "No.ofMonthsinArrears" := 0;
        AsAt := Today;
        RepaymentPeriod := AsAt;
        //SFactory.FnGenerateLoanRepaymentSchedule("Loans Register"."Loan  No.");
        DateFilter := '..' + Format(AsAt);
        LoansR.Reset();
        
        LoansR.SetAutoCalcFields("Outstanding Balance", "Last Pay Date");
        //LoansR.SetFilter("Outstanding Balance", '<>%1',0);//allows to clasify all loans so remove this filter.
        if LoansR.FindSet() then begin
            ProgressWindow.OPEN('Classifying loans #1#######');
            repeat
                Sleep(100);
                LSchedule.Reset;
                LSchedule.SetRange(LSchedule."Loan No.", LoansR."Loan  No.");
                LSchedule.SetFilter(LSchedule."Repayment Date", DateFilter);
                if LSchedule.FindLast then begin
                    ExpectedBalance := LSchedule."Loan Balance";
                    varRepayment := LSchedule."Principal Repayment";
                end;
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", LoansR."Loan  No.");
                Loans.SetFilter(Loans."Date filter", DateFilter);
                if Loans.Find('-') then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Scheduled Principal to Date", Loans."Principal Paid", Loans."Schedule Repayments", Loans.OutstandingLessInt);
                    LBal := Loans.OutstandingLessInt;
                end;


                Arrears := LBal - ExpectedBalance;

                if LoansR."Repayment Start Date" > AsAt then
                    Arrears := 0;
                if ((Arrears < 0) or (Arrears = 0)) then begin
                    Arrears := 0
                end else begin
                    Arrears := Arrears;
                end;

                if varRepayment > 0 then begin
                    "No.ofMonthsinArrears" := ROUND((Arrears / varRepayment) * 30, 1, '=');

                end else begin
                    "No.ofMonthsinArrears" := ROUND((Arrears / (LoansR."Approved Amount" / LoansR.Installments)) * 30, 1, '=');
                end;
                LoansR."Amount in Arrears" := Arrears;
                LoansR."No of Months in Arrears" := "No.ofMonthsinArrears";
                LoansR."Days In Arrears" := "No.ofMonthsinArrears";
                LoansR."Principal In Arrears" := Arrears;
                //"Loans Register".arre
                LoansR.Modify;

                //Message('noof days%1-bal%2-expectation%3-repayment%4', "No.ofMonthsinArrears", LBal, ExpectedBalance, varRepayment);
                if LoansR."Expected Date of Completion" > Today then begin
                    IF LoansR."Repayment Start Date" > AsAt THEN begin

                        LoansR."Loans Category" := LoansR."Loans Category"::Perfoming;
                    end;

                    if ("No.ofMonthsinArrears" = 0) then begin
                        LoansR."Loans Category" := LoansR."loans category"::Perfoming;

                        "0Month" := LoansR."Outstanding Balance"
                    end else
                        if (("No.ofMonthsinArrears" > 0) and ("No.ofMonthsinArrears" <= 30)) then begin
                            LoansR."Loans Category" := LoansR."loans category"::Watch;
                            "1Month" := LoansR."Outstanding Balance"
                        end else
                            if ("No.ofMonthsinArrears" > 30) and ("No.ofMonthsinArrears" <= 180) then begin
                                LoansR."Loans Category" := LoansR."loans category"::Substandard;
                                "2Month" := LoansR."Outstanding Balance"
                            end else
                                if ("No.ofMonthsinArrears" > 180) and ("No.ofMonthsinArrears" <= 360) then begin
                                    LoansR."Loans Category" := LoansR."loans category"::Doubtful;
                                    "3Month" := LoansR."Outstanding Balance"
                                end else
                                    if ("No.ofMonthsinArrears" > 360) then begin
                                        LoansR."Loans Category" := LoansR."loans category"::Loss;
                                        Over3Month := LoansR."Outstanding Balance";
                                    end;

                end;

                if (LoansR."Expected Date of Completion" < Today) and (LoansR."Outstanding Balance" > 0) then begin

                    Over3Month := LoansR."Outstanding Balance";
                    LoansR."Loans Category" := LoansR."Loans Category"::Loss;
                    LoansR."Loans Category-SASRA" := LoansR."Loans Category-SASRA"::Loss;

                    if varRepayment = 0 then begin
                        varRepayment := LoansR."Approved Amount" / LoansR.Installments;
                    end else begin
                        varRepayment := varRepayment;
                    end;
                    LoansR."Amount in Arrears" := LoansR."Outstanding Balance";
                    LoansR."No of Months in Arrears" := ROUND((LoansR."Outstanding Balance" / varRepayment) * 30, 1, '=');

                    //Message('Outstanding%1Repayment%2', "Loans Register"."Outstanding Balance", varRepayment);
                    LoansR."Days In Arrears" := ROUND((LoansR."Outstanding Balance" / varRepayment) * 30, 1, '=');
                    ;
                    LoansR."Principal In Arrears" := LoansR."Outstanding Balance";
                    LoansR."Interest In Arrears" := LoansR."Outstanding Interest";
                end;

                LoansR.Modify();

                LoansR.CalcFields("Outstanding Balance");
                if LoansR."Outstanding Balance" = 0 then begin
                    LoansR."Loans Category" := LoansR."Loans Category"::Perfoming;
                    LoansR.Modify;
                end;

                GrandTotal := GrandTotal + LoansR."Outstanding Balance";
                if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                    NoLoans := NoLoans + 1;
                ProgressWindow.UPDATE(1, LoansR."Loan  No." + ':' + LoansR."Client Name");
            until LoansR.Next() = 0;
            ProgressWindow.CLOSE;
        end;
    end;


    var
        TotalExpectedAmount: Decimal;
        TotalPaidAMount: Decimal;
        MonthlyRepayments: Decimal;
        LoansR: Record "Loans Register";
        NumberOfMonths: Decimal;
        Members: Record Customer;
        NumberOfDays: Decimal;
        Arrears: Decimal;
        TotalInterestPaid: Decimal;
        Loanss: Record "Loans Register";
        ProgressWindow: Dialog;
        Generate: Codeunit "Au Factory";
}
