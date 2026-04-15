//<---------------------------------------------------------------------->															
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // 															
Report 50057 "Loans Defaulter Aging Display"
{
    ApplicationArea = All;
    RDLCLayout = 'Layouts/LoansDefaulterAging-SASRA_Display.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    // ProcessingOnly = true;
    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Total Outstanding Balance", "Last Pay Date";
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance" = filter(<> 0));
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Outstanding Balance", "Date filter", "Client Code";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }

            column(UserId; UserId)
            {
            }
            column(Loans__Loan__No__; "Loans Register"."Loan  No.")
            {
            }
            column(Arrears; Arrears)
            {
            }
            column(DaysInArrears_LoansRegister; "Loans Register"."Loan Insurance Paid")
            {
            }
            column(Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_; "Loans Register"."Staff No")
            {
            }
            column(Loans__Client_Name_; "Loans Register"."Client Name")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; "Loans Register"."Outstanding Balance")
            {
            }
            column(Loans_Loans__Outstanding_Interest_; "Loans Register"."Outstanding Interest")
            {
            }
            column(Last_Pay_Date; "Last Pay Date")
            {
            }
            column(Last_Repayment; "Last Repayment")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V0Month_; "0Month")
            {
            }
            column(AmountinArrears_LoansRegister; "Loans Register"."Amount in Arrears")
            {
            }
            // column(NoofMonthsinArrears_LoansRegister; "Loans Register"."No of Months in Arrears")
            // {
            // }
            column(NoofMonthsinArrears_LoansRegister; daysinLoss + "No.ofMonthsinArrears")
            { }
            column(Expected_Completion_Date_LoansRegister; "Loans Register"."Expected Date of Completion")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016; "Loans Register"."Outstanding Balance")
            {
            }
            column(Loans_Loans_TOTAL_Outstanding_Balance; "Loans Register"."Total Outstanding Balance")
            {
            }
            column(Loans_Loans_Outstanding_Interest; "Loans Register"."Outstanding Interest")
            {
            }
            column(InterestDue_LoansRegister; "Loans Register"."Interest Due")
            {
            }
            column(Loans__Approved_Amount_; "Loans Register"."Approved Amount")
            {
            }
            column(Loans_Loans__Interest_Due_; "Loans Register"."Interest Due")
            {
            }
            column(TotalBalance; "Loans Register"."Outstanding Balance" + "Loans Register"."Interest Due")
            {
            }
            column(V1MonthC_; "1MonthC")
            {
            }
            column(V2MonthC_; "2MonthC")
            {
            }
            column(V3MonthC_; "3MonthC")
            {
            }
            column(Over3MonthC; Over3MonthC)
            {
            }
            column(NoLoans; NoLoans)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(V0Month__Control1102760031; "0Month")
            {
            }
            column(V1Month__Control1102760032; "1Month")
            {
            }
            column(V2Month__Control1102760033; "2Month")
            {
            }
            column(V3Month__Control1102760034; "3Month")
            {
            }
            column(Over3Month_Control1102760035; Over3Month)
            {
            }
            column(V0MonthC_; "0MonthC")
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(PerformingCaption; PerformingCaptionLbl)
            {
            }
            column(V1___30_Days_Caption; V1___30_Days_CaptionLbl)
            {
            }
            column(V0_Days_Caption; V0_Days_CaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(V31___180_Days_Caption; V31___180_Days_CaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(V181___360_Days_Caption; V181___360_Days_CaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(Over_360_DaysCaption; Over_360_DaysCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(LoanProductType; "Loans Register"."Loan Product Type")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(Fosabal; Fosabal)
            {
            }
            column(Depbal; Depbal)
            {
            }
            trigger OnPreDataItem();
            begin
                if AsAt = 0D then AsAt := Today;
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                //Initialize and Define The Variables 
                Fosabal := 0;
                Depbal := 0;
                ExpectedBalance := 0;
                varRepayment := 0;
                "0Month" := 0;
                Over3Month := 0;
                "1Month" := 0;
                "3Month" := 0;
                "2Month" := 0;
                daysinLoss := 0;
                LBal := 0;
                ExpectedBalance := 0;
                varRepayment := 0;
                Arrears := 0;
                "No.ofMonthsinArrears" := 0;
                RepaymentPeriod := 0D;
                expectedDate := 0D;


                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Perfoming then begin
                    "0Month" := "Loans Register"."Outstanding Balance"
                end else
                    if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Watch then begin
                        "1Month" := "Loans Register"."Outstanding Balance"
                    end else
                        if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Substandard then begin
                            "2Month" := "Loans Register"."Outstanding Balance"
                        end else
                            if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Doubtful then begin
                                "3Month" := "Loans Register"."Outstanding Balance"
                            end else
                                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Loss then begin
                                    Over3Month := "Loans Register"."Outstanding Balance";
                                end;

                GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";
                if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then NoLoans := NoLoans + 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = false;
        layout
        {
            area(content)
            {
                field("As At"; AsAt)
                {
                    ShowMandatory = True;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        // AsAt := CalcDate('<-CM-1D>', Today);
                    end;
                }

            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        varRepayment: Decimal;
        Fosabal: Decimal;
        Depbal: Decimal;
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        daysinLoss: Integer;
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
        DaysPastCompletion: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        "0Day": Decimal;
        "1Day": Decimal;
        "2Day": Decimal;
        "3Day": Decimal;
        Over3Day: Decimal;
        isMobile: Boolean;
        expectedDate: Date;
        LSchedule: Record "Loan Repayment Schedule";
        RepaymentPeriod: Date;
        referenceDate: Date;
        Loans: Record "Loans Register";
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        "No.ofMonthsinArrears": Integer;
        Company: Record "Company Information";
        SFactory: Codeunit "Au Factory";
        ExpectedBalance: Decimal;
        Numberofdays: Integer;
        detVend: Record "Detailed Vendor Ledg. Entry";
        vend: Record Vendor;
}





