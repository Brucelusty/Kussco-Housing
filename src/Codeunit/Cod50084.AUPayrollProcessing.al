Codeunit 50084 "AU Payroll Processing"
{


    trigger OnRun()
    begin
    end;

    var
        Text020: label 'Because of circular references, the program cannot calculate a formula.';
        Text012: label 'You have entered an illegal value or a nonexistent row number.';
        Text013: label 'You have entered an illegal value or a nonexistent column number.';
        Text017: label 'The error occurred when the program tried to calculate:\';
        Text018: label 'Acc. Sched. Line: Row No. = %1, Line No. = %2, Totaling = %3\';
        Text019: label 'Acc. Sched. Column: Column No. = %4, Line No. = %5, Formula  = %6';
        Text023: label 'Formulas ending with a percent sign require %2 %1 on a line before it.';
        VitalSetup: Record "Payroll General Setup.";
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        Pcode: Record "Payroll Transaction Code.";
        curReliefMorgage: Decimal;
        Zakayo: Decimal;
        shifPercent: Decimal;
        shifReliefPerc: Decimal;
        shifMin: Decimal;
        shifReliefMax: Decimal;
        PrTransactionCodes: record "Payroll Transaction Code.";
        curMaximumRelief: Decimal;
        curNssfEmployee: Decimal;
        curNssf_Employer_Factor: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        intNSSF_BasedOn: Option Gross,Basic,"Taxable Pay";
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;

        AuFactory: Codeunit "Au Factory";
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        PostingGroup: Record "Payroll Posting Groups.";
        TaxAccount: Code[20];
        salariesAcc: Code[20];

        TransNames: Text[250];
        PAYEAccount: Code[20];
        PayablesAcc: Code[20];
        NSSFEMPyer: Code[20];
        PensionEMPyer: Code[20];
        NSSFEMPyee: Code[20];
        AddEarningsPaye: Decimal;
        NHIFEMPyer: Code[20];
        NHIFEMPyee: Code[20];
        HrEmployee: Record "Payroll Employee.";
        CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime,DevShare,NHIF,Holiday,SHIF;
        PayrollType: Code[20];
        SpecialTranAmount: Decimal;
        EmpSalary: Record "Payroll Employee.";
        txBenefitAmt: Decimal;
        TelTaxACC: Code[20];
        loans: Record "Loans Register";
        Management: Boolean;
        Members: Record Customer;


    procedure fnInitialize()
    begin
        //Initialize Global Setup Items
        VitalSetup.FindFirst;
        with VitalSetup do begin
            curReliefPersonal := "Tax Relief";
            curReliefInsurance := "Insurance Relief";
            curReliefMorgage := "Mortgage Relief"; //Same as HOSP
            curMaximumRelief := "Max Relief";
            curNssfEmployee := "NSSF Employee";
            curNssf_Employer_Factor := "NSSF Employer Factor";
            intNHIF_BasedOn := "NHIF Based on";
            shifPercent := SHIF;
            shifMin := "Min SHIF";
            shifReliefPerc := "SHIF Relief";
            shifReliefMax := "Max SHIF relief";
            curMaxPensionContrib := "Max Pension Contribution";
            curRateTaxExPension := "Tax On Excess Pension";
            curOOIMaxMonthlyContrb := "OOI Deduction";
            curOOIDecemberDedc := "OOI December";
            curLoanMarketRate := "Loan Market Rate";
            curLoanCorpRate := "Loan Corporate Rate";
            Zakayo := "Zakayo Levy";

        end;
    end;


    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; PayrollCode: Code[20]; SuspendPay: boolean)
    var
        strTableName: Text[50];
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curVolPension: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions.";
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record "Payroll Salary Arrears.";
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prTransactionCodes: Record "Payroll Transaction Code.";
        strExtractedFrml: Text[250];
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record "Employee Unused Relief.";
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curSHIF: Decimal;
        NhifRelief: Decimal;
        ShifRelief: Decimal;
        curTotalDeductions: Decimal;
        SaccoMember: code[40];
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        Schedule: Record "Loan Repayment Schedule";
        PrincipleLoan: decimal;
        LoanArrears: decimal;
        TotalPaidSchedule: decimal;
        TotalPaid: decimal;
        curOOI: Decimal;
        PayrollEmployees: Record "Payroll Employee.";
        curHOSP: Decimal;
        curLoanInt: Decimal;
        TransCodes: code[60];
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        JournalPostingType: Option " ","G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None",Member;
        JournalAcc: Code[20];
        Customer: Record Customer;
        JournalPostAs: Option " ",Debit,Credit;
        IsCashBenefit: Decimal;
        Teltax: Decimal;
        Teltax2: Decimal;
        prEmployeeTransactions2: Record "Payroll Employee Transactions.";
        prTransactionCodes3: Record "Payroll Transaction Code.";
        curTransAmount2: Decimal;
        curNssf_Base_Amount: Decimal;
        CurrInsuranceRel: Decimal;
        HousingLevy: Decimal;
        HousingRelief: Decimal;
        EmployeeP: Record "Payroll Employee.";
        LoanTypes: Record "Loan Products Setup";
        EssAmount: Decimal;
        Vendors: Record Vendor;
        contr: Boolean;
    begin
        //Initialize
        fnInitialize;
        fnGetJournalDet(strEmpCode);
        //PayrollType
        PayrollType := PayrollCode;


        if SuspendPay = false then begin

            if EmployeeP.Get(strEmpCode) then
                Management := EmployeeP."Managerial Position";

            //check if the period selected=current period. If not, do NOT run this function
            if SelectedPeriod <> dtOpenPeriod then exit;
            intMonth := Date2dmy(SelectedPeriod, 2);
            intYear := Date2dmy(SelectedPeriod, 3);

            if curBasicPay > 0 then begin
                //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                    CountDaysofMonth := fnDaysInMonth(dtDOE);
                    DaysWorked := fnDaysWorked(dtDOE, false);
                    curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
                end;

                //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                if dtTermination <> 0D then begin
                    if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                        CountDaysofMonth := fnDaysInMonth(dtTermination);
                        DaysWorked := fnDaysWorked(dtTermination, true);
                        curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
                    end;
                end;

                curTransAmount := curBasicPay;
                strTransDescription := 'Basic Pay';
                TGroup := 'BASIC SALARY';
                TGroupOrder := 1;
                TSubGroupOrder := 1;
                fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
                TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none, false);

                //Salary Arrears
                prSalaryArrears.Reset;
                prSalaryArrears.SetRange(prSalaryArrears."Employee Code", strEmpCode);
                prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
                prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
                if prSalaryArrears.Find('-') then begin
                    repeat
                        curSalaryArrears := prSalaryArrears."Salary Arrears";
                        curPayeArrears := prSalaryArrears."PAYE Arrears";

                        //Insert [Salary Arrears] into period trans [ARREARS]
                        curTransAmount := curSalaryArrears;
                        strTransDescription := 'Salary Arrears';
                        TGroup := 'ARREARS';
                        TGroupOrder := 1;
                        TSubGroupOrder := 2;
                        fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                          strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept, salariesAcc,
                          Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none, false);

                        //Insert [PAYE Arrears] into period trans [PYAR]
                        curTransAmount := curPayeArrears;
                        strTransDescription := 'P.A.Y.E Arrears';
                        TGroup := 'STATUTORIES';
                        TGroupOrder := 7;
                        TSubGroupOrder := 4;
                        fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                           strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                           salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none, true)

                    until prSalaryArrears.Next = 0;
                end;

                //Get Earnings
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                // prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
                if prEmployeeTransactions.Find('-') then begin
                    curTotAllowances := 0;
                    IsCashBenefit := 0;
                    
                    repeat
                        prTransactionCodes.Reset;
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);
                        //prTransactionCodes.SETRANGE(prTransactionCodes."Special Transaction",prTransactionCodes."Special Transaction"::Ignore);
                        if prTransactionCodes.Find('-') then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                            AddEarningsPaye := 0;
                            strTransDescription := '';
                            strExtractedFrml := '';
                            if prTransactionCodes."Is Formulae" then begin
                                //if Management then
                                //strExtractedFrml:=fnPureFormula(strEmpCode, intMonth, intYear,prTransactionCodes."Leave Reimbursement")
                                //ELSE
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                                curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '<'); //Get the calculated amount

                            end else begin
                                curTransAmount := prEmployeeTransactions.Amount;
                                // curTransAmount := prEmployeeTransactions."Original Deduction Amount";
                            end;
                            AddEarningsPaye := curTransAmount;
                            if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::None then //[0=None, 1=Increasing, 2=Reducing]
                                curTransBalance := 0;
                            if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Increasing then
                                curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                            if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing then
                                curTransBalance := prEmployeeTransactions.Balance - curTransAmount;


                            //Prorate Allowances Here
                            //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                            if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                                CountDaysofMonth := fnDaysInMonth(dtDOE);
                                DaysWorked := fnDaysWorked(dtDOE, false);
                                curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                            end;

                            //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                            if dtTermination <> 0D then begin
                                if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                                    CountDaysofMonth := fnDaysInMonth(dtTermination);
                                    DaysWorked := fnDaysWorked(dtTermination, true);
                                    curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                                end;
                            end;
                            // Prorate Allowances Here



                            //Add Non Taxable Here
                            if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transaction" =
                            prTransactionCodes."special transaction"::Ignore) then
                                curNonTaxable := curNonTaxable + curTransAmount;


                            //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                            if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transaction" <>
                            prTransactionCodes."special transaction"::Ignore) then
                                curTransAmount := 0;


                            curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                            curTransAmount := curTransAmount;
                            curTransBalance := curTransBalance;
                            strTransDescription := prTransactionCodes."Transaction Name";
                            TGroup := 'ALLOWANCE';
                            TGroupOrder := 3;
                            TSubGroupOrder := 0;


                            //Get the posting Details
                            JournalPostingType := Journalpostingtype::" ";
                            JournalAcc := '';
                            if prTransactionCodes.SubLedger <> prTransactionCodes.Subledger::" " then begin
                                if prTransactionCodes.SubLedger = prTransactionCodes.Subledger::Customer then begin

                                    HrEmployee.Get(strEmpCode);
                                    Customer.Reset;
                                    Customer.SetRange(Customer."No.", HrEmployee."Sacco Membership No.");
                                    if Customer.Find('-') then begin
                                        JournalAcc := Customer."No.";
                                        JournalPostingType := Journalpostingtype::Customer;
                                    end;
                                end;
                            end else begin
                                JournalAcc := prTransactionCodes."G/L Account";
                                JournalPostingType := Journalpostingtype::"G/L Account";
                            end;

                            //Get is Cash Benefits
                            if prTransactionCodes."Is Cash" then
                                IsCashBenefit := IsCashBenefit + curTransAmount;
                            //End posting Details

                            fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                            strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                            prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, Journalpostas::Debit, JournalPostingType, '',
                            prTransactionCodes."Co-Op Parameters", false);

                        end;
                    until prEmployeeTransactions.Next = 0;
                end;


                //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
                curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
                curTransAmount := curGrossPay;
                strTransDescription := 'Gross Pay';
                TGroup := 'GROSS PAY';
                TGroupOrder := 4;
                TSubGroupOrder := 0;
                fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
                 intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none, false);

                //Get the NSSF amount
                //insert housing levy Kit
                prTransactionCodes.reset;
                prTransactionCodes.SetRange(prTransactionCodes."is Housing Levy", true);
                if prTransactionCodes.FindFirst() then begin
                    prEmployeeTransactions.Reset;
                    prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                    prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                    prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                    //prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                    prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                    if prEmployeeTransactions.FindFirst() then begin
                        prEmployeeTransactions.DeleteAll(true);
                    end;

                    prEmployeeTransactions.Reset;
                    prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                    prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                    prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                    prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                    prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                    if NOT prEmployeeTransactions.Find('-') then begin
                        prEmployeeTransactions.Init();
                        prEmployeeTransactions.Reset();
                        if prEmployeeTransactions.FindLast() then begin
                            prEmployeeTransactions."Entry No" := prEmployeeTransactions."Entry No" + 1;
                        end;
                        HousingLevy := 0;
                        HousingLevy := (prTransactionCodes."Housing Levy%" / 100) * curGrossPay;
                        prEmployeeTransactions."No." := strEmpCode;
                        prEmployeeTransactions."Period Month" := intMonth;
                        prEmployeeTransactions."Period Year" := intYear;
                        prEmployeeTransactions."Payroll Code" := PayrollCode;
                        prEmployeeTransactions."Payroll Period" := SelectedPeriod;
                        prEmployeeTransactions."Transaction Code" := prTransactionCodes."Transaction Code";
                        prEmployeeTransactions."Transaction Name" := 'Housing Levy';
                        prEmployeeTransactions."Original Amount" := HousingLevy;
                        prEmployeeTransactions."Original Deduction Amount" := HousingLevy;
                        prEmployeeTransactions.Amount := HousingLevy;
                        prEmployeeTransactions."Amount(LCY)" := HousingLevy;
                        prEmployeeTransactions."Transaction Type" := prEmployeeTransactions."Transaction Type"::Deduction;
                        if prEmployeeTransactions."Original Deduction Amount" > 0 then
                            // prEmployeeTransactions.Insert(true);

                        curTransAmount := HousingLevy;
                        strTransDescription := 'Housing Levy';
                        TGroup := 'STATUTORIES';
                        TGroupOrder := 7;
                        TSubGroupOrder := 4;

                        fnUpdatePeriodTrans(strEmpCode, 'HSNLVY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
                        intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none, true);
                    end;
                end;
                //end insertion

                Members.Reset();
                Members.SetRange(Members."Payroll No", strEmpCode);
                Members.SetFilter(Members."Monthly Contribution", '>%1', 0);
                if Members.FindFirst() then begin

                    //Deduct Deposits
                    prTransactionCodes.reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Co-Op Parameters", prTransactionCodes."Co-Op Parameters"::Shares);
                    if prTransactionCodes.FindFirst() then begin
                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                        if prEmployeeTransactions.FindFirst() then begin
                            prEmployeeTransactions.DeleteAll(true);
                        end;

                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                        if NOT prEmployeeTransactions.Find('-') then begin
                            prEmployeeTransactions.Init();
                            prEmployeeTransactions.Reset();
                            if prEmployeeTransactions.FindLast() then begin
                                prEmployeeTransactions."Entry No" := prEmployeeTransactions."Entry No" + 1;
                            end;
                            Vendors.Reset();
                            Vendors.SetRange(Vendors."BOSA Account No", Members."No.");
                            Vendors.SetFilter(Vendors."Account Type", '102');
                            if Vendors.FindFirst() then begin
                                Vendors.CalcFields(Balance);
                                prEmployeeTransactions."No." := strEmpCode;
                                prEmployeeTransactions."Period Month" := intMonth;
                                prEmployeeTransactions."Period Year" := intYear;
                                prEmployeeTransactions."Payroll Code" := PayrollCode;
                                prEmployeeTransactions."Payroll Period" := SelectedPeriod;
                                prEmployeeTransactions.Membership := Vendors."No.";
                                prEmployeeTransactions."Transaction Code" := prTransactionCodes."Transaction Code";
                                prEmployeeTransactions."Transaction Name" := prTransactionCodes."Transaction Name";
                                prEmployeeTransactions."Original Amount" := Members."Monthly Contribution";
                                prEmployeeTransactions."Original Deduction Amount" := Members."Monthly Contribution";
                                prEmployeeTransactions.Amount := Members."Monthly Contribution";
                                prEmployeeTransactions."Amount(LCY)" := Members."Monthly Contribution";
                                prEmployeeTransactions.Balance := Vendors.Balance;
                                prEmployeeTransactions."Balance(LCY)" := Vendors.Balance;
                                prEmployeeTransactions."Transaction Type" := prEmployeeTransactions."Transaction Type"::Deduction;
                                if prEmployeeTransactions."Original Deduction Amount" > 0 then
                                    prEmployeeTransactions.Insert(true);
                            end;
                        end;
                    end;
                    //End Deduct Deposits

                    //Deduct Benevolent
                    prTransactionCodes.reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Co-Op Parameters", prTransactionCodes."Co-Op Parameters"::Benevolent);
                    if prTransactionCodes.FindFirst() then begin
                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                        if prEmployeeTransactions.FindFirst() then begin
                            prEmployeeTransactions.DeleteAll(true);
                        end;

                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                        if NOT prEmployeeTransactions.Find('-') then begin
                            prEmployeeTransactions.Init();
                            prEmployeeTransactions.Reset();
                            if prEmployeeTransactions.FindLast() then begin
                                prEmployeeTransactions."Entry No" := prEmployeeTransactions."Entry No" + 1;
                            end;

                            prEmployeeTransactions."No." := strEmpCode;
                            prEmployeeTransactions."Period Month" := intMonth;
                            prEmployeeTransactions."Period Year" := intYear;
                            prEmployeeTransactions."Payroll Code" := PayrollCode;
                            prEmployeeTransactions."Payroll Period" := SelectedPeriod;
                            prEmployeeTransactions.Membership := Vendors."No.";
                            prEmployeeTransactions."Transaction Code" := prTransactionCodes."Transaction Code";
                            prEmployeeTransactions."Transaction Name" := prTransactionCodes."Transaction Name";
                            prEmployeeTransactions."Original Amount" := 300;
                            prEmployeeTransactions."Original Deduction Amount" := 300;
                            prEmployeeTransactions.Amount := 300;
                            prEmployeeTransactions."Amount(LCY)" := 300;
                            prEmployeeTransactions."Transaction Type" := prEmployeeTransactions."Transaction Type"::Deduction;
                            if prEmployeeTransactions."Original Deduction Amount" > 0 then
                                prEmployeeTransactions.Insert(true);

                        end;
                    end;



                    //End Deduct Benevolent



                end;


                Members.Reset();
                Members.SetRange(Members."Payroll No", strEmpCode);
                Members.SetFilter(Members."ESS Contribution", '>%1', 0);
                if Members.FindFirst() then begin
                    prTransactionCodes.reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Co-Op Parameters", prTransactionCodes."Co-Op Parameters"::ESS);
                    if prTransactionCodes.FindFirst() then begin
                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                        if prEmployeeTransactions.FindFirst() then begin
                            prEmployeeTransactions.DeleteAll(true);
                        end;

                        Vendors.Reset();
                        Vendors.SetRange(Vendors."BOSA Account No", Members."No.");
                        Vendors.SetFilter(Vendors."Account Type", '104');
                        if Vendors.FindFirst() then begin
                            Vendors.CalcFields(Balance);
                            prEmployeeTransactions.Reset;
                            prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                            prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                            prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                            if NOT prEmployeeTransactions.Find('-') then begin
                                prEmployeeTransactions.Init();
                                prEmployeeTransactions.Reset();
                                if prEmployeeTransactions.FindLast() then begin
                                    prEmployeeTransactions."Entry No" := prEmployeeTransactions."Entry No" + 1;
                                end;

                                prEmployeeTransactions."No." := strEmpCode;
                                prEmployeeTransactions."Period Month" := intMonth;
                                prEmployeeTransactions."Period Year" := intYear;
                                prEmployeeTransactions."Payroll Code" := PayrollCode;
                                prEmployeeTransactions."Payroll Period" := SelectedPeriod;
                                prEmployeeTransactions."Transaction Code" := prTransactionCodes."Transaction Code";
                                prEmployeeTransactions."Transaction Name" := prTransactionCodes."Transaction Name";
                                prEmployeeTransactions.Membership := Vendors."No.";
                                prEmployeeTransactions."Original Amount" := Members."ESS Contribution";
                                prEmployeeTransactions."Original Deduction Amount" := Members."ESS Contribution";
                                prEmployeeTransactions.Amount := Members."ESS Contribution";
                                prEmployeeTransactions."Amount(LCY)" := Members."ESS Contribution";
                                prEmployeeTransactions.Balance := Vendors.Balance;
                                prEmployeeTransactions."Balance(LCY)" := Vendors.Balance;
                                prEmployeeTransactions."Transaction Type" := prEmployeeTransactions."Transaction Type"::Deduction;
                                if prEmployeeTransactions."Original Deduction Amount" > 0 then
                                    prEmployeeTransactions.Insert(true);
                            end;
                        end;
                    end;
                end;


                //insert Vol Pension Kit
                if fnCheckPaysVoluntaryPension(strEmpCode) = true then begin
                    curVolPension := 0;
                    prTransactionCodes.reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Is Pension", true);
                    if prTransactionCodes.FindFirst() then begin
                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        //prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                        if prEmployeeTransactions.FindFirst() then begin
                            prEmployeeTransactions.DeleteAll(true);
                        end;

                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                        if NOT prEmployeeTransactions.Find('-') then begin
                            prEmployeeTransactions.Init();
                            prEmployeeTransactions.Reset();
                            if prEmployeeTransactions.FindLast() then begin
                                prEmployeeTransactions."Entry No" := prEmployeeTransactions."Entry No" + 1;
                            end;
                            prEmployeeTransactions."No." := strEmpCode;
                            prEmployeeTransactions."Period Month" := intMonth;
                            prEmployeeTransactions."Period Year" := intYear;
                            prEmployeeTransactions."Payroll Code" := PayrollCode;
                            prEmployeeTransactions."Payroll Period" := SelectedPeriod;
                            prEmployeeTransactions."Transaction Code" := prTransactionCodes."Transaction Code";
                            prEmployeeTransactions."Transaction Name" := prTransactionCodes."Transaction Name";
                            prEmployeeTransactions."Original Amount" := fnCalculateVoluntaryPension(strEmpCode);
                            prEmployeeTransactions."Original Deduction Amount" := fnCalculateVoluntaryPension(strEmpCode);
                            prEmployeeTransactions.Amount := fnCalculateVoluntaryPension(strEmpCode);
                            prEmployeeTransactions."Amount(LCY)" := fnCalculateVoluntaryPension(strEmpCode);
                            prEmployeeTransactions."Transaction Type" := prEmployeeTransactions."Transaction Type"::Deduction;
                            if prEmployeeTransactions."Original Deduction Amount" > 0 then
                                prEmployeeTransactions.Insert(true);
                            curVolPension := fnCalculateVoluntaryPension(strEmpCode);
                            // Message('Pays%1',curVolPension);
                        end;
                    end;
                end;
                //end insertion

                //Get the N.S.S.F amount for the month GBT
                curNssf_Base_Amount := 0;

                if intNSSF_BasedOn = Intnssf_basedon::Gross then //>NSSF calculation can be based on:
                    curNssf_Base_Amount := curGrossPay;
                if intNSSF_BasedOn = Intnssf_basedon::Basic then
                    curNssf_Base_Amount := curBasicPay;



                if blnPaysNssf then
                    // curNSSF := curNssfEmployee;
                    //Error('BaseAmount%1',curNssf_Base_Amount);
                    curNSSF := fnGetEmployeeNSSF(curNssf_Base_Amount);//2160;
                //fnGetEmployeeNSSF(curNssf_Base_Amount);//client using the old rates
                curTransAmount :=  curNSSF;
                curNSSF :=  curNSSF;
                strTransDescription := 'N.S.S.F';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 1;
                fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
                strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
                Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NSSF, true);


                curNhif_Base_Amount := 0;

                if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                    curNhif_Base_Amount := curGrossPay;
                if intNHIF_BasedOn = Intnhif_basedon::Basic then
                    curNhif_Base_Amount := curBasicPay;
                if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                    curNhif_Base_Amount := curTaxablePay;

                if blnPaysNhif then begin
                    curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                end;

                //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
                curDefinedContrib := curNSSF + EmployeeP."Insurance Premium" + curNHIF + HousingLevy;//curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
                curTransAmount := curDefinedContrib;
                strTransDescription := 'Defined Contributions';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 1;

                fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
                intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none, false);


                //Get the Gross taxable amount
                //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
                curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;

                //>If GrossTaxable = 0 Then TheDefinedToPost = 0
                if curGrossTaxable = 0 then curDefinedContrib := 0;


                VitalSetup.Get();
                //Get Insurance Relief
                EmployeeP.Reset;
                EmployeeP.SetRange(EmployeeP."No.", strEmpCode);
                if EmployeeP.Find('-') then begin

                    CurrInsuranceRel := EmployeeP."Insurance Premium" * (VitalSetup."Insurance Relief" / 100);


                    //Insert Insurance Relief
                    curTransAmount := CurrInsuranceRel;
                    strTransDescription := 'Insurance Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 8;
                    fnUpdatePeriodTrans(strEmpCode, 'INSRD', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
               curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
               Coopparameters::none, false);

                end;

                //Personal Relief
                if blnGetsPAYERelief then begin
                    curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                    curTransAmount := curReliefPersonal;
                    strTransDescription := 'Personal Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 9;
                    fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                     Coopparameters::none, false);
                end;
                //ELSE
                // curReliefPersonal := 0;

                //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                //>Pension Contribution [self] relief
                curPensionStaff := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
                if curPensionStaff > 0 then begin
                    if curPensionStaff > curMaxPensionContrib then
                        curTransAmount := curMaxPensionContrib
                    else
                        curTransAmount := curPensionStaff;
                    strTransDescription := 'Pension Contribution';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 2;
                    fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                    Coopparameters::none, false)
                end;

                //if he PAYS paye only*******************I
                if blnPaysPaye and blnGetsPAYERelief then begin
                    //Get Insurance Relief
                    SpecialTranAmount := 0;
                    curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                    Specialtranstype::"Life Insurance", false); //Insurance is 3 on [Special Transaction]

                    if curInsuranceReliefAmount > 0 then begin
                        curTransAmount := curInsuranceReliefAmount;
                        strTransDescription := 'Insurance Relief';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 8;
                        fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                        Coopparameters::none, false);
                    end;

                    //>OOI
                    curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                    Specialtranstype::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
                    if curOOI > 0 then begin
                        if curOOI <= curOOIMaxMonthlyContrb then
                            curTransAmount := curOOI
                        else
                            curTransAmount := curOOIMaxMonthlyContrb;

                        strTransDescription := 'Owner Occupier Interest';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 3;
                        fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                        Coopparameters::none, false);
                    end;

                    //HOSP
                    curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                    Specialtranstype::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
                    if curHOSP > 0 then begin
                        if curHOSP <= curReliefMorgage then
                            curTransAmount := curHOSP
                        else
                            curTransAmount := curReliefMorgage;

                        strTransDescription := 'Home Ownership Savings Plan';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 4;
                        fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                        Coopparameters::none, false);
                    end;
                end;

                curNhif_Base_Amount := 0;

                if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                    curNhif_Base_Amount := curGrossPay;
                if intNHIF_BasedOn = Intnhif_basedon::Basic then
                    curNhif_Base_Amount := curBasicPay;
                if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                    curNhif_Base_Amount := curTaxablePay;

                if blnPaysNhif then begin
                    curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                end;

                if curPensionStaff > curMaxPensionContrib then
                    curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curMaxPensionContrib + curOOI + curHOSP + curNonTaxable)
                else
                    curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable);


                //Taxable Benefit
                txBenefitAmt := 0;
                if EmpSalary.Get(strEmpCode) then begin
                    if EmpSalary."Pays NSSF" = false then begin
                        if fnCheckPaysPension(strEmpCode, SelectedPeriod) = true then begin
                            if (EmpSalary."Basic Pay" * 0.1) > 20000 then begin
                                txBenefitAmt := EmpSalary."Basic Pay" * 0.2;
                            end else begin
                                txBenefitAmt := ((EmpSalary."Basic Pay" * 0.2) + (EmpSalary."Basic Pay" * 0.1)) - 20000;
                                if txBenefitAmt < 0 then
                                    txBenefitAmt := 0;
                            end;
                            strTransDescription := 'Taxable Pension';
                            TGroup := 'TAX CALCULATIONS';
                            TGroupOrder := 6;
                            TSubGroupOrder := 6;
                            fnUpdatePeriodTrans(strEmpCode, 'TXBB', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                             txBenefitAmt, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                             Coopparameters::none, false);
                        end;
                    end;
                end;
                // Message('curTaxablePay%1curTransAmount%2txBenefitAmt%3AddEarningsPaye%4', curTaxablePay, curTransAmount, txBenefitAmt, AddEarningsPaye);
                curTransAmount := curTaxablePay + txBenefitAmt; //+ AddEarningsPaye;
                strTransDescription := 'Taxable Pay';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 6;
                fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                 Coopparameters::none, false);

                //Get the Tax charged for the month

                curTaxablePay := curTaxablePay + txBenefitAmt;//+ AddEarningsPaye;
                                                              // Message('Goss%1Tax%2Isurance%3curReliefPersonal%4CurrInsuranceRel%5', curTaxablePay, ROUND(fnGetEmployeePaye(curTaxablePay), 1, '>'), curInsuranceReliefAmount, curReliefPersonal, CurrInsuranceRel);
                curTaxCharged := ROUND(fnGetEmployeePaye(curTaxablePay), 1, '>') - (curInsuranceReliefAmount + curReliefPersonal + CurrInsuranceRel + NhifRelief + HousingRelief);
                curTransAmount := curTaxCharged + 2400;
                strTransDescription := 'Tax Charged';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 7;
                fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                Coopparameters::none, false);

                //IF strEmpCode='028' THEN MESSAGE(FORMAT(curInsuranceReliefAmount+curReliefPersonal+CurrInsuranceRel));
                //Message('curTaxCharged%1NhifRelief%2curReliefPersonal%3curInsuranceReliefAmount%4curTaxCharged %5', ROUND(fnGetEmployeePaye(curTaxablePay), 1, '>'), curReliefPersonal, CurrInsuranceRel, curInsuranceReliefAmount, curTaxCharged);
                //Get the Net PAYE amount to post for the monthcurReliefPersonal
                //  Message('curTransAmount%1', curTransAmount);
                NhifRelief := fnGetEmployeeNHIF(curGrossPay) * 0.15;
                NhifRelief := 0;

                if HousingLevy > 0 then begin
                    HousingRelief := 0;
                    HousingRelief := HousingLevy * 0.15;
                    HousingRelief := 0;
                end;

                if (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief then
                    //curPAYE :=ROUND( curTaxCharged - curMaximumRelief,1,'<')

                    curPAYE := (curTaxCharged - curMaximumRelief) - (NhifRelief + HousingRelief)
                //curPAYE :=( curTaxCharged - curReliefPersonal )
                else
                    //curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount);
                    curPAYE := (curTaxCharged) - (NhifRelief + HousingRelief);
                //curPAYE := ROUND(curTaxCharged,1,'<');



                if not blnPaysPaye then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
                curTransAmount := curPAYE;//+curTransAmount2;

                if curPAYE < 0 then curTransAmount := 0;
                strTransDescription := 'P.A.Y.E';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 3;
                fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, PAYEAccount, Journalpostas::Credit,
                 Journalpostingtype::"G/L Account", '', Coopparameters::none, true);

                //Store the unused relief for the current month
                //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
                if curPAYE < 0 then begin
                    prUnusedRelief.Reset;
                    prUnusedRelief.SetRange(prUnusedRelief."Employee No.", strEmpCode);
                    prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
                    prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
                    if prUnusedRelief.Find('-') then
                        prUnusedRelief.Delete;

                    prUnusedRelief.Reset;
                    with prUnusedRelief do begin
                        Init;
                        "Employee No." := strEmpCode;
                        "Unused Relief" := curPAYE;
                        "Period Month" := intMonth;
                        "Period Year" := intYear;
                        Insert;

                        curPAYE := 0;
                    end;
                end;

                //nhif relief
                curNhif_Base_Amount := 0;

                if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                    curNhif_Base_Amount := curGrossPay;
                if intNHIF_BasedOn = Intnhif_basedon::Basic then
                    curNhif_Base_Amount := curBasicPay;
                if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                    curNhif_Base_Amount := curTaxablePay;

                if blnPaysNhif then begin
                    //curNHIF:=450;
                    //Personal Relief

                    // NhifRelief := fnGetEmployeeNHIF(curNhif_Base_Amount) * 0.15; //*****Get curUnusedRelief
                    NhifRelief := fnGetEmployeeNHIF(curNhif_Base_Amount) * (shifReliefPerc/100); //*****Get curUnusedRelief
                    if NhifRelief > shifReliefMax then NhifRelief := shifReliefMax;
                    NhifRelief := 0;
                    if NhifRelief <> 0 then begin
                        curTransAmount := NhifRelief;
                        strTransDescription := 'SHIF Relief';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 9;
                        fnUpdatePeriodTrans(strEmpCode, 'SHIF Re', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                        Coopparameters::none, false);
                    end;
                end;

                if HousingLevy > 0 then begin
                    HousingRelief := 0;
                    if HousingRelief <> 0 then begin
                        HousingRelief := HousingLevy * 0.15; //*****Get curUnusedRelief
                        curTransAmount := HousingRelief;
                        strTransDescription := 'Housing Levy Relief';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 9;
                        fnUpdatePeriodTrans(strEmpCode, 'Housing Levy Relief', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                        Coopparameters::none, false);
                    end;
                end;



                //Get the N.H.I.F amount for the month GBT
                curNhif_Base_Amount := 0;

                if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                    curNhif_Base_Amount := curGrossPay;
                if intNHIF_BasedOn = Intnhif_basedon::Basic then
                    curNhif_Base_Amount := curBasicPay;
                if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                    curNhif_Base_Amount := curTaxablePay;

                if blnPaysNhif then begin
                    //curNHIF:=450;
                    curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);

                    // curNHIF:=320;
                    curTransAmount := curNHIF;
                    strTransDescription := 'S.H.I.F';//
                    TGroup := 'STATUTORIES';
                    TGroupOrder := 7;
                    TSubGroupOrder := 2;
                    fnUpdatePeriodTrans(strEmpCode, 'SHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                     NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::SHIF, true);

                end;

                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                if prEmployeeTransactions.Find('-') then begin
                    curTotalDeductions := 0;

                    repeat
                        prTransactionCodes.Reset;
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                        prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Deduction);
                        if prTransactionCodes.Find('-') then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                            strTransDescription := '';
                            strExtractedFrml := '';
                            //Message('transaction code 2 %1 -%2', prEmployeeTransactions."Transaction Code", strEmpCode);
                            if prTransactionCodes."Is Formulae" then begin
                                // if Management then
                                //                strExtractedFrml:=fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Leave Reimbursement")
                                //              ELSE
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                                curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                            end else begin
                                curTransAmount := prEmployeeTransactions."Original Deduction Amount";
                            end;
                            //Message('%1-%2', curTransAmount, strEmpCode);

                            //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                            if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Life Insurance")
                              and (prTransactionCodes."Deduct Premium" = false) then begin
                                curTransAmount := 0;
                            end;

                            //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                            if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::Morgage)
                             and (prTransactionCodes."Deduct Mortgage" = false) then begin
                                curTransAmount := 0;
                            end;

                            if prTransactionCodes."IsCo-Op/LnRep" = true then begin
                                CoopParameters := prTransactionCodes."Co-Op Parameters";
                            end;


                            //Get the posting Details
                            JournalPostingType := Journalpostingtype::" ";
                            JournalAcc := '';
                            if prTransactionCodes.SubLedger <> prTransactionCodes.Subledger::" " then begin
                                if prTransactionCodes.SubLedger = prTransactionCodes.Subledger::Customer then begin
                                    HrEmployee.Get(strEmpCode);

                                    //IF prTransactionCodes.CustomerPostingGroup ='' THEN
                                    //Customer.SETRANGE(Customer."Employer Code",'KPSS');

                                    if prTransactionCodes."Customer Posting Group" <> '' then begin
                                        Customer.SetRange(Customer."Customer Posting Group", prTransactionCodes."Customer Posting Group");
                                    end;
                                    Customer.Reset;
                                    Customer.SetRange(Customer."No.", HrEmployee."Payroll No");
                                    //MESSAGE('%1,%2,%3',JournalAcc,strEmpCode,Customer."Payroll/Staff No");
                                    if Customer.Find('-') then begin
                                        JournalAcc := Customer."No.";
                                        JournalPostingType := Journalpostingtype::Customer;
                                    end;
                                end;
                            end else begin
                                JournalAcc := prTransactionCodes."G/L Account";
                                JournalPostingType := Journalpostingtype::"G/L Account";
                            end;

                            //End posting Details


                            //End Loan transaction calculation
                            //Fringe Benefits and Low interest Benefits
                            if prTransactionCodes."Fringe Benefit" = true then begin
                                if prTransactionCodes."Interest Rate" < curLoanMarketRate then begin
                                    fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
                                     * prEmployeeTransactions.Balance;
                                end;
                            end else begin
                                fnCalcFringeBenefit := 0;
                            end;
                            if fnCalcFringeBenefit > 0 then begin
                                fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
                                 'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

                            end;
                            //End Fringe Benefits
                            //Message('second %1-%2', curTransAmount, strEmpCode);
                            //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                            if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Staff Loan") and
                               (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Reducing) then begin
                                curTransAmount := 0;
                                curLoanInt := 0;
                                if (FnLoanInterestExempted(prEmployeeTransactions."Loan Number") = false) then
                                    //curLoanInt := ROUND(prEmployeeTransactions."Original Deduction Amount", 1, '=');/*fnCalcLoanInterest (strEmpCode, prEmployeeTransactions."Transaction Code", prEmployeeTransactions."Outstanding Interest",
                                    //FnGetInterestRate(prEmployeeTransactions."Transaction Code"),prTransactionCodes."Repayment Method",
                                    //prEmployeeTransactions.Amount,prEmployeeTransactions.Balance,SelectedPeriod,prEmployeeTransactions."Interest Charged",FALSE)*/

                                    //Post the Interest
                                    //IF (curLoanInt<>0) THEN BEGIN
                                    curTransAmount := 0;
                                //curTransAmount := prEmployeeTransactions."Interest Charged";


                                curTransAmount := curLoanInt;
                                curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions

                                curTransBalance := 0;
                                strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                                strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                                TGroup := 'DEDUCTIONS';
                                TGroupOrder := 8;
                                TSubGroupOrder := 1;
                                if curTransAmount <> 0 then
                                    fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                      strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                                      JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                                      Coopparameters::"loan Interest", false);
                                //                curTransAmount :=prEmployeeTransactions.Amount;
                                //                prEmployeeTransactions.Amount:=curTransAmount;

                                //curTransAmount := prEmployeeTransactions."Amtzd Loan Repay Amt" - curLoanInt;
                                curTransAmount := prEmployeeTransactions."Original Deduction Amount";



                                prEmployeeTransactions."Original Deduction Amount" := prEmployeeTransactions."Original Deduction Amount";
                                prEmployeeTransactions.Amount := prEmployeeTransactions."Original Deduction Amount";
                                //prEmployeeTransactions.MODIFY;


                                prEmployeeTransactions.Modify;
                            end;
                            //Loan Calculation Amortized



                            case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                                prTransactionCodes."balance type"::None:
                                    curTransBalance := 0;
                                prTransactionCodes."balance type"::Increasing:
                                    curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                                prTransactionCodes."balance type"::Reducing:
                                    begin
                                        //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                        if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                            curTransAmount := prEmployeeTransactions.Balance;
                                            curTransBalance := 0;
                                        end else begin
                                            curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                        end;
                                        if curTransBalance < 0 then begin
                                            curTransAmount := 0;
                                            curTransBalance := 0;
                                        end;
                                    end
                            end;



                            if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Staff Loan") and
                               (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Amortized) then begin
                                curTransAmount := 0;
                                curLoanInt := 0;
                                curLoanInt := ROUND(prEmployeeTransactions."Interest Charged", 1, '=');
                                /*fnCalcLoanInterest (strEmpCode, prEmployeeTransactions."Transaction Code",
                                prTransactionCodes."Interest Rate",prTransactionCodes."Repayment Method",
                                  prEmployeeTransactions."Original Amount",prEmployeeTransactions.Balance,SelectedPeriod,prEmployeeTransactions."Interest Charged",FALSE);*/
                                //Post the Interest
                                //IF (curLoanInt<>0) THEN BEGIN
                                curTransAmount := curLoanInt;
                                //curTransAmount := prEmployeeTransactions.Amount-curLoanInt;

                                curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions


                                curTransBalance := 0;
                                strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                                strTransDescription := loans."Loan  No." + 'Interest';
                                TGroup := 'DEDUCTIONS';
                                TGroupOrder := 8;
                                TSubGroupOrder := 1;
                                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                  strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                                  JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                                  Coopparameters::"loan Interest", false);
                                // END;
                                //Get the Principal Amt
                                //curTransAmount:=prEmployeeTransactions."Amtzd Loan Repay Amt"-curLoanInt;//28-Oct-2019
                                curTransAmount := prEmployeeTransactions."Original Deduction Amount";
                                //curTransAmount:=prEmployeeTransactions.Amount;
                                // curTransAmount :=curLoanInt;// prEmployeeTransactions.Amount;
                                //Modify PREmployeeTransaction Table
                                //prEmployeeTransactions."Original Deduction Amount":=cu;
                                prEmployeeTransactions.Amount := curTransAmount;
                                prEmployeeTransactions."Original Deduction Amount" := prEmployeeTransactions."Original Deduction Amount";
                                prEmployeeTransactions.Modify;
                            end;
                            //Loan Calculation Amortized



                            case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                                prTransactionCodes."balance type"::None:
                                    curTransBalance := 0;
                                prTransactionCodes."balance type"::Increasing:
                                    curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                                prTransactionCodes."balance type"::Reducing:
                                    begin
                                        //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                        if prEmployeeTransactions.Balance < prEmployeeTransactions."Original Deduction Amount" then begin
                                            curTransAmount := prEmployeeTransactions.Balance;
                                            curTransBalance := 0;
                                        end else begin
                                            curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                        end;

                                        if curTransBalance < 0 then begin
                                            curTransAmount := 0;
                                            curTransBalance := 0;
                                        end;

                                    end;


                            end;
                            SaccoMember := '';
                            PayrollEmployees.reset;
                            PayrollEmployees.setrange(PayrollEmployees."No.", strEmpCode);
                            if PayrollEmployees.FindFirst then begin
                                SaccoMember := PayrollEmployees."Payroll No";
                            end;

                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                                                                       //Message('deduction%1-%2', curTotalDeductions, prTransactionCodes."Transaction Name");

                            curTransAmount := curTransAmount;
                            curTransBalance := curTransBalance;
                            strTransDescription := prTransactionCodes."Transaction Name";
                            contr := prTransactionCodes."Is Contribution";
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 0;
                            fnUpdatePeriodTransSacco(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                             strTransDescription, curTransAmount, curTransBalance, intMonth,
                             intYear, SaccoMember, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                             JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                             prTransactionCodes."Co-Op Parameters", SaccoMember, contr);//prEmployeeTransactions.Membership

                            //Create Employer Deduction
                            if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                                if prTransactionCodes."Formulae for Employer" <> '' then begin
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Formulae for Employer");
                                    curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                                end else begin
                                    curTransAmount := prEmployeeTransactions."Employer Amount";
                                end;
                                if curTransAmount > 0 then
                                    fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
                                     'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                                      prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

                            end;
                            //Employer deductions

                        end;

                    until prEmployeeTransactions.Next = 0;

                    // curTotalDeductions := curTotalDeductions + curNSSF + curNHIF + curPAYE + curPayeArrears;
                    // Message('deductions %1', curTotalDeductions);
                    // curTransBalance := 0;
                    // strTransCode := 'TOT-DED';
                    // strTransDescription := 'TOTAL DEDUCTION';
                    // TGroup := 'DEDUCTIONS';
                    // TGroupOrder := 8;
                    // TSubGroupOrder := 9;
                    // fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                    //   strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
                    //   prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                    //   '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none)

                    //END GET TOTAL DEDUCTIONS
                end;

                //Loans Deductions Kitui
                PayrollEmployees.reset;
                PayrollEmployees.setrange(PayrollEmployees."No.", strEmpCode);
                if PayrollEmployees.FindFirst then begin
                    Loans.Reset;
                    Loans.setrange(Loans."Client Code", PayrollEmployees."Payroll No");
                    loans.SetAutoCalcFields(Loans."Total Outstanding Balance");
                    loans.SetRange(loans.Posted, true);
                    loans.setfilter(Loans."Total Outstanding Balance", '>%1', 0);
                    if loans.FindFirst() then begin
                        repeat
                            loans.CalcFields(loans."Outstanding Balance", loans."Outstanding Interest", loans."Total Outstanding Balance");
                            Pcode.reset;
                            Pcode.Setrange(Pcode."Loan Product", loans."Loan Product Type");
                            if Pcode.findfirst() then begin
                                TransCodes := Pcode."Transaction Code";
                                
                                if loans."Total Outstanding Balance" > 0 then begin

                                    TotalPaid := 0;
                                    TotalPaidSchedule := 0;
                                    TotalPaid := Loans."Approved Amount" - Loans."Outstanding Balance";
                                    Schedule.reset;
                                    Schedule.SetRange(Schedule."Loan No.", Loans."Loan  No.");
                                    Schedule.SetFilter(Schedule."Repayment Date", '..%1', Calcdate('-1M', Calcdate('CM', SelectedPeriod)));
                                    if Schedule.find('-') then begin
                                        Schedule.calcsums(schedule."Principal Repayment");
                                        TotalPaidSchedule := schedule."Principal Repayment";
                                    end;

                                    LoanArrears := 0;
                                    LoanArrears := TotalPaidSchedule - TotalPaid;

                                    if LoanArrears < 0 then LoanArrears := 0;//

                                    Schedule.reset;
                                    Schedule.SetRange(Schedule."Loan No.", Loans."Loan  No.");
                                    Schedule.SetFilter(Schedule."Repayment Date", '%1..%2', Calcdate('-CM', SelectedPeriod), Calcdate('CM', SelectedPeriod));
                                    if Schedule.find('-') then begin
                                        PrincipleLoan := 0;
                                        Schedule.calcsums(schedule."Principal Repayment");
                                        PrincipleLoan := schedule."Monthly Repayment";

                                        loanArrears := PrincipleLoan;//+ loans."Outstanding Interest";
                                        if (loans."Total Outstanding Balance" < PrincipleLoan) then begin
                                            LoanArrears := loans."Total Outstanding Balance";
                                        end;
                                    end;

                                    if LoanArrears = 0 then begin
                                        AuFactory.FnGenerateLoanRepaymentSchedule(loans."Loan  No.");

                                        Schedule.reset;
                                        Schedule.SetRange(Schedule."Loan No.", Loans."Loan  No.");
                                        Schedule.SetFilter(Schedule."Repayment Date", '%1..%2', Calcdate('-CM', SelectedPeriod), Calcdate('CM', SelectedPeriod));
                                        if Schedule.find('-') then begin
                                            PrincipleLoan := 0;
                                            Schedule.calcsums(schedule."Principal Repayment");
                                            PrincipleLoan := schedule."Monthly Repayment";

                                            loanArrears := PrincipleLoan;//+ loans."Outstanding Interest";
                                            if (loans."Total Outstanding Balance" < PrincipleLoan) then begin
                                                LoanArrears := loans."Total Outstanding Balance";
                                            end;
                                        end;
                                    end;

                                    if Today > loans."Expected Date of Completion" then begin
                                        LoanArrears := loans."Outstanding Balance" + loans."Outstanding Interest";
                                    end;

                                    curTransBalance := 0;
                                    curTransAmount := 0;
                                    curTransAmount := loanArrears;
                                    curTransBalance := (loans."Total Outstanding Balance") - LoanArrears;
                                    strTransCode := TransCodes;
                                    LoanTypes.Reset();
                                    LoanTypes.SetRange(LoanTypes.Code, loans."Loan Product Type");
                                    if LoanTypes.FindFirst() then
                                        strTransDescription := 'Repayment ' + LoanTypes."Product Description";
                                    TGroup := 'DEDUCTIONS';
                                    TGroupOrder := 8;
                                    TSubGroupOrder := 1;
                                    //Message('Payroll%1',PayrollEmployees."Payroll No");
                                    fnUpdatePeriodTransSacco(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                      strTransDescription, loanArrears, curTransBalance, intMonth, intYear,
                                      PayrollEmployees."Payroll No", '', SelectedPeriod, Dept,
                                      JournalAcc, Journalpostas::Credit, JournalPostingType, loans."Loan  No.",
                                      Coopparameters::loan, PayrollEmployees."Payroll No", false);
                                    curTotalDeductions := curTotalDeductions + loanArrears;

                                end;
                            end;
                        until Loans.Next = 0;
                    end;

                end;
                //Loan Deductions






                curTotalDeductions := curTotalDeductions + curNSSF + curNHIF + curPAYE + curPayeArrears + HousingLevy;
                //Message('%1-%2-%3-%4-%5-%6', curTotalDeductions, strEmpCode, curPayeArrears, curNHIF, curNSSF, curPAYE);
                //Message('deductions %1-%2-%3-%4-%5-rec%6', curTotalDeductions, curNSSF, curNHIF, curPAYE, curPayeArrears, curTotalDeductions);
                curTransBalance := 0;
                strTransCode := 'TOT-DED';
                strTransDescription := 'TOTAL DEDUCTION';
                TGroup := 'DEDUCTIONS';
                TGroupOrder := 8;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                  strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                  '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none, false);

                //curNetPay := curGrossPay - ROUND((curTotalDeductions + IsCashBenefit + Teltax2), 0.05, '<');
                curNetPay := curGrossPay - ROUND((curTotalDeductions + Teltax2), 0.05, '<');
                //Message('curGrossPay%1curTotalDeductions%2IsCashBenefit%3Teltax2%4', curGrossPay, curTotalDeductions, IsCashBenefit, Teltax2);

                curNetPay := ROUND(curNetPay, 0.05, '<'); //- curExcessPension

                curNetPay := curNetPay - ROUND(curTotCompanyDed, 0.05, '<'); //******Get Company Deduction*****


                curNetRnd_Effect := ROUND(curNetPay, 0.05, '<') - ROUND(curNetPay, 0.05, '<');
                curTransAmount := ROUND(curNetPay, 0.05, '<');
                strTransDescription := 'Net Pay';
                TGroup := 'NET PAY';
                TGroupOrder := 9;
                TSubGroupOrder := 0;


                fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                PayablesAcc, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none, false);

            end;
        end

    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary, 0.05, '<');
    end;


    procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        SysDate.SetRange(SysDate."Period Start", FirstDay, LastDate);
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        if SysDate.Find('-') then
            DaysInMonth := SysDate.Count;
    end;


    procedure fnUpdatePeriodTrans(EmpCode: Code[40]; TCode: Code[40]; TGroup: Code[40]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime,DevShare,NHIF,Holiday,SHIF; contrGroup: Boolean)
    var
        prPeriodTransactions: Record "prPeriod Transactions.";
        //prPeriodTransactions: Record "prPeriod Transactions";

        prSalCard: Record "Payroll Employee.";
    begin
        if curAmount = 0 then exit;
        with prPeriodTransactions do begin
            prPeriodTransactions.Reset();
            prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", TCode);
            prPeriodTransactions.SetRange("Employee Code", EmpCode);
            prPeriodTransactions.SetRange("Payroll Period", dtOpenPeriod);
            if prPeriodTransactions.Find('-') then begin
                prPeriodTransactions.DeleteAll();
            end;
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TCode;
            "Group Text" := TGroup;
            "Transaction Name" := Description;
            Amount := ROUND(curAmount, 0.05, '<');
            //Amount := curAmount;
            Balance := curBalance;
            "Original Amount" := "Original Amount";
            "Group Order" := GroupOrder;
            "Sub Group Order" := SubGroupOrder;//
            Membership := mMembership;
            "Reference No" := ReferenceNo;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := dtOpenPeriod;
            "Department Code" := Department;
            "Journal Account Type" := JournalACType;
            "Post As" := PostAs;
            "Journal Account Code" := JournalAC;
            "Loan Number" := LoanNo;
            "coop parameters" := CoopParam;
            "Payroll Code" := PayrollType;
            "Is Contribution" := contrGroup;
            //Paymode
            if prSalCard.Get(EmpCode) then
                "Payment Mode" := prSalCard."Payment Mode";

            prPeriodTransactions.Insert(true);

            //Update the prEmployee Transactions  with the Amount
            fnUpdateEmployeeTrans("Employee Code", "Transaction Code", Amount, "Period Month", "Period Year", "Payroll Period");
        end;
    end;

    procedure fnUpdatePeriodTransSacco(EmpCode: Code[40]; TCode: Code[40]; TGroup: Code[40]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension; SaccoMembership: Code[20]; isRedundant: Boolean)
    var
        prPeriodTransactions: Record "prPeriod Transactions.";
        //prPeriodTransactions: Record "prPeriod Transactions";

        prSalCard: Record "Payroll Employee.";
    begin
        if curAmount = 0 then exit;
        with prPeriodTransactions do begin
            prPeriodTransactions.Reset();
            prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", TCode);
            prPeriodTransactions.SetRange("Employee Code", EmpCode);
            prPeriodTransactions.SetRange("Payroll Period", dtOpenPeriod);
            if prPeriodTransactions.Find('-') then begin
                prPeriodTransactions.DeleteAll();
            end;
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TCode;
            "Group Text" := TGroup;
            "Transaction Name" := Description;
            Amount := ROUND(curAmount, 0.05, '<');
            //Amount := curAmount;
            Balance := curBalance;
            "Original Amount" := "Original Amount";
            "Group Order" := GroupOrder;
            "Sub Group Order" := SubGroupOrder;
            Membership := mMembership;
            "Reference No" := ReferenceNo;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := dtOpenPeriod;
            "Department Code" := Department;
            "Journal Account Type" := JournalACType;
            "Post As" := PostAs;
            "Sacco Member No" := SaccoMembership;
            "Journal Account Code" := JournalAC;
            "Loan Number" := LoanNo;
            "coop parameters" := CoopParam;
            "Payroll Code" := PayrollType;
            "Is Contribution" := isRedundant;
            //Paymode
            if prSalCard.Get(EmpCode) then
                "Payment Mode" := prSalCard."Payment Mode";

            prPeriodTransactions.Insert(true);

            //Update the prEmployee Transactions  with the Amount
            fnUpdateEmployeeTrans("Employee Code", "Transaction Code", Amount, "Period Month", "Period Year", "Payroll Period");
        end;
    end;

    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prTransactionCodes: Record "Payroll Transaction Code.";
        strExtractedFrml: Text[250];
    begin
        SpecialTransAmount := 0;
        prTransactionCodes.Reset;
        prTransactionCodes.SetRange(prTransactionCodes."Special Transaction", intSpecTransID);
        if prTransactionCodes.Find('-') then begin
            repeat
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                // prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
                if prEmployeeTransactions.Find('-') then begin

                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if prTransactionCodes."Is Formulae" then begin
                                strExtractedFrml := '';
                                //message('Here');
                                //if Management then
                                //              strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Leave Reimbursement")
                                //            ELSE
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                                SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            end else
                                SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        Intspectransid::"Owner Occupier Interest":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


                        Intspectransid::"Home Ownership Savings Plan":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        Intspectransid::Morgage:
                            begin
                                SpecialTransAmount := SpecialTransAmount + curReliefMorgage;

                                if SpecialTransAmount > curReliefMorgage then begin
                                    SpecialTransAmount := curReliefMorgage
                                end;

                            end;

                    end;
                end;
            until prTransactionCodes.Next = 0;
        end;
        SpecialTranAmount := SpecialTransAmount;
    end;


    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record "Payroll PAYE Setup.";
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;

        prPAYE.Reset;
        if prPAYE.FindFirst then begin
            if curTaxablePay < prPAYE."PAYE Tier" then exit;
            repeat
                KeepCount += 1;
                curTempAmount := curTaxablePay;
                if curTaxablePay = 0 then exit;
                if KeepCount = prPAYE.Count then   //this is the last record or loop
                    curTaxablePay := curTempAmount
                else
                    if curTempAmount >= prPAYE."PAYE Tier" then
                        curTempAmount := prPAYE."PAYE Tier"
                    else
                        curTempAmount := curTempAmount;

                PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                curTaxablePay := curTaxablePay - curTempAmount;

            until prPAYE.Next = 0;
        end;
        PAYE := ROUND(PAYE, 1, '>');
    end;


    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) SHIF: Decimal
    var
        prSHIF: Record "Payroll General Setup.";
    begin
        prSHIF.Get();
        SHIF := curBaseAmount * (prSHIF.SHIF/100);
        if SHIF < prSHIF."Min SHIF" then SHIF := prSHIF."Min SHIF";
    end;

    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then StartCopy := true;

            if StartCopy then TransCode := TransCode + Char;
            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;
            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                //Get TransCodeAmount
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;


    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prPeriodTransactions: Record "prPeriod Transactions.";
    begin
        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
        if prEmployeeTransactions.FindFirst then begin

            TransAmount := prEmployeeTransactions.Amount;
            if prEmployeeTransactions."No of Units" <> 0 then
                TransAmount := prEmployeeTransactions."No of Units";

        end;
        if TransAmount = 0 then begin
            prPeriodTransactions.Reset;
            prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", strTransCode);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
            prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
            if prPeriodTransactions.FindFirst then
                TransAmount := prPeriodTransactions.Amount;
        end;
    end;


    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        //AccSchedMgt: Codeunit AccSchedManagement;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin

        //Results:=AccSchedMgt.CalcCellValue(true,strFormula,AccSchedLine,ColumnLayout,CalcAddCurr);
    end;

    // [EventSubscriber(ObjectType::Codeunit, codeunit::AccSchedManagement, 'OnBeforeEvaluateExpression', '', false, false)]
    // local procedure MyProcedure() Results:Decimal
    //    AccSchedLine: Record "Acc. Schedule Line";
    //     ColumnLayout: Record "Column Layout";
    //     CalcAddCurr: Boolean;
    //     AccSchedMgt: Codeunit AccSchedManagement;
    // begin

    //end;



    procedure fnClosePayrollPeriod(dtOpenPeriod: Date; PayrollCode: Code[20]) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        // prPeriodTransactions: Record UnknownRecord51516335;
        intMonth: Integer;
        intYear: Integer;
        prTransactionCodes: Record "Payroll Transaction Code.";
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prEmployeeTrans: Record "Payroll Employee Transactions.";
        prPayrollPeriods: Record "Payroll Calender.";
        prNewPayrollPeriods: Record "Payroll Calender.";
        CreateTrans: Boolean;
        ControlInfo: Record "Control-Information.";
        prEmployeeP9Info: Record "Payroll Employee P9.";
    begin
        ControlInfo.reset;
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        intMonth := Date2dmy(dtOpenPeriod, 2);
        intYear := Date2dmy(dtOpenPeriod, 3);

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);

        //Multiple Payroll
        if ControlInfo."Multiple Payroll" then
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Payroll Code", PayrollCode);

        if prEmployeeTransactions.Find('-') then begin
            repeat
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                if prTransactionCodes.Find('-') then begin
                    with prTransactionCodes do begin
                        case prTransactionCodes."Balance Type" of
                            prTransactionCodes."balance type"::None:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := 0;
                                end;
                            prTransactionCodes."balance type"::Increasing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
                                end;
                            prTransactionCodes."balance type"::Reducing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                        curTransAmount := prEmployeeTransactions.Balance;
                                        curTransBalance := 0;
                                    end else begin
                                        curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
                                    end;

                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end;
                        end;
                    end;
                end;

                //For those transactions with Start and End Date Specified
                if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then begin
                    if prEmployeeTransactions."End Date" < dtNewPeriod then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                    end;
                end;
                //End Transactions with Start and End Date

                if (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) and
                   (prEmployeeTransactions."Stop for Next Period" = false) then //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
                 begin
                    //IF (curTransAmount <> 0) THEN  //Update the employee transaction table
                    // BEGIN
                    if ((prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing) and (curTransBalance <> 0)) or
                     (prTransactionCodes."Balance Type" <> prTransactionCodes."balance type"::Reducing) then
                        prEmployeeTransactions.Balance := curTransBalance;
                    prEmployeeTransactions.Modify;


                    //Insert record for the next period
                    with prEmployeeTrans do begin
                        Init;
                        "No." := prEmployeeTransactions."No.";
                        "Transaction Code" := prEmployeeTransactions."Transaction Code";
                        "Transaction Name" := prEmployeeTransactions."Transaction Name";
                        "Transaction Type" := prEmployeeTransactions."Transaction Type";
                        Amount := curTransAmount;
                        Balance := curTransBalance;
                        "Amtzd Loan Repay Amt" := prEmployeeTransactions."Amtzd Loan Repay Amt";
                        "Original Amount" := prEmployeeTransactions."Original Amount";
                        Membership := prEmployeeTransactions.Membership;
                        "Member No" := prEmployeeTransactions."Member No";
                        "Reference No" := prEmployeeTransactions."Reference No";
                        "Loan Number" := prEmployeeTransactions."Loan Number";
                        "Original Deduction Amount" := prEmployeeTransactions."Original Deduction Amount";
                        Amount := prEmployeeTransactions.Amount;
                        "Amount(LCY)" := prEmployeeTransactions."Amount(LCY)";
                        "Period Month" := intNewMonth;
                        "Period Year" := intNewYear;
                        "Payroll Period" := dtNewPeriod;
                        "Payroll Code" := PayrollCode;
                        "Sacco Membership No." := prEmployeeTransactions."Member No";
                        "Sacco Membership No." := prEmployeeTransactions."Sacco Membership No.";
                        if not Insert then modify;
                    end;
                    //END;
                end
            until prEmployeeTransactions.Next = 0;
        end;

        //Update the Period as Closed
        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Month", intMonth);
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Year", intYear);
        prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
        if ControlInfo."Multiple Payroll" then
            prPayrollPeriods.SetRange(prPayrollPeriods."Payroll Code", PayrollCode);

        if prPayrollPeriods.Find('-') then begin
            prPayrollPeriods.Closed := true;
            prPayrollPeriods."Date Closed" := Today;
            prPayrollPeriods.Modify;
        end;

        //Enter a New Period
        with prNewPayrollPeriods do begin
            Init;
            "Period Month" := intNewMonth;
            "Period Year" := intNewYear;
            "Period Name" := Format(dtNewPeriod, 0, '<Month Text>') + '' + Format(intNewYear);
            "Date Opened" := dtNewPeriod;
            Closed := false;
            "Payroll Code" := PayrollCode;
            Insert;
        end;

        //Effect the transactions for the P9
        prEmployeeP9Info.Reset();
        prEmployeeP9Info.SetRange("Payroll Period", dtOpenPeriod);
        prEmployeeP9Info.SetRange("Period Year", intYear);
        prEmployeeP9Info.SetRange("Period Month", intMonth);
        if prEmployeeP9Info.Find('-') = false then begin

            fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod, PayrollCode);
        end;


        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intMonth, intYear, dtOpenPeriod);
    end;

    procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        intNewMonth: Integer;
        intNewYear: Integer;
        dtNewPeriod: Date;
    begin
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        prPeriodTransactions.Reset;
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
        prPeriodTransactions.SetRange(prPeriodTransactions."Group Order", 9);
        prPeriodTransactions.SetFilter(prPeriodTransactions.Amount, '<0');

        if prPeriodTransactions.Find('-') then begin
            repeat
                with prEmployeeTransactions do begin
                    Init;
                    "No." := prPeriodTransactions."Employee Code";
                    "Transaction Code" := 'NEGP';
                    "Transaction Name" := 'Negative Pay';
                    Amount := prPeriodTransactions.Amount;
                    Balance := 0;
                    "Original Amount" := 0;
                    "Period Month" := intNewMonth;
                    "Period Year" := intNewYear;
                    "Payroll Period" := dtNewPeriod;
                    Insert;
                end;
            until prPeriodTransactions.Next = 0;
        end;
    end;


    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date; PayrollCode: Code[20])
    var
        P9EmployeeCode: Code[20];
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployee: Record "Payroll Employee.";
    begin
        P9BasicPay := 0;
        P9Allowances := 0;
        P9Benefits := 0;
        P9ValueOfQuarters := 0;
        P9DefinedContribution := 0;
        P9OwnerOccupierInterest := 0;
        P9GrossPay := 0;
        P9TaxablePay := 0;
        P9TaxCharged := 0;
        P9InsuranceRelief := 0;
        P9TaxRelief := 0;
        P9Paye := 0;
        P9NSSF := 0;
        P9NHIF := 0;
        P9Deductions := 0;
        P9NetPay := 0;

        prEmployee.Reset;
        prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Active);
        if prEmployee.Find('-') then begin
            repeat
                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;

                prPeriodTransactions.Reset;
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
                if prPeriodTransactions.Find('-') then begin
                    repeat
                        with prPeriodTransactions do begin
                            case prPeriodTransactions."Group Order" of
                                1: //Basic pay & Arrears
                                    begin
                                        if "Sub Group Order" = 1 then P9BasicPay := Amount; //Basic Pay
                                        if "Sub Group Order" = 2 then P9BasicPay := P9BasicPay + Amount; //Basic Pay Arrears
                                    end;
                                3:  //Allowances
                                    begin
                                        P9Allowances := P9Allowances + Amount
                                    end;
                                4: //Gross Pay
                                    begin
                                        P9GrossPay := Amount
                                    end;
                                6: //Taxation
                                    begin
                                        if "Sub Group Order" = 1 then P9DefinedContribution := Amount; //Defined Contribution
                                        if "Sub Group Order" = 9 then P9TaxRelief := Amount; //Tax Relief
                                        if "Sub Group Order" = 8 then P9InsuranceRelief := Amount; //Insurance Relief
                                        if "Sub Group Order" = 6 then P9TaxablePay := Amount; //Taxable Pay
                                        if "Sub Group Order" = 7 then P9TaxCharged := Amount; //Tax Charged
                                    end;
                                7: //Statutories
                                    begin
                                        if "Sub Group Order" = 1 then P9NSSF := Amount; //Nssf
                                        if "Sub Group Order" = 2 then P9NHIF := Amount; //Nhif
                                        if "Sub Group Order" = 3 then P9Paye := Amount; //paye
                                        if "Sub Group Order" = 4 then P9Paye := P9Paye + Amount; //Paye Arrears
                                    end;
                                8://Deductions
                                    begin
                                        P9Deductions := P9Deductions + Amount;
                                    end;
                                9: //NetPay
                                    begin
                                        P9NetPay := Amount;
                                    end;
                            end;
                        end;
                    until prPeriodTransactions.Next = 0;
                end;
                //Update the P9 Details

                if P9NetPay <> 0 then
                    fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                        P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                        P9NHIF, P9Deductions, P9NetPay, dtCurPeriod, PayrollCode);

            until prEmployee.Next = 0;
        end;
    end;


    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date; prPayrollCode: Code[20])
    var
        prEmployeeP9Info: Record "Payroll Employee P9.";
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := Date2dmy(dtCurrPeriod, 2);
        intYear := Date2dmy(dtCurrPeriod, 3);

        prEmployeeP9Info.Reset;
        with prEmployeeP9Info do begin
            Init;
            "Employee Code" := P9EmployeeCode;
            "Basic Pay" := P9BasicPay;
            Allowances := P9Allowances;
            Benefits := P9Benefits;
            "Value Of Quarters" := P9ValueOfQuarters;
            "Defined Contribution" := P9DefinedContribution;
            "Owner Occupier Interest" := P9OwnerOccupierInterest;
            "Gross Pay" := P9GrossPay;
            "Taxable Pay" := P9TaxablePay;
            "Tax Charged" := P9TaxCharged;
            "Insurance Relief" := P9InsuranceRelief;
            "Tax Relief" := P9TaxRelief;
            PAYE := P9Paye;
            NSSF := P9NSSF;
            NHIF := P9NHIF;
            Deductions := P9Deductions;
            "Net Pay" := P9NetPay;
            "Period Month" := intMonth;
            "Period Year" := intYear;
            "Payroll Period" := dtCurrPeriod;
            "Payroll Code" := prPayrollCode;
            Insert;
        end;
    end;


    procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        if not IsTermination then
            SysDate.SetRange(SysDate."Period Start", dtDate, LastDate)
        else
            SysDate.SetRange(SysDate."Period Start", FirstDay, dtDate);
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        if SysDate.Find('-') then
            DaysWorked := SysDate.Count;
    end;


    procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
    var
        FirstMonth: Boolean;
        startmonth: Integer;
        startYear: Integer;
        "prEmployee P9 Info": Record "Payroll Employee P9.";
        P9BasicPay: Decimal;
        P9taxablePay: Decimal;
        P9PAYE: Decimal;
        ProratedBasic: Decimal;
        SalaryArrears: Decimal;
        SalaryVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPAYE: Decimal;
        PAYEVariance: Decimal;
        PAYEArrears: Decimal;
        PeriodMonth: Integer;
        PeriodYear: Integer;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
    begin
        fnInitialize;

        FirstMonth := true;
        if EndDate > StartDate then begin
            while StartDate < EndDate do begin
                //fnGetEmpP9Info
                startmonth := Date2dmy(StartDate, 2);
                startYear := Date2dmy(StartDate, 3);

                "prEmployee P9 Info".Reset;
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Employee Code", EmpCode);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Month", startmonth);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Year", startYear);
                if "prEmployee P9 Info".Find('-') then begin
                    P9BasicPay := "prEmployee P9 Info"."Basic Pay";
                    P9taxablePay := "prEmployee P9 Info"."Taxable Pay";
                    P9PAYE := "prEmployee P9 Info".PAYE;

                    if P9BasicPay > 0 then   //Staff payment history is available
                     begin
                        if FirstMonth then begin                 //This is the first month in the arrears loop
                            if Date2dmy(StartDate, 1) <> 1 then //if the date doesn't start on 1st, we have to prorate the salary
                             begin
                                //ProratedBasic := ProratePay.fnProratePay(P9BasicPay, CBasic, StartDate); ********
                                //Get the Basic Salary (prorate basic pay if needed) //Termination Remaining
                                if (Date2dmy(dtDOE, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(StartDate, 3)) then begin
                                    CountDaysofMonth := fnDaysInMonth(dtDOE);
                                    DaysWorked := fnDaysWorked(dtDOE, false);
                                    ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                end;

                                //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                                if dtTermination <> 0D then begin
                                    if (Date2dmy(dtTermination, 2) = Date2dmy(StartDate, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(StartDate, 3)) then begin
                                        CountDaysofMonth := fnDaysInMonth(dtTermination);
                                        DaysWorked := fnDaysWorked(dtTermination, true);
                                        ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                    end;
                                end;

                                SalaryArrears := (CBasic - ProratedBasic)
                            end
                            else begin
                                SalaryArrears := (CBasic - P9BasicPay);
                            end;
                        end;
                        SalaryVariance := SalaryVariance + SalaryArrears;
                        SupposedTaxablePay := P9taxablePay + SalaryArrears;

                        //To calc paye arrears, check if the Supposed Taxable Pay is > the taxable pay for the loop period
                        if SupposedTaxablePay > P9taxablePay then begin
                            SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay);
                            SupposedPAYE := SupposedTaxCharged - curReliefPersonal;
                            PAYEVariance := SupposedPAYE - P9PAYE;
                            PAYEArrears := PAYEArrears + PAYEVariance;
                        end;
                        FirstMonth := false;               //reset the FirstMonth Boolean to False
                    end;
                end;
                StartDate := CalcDate('+1M', StartDate);
            end;
            if SalaryArrears <> 0 then begin
                PeriodYear := Date2dmy(dtOpenPeriod, 3);
                PeriodMonth := Date2dmy(dtOpenPeriod, 2);
                fnUpdateSalaryArrears(EmpCode, TransCode, StartDate, EndDate, SalaryArrears, PAYEArrears, PeriodMonth, PeriodYear,
                dtOpenPeriod);
            end

        end
        else
            Error('The start date must be earlier than the end date');
    end;


    procedure fnUpdateSalaryArrears(EmployeeCode: Text[50]; TransCode: Text[50]; OrigStartDate: Date; EndDate: Date; SalaryArrears: Decimal; PayeArrears: Decimal; intMonth: Integer; intYear: Integer; payperiod: Date)
    var
        FirstMonth: Boolean;
        ProratedBasic: Decimal;
        SalaryVariance: Decimal;
        PayeVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPaye: Decimal;
        CurrentBasic: Decimal;
        StartDate: Date;
        "prSalary Arrears": Record "Payroll Salary Arrears.";
    begin
        "prSalary Arrears".Reset;
        "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code", EmployeeCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
        if "prSalary Arrears".Find('-') = false then begin
            "prSalary Arrears".Init;
            "prSalary Arrears"."Employee Code" := EmployeeCode;
            "prSalary Arrears"."Transaction Code" := TransCode;
            "prSalary Arrears"."Start Date" := OrigStartDate;
            "prSalary Arrears"."End Date" := EndDate;
            "prSalary Arrears"."Salary Arrears" := SalaryArrears;
            "prSalary Arrears"."PAYE Arrears" := PayeArrears;
            "prSalary Arrears"."Period Month" := intMonth;
            "prSalary Arrears"."Period Year" := intYear;
            "prSalary Arrears"."Payroll Period" := payperiod;
            "prSalary Arrears".Insert;
        end
    end;


    procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; IntAmount: Decimal; Welfare: Boolean) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := Date2dmy(CurrPeriod, 2);
        intYear := Date2dmy(CurrPeriod, 3);
        curLoanInt := 0;

        // IF strEmpCode='018'  THEN BEGIN
        //
        //  IF strTransCode='DL' THEN
        //      InterestRate:=InterestRate;
        // END;


        if InterestRate > 0 then begin
            if RecoveryMethod = Recoverymethod::"Straight line" then //Straight Line Method [1]
                curLoanInt := (InterestRate / 1200) * LoanAmount;

            if RecoveryMethod = Recoverymethod::Reducing then //Reducing Balance [0]

                 curLoanInt := (InterestRate / 1200) * Balance;

            if RecoveryMethod = Recoverymethod::Amortized then //Amortized [2]
                curLoanInt := (InterestRate / 1200) * Balance;

        end else
            curLoanInt := 0;

        curLoanInt := IntAmount;

        //Return the Amount
        LnInterest := ROUND(curLoanInt, 1, '>');
    end;


    procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
    var
        prEmployerDeductions: Record "Payroll Employer Deductions.";
    begin

        if curAmount = 0 then exit;
        with prEmployerDeductions do begin
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TCode;
            Amount := curAmount;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := dtOpenPeriod;
            Insert;
        end;
    end;


    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
    end;


    procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; TransAmount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date)
    var
        prEmployeeTrans: Record "Payroll Employee Transactions.";
        duplicate: Integer;
        i: Integer;
    begin

        duplicate := 0;
        prEmployeeTrans.Reset();
        prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", TransCode);
        prEmployeeTrans.SetRange("No.", EmpCode);
        prEmployeeTrans.SetRange("Payroll Period", PayrollPeriod);
        if prEmployeeTrans.Find('-') then begin
            // duplicate := duplicate + 1;
            prEmployeeTrans.FirstEntry := true;
            prEmployeeTrans.Modify;
        end;

        prEmployeeTrans.Reset();
        prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", TransCode);
        prEmployeeTrans.SetRange("No.", EmpCode);
        prEmployeeTrans.SetRange("Payroll Period", PayrollPeriod);
        prEmployeeTrans.SetRange(FirstEntry, false);
        if prEmployeeTrans.FindSet() then begin
            // if duplicate > 1 then begin
                // repeat
                //     for i := duplicate downto (duplicate - 1) do begin
            prEmployeeTrans.DeleteAll(true);
                //     end;
                // until prEmployeeTrans.Next() = 0;
            // end;
        end;
    end;

    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        SalaryCard: Record "Payroll Employee.";
    begin
        //Get Payroll Posting Accounts
        if SalaryCard.Get(strEmpCode) then begin
            if PostingGroup.Get(SalaryCard."Posting Group") then begin
                //Comment This for the Time Being

                PostingGroup.TestField("Salary Account");
                // PostingGroup.TestField("Income Tax Account");
                PostingGroup.TestField("Net Salary Payable");
                PostingGroup.TestField("SSF Employer Account");
                // PostingGroup.TESTFIELD("Pension Employer Acc");

                //TaxAccount:=PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PAYEAccount := PostingGroup."PAYE Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                // PayablesAcc:=SalaryCard."Bank Account Number";
                NSSFEMPyer := PostingGroup."SSF Employer Account";
                NSSFEMPyee := PostingGroup."SSF Employee Account";
                //NHIFEMPyee:=PostingGroup."NHIF Employee Account";
                NHIFEMPyee := PostingGroup."NHIF Employee Account";
                //PensionEMPyer:=PostingGroup."Pension Employer Acc";
                //TelTaxACC:=PostingGroup."Telephone Tax Acc";
            end else begin
                Error('Please specify Posting Group in Employee No.  ' + strEmpCode);
            end;
        end;
        //End Get Payroll Posting Accounts
    end;


    procedure fnGetSpecialTransAmount2(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean)
    var
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prTransactionCodes: Record "Payroll Transaction Code.";
        strExtractedFrml: Text[250];
    begin
        SpecialTranAmount := 0;
        prTransactionCodes.Reset;
        prTransactionCodes.SetRange(prTransactionCodes."Special Transaction", intSpecTransID);
        if prTransactionCodes.Find('-') then begin
            repeat
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                if prEmployeeTransactions.Find('-') then begin

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            if prTransactionCodes."Is Formulae" then begin
                                strExtractedFrml := '';
                                // if Management then
                                //              strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Leave Reimbursement")
                                //            ELSE
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                                SpecialTranAmount := SpecialTranAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            end else
                                SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        Intspectransid::"Life Insurance":
                            SpecialTranAmount := SpecialTranAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        Intspectransid::"Owner Occupier Interest":
                            SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;


                        Intspectransid::"Home Ownership Savings Plan":
                            SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        Intspectransid::Morgage:
                            begin
                                SpecialTranAmount := SpecialTranAmount + curReliefMorgage;

                                if SpecialTranAmount > curReliefMorgage then begin
                                    SpecialTranAmount := curReliefMorgage
                                end;

                            end;

                    end;
                end;
            until prTransactionCodes.Next = 0;
        end;
    end;


    procedure fnCheckPaysPension(pnEmpCode: Code[20]; pnPayperiod: Date) PaysPens: Boolean
    var
        pnTranCode: Record "Payroll Transaction Code.";
        pnEmpTrans: Record "Payroll Employee Transactions.";
    begin
        PaysPens := false;
        pnEmpTrans.Reset;
        pnEmpTrans.SetRange(pnEmpTrans."No.", pnEmpCode);
        pnEmpTrans.SetRange(pnEmpTrans."Payroll Period", pnPayperiod);
        if pnEmpTrans.Find('-') then begin
            repeat
                if pnTranCode.Get(pnEmpTrans."Transaction Code") then
                    if pnTranCode."Co-Op Parameters" = pnTranCode."co-op parameters"::Welfare then
                        PaysPens := true;
            until pnEmpTrans.Next = 0;
        end;
    end;

    procedure fnCheckPaysVoluntaryPension(pnEmpCode: Code[20]) PaysPens: Boolean//Kitui
    var
        pnTranCode: Record "Payroll Transaction Code.";
        pnEmpTrans: Record "Payroll Employee Transactions.";
    begin
        PaysPens := false;
        EmpSalary.Reset();
        EmpSalary.setrange(EmpSalary."No.", pnEmpCode);
        EmpSalary.SetRange(EmpSalary."Pays Pension", true);
        if EmpSalary.findfirst then begin
            PaysPens := true;
        end;
        Exit(PaysPens);
    end;

    procedure fnCalculateVoluntaryPension(pnEmpCode: Code[20]) PensContrib: Decimal//Kitui
    var
        pnTranCode: Record "Payroll Transaction Code.";
        pnEmpTrans: Record "Payroll Employee Transactions.";
    begin
        PensContrib := 0;
        EmpSalary.Reset();
        EmpSalary.setrange(EmpSalary."No.", pnEmpCode);
        EmpSalary.SetRange(EmpSalary."Pays Pension", true);
        if EmpSalary.findfirst then begin
            PensContrib := EmpSalary."Employee Pension %";//Round((EmpSalary."Basic Pay"*EmpSalary."Employee Pension %"/100),1,'>');
        end;

    end;

    procedure fnGetEmployeeNSSF(curBaseAmount: Decimal) NSSF: Decimal
    var
        prNSSF: Record "Payroll NSSF Setup.";
        Tone: Decimal;
        Ttwoo: Decimal;
    begin
        /*         prNSSF.Reset;
                prNSSF.SetRange(prNSSF."Tier Code");
                if prNSSF.Find('-') then begin
                    repeat
                        if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
                            NSSF := prNSSF."Tier 1 Employee Deduction" + prNSSF."Tier 2 Employee Deduction";
                    until prNSSF.Next = 0;
                end; */
        IF curBaseAmount > 8000 THEN
            Tone := 0;
        Tone := 0.06 * 8000;
        Ttwoo := 0;
        Ttwoo := (curBaseAmount - 8000) * 0.06;
        NSSF := Tone + Ttwoo;

        IF NSSF > 4320 THEN
            NSSF := 4320;
    end;


    procedure fnGetEmployerNSSF(curBaseAmount: Decimal) NSSF: Decimal
    var
        prNSSF: Record "Payroll NSSF Setup.";
    begin
        prNSSF.Reset;
        prNSSF.SetRange(prNSSF."Tier Code");
        if prNSSF.Find('-') then begin
            repeat
                if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
                    NSSF := prNSSF."Tier 1 Employer Contribution" + prNSSF."Tier 2 Employer Contribution";
            until prNSSF.Next = 0;
        end;
    end;

    procedure FnUpdateBalances("Payroll Employee Transactions.": Record "Payroll Employee Transactions.")
    var
        ObjMemberLedger: Record "Member Ledger Entry";
        Totalshares: Decimal;
        ObjLoanRegister: Record "Loans Register";
        LNPric: Decimal;
        ObjPRTransactioons: Record "prPeriod Transactions.";
    begin
        // ObjPRTransactioons.Reset;
        // ObjPRTransactioons.SetRange(ObjPRTransactioons."Employee Code", "Payroll Employee Transactions."."No.");
        // if ObjPRTransactioons.Find('-') then
        //     Report.Run(172591, false, false, ObjPRTransactioons);
        //Report.RunModal(172591, false);//TO RELOOK
        // Commit();
    end;

    procedure FnGetInterestRate(LoanProductCode: Code[40]) InterestRate: Decimal
    var
        ObjLoanProducts: Record "Loan Products Setup";
    begin
        ObjLoanProducts.Reset;
        ObjLoanProducts.SetRange(ObjLoanProducts.Code, LoanProductCode);
        if ObjLoanProducts.Find('-') then begin
            InterestRate := ObjLoanProducts."Interest rate";
        end;
        exit(InterestRate);
    end;

    local procedure FnLoanInterestExempted(LoanNo: Code[50]) Found: Boolean
    var
        ObjExemptedLoans: Record "Loan Repay Schedule-Calc";
    begin
        ObjExemptedLoans.Reset;
        ObjExemptedLoans.SetRange(ObjExemptedLoans."Loan Category", LoanNo);
        if ObjExemptedLoans.Find('-') then begin
            Found := true;
        end;
        exit(Found);
    end;
}

