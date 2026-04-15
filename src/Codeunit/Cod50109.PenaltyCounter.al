codeunit 50109 "Penalty Counter"
{
    trigger OnRun()
    begin
        CheckDefaultedLoans()
    end;

    local procedure CheckDefaultedLoans()
    var
        NoOfDays: Integer;
        RepayementDeadLineDate: Date;
        customer: Record Customer;
        loanType: Record "Loan Products Setup";
    begin
        JTemplate := 'GENERAL';
        JBatch := 'SKYWORLD';

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", JTemplate);
        GenJournalLine.SETRANGE("Journal Batch Name", JBatch);
        IF GenJournalLine.FIND('-') THEN BEGIN
            GenJournalLine.DELETEALL;
        END;

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", JTemplate);
        GenBatches.SetRange(GenBatches.Name, JBatch);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := JTemplate;
            GenBatches.Name := JBatch;
            GenBatches.Description := 'Mobile Loan Advance Penalty & Default Interest';
            GenBatches.Insert;
        end;

        lastNo := 0;
        // CreditRating.SetCurrentKey("Entry No");
        // if CreditRating.FindLast() then begin
        //     lastNo := CreditRating."Entry No";
        // end else
        //     lastNo := 1;

        // Error('Here');
        loanType.Get('A03');
        loanType.Reset();
        loanType.SetRange(Code, 'A03');
        if loanType.Find('-') then begin
            loansReg.Reset();
            loansReg.SetRange(loansReg."Loan Product Type", 'A03');
            loansReg.SetAutoCalcFields(loansReg."Total Outstanding Balance");
            loansReg.SetFilter(loansReg."Total Outstanding Balance", '>%1', 0);
            if loansReg.FindSet() then begin
                repeat
                    IF loansReg."Expected Date of Completion" = 0D THEN begin
                        loansReg.Validate("Loan Disbursement Date");
                        loansReg.Modify;
                        RepayementDeadLineDate := CALCDATE('<7D>', CalcDate('<'+Format(loansReg.Installments)+'M>', loansReg."Repayment Start Date"));
                    end else begin
                        RepayementDeadLineDate := CALCDATE('<7D>', loansReg."Expected Date of Completion");
                    end;

                    if RepayementDeadLineDate < TODAY then begin

                        CalculatePenalty(loansReg."Loan  No.");

                        lastNo := lastNo + 1;
                        SaccoSetup.Get();
                        CreditRating.Reset();
                        CreditRating.SetRange(CreditRating."Loan No.",loansReg."Loan  No.");
                        if CreditRating.Find('-') then begin
                            if CreditRating."Loan Limit" <> loanType."Min. Loan Amount" then begin
                                // CreditRating."Entry No" := lastNo;
                                CreditRating."Loan Limit" := loanType."Min. Loan Amount";
                                CreditRating."Check Entry" := true;
                                CreditRating.Modify();
                            end;
                        end else begin
                            customer.Get(loansReg."Client Code");
                            CreditRating.Init();
                            CreditRating."Loan No." := loansReg."Loan  No.";
                            CreditRating."Document Date" := TODAY;
                            CreditRating."Loan Amount" := loansReg."Approved Amount";
                            CreditRating."Date Entered" := TODAY;
                            CreditRating."Time Entered" := TIME;
                            CreditRating."Entered By" := USERID;
                            CreditRating."Account No" := loansReg."Account No";
                            CreditRating."Member No" := loansReg."Client Code";
                            CreditRating."Telephone No" := customer."Mobile Phone No";
                            CreditRating."Customer Name" := loansReg."Client Name";
                            CreditRating."Loan Product Type" := loansReg."Loan Product Type";
                            CreditRating."Loan Limit" := loanType."Min. Loan Amount";
                            CreditRating."Staff No." := customer."Payroll No";
                            CreditRating.INSERT;
                        end;
                    end;
                until loansReg.Next() = 0;

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;
            end;
        end;
    end;

    procedure CalculatePenalty(loanNo: Code[20])
    var
        LoansRegister: Record "Loans Register";
        MembersRegister: Record "Members Register";
        RepayementDeadLineDate: Date;
        LoanProductsSetup: Record "Loan Products Setup";
        Penalty: Decimal;
        accruedInt: Decimal;
        MonthNumber: Integer;
        TransType: Enum TransactionTypesEnum;
    begin
        
        JTemplate := 'GENERAL';
        JBatch := 'SKYWORLD';

        LoansRegister.Reset();
        LoansRegister.SetRange("Loan  No.", loanNo);
        IF LoansRegister.Find('-') THEN BEGIN
            //GenerateSchedule.Autogenerateschedule("Loans Register"."Loan  No.");
            LoansRegister.CalcFields("Outstanding Balance", "Outstanding Interest", "Total Outstanding Balance");
            if LoanProductsSetup.GET(LoansRegister."Loan Product Type") then begin
                MonthNumber := 1;
                RepayementDeadLineDate := CALCDATE('7D', LoansRegister."Expected Date of Completion");
                IF RepayementDeadLineDate = 0D THEN RepayementDeadLineDate := CALCDATE(FORMAT('7D', LoansRegister.Installments) + 'M', LoansRegister."Application Date");

                TransType := TransType::"Loan Penalty Charged";
                IF PenaltyCounter.GET(LoansRegister."Loan  No.") THEN BEGIN
                    TransType := TransType::"Interest Due";
                    IF PenaltyCounter."Penalty Number" = 6 then exit;
                    IF PenaltyCounter."Next Penalty Date" > TODAY THEN exit;
                    RepayementDeadLineDate := PenaltyCounter."Next Penalty Date";

                    accruedInt := Round(((LoansRegister."Total Outstanding Balance") * (LoanProductsSetup."Interest rate"/100)), 1, '>');
                    
                    if accruedInt <= 0 then exit;
                    
                    IF cust.GET(LoansRegister."Client Code") THEN begin
                        cust."Loan Defaulter" := TRUE;
                        cust.Defaulter := true;
                        cust.MODIFY;
                    end;

                    LineNo := LineNo + 10000;
                    SFactorys.FnCreateGnlJournalLine(JTemplate, JBatch, LoansRegister."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                    GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, (accruedInt), 'BOSA', LoansRegister."Loan  No.",
                    LoansRegister."Loan Product Type Name" + ': Interest on Defaulted Mobile Loan for Month-' + FORMAT(MonthNumber), LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");

                    LineNo := LineNo + 10000;
                    SFactorys.FnCreateGnlJournalLine(JTemplate, JBatch, LoansRegister."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", LoanProductsSetup."Loan Interest Account" , Today, (accruedInt)*-1, 'BOSA', LoansRegister."Loan  No.",
                    LoansRegister."Loan Product Type Name" + ': Interest on Defaulted Mobile Loan for Month-' + FORMAT(MonthNumber), LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");

                    PenaltyCounter."Penalty Number" += 1;
                    PenaltyCounter."Next Penalty Date" := CALCDATE('1M', PenaltyCounter."Next Penalty Date");
                    PenaltyCounter."Amount Charged" := accruedInt;
                    PenaltyCounter.MODIFY;
                END else begin

                    IF RepayementDeadLineDate > TODAY THEN exit;

                    Penalty := ROUND((LoansRegister."Total Outstanding Balance") * 0.1, 1, '>');
                    if Penalty <= 0 then exit;

                    IF MembersRegister.GET(LoansRegister."Client Code") THEN begin
                        MembersRegister."Loan Defaulter" := TRUE;
                        MembersRegister.MODIFY;
                    end;
                        
                    IF cust.GET(LoansRegister."Client Code") THEN begin
                        cust."Loan Defaulter" := TRUE;
                        cust.Defaulter := true;
                        cust.MODIFY;
                    end;

                    LineNo := LineNo + 10000;
                    SFactorys.FnCreateGnlJournalLine(JTemplate, JBatch, LoansRegister."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Charged",
                    GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, (Penalty), 'BOSA', LoansRegister."Loan  No.",
                    LoansRegister."Loan Product Type Name" + ': Penalty for Month-' + FORMAT(MonthNumber), LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");

                    LineNo := LineNo + 10000;
                    SFactorys.FnCreateGnlJournalLine(JTemplate, JBatch, LoansRegister."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", LoanProductsSetup."Penalty Charged Account", Today, (Penalty)*-1, 'BOSA', LoansRegister."Loan  No.",
                    LoansRegister."Loan Product Type Name" + ': Penalty for Month-' + FORMAT(MonthNumber), LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");

                    PenaltyCounter.INIT;
                    PenaltyCounter."Loan Number" := LoansRegister."Loan  No.";
                    PenaltyCounter.Validate("Loan Number");
                    PenaltyCounter."Penalty Number" := 1;
                    PenaltyCounter."Next Penalty Date" := CALCDATE('1M', TODAY);
                    PenaltyCounter."Product Type" := 'A03';
                    PenaltyCounter."Amount Charged" := Penalty;
                    if not PenaltyCounter.INSERT then PenaltyCounter.Modify;
                end;
            end;
        END;

    end;

    var
    lineNo: Integer;
    lastNo: Integer;
    accountBal: Decimal;
    currentLiability: Decimal;
    payment: Decimal;
    remainder: Decimal;
    deathDep: Decimal;
    withAmount: Decimal;
    ESSAmount: Decimal;
    depAmount: Decimal;
    docNo: Code[30];
    loanNo: Code[20];
    JTemplate: Code[60];
    JBatch: Code[60];
    SFactorys: Codeunit "Au Factory";
    cust: Record Customer;
    vend: Record Vendor;
    PenaltyCounter: Record "Penalty Counter";
    CreditRating: Record "Credit Rating";
    SaccoSetup: Record "Sacco Setup";
    loansReg: Record "Loans Register";
    loanGuar: Record "Loans Guarantee Details";
    saccoGenSetup: Record "Sacco General Set-Up";
    GenBatches: Record "Gen. Journal Batch";
    GenJournalLine: Record "Gen. Journal Line";
    detCust: Record "Detailed Cust. Ledg. Entry";
}
