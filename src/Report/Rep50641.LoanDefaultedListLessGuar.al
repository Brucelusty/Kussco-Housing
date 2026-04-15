report 50641 "Loan Defaulters List Less Guar"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\LoanDefaulterListGuar.rdlc';

    dataset
    {
        dataitem(Loans;"Loans Register")
        {
            CalcFields = "Schedule Repayments","Total Repayment";
            DataItemTableView = WHERE(Posted=CONST(True),
                                      "Outstanding Balance"=FILTER(>0),
                                      "Issued Date"=FILTER(<>''),
                                      "Repayment Start Date"=FILTER(<>''),
                                      Repayment=FILTER(>0),
                                      Interest=FILTER(>0));
            RequestFilterFields = "Issued Date","Date filter","Loan Product Type","Client Code","Recovery Mode","Loans Category-SASRA","Last Pay Date","Loan  No.";
            column(companyPicture; CompanyInfo.Picture)
            {}
            column(CompanyName; CompanyInfo.Name)
            {}
            column(CompanyAddress2; CompanyInfo."Address 2")
            {}
            column(CompanyAddress; CompanyInfo.Address)
            {}
            column(CompanyPhoneNo;CompanyInfo."Phone No.")
            {}
            column(CompanyEmail; CompanyInfo."E-Mail")
            {}
            column(LoanNo;"Loan  No.")
            {
            }
            column(LoanType;"Loan Product Type")
            {
            }
            column(ClientCode;"Client Code")
            {
            }
            column(ClientName;"Client Name")
            {
            }
            column(ApprovedAmnt;"Approved Amount")
            {
            }
            column(AmountPaid;"Principal Paid"+"Interest Paid")
            {
            }
            // column(totalbal;("Principal Paid"+"Interest Paid"))
            // {
            // }
            column(Outstandingbal;totalbal)
            {
            }
            column(TotalExpectedAmount;TotalExpectedAmount)
            {
            }
            column(TotalActual;TotalActual)
            {}
            column(AmountDefaulted;"Amount defaulted")
            {
            }
            column(LaSTpaydate;"Last Pay Date")
            {
            }
            column(InstallmentDefaulted;"Installment Defaulted")
            {
            }
            column(IssuedDate;Loans."Issued Date")
            {
            }
            column(Period;Period)
            {
            }
            column(ID;"ID NO")
            {
            }
            column(Phone_No_; "Phone No.")
            { }
            column(email; email)
            { }
            column(Staff_No; "Staff No")
            {}
            column(Current_Shares; memberDep)
            { }
            column(LoanProduct;"Loan Product Type Name")
            {
            }
            column(RepaymentMode;"Repayment Method")
            {
            }
            column(InterestPaid_Loans;Loans."Interest Paid")
            {
            }
            column(Interestpaid;"Interest Paid")
            {
            }
            column(LastPayDate_Loans;Loans."Last Pay Date")
            {
            }
            column(LoanProductTypeName_Loans;Loans."Loan Product Type Name")
            {
            }
            column(LoanProductType_Loans;Loans."Loan Product Type")
            {
            }
            column(RecoveryMode_Loans;Loans."Recovery Mode")
            {
            }
            column(IssuedDate_Loans;Loans."Issued Date")
            {
            }
            column(RepaymentMethod_Loans;Loans."Repayment Method")
            {
            }
            column(LoansCategorySASRA_Loans;Loans."Loans Category-SASRA")
            {
            }
            column(Loans_Category;"Loans Category")
            {
            }
            column(OustandingInterest_Loans;Loans."Outstanding Interest")
            {
            }
            column(DaysArrears;"Days in Arrears")
            {
            }
            column(ExpectedDateofCompletion_Loans;Loans."Expected Date of Completion")
            {
            }
            column(Installments_Loans;Loans.Installments)
            {
            }
            column(Filters;Filters)
            {
            }
            column(ApprovedAmount_Loans;Loans."Approved Amount")
            {
            }

            trigger OnAfterGetRecord()
            var
                ExpectedAmount: Decimal;
                RSchedule: Record "Loan Repayment Schedule";
                ModLoan: Record "Loans Register";
                FSchedule: Record "Loan Repayment Schedule";
            begin
                memberDep:= 0;
                if Cust.Get(Loans."Client Code") then begin
                    Cust.CalcFields("Shares Retained", "Current Shares");
                    memberDep:= Cust."Current Shares";
                end; 
                Loanss.RESET;
                Loanss.SETRANGE(Loanss."Loan  No.",Loans."Loan  No.");
                Loanss.SETRANGE(Loanss.Posted,TRUE);
                IF Loanss.FINDFIRST THEN
                BEGIN
                Loanss.CALCFIELDS(Loanss."Outstanding Balance");
                IF Loanss."Outstanding Balance">0 THEN BEGIN
                TotalExpectedAmount:=0;
                TotalPaidAMount:=0;
                MonthlyRepayments:=0;
                NumberOfMonths:=0;
                NumberOfDays:=0;
                Arrears:=0;
                TotalInterestPaid:=0;

                Memb.RESET;
                Memb.SETRANGE(Memb."Payroll No",Loanss."Staff No");
                IF Memb.FIND('-')THEN BEGIN

                END;

                RSchedule.RESET;
                RSchedule.SETRANGE(RSchedule."Loan No.",Loanss."Loan  No.");
                RSchedule.SETFILTER(RSchedule."Repayment Date",'..%1',AsAt);
                IF RSchedule.FINDSET THEN
                BEGIN
                RSchedule.CALCSUMS(RSchedule."Principal Repayment");
                TotalExpectedAmount:=RSchedule."Principal Repayment";
                RSchedule.CALCSUMS(RSchedule."Monthly Repayment");
                TotalActual:=RSchedule."Monthly Repayment";
                END;
                totalbal:=0;
                "Amount defaulted":=0;
                DaysArrears:=0;
                Loanss.CALCFIELDS(Loanss."Outstanding Balance",Loanss."Current Interest Paid");
                totalbal:=Loanss."Outstanding Balance";
                TotalPaidAMount:=Loanss."Approved Amount"-Loanss."Outstanding Balance";
                TotalInterestPaid:=Loanss."Current Interest Paid"*-1;
                TotalPaidAMount:=TotalPaidAMount+TotalInterestPaid;
                Arrears:=TotalExpectedAmount-TotalPaidAMount;
                "Amount defaulted":=Arrears;
                RSchedule.RESET;
                RSchedule.SETRANGE(RSchedule."Loan No.",Loanss."Loan  No.");
                IF RSchedule.FINDFIRST THEN BEGIN
                MonthlyRepayments:=RSchedule."Monthly Repayment"
                END;
                IF MonthlyRepayments>0 THEN BEGIN
                NumberOfMonths:=ROUND((Arrears/MonthlyRepayments),1,'=');
                NumberOfDays:=NumberOfMonths*30;
                DaysArrears:=NumberOfDays;
                IF DaysArrears<0 THEN
                DaysArrears:=0
                ELSE
                DaysArrears:=DaysArrears;

                // END ELSE BEGIN
                // Generate.Autogenerateschedule(Loans."Loan  No.");
                // NumberOfMonths:=ROUND((Arrears/MonthlyRepayments),1,'=');
                // NumberOfDays:=NumberOfMonths*30;
                END;
                //MESSAGE('Expected%1 Pid%2 Arrears%3NoOfdays%4 Repayment%5',TotalExpectedAmount,TotalPaidAMount,Arrears,NumberOfDays,MonthlyRepayments);

            //     IF NumberOfDays<=30 THEN BEGIN
            //     Loanss."Loans Category-SASRA":=Loanss."Loans Category-SASRA"::Perfoming;
            //     Loanss."Loans Category":=Loanss."Loans Category"::Perfoming;
            //     END ELSE IF(NumberOfDays>30) AND (NumberOfDays<=60) THEN BEGIN
            //     Loanss."Loans Category-SASRA":=Loanss."Loans Category-SASRA"::Watch;
            //     Loanss."Loans Category":=Loanss."Loans Category"::Watch;
            //     END ELSE IF(NumberOfDays>60) AND (NumberOfDays<=180) THEN BEGIN
            //     Loanss."Loans Category-SASRA":=Loanss."Loans Category-SASRA"::Substandard;
            //     Loanss."Loans Category":=Loanss."Loans Category"::Substandard;
            //     END ELSE IF(NumberOfDays>60) AND (NumberOfDays<=180) THEN BEGIN
            //     Loanss."Loans Category-SASRA":=Loanss."Loans Category-SASRA"::Doubtful;
            //     Loanss."Loans Category":=Loanss."Loans Category"::Doubtful;
            //     END ELSE IF(NumberOfDays>180)  THEN BEGIN
            //     Loanss."Loans Category-SASRA":=Loanss."Loans Category-SASRA"::Loss;
            //     Loanss."Loans Category":=Loanss."Loans Category"::Loss;
            //     END;
            //     Loanss.MODIFY;
                END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                IF CurrDate=0D THEN
                  CurrDate := TODAY;
                Loans.SETRANGE(Loans."Date filter",0D,CurrDate);
                CurrDate:=Loans.GETRANGEMAX(Loans."Date filter");
                UpdateCompletedLoansToPerfoming;
                GenerateScheduleForLoans;
                Filters := Loans.GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt;AsAt)
                {
                    Caption = 'As at Date';
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
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        TShare: Decimal;
        TLApp: Decimal;
        TCheque: Decimal;
        DateFilterBF: Text[150];
        TLBalance: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        LoanApp: Record "Loans Register";
        PendingApp: Decimal;
        ApprovedApp: Decimal;
        Cust: Record "Customer";
        ShowSec: Boolean;
        TLAppB: Decimal;
        TChequeB: Decimal;
        TReq: Decimal;
        Variance: Integer;
        CurrDate: Date;
        Savings: Decimal;
        Tsavings: Decimal;
        vend: Record Vendor;
        TapprovedAmount: Decimal;
        "Amount defaulted": Decimal;
        "Defaulted install": Decimal;
        TotalActual: Decimal;
        ExpIntallment: Decimal;
        membledg: Record "Member Ledger Entry";
        HesabuWeeks: Decimal;
        ExpectedPrinc: Decimal;
        TotExpPr: Decimal;
        TotExpAmount: Decimal;
        Amountpaid: Decimal;
        recloan: Record "Loans Register";
        TotalAmountDefaulted: Decimal;
        no: Integer;
        totalbal: Decimal;
        loanbal: Decimal;
        Period: Decimal;
        DaysArrears: Decimal;
        idno: Code[16];
        email: Text;
        CurrentShares: Decimal;
        Memb: Record "Customer";
        CanModify: Boolean;
        GenSch: Codeunit "Generate Schedule";
        CompanyInfo: Record "Company Information";
        Filters: Text;
        AsAt: Date;
        Expectedbal: Decimal;
        Actualbal: Decimal;
        LoansRegister6: Record "Loans Register";
        Monthlyrep: Decimal;
        ExpectedRepayment: Decimal;
        memberDep: Decimal;
        TotalPaidA: Decimal;
        AmountDifference: Decimal;
        RepaymentNew: Decimal;
        Rinstallments: Decimal;
        TotalDayssN: Decimal;
        CurrentInterest: Decimal;
        Loanss: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        TotalExpectedAmount: Decimal;
        TotalPaidAMount: Decimal;
        MonthlyRepayments: Decimal;
        NumberOfMonths: Decimal;
        NumberOfDays: Decimal;
        Arrears: Decimal;
        Generate: Codeunit "Generate Schedule";
        TotalInterestPaid: Decimal;

    local procedure UpdateCompletedLoansToPerfoming()
    var
        UpdateLoan: Record "Loans Register";
    begin
        // UpdateLoan.RESET;
        // UpdateLoan.SETAUTOCALCFIELDS(UpdateLoan."Outstanding Balance");
        // UpdateLoan.SETFILTER(UpdateLoan."Outstanding Balance",'<=%1',0);
        // UpdateLoan.SETFILTER(UpdateLoan."Loans Category-SASRA",'<>%1',UpdateLoan."Loans Category-SASRA"::Perfoming);
        // IF UpdateLoan.FINDSET THEN
        //    REPEAT
        //        UpdateLoan."Loans Category-SASRA":= UpdateLoan."Loans Category-SASRA"::Perfoming;
        //        UpdateLoan.MODIFY;
        //      UNTIL UpdateLoan.NEXT = 0;
    end;

    local procedure GenerateScheduleForLoans()
    var
        GenLoan: Record "Loans Register";
    begin
        // GenLoan.RESET;
        // GenLoan.SETAUTOCALCFIELDS(GenLoan."Outstanding Balance");
        // GenLoan.SETFILTER(GenLoan."Outstanding Balance",'>%1',0);
        // IF GenLoan.FINDSET THEN
        //   REPEAT
        //         IF GenLoan."Issued Date"<>GenLoan."Loan Disbursement Date" THEN
        //           // GenSch.Autogenerateschedule(GenLoan."Loan  No.");
        //     UNTIL GenLoan.NEXT = 0;
    end;
}




