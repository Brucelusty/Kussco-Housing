report 50034 "Loan Appraisal Overdraft"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Loan Appraisal Overdraft.rdlc';

    dataset
    {
        dataitem(DataItem4645; "Loans Register")
        {
            DataItemTableView = SORTING("Loan  No.");
            RequestFilterFields = "Loan  No.";
            column(TotalDeduction; TotalDeduction)
            {
            }
            column(TotalSalaryAmount; TotalSalaryAmount)
            {
            }
            column(RepaymentAmount; RepaymentAmount)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Initials; Initials)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(ApprovedAmount_LoansRegister; LoanApp."Approved Amount")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__E_Mail_; CompanyInfo."E-Mail")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(Loans__Application_Date_; "Application Date")
            {
            }
            column(totnettakehome; totnettakehome)
            {
            }
            column(Psalary; Psalary)
            {
            }
            column(SHARES; SHARES)
            {
            }
            column(Recomend; Recomend)
            {
            }
            column(CHARGES; Charge)
            {
            }
            column(Lamount; Lamount)
            {
            }
            column(DepositReinstatement; "Deposit Reinstatement")
            {
            }
            column(TotalLoanBal; TotalLoanBal)
            {
            }
            column(Upfronts; Upfronts)
            {
            }
            column(Netdisbursed; Netdisbursed)
            {
            }
            column(StatDeductions; StatDeductions)
            {
            }
            column(TotalTopUpCommission_LoansRegister; "Total TopUp Commission")
            {
            }
            column(TotLoans; TotLoans)
            {
            }
            column(PrincipleRepayment; LoanApp."Loan Principle Repayment")
            {
            }
            column(InterestRepayment; LoanApp."Loan Interest Repayment")
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans_Loans__Client_Code_; LoanApp."Client Code")
            {
            }
            column(LoansApprovedAmount; LoanApp."Approved Amount")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Loans__Requested_Amount_; "Requested Amount")
            {
            }
            column(Loans__Staff_No_; "Staff No")
            {
            }
            column(NetSalary; NetSalary)
            {
            }
            column(Approved_Amounts; "Approved Amount")
            {
            }
            column(Reccom_Amount; Recomm)
            {
            }
            column(LOANBALANCE; LOANBALANCE)
            {
            }
            column(Loans_Installments; Installments)
            {
            }
            column(Loans__No__Of_Guarantors_; "No. Of Guarantors")
            {
            }
            column(Cshares_3; Cshares * 3)
            {
            }
            column(Cshares_3__LOANBALANCE_BRIDGEBAL_LOANBALANCEFOSASEC; (Cshares * 3) - LOANBALANCE + BRIDGEBAL - LOANBALANCEFOSASEC)
            {
            }
            column(Cshares; Cshares)
            {
            }
            column(EMPLCODE; EMPLCODE)
            {
            }
            column(LOANBALANCE_BRIDGEBAL; TotalLoanBal - BRIDGEBAL)
            {
            }
            column(Loans__Transport_Allowance_; "Transport Allowance")
            {
            }
            column(Loans__Employer_Code_; "Employer Code")
            {
            }
            column(Loans__Loan_Product_Type_Name_; "Loan Product Type Name")
            {
            }
            column(Loans__Loan__No___Control1102760138; "Loan  No.")
            {
            }
            column(Loans__Application_Date__Control1102760139; "Application Date")
            {
            }
            column(Loans__Loan_Product_Type__Control1102760140; "Loan Product Type")
            {
            }
            column(Loans_Loans__Client_Code__Control1102760141; LoanApp."Client Code")
            {
            }
            column(Cust_Name_Control1102760142; Cust.Name)
            {
            }
            column(Loans__Staff_No__Control1102760144; "Staff No")
            {
            }
            column(Loans_Installments_Control1102760145; Installments)
            {
            }
            column(Loans__No__Of_Guarantors__Control1102760146; "No. Of Guarantors")
            {
            }
            column(Loans__Requested_Amount__Control1102760143; "Requested Amount")
            {
            }
            column(Loans_Repayment; Repayment)
            {
            }
            column(Loans__Employer_Code__Control1102755075; "Employer Code")
            {
            }
            column(Interest_LoansRegister; LoanApp.Interest)
            {
            }
            column(MAXAvailable; MAXAvailable)
            {
            }
            column(Cshares_Control1102760156; Cshares)
            {
            }
            column(BRIDGEBAL; BRIDGEBAL)
            {
            }
            column(LOANBALANCE_BRIDGEBAL_Control1102755006; LOANBALANCE - BRIDGEBAL)
            {
            }
            column(DEpMultiplier; DEpMultiplier)
            {
            }
            column(DefaultInfo; DefaultInfo)
            {
            }
            column(RecomRemark; RecomRemark)
            {
            }
            column(Recomm; Recomm)
            {
            }
            column(RecoveryMode_LoansRegister; LoanApp."Recovery Mode")
            {
            }
            column(BasicEarnings; BasicEarnings)
            {
            }
            column(GShares; GShares)
            {
            }
            column(GShares_TGuaranteedAmount; GShares - TGuaranteedAmount)
            {
            }
            column(Msalary; Msalary)
            {
            }
            column(MAXAvailable_Control1102755031; MAXAvailable)
            {
            }
            column(Recomm_TOTALBRIDGED; Recomm - TOTALBRIDGED)
            {
            }
            column(GuarantorQualification; GuarantorQualification)
            {
            }
            column(Requested_Amount__MAXAvailable; "Requested Amount" - MAXAvailable)
            {
            }
            column(Requested_Amount__Msalary; "Requested Amount" - Msalary)
            {
            }
            column(Requested_Amount__GShares; "Requested Amount" - GShares)
            {
            }
            column(Loan_Appraisal_AnalysisCaption; Loan_Appraisal_AnalysisCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_Application_DetailsCaption; Loan_Application_DetailsCaptionLbl)
            {
            }
            column(Loans__Application_Date_Caption; FIELDCAPTION("Application Date"))
            {
            }
            column(Loans__Loan__No__Caption; FIELDCAPTION("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(MemberCaption; MemberCaptionLbl)
            {
            }
            column(Amount_AppliedCaption; Amount_AppliedCaptionLbl)
            {
            }
            column(Loans__Staff_No_Caption; FIELDCAPTION("Staff No"))
            {
            }
            column(Loans_InstallmentsCaption; FIELDCAPTION(Installments))
            {
            }
            column(Deposits__3Caption; Deposits__3CaptionLbl)
            {
            }
            column(Eligibility_DetailsCaption; Eligibility_DetailsCaptionLbl)
            {
            }
            column(Maxim__Amount_Avail__for_the_LoanCaption; Maxim__Amount_Avail__for_the_LoanCaptionLbl)
            {
            }
            column(Outstanding_LoanCaption; Outstanding_LoanCaptionLbl)
            {
            }
            column(Member_DepositsCaption; Member_DepositsCaptionLbl)
            {
            }
            column(Loans__No__Of_Guarantors_Caption; FIELDCAPTION("No. Of Guarantors"))
            {
            }
            column(Loans__Transport_Allowance_Caption; FIELDCAPTION("Transport Allowance"))
            {
            }
            column(Loans__Employer_Code_Caption; FIELDCAPTION("Employer Code"))
            {
            }
            column(Loans__No__Of_Guarantors__Control1102760146Caption; FIELDCAPTION("No. Of Guarantors"))
            {
            }
            column(Loans_Installments_Control1102760145Caption; FIELDCAPTION(Installments))
            {
            }
            column(Loans__Staff_No__Control1102760144Caption; FIELDCAPTION("Staff No"))
            {
            }
            column(Amount_AppliedCaption_Control1102760132; Amount_AppliedCaption_Control1102760132Lbl)
            {
            }
            column(MemberCaption_Control1102760133; MemberCaption_Control1102760133Lbl)
            {
            }
            column(Loan_TypeCaption_Control1102760134; Loan_TypeCaption_Control1102760134Lbl)
            {
            }
            column(Loans__Application_Date__Control1102760139Caption; FIELDCAPTION("Application Date"))
            {
            }
            column(Loans__Loan__No___Control1102760138Caption; FIELDCAPTION("Loan  No."))
            {
            }
            column(Loan_Application_DetailsCaption_Control1102760151; Loan_Application_DetailsCaption_Control1102760151Lbl)
            {
            }
            column(RepaymentCaption; RepaymentCaptionLbl)
            {
            }
            column(Loans__Employer_Code__Control1102755075Caption; FIELDCAPTION("Employer Code"))
            {
            }
            column(Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150; Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150Lbl)
            {
            }
            column(Total_Outstand__Loan_BalanceCaption; Total_Outstand__Loan_BalanceCaptionLbl)
            {
            }
            column(Deposits___MulitiplierCaption; Deposits___MulitiplierCaptionLbl)
            {
            }
            column(Member_DepositsCaption_Control1102760148; Member_DepositsCaption_Control1102760148Lbl)
            {
            }
            column(Deposits_AnalysisCaption; Deposits_AnalysisCaptionLbl)
            {
            }
            column(Bridged_AmountCaption; Bridged_AmountCaptionLbl)
            {
            }
            column(Out__Balance_After_Top_upCaption; Out__Balance_After_Top_upCaptionLbl)
            {
            }
            column(Recommended_AmountCaption; Recommended_AmountCaptionLbl)
            {
            }
            column(Net_Loan_Disbursement_Caption; Net_Loan_Disbursement_CaptionLbl)
            {
            }
            column(V3__Qualification_as_per_GuarantorsCaption; V3__Qualification_as_per_GuarantorsCaptionLbl)
            {
            }
            column(Defaulter_Info_Caption; Defaulter_Info_CaptionLbl)
            {
            }
            column(V2__Qualification_as_per_SalaryCaption; V2__Qualification_as_per_SalaryCaptionLbl)
            {
            }
            column(V1__Qualification_as_per_SharesCaption; V1__Qualification_as_per_SharesCaptionLbl)
            {
            }
            column(QUALIFICATIONCaption; QUALIFICATIONCaptionLbl)
            {
            }
            column(Insufficient_Deposits_to_cover_the_loan_applied__RiskCaption; Insufficient_Deposits_to_cover_the_loan_applied__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption; WARNING_CaptionLbl)
            {
            }
            column(Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaption; Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption_Control1000000140; WARNING_Caption_Control1000000140Lbl)
            {
            }
            column(WARNING_Caption_Control1000000141; WARNING_Caption_Control1000000141Lbl)
            {
            }
            column(Guarantors_do_not_sufficiently_cover_the_loan__RiskCaption; Guarantors_do_not_sufficiently_cover_the_loan__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption_Control1000000020; WARNING_Caption_Control1000000020Lbl)
            {
            }
            column(Shares_Deposits_BoostedCaption; Shares_Deposits_BoostedCaptionLbl)
            {
            }
            column(DepX; DepX)
            {
            }
            column(TwoThird; TwoThirds)
            {
            }
            column(BasicPayH_LoansRegister; LoanApp."Basic Pay H")
            {
            }
            column(OtherIncome_LoansRegister; LoanApp."Other Income.")
            {
            }
            column(Thirdbasic_LoansRegister; LoanApp."Third basic")
            {
            }
            column(TwoThirdsBasic_LoansRegister; LoanApp."Two Thirds Basic")
            {
            }
            column(ExistingLoanRepayments_LoansRegister; LoanApp."Existing Loan Repayments")
            {
            }
            column(MonthlyContribution_LoansRegister; LoanApp."Monthly Contribution")
            {
            }
            column(TotalDeductions_LoansRegister; LoanApp."Total Deductions")
            {
            }
            column(TotalEarningsSalary_LoansRegister; LoanApp."Total Earnings(Salary)")
            {
            }
            column(TotalDeductionsSalary_LoansRegister; LoanApp."Total Deductions(Salary)")
            {
            }
            column(NettakeHome_LoansRegister; LoanApp."Net take Home")
            {
            }
            column(RecomendAmount; Recomend)
            {
            }
            column(OtherIncome; OtherIncome)
            {
            }
            column(LPrincipal; LPrincipal)
            {
            }
            column(LInterest; LInterest)
            {
            }
            column(LNumber; LNumber)
            {
            }
            column(TotalLoanDeductions; TotalLoanDeductions)
            {
            }
            column(MinDepositAsPerTier_Loans; "Min Deposit As Per Tier")
            {
            }
            column(TotalRepayments; TotalRepayments)
            {
            }
            column(Totalinterest; Totalinterest)
            {
            }
            column(Band; Band)
            {
            }
            column(NtTakeHome; NtTakeHome)
            {
            }
            column(ATHIRD; ATHIRD)
            {
            }
            column(Fosarepayment; Fosarepayment)
            {
            }
            column(BridgedRepayment; BridgedRepayment)
            {
            }
            column(BRIGEDAMOUNT; BRIGEDAMOUNT)
            {
            }
            column(Signature__________________Caption; Signature__________________CaptionLbl)
            {
            }
            column(Date___________________Caption; Date___________________CaptionLbl)
            {
            }
            column(General_Manger______________________Caption; General_Manger______________________CaptionLbl)
            {
            }
            column(Signature__________________Caption_Control1102760039; Signature__________________Caption_Control1102760039Lbl)
            {
            }
            column(Date___________________Caption_Control1102760040; Date___________________Caption_Control1102760040Lbl)
            {
            }
            column(Signature__________________Caption_Control1102755017; Signature__________________Caption_Control1102755017Lbl)
            {
            }
            column(Date___________________Caption_Control1102755018; Date___________________Caption_Control1102755018Lbl)
            {
            }
            column(Loans_Officer______________________Caption; Loans_Officer______________________CaptionLbl)
            {
            }
            column(Chairman_Signature______________________Caption; Chairman_Signature______________________CaptionLbl)
            {
            }
            column(CheckedBy_LoansRegister; LoanApp."Checked By")
            {
            }
            column(ApprovedBy_LoansRegister; LoanApp."Approved By")
            {
            }
            column(Secretary_s_Signature__________________Caption; Secretary_s_Signature__________________CaptionLbl)
            {
            }
            column(Members_Signature______________________Caption; Members_Signature______________________CaptionLbl)
            {
            }
            column(Credit_Committe_Minute_No______________________Caption; Credit_Committe_Minute_No______________________CaptionLbl)
            {
            }
            column(Date___________________Caption_Control1102755074; Date___________________Caption_Control1102755074Lbl)
            {
            }
            column(Comment____________CaptionLbl; Comment____________CaptionLbl)
            {
            }
            column(Loans_Asst__Officer______________________Caption; Loans_Asst__Officer______________________CaptionLbl)
            {
            }
            dataitem(DataItem3518; "Loan Appraisal Salary Details")
            {
                DataItemLink = "Client Code" = FIELD("Client Code"),
                               "Loan No" = FIELD("Loan  No.");
                DataItemTableView = SORTING("Loan No", "Client Code", Code);
                PrintOnlyIfDetail = false;
                column(Appraisal_Salary_Details__Client_Code_; "Client Code")
                {
                }
                column(Appraisal_Salary_Details_Code; Code)
                {
                }
                column(Appraisal_Salary_Details_Description; Description)
                {
                }
                column(Appraisal_Salary_Details_Type; Type)
                {
                }
                column(Appraisal_Salary_Details_Amount; Amount)
                {
                }
                column(Earnings; Earnings)
                {
                }
                column(Deductions; Deductions)
                {
                }
                column(Earnings_Deductions___Earnings__1_3; (Earnings - Deductions) - (Earnings) * 1 / 3)
                {
                }
                column(Earnings__1_3; (Earnings) * 1 / 3)
                {
                }
                column(Net_Salary; NetSalary)
                {
                }
                column(Msalary_Control1102755030; Msalary)
                {
                }
                column(Appraisal_Salary_Details__Client_Code_Caption; FIELDCAPTION("Client Code"))
                {
                }
                column(Appraisal_Salary_Details_CodeCaption; FIELDCAPTION(Code))
                {
                }
                column(Appraisal_Salary_Details_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Appraisal_Salary_Details_TypeCaption; FIELDCAPTION(Type))
                {
                }
                column(Appraisal_Salary_Details_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(Salary_Details_AnalysisCaption; Salary_Details_AnalysisCaptionLbl)
                {
                }
                column(Total_EarningsCaption; Total_EarningsCaptionLbl)
                {
                }
                column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
                {
                }
                column(Net_SalaryCaption; Net_SalaryCaptionLbl)
                {
                }
                column(Qualification_as_per_SalaryCaption; Qualification_as_per_SalaryCaptionLbl)
                {
                }
                column(V1_3_of_Gross_PayCaption; V1_3_of_Gross_PayCaptionLbl)
                {
                }
                column(GuarOutstanding; GuarOutstanding)
                {
                }
                column(OTHERDEDUCTIONS; OTHERDEDUCTIONS)
                {
                }
            }
            dataitem(DataItem5140; "Loans Guarantee Details")
            {
                DataItemLink = "Loan No" = FIELD("Loan  No.");
                DataItemTableView = SORTING("Loan No", "Member No")
                                    WHERE("Amont Guaranteed" = FILTER(<> 0));
                PrintOnlyIfDetail = false;
                column(Amont_Guarant; "Loan No")
                {
                }
                column(Name; Name)
                {
                }
                column(AmontGuaranteed_LoansGuaranteeDetails; LoanG."Amont Guaranteed")
                {
                }
                column(Guarantor_Memb_No; LoanG."Member No")
                {
                }
                column(G_Shares; LoanG.Shares)
                {
                }
                column(Loan_Guarant; "Loan No")
                {
                }
                column(Guarantor_Outstanding; "Guarantor Outstanding")
                {
                }
                column(Employer_code; "Employer Code")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF CustRecord.GET(LoanG."Member No") THEN BEGIN
                        //CustRecord.CALCFIELDS(CustRecord."Current Savings",CustRecord."Principal Balance");
                        TShares := TShares + CustRecord."Current Savings";
                        TLoans := TLoans + CustRecord."Principal Balance";
                    END;

                    //GuaranteedAmount:=0;
                    LoanG.RESET;

                    LoanG.SETRANGE(LoanG."Member No", "Member No");
                    IF LoanG.FIND('-') THEN BEGIN
                        REPEAT
                            LoanG.CALCFIELDS(LoanG."Outstanding Balance", LoanG."Guarantor Outstanding");
                            IF LoanG."Outstanding Balance" > 0 THEN BEGIN
                                GuaranteedAmount := GuaranteedAmount + LoanG."Amont Guaranteed";
                                GuarOutstanding := LoanG."Guarantor Outstanding";
                            END;
                        UNTIL LoanG.NEXT = 0;
                    END;
                    TGuaranteedAmount := TGuaranteedAmount + GuaranteedAmount;
                end;
            }
            dataitem("Loan Offset Details"; "Loan Offset Details")
            {
                DataItemLink = "Loan No." = FIELD("Loan  No.");
                DataItemTableView = WHERE("Total Top Up" = FILTER(> 0));
                PrintOnlyIfDetail = false;
                column(Loans_Top_up__Principle_Top_Up_; "Principle Top Up")
                {
                }
                column(Loans_Top_up__Loan_Type_; Ttype)
                {
                }
                column(Loans_Top_up__Client_Code_; "Client Code")
                {
                }
                column(Loans_Top_up__Loan_No__; "Loan No.")
                {
                }
                column(Loans_Top_up__Total_Top_Up_; "Principle Top Up" + "Interest Top Up" + Commision)
                {
                }
                column(Loans_Top_up__Interest_Top_Up_; "Interest Top Up")
                {
                }
                column(Loan_Type; "Loan Offset Details"."Loan Type")
                {
                }
                column(Loans_Top_up_Commision; Commision)
                {
                }
                column(Loans_Top_up__Principle_Top_Up__Control1102760116; "Principle Top Up")
                {
                }
                column(ExpectedRepayment_LoanOffsetDetails; "Loan Offset Details"."Expected Repayment")
                {
                }
                column(BrTopUpCom; BrTopUpCom)
                {
                }
                column(TOTALBRIDGED; TOTALBRIDGED)
                {
                }
                column(Loans_Top_up__Total_Top_Up__Control1102755050; "Total Top Up")
                {
                }
                column(Loans_Top_up_Commision_Control1102755053; Commision)
                {
                }
                column(Loans_Top_up__Interest_Top_Up__Control1102755055; "Interest Top Up")
                {
                }
                column(Total_TopupsCaption; Total_TopupsCaptionLbl)
                {
                }
                column(Bridged_LoansCaption; Bridged_LoansCaptionLbl)
                {
                }
                column(Loan_No_Caption; Loan_No_CaptionLbl)
                {
                }
                column(Loans_Top_up_CommisionCaption; FIELDCAPTION(Commision))
                {
                }
                column(Principal_Top_UpCaption; Principal_Top_UpCaptionLbl)
                {
                }
                column(Loans_Top_up__Interest_Top_Up_Caption; FIELDCAPTION("Interest Top Up"))
                {
                }
                column(Client_CodeCaption; Client_CodeCaptionLbl)
                {
                }
                column(Loan_TypeCaption_Control1102755059; Loan_TypeCaption_Control1102755059Lbl)
                {
                }
                column(TotalsCaption; TotalsCaptionLbl)
                {
                }
                column(Total_Amount_BridgedCaption; Total_Amount_BridgedCaptionLbl)
                {
                }
                column(Bridging_total_higher_than_the_qualifing_amountCaption; Bridging_total_higher_than_the_qualifing_amountCaptionLbl)
                {
                }
                column(WARNING_Caption_Control1102755044; WARNING_Caption_Control1102755044Lbl)
                {
                }
                column(Loans_Top_up_Loan_Top_Up; "Loan Top Up")
                {
                }
                column(WarnBridged; WarnBridged)
                {
                }
                column(WarnSalary; WarnSalary)
                {
                }
                column(WarnDeposits; WarnDeposits)
                {
                }
                column(WarnGuarantor; WarnGuarantor)
                {
                }
                column(WarnShare; WarnShare)
                {
                }
                column(LoanDefaultInfo; DefaultInfo)
                {
                }
                column(Riskamount; Riskamount)
                {
                }
                column(RiskDeposits; RiskDeposits)
                {
                }
                column(RiskGshares; RiskGshares)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    TotalTopUp := ROUND((TotalTopUp + "Principle Top Up"), 0.05, '>');
                    TotalIntPayable := TotalIntPayable + "Monthly Repayment";
                    GTotals := GTotals + ("Principle Top Up" + "Monthly Repayment");
                    IF LoanApp.GET("Loan Offset Details"."Loan No.") THEN BEGIN
                        IF LoanType.GET(LoanApp."Loan Product Type") THEN
                            Ttype := LoanType."Product Description";
                    END;
                    //END;

                    TOTALBRIDGED := TOTALBRIDGED + "Loan Offset Details"."Total Top Up";

                    IF TOTALBRIDGED > Recomm THEN
                        WarnBridged := UPPERCASE('WARNING: Bridging Total is Higher than the Qualifing Amount.')
                    ELSE
                        WarnBridged := '';
                end;

                trigger OnPreDataItem()
                begin
                    BrTopUpCom := 0;
                    TOTALBRIDGED := 0;
                end;
            }
            dataitem(DataItem1000000049; "Other Commitements Clearance")
            {
                DataItemLink = "Loan No." = FIELD("Loan  No.");
                column(LoanNo_OtherCommitementsClearance; "Loan No.")
                {
                }
                column(Description_OtherCommitementsClearance; Lcommit.Description)
                {
                }
                column(Payee_OtherCommitementsClearance; Lcommit.Payee)
                {
                }
                column(Amount_OtherCommitementsClearance; Lcommit.Amount)
                {
                }
                column(DateFilter_OtherCommitementsClearance; Lcommit."Date Filter")
                {
                }
                column(BankersChequeNo_OtherCommitementsClearance; Lcommit."Bankers Cheque No")
                {
                }
                column(BankersChequeNo2_OtherCommitementsClearance; Lcommit."Bankers Cheque No 2")
                {
                }
                column(BankersChequeNo3_OtherCommitementsClearance; Lcommit."Bankers Cheque No 3")
                {
                }
                column(BatchNo_OtherCommitementsClearance; Lcommit."Batch No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                SalAmount: Decimal;
                QualAmount: Decimal;
                TotalStandingOrder: Decimal;
                StandingOrder: Record "Standing Orders";
                BasicPayR: Decimal;
            begin
                //Initials:=(COPYSTR(USERID,8));
                Generate.AutogeneratescheduleBuffer(LoanApp."Loan  No.");
                Cshares := 0;
                MAXAvailable := 0;
                LOANBALANCE := 0;
                TotalTopUp := 0;
                TotalIntPayable := 0;
                GTotals := 0;
                AmountGuaranteed := 0;
                TotLoans := 0;
                BInt := 0;

                //EMPLCODE:=0;

                TotalSec := 0;
                TShares := 0;
                TLoans := 0;
                Earnings := 0;
                Deductions := 0;
                BASIC := 0;
                NetSalary := 0;
                LoanPrincipal := 0;
                loanInterest := 0;
                Psalary := 0;
                TotalLoanBal := 0;
                TotalBand := 0;
                //NtTakeHome:=0;
                //NetDisburment:=0;
                TotalRepay := 0;
                OtherIncome := 0;
                RepaymentAmount := 0;
                PrincipleAmount := 0;
                InterestAmount := 0;
                BufferSchedule.RESET;
                BufferSchedule.SETRANGE(BufferSchedule."Loan No", LoanApp."Loan  No.");
                IF BufferSchedule.FINDFIRST THEN BEGIN
                    RepaymentAmount := BufferSchedule."Monthly Repayment";
                    PrincipleAmount := BufferSchedule."Principle Repayment";
                    InterestAmount := BufferSchedule."Monthly Interest";
                END;
                OtherIncome := LoanApp."Other Income.";
                //LoanApp."Total Deductions(Salary)":=0;
                //update salary
                LoanApp."Third basic" :=/*0.25*/(1 / 3) * (LoanApp."Basic Pay H");
                LoanApp."Two Thirds Basic" :=/*(0.75)*/(2 / 3) * (LoanApp."Basic Pay H");
                IF LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary THEN BEGIN
                    LoanApp."Third basic" := 0.25 * (LoanApp."Basic Pay H");
                    LoanApp."Two Thirds Basic" := 0.75 * (LoanApp."Basic Pay H");
                END;


                Fosarepayment := 0;

                LoanApp.RESET;
                LoanApp.SETRANGE(LoanApp."Client Code", "Client Code");
                //LoanApp.SETRANGE(LoanApp.Source,LoanApp.Source::FOSA);
                LoanApp.SETRANGE(LoanApp."Recovery Mode", LoanApp."Recovery Mode"::Salary);
                LoanApp.SETRANGE(LoanApp.Posted, TRUE);
                IF LoanApp.FINDSET THEN BEGIN
                    REPEAT
                        //IF (LoanApp."Loan Product Type"='D/L') OR (LoanApp."Loan Product Type"='E/L')  OR  (LoanApp."Loan Product Type"='J/L') OR (LoanApp."Loan Product Type"='SELF') THEN BEGIN
                        LoanApp.CALCFIELDS(LoanApp."Outstanding Balance", LoanApp."Total Repayments", LoanApp."Total Interest");
                        IF LoanApp."Outstanding Balance" > 0 THEN BEGIN

                            // Fosarepayment:=Fosarepayment+LoanApp.Repayment;

                            LoanRepaymentSchedule.RESET;
                            LoanRepaymentSchedule.SETRANGE(LoanRepaymentSchedule."Loan No.", LoanApp."Loan  No.");
                            IF LoanRepaymentSchedule.FINDFIRST THEN
                                Fosarepayment := Fosarepayment + LoanRepaymentSchedule."Monthly Repayment"
                            ELSE
                                Fosarepayment := Fosarepayment + LoanApp.Repayment;
                        END;
                    //END;
                    UNTIL LoanApp.NEXT = 0;
                END;

                //LoanApp."Total Deductions(Salary)":=Fosarepayment+LoanApp."Other Deductions"+LoanApp."Total Deductions(Salary)";
                //+LoanApp."Total Deductions(Salary)";
                //LoanApp."Net take Home":=({0.75}(2/3)*LoanApp."Basic Pay H")-(Fosarepayment+LoanApp."Other Deductions");
                //LoanApp."Net take Home":=(LoanApp."Total Earnings(Salary)"-LoanApp."Total Deductions(Salary)"-
                //LoanApp."Third basic");//Kitui
                //LoanApp."Net take Home":=(LoanApp."Two Thirds Basic"-"Total Deductions(Salary)");
                //TotalDeductionsSalary := LoanApp."Total Deductions(Salary)"
                //LoanApp.MODIFY;;
                COMMIT;
                //end of update
                Cust.SETRANGE(Cust."No.", LoanApp."Client Code");
                IF Cust.FIND('-') THEN BEGIN
                    EMPLCODE := Cust."Employer Code";
                    Cust.CALCFIELDS(Cust."Current Shares");
                    Cshares := Cust."Current Shares";
                END;


                //Recomended Amount
                IF LoanApp.Repayment < LoanApp."Net take Home" THEN
                    Recomend := LoanApp."Requested Amount"
                ELSE
                    Recomend := LoanApp."Net take Home" * LoanApp.Installments;

                //  Deposits analysis
                IF LoanType.GET(LoanApp."Loan Product Type") THEN BEGIN

                    //QUALIFICATION AS PER DEPOSITS

                    IF "Loan Product Type" = 'J/L' THEN BEGIN
                        DEpMultiplier := LoanType."Shares Multiplier" * (Cshares + "Jaza Deposits" + "Deposit Reinstatement")

                    END ELSE BEGIN
                        DEpMultiplier := LoanType."Shares Multiplier" * (Cshares + "Deposit Reinstatement");
                    END;

                    BridgedRepayment := 0;
                    TotalRepayments := 0;
                    //Bonnie
                    LoanApp.RESET;
                    LoanApp.SETRANGE(LoanApp."Client Code", "Client Code");
                    LoanApp.SETRANGE(LoanApp.Source, LoanApp.Source::BOSA);
                    LoanApp.SETRANGE(LoanApp.Posted, TRUE);
                    IF LoanApp.FIND('-') THEN BEGIN
                        REPEAT
                            //IF (LoanApp."Loan Product Type"='D/L') OR (LoanApp."Loan Product Type"='E/L')  OR  (LoanApp."Loan Product Type"='J/L') OR (LoanApp."Loan Product Type"='SELF') THEN BEGIN
                            LoanApp.CALCFIELDS(LoanApp."Outstanding Balance", LoanApp."Total Repayments", LoanApp."Total Interest");
                            IF LoanApp."Outstanding Balance" > 0 THEN BEGIN
                                LOANBALANCE := LOANBALANCE + LoanApp."Outstanding Balance";
                                TotalRepayments := TotalRepayments + LoanApp.Repayment;

                            END;
                        //END;
                        UNTIL LoanApp.NEXT = 0;
                    END;
                END;
                SHARES := 0;
                Commision := 0;
                Deeboster := 0;
                TOpDeb := 0;
                LoanTopUp.RESET;
                LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApp."Loan  No.");
                LoanTopUp.SETRANGE(LoanTopUp."Client Code", LoanApp."Client Code");
                IF LoanTopUp.FIND('-') THEN BEGIN
                    REPEAT
                        //BRIGEDAMOUNT:=BRIGEDAMOUNT+LoanTopUp."Principle Top Up";
                        BRIGEDAMOUNT := BRIGEDAMOUNT + LoanTopUp."Principle Top Up";
                        BInt := BInt + LoanTopUp."Interest Top Up";
                        Commision := Commision + LoanTopUp.Commision;
                    UNTIL LoanTopUp.NEXT = 0;

                END;
                IF LoanType.GET("Loan Product Type") THEN BEGIN
                    //IF LoanType.Source=LoanType.Source::BOSA THEN BEGIN
                    IF LoanType."Post to Deposits" = TRUE THEN BEGIN


                        SHARES := "Approved Amount" * 0.005;
                        //IF ("Loan Product Type"='L05') THEN
                        //SHARES:=0;
                        IF SHARES > 5000 THEN
                            SHARES := 5000;

                        IF LoanType.Code = 'L16' THEN BEGIN
                            Deeboster := ("Approved Amount" * 50 / 100);
                            TOpDeb := ("Approved Amount" * 5 / 100);
                        END;
                    END;
                    //END;
                END;
                LoanTopUp.RESET;
                LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApp."Loan  No.");
                LoanTopUp.SETRANGE(LoanTopUp."Client Code", LoanApp."Client Code");
                IF LoanTopUp.FIND('-') THEN BEGIN

                    REPEAT

                        IF LoanTopUp."Partial Bridged" = FALSE THEN BEGIN

                            BridgedRepayment := BridgedRepayment + LoanTopUp."Monthly Repayment";
                            FinalInst := FinalInst + LoanTopUp."Finale Instalment";
                        END;
                    UNTIL LoanTopUp.NEXT = 0;
                END;

                TotalRepayments := TotalRepayments - BridgedRepayment;

                TotalLoanBal := (LOANBALANCE + LoanApp."Approved Amount") - BRIGEDAMOUNT;


                LBalance := LOANBALANCE - BRIGEDAMOUNT + Commision;
                //****Banding*******************************
                /*
                IF CONFIRM('Do you Want the system to insert the Minimum Deposits Contributions?',FALSE)=TRUE THEN BEGIN
                IF BANDING.FIND('-') THEN BEGIN
                REPEAT
                IF (TotalLoanBal>=BANDING."Minimum Amount") AND (TotalLoanBal<=BANDING."Maximum Amount") THEN BEGIN
                Band:=BANDING."Minimum Dep Contributions";
                "Min Deposit As Per Tier":=Band;

                MODIFY;
                END;
                UNTIL BANDING.NEXT=0;
                END;
                END ELSE
                Band:="Min Deposit As Per Tier";
                */

                ///****************End Banding************
                TotalBand := TotalLoanBal + Band;



                //***Banding


                //**Guarantors Loan Balances
                LoanG.RESET;
                LoanG.SETRANGE(LoanG."Member No", "Client Code");
                IF LoanG.FIND('-') THEN BEGIN
                    CALCFIELDS("Outstanding Balance");
                    GuarOutstanding := "Outstanding Balance";
                END;


                //qualification as per salary
                //compute Earnings
                SalDetails.RESET;
                SalDetails.SETRANGE(SalDetails."Member No", LoanApp."Client Code");
                //SalDetails.SETRANGE(SalDetails."Loan , LoanApp."Loan  No.");
                //SalDetails.SETRANGE(SalDetails.Type, SalDetails.Type::Earnings);
                IF SalDetails.FIND('-') THEN BEGIN
                    REPEAT
                        Earnings := Earnings + SalDetails."Gross Amount";
                    UNTIL SalDetails.NEXT = 0;

                END;



                //compute BASIC
                SalDetails.RESET;
                SalDetails.SETRANGE(SalDetails."Member No", LoanApp."Client Code");
                //SalDetails.SETRANGE(SalDetails., LoanApp."Loan  No.");
                //SalDetails.SETRANGE(SalDetails.Type, SalDetails.Type::Earning);
                IF SalDetails.FIND('-') THEN BEGIN
                    REPEAT
                        //IF SalDetails."Gross Amount" = TRUE THEN
                        BASIC := BASIC + SalDetails."Gross Amount";
                    UNTIL SalDetails.NEXT = 0;
                END;

                /*
                //compute Earnings
                //compute Deduction
                SalDetails.RESET;
                SalDetails.SETRANGE(SalDetails."Client Code",Loans."Client Code");
                SalDetails.SETRANGE(SalDetails.Type,SalDetails.Type::Deductions);

                IF SalDetails.FIND('-') THEN BEGIN
                REPEAT
                 Deductions:=Deductions+SalDetails.Amount;
                UNTIL SalDetails.NEXT=0;
                END;
                MESSAGE('StatDeductions is %1',StatDeductions);

                    */

                //**//  Statutory Ded
                /*                     SalDetails.RESET;
                                    SalDetails.SETRANGE(SalDetails."Member No", LoanApp."Client Code");
                                    //SalDetails.SETRANGE(SalDetails."Loan No", LoanApp."Loan  No.");
                                    //SalDetails.SETRANGE(SalDetails.Type, SalDetails.Type::Deductions);
                                    SalDetails.SETRANGE(SalDetails.Statutory, TRUE);
                                    IF SalDetails.FIND('-') THEN BEGIN
                                        REPEAT
                                            StatDeductions := StatDeductions + SalDetails."Gross Amount";
                                        UNTIL SalDetails.NEXT = 0;
                                    END; */



                //**//  Statutory Ded End


                //**//  Long Term Ded
                /*                     SalDetails.RESET;
                                    SalDetails.SETRANGE(SalDetails."Member No", LoanApp."Client Code");
                                    SalDetails.SETRANGE(SalDetails."Loan No", LoanApp."Loan  No.");
                                    SalDetails.SETRANGE(SalDetails.Type, SalDetails.Type::Deductions);
                                    SalDetails.SETRANGE(SalDetails.Statutory, FALSE);
                                    IF SalDetails.FIND('-') THEN BEGIN
                                        REPEAT
                                            OTHERDEDUCTIONS := OTHERDEDUCTIONS + SalDetails.Amount;
                                        UNTIL SalDetails.NEXT = 0;
                                    END; */



                //**//  Long Term Ded End





                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                LoanAmount := 0;
                InterestRate := Interest;
                LoanAmount := "Requested Amount";
                RepayPeriod := Installments;
                //LBalance1:="Approved Amount";

                IF "Loan Product Type" <> 'BBL' THEN BEGIN
                    IF "Repayment Method" = "Repayment Method"::Amortised THEN BEGIN
                        //TESTFIELD(Installments);
                        //LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
                        //LInterest:=ROUND((InterestRate/100)/12*LoanAmount,1,'>');

                        TESTFIELD("Loan  No.");
                        TESTFIELD(Installments);
                        "Loan Principle Repayment" := Repayment - "Loan Interest Repayment";
                        "Loan Interest Repayment" := ROUND("Approved Amount" / 100 / 12 * Interest, 0.05, '>');
                        Repayment := ROUND((Interest / 12 / 100) / (1 - POWER((1 + (Interest / 12 / 100)), -Installments)) * "Approved Amount", 1, '>');
                        //Repayment:=LPrincipal+LInterest;
                        //"Loan Principle Repayment":=LPrincipal;
                        //"Loan Interest Repayment":=LInterest;

                    END;
                END;

                //**2Thirds Waumini

                //TwoThirds:=ROUND((Earnings- StatDeductions)*2/3,0.05,'>');
                //ATHIRD:=ROUND((Earnings- StatDeductions)*1/3,0.05,'>');
                TwoThirds := ROUND((BASIC) * 2 / 3, 0.05, '>');
                ATHIRD := ROUND((BASIC) * 1 / 3, 0.05, '>');
                IF LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary THEN BEGIN
                    TwoThirds := ROUND((BASIC) * 0.75, 0.05, '>');

                    ATHIRD := ROUND((BASIC) * 0.25, 0.05, '>');
                END;
                NtTakeHome := TwoThirds - (TotalRepayments + Repayment + Band);
                IF LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Checkoff THEN BEGIN
                    ATHIRD := ROUND((BASIC) * 0.25, 0.05, '>');
                    TwoThirds := ROUND((BASIC) * 0.67, 0.05, '>');

                    totnettakehome := (LoanApp."Total Earnings(Salary)") - (LoanApp."Third basic"
                                    + LoanApp."Total Deductions(Salary)") + BridgedRepayment - TotalRepayments;

                    LoanApp."Net take Home" := totnettakehome;
                    LoanApp.MODIFY;

                END ELSE
                    totnettakehome := LoanApp."Net take Home";
                //compute Deductions
                //NetSalary:=Earnings-StatDeductions-TotalRepayments-Band-Repayment+LoanTopUp."Remaining Installments"-OTHERDEDUCTIONS;
                NetSalary := Earnings - OTHERDEDUCTIONS;
                //MESSAGE('Net%1',NetSalary);
                salary := ROUND(((Earnings - Deductions) * 2 / 3) - Band - TotalRepayments, 0.05, '>');
                IF LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary THEN
                    salary := ROUND(((Earnings - Deductions) * 0.75) - Band - TotalRepayments, 0.05, '>');

                //Psalary:=TwoThirds-(OTHERDEDUCTIONS);
                //Kit Overdraft
                BasicPayR := 0;
                BasicPayR := 0.85 * LoanApp."Basic Pay H";
                BasicPayR := BasicPayR - LoanApp."Total Deductions(Salary)";
                //MESSAGE('BasicR%1Basic2%2Totals%3',BasicPayR,LoanApp."Basic Pay H",LoanApp."Total Deductions(Salary)");
                //Kit Overdraft
                totnettakehome := BasicPayR;
                Psalary := totnettakehome;
                //Total amount guaranteed
                GShares := 0;
                GShares1 := 0;
                LoanG.RESET;
                LoanG.SETRANGE(LoanG."Loan No", "Loan  No.");
                IF LoanG.FIND('-') THEN BEGIN
                    REPEAT
                        // GShares1:=LoanG.Shares;
                        // GShares:=GShares+LoanG.Shares;
                        GShares1 := LoanG."Amont Guaranteed";
                        GShares := GShares + LoanG."Amont Guaranteed";
                    UNTIL LoanG.NEXT = 0;
                END;
                //End Total Amount guaranteed
                //MESSAGE('guarantor shares%1',GShares1);


                //Recommended Amount

                IF "Loan Product Type" = 'J/L' THEN BEGIN

                    DepX := DEpMultiplier - (LBalance - FinalInst)
                    //DepX:=("Member Deposits"+"Jaza Deposits"+"Deposit Reinstatement")-LBalance ;
                END
                ELSE
                    DepX := (DEpMultiplier);
                Psalary := ROUND((2 / 3 * Psalary), 0.5, '>');
                //Qualification As Per Salary
                //Msalary:=ROUND((Psalary*"Requested Amount")/Repayment,100,'<');


                IF (Psalary > Repayment) OR (Psalary = Repayment) THEN BEGIN
                    Msalary := "Requested Amount"

                END ELSE BEGIN
                    //Msalary:=ROUND((salary*100*Installments)/(100+Installments),100,'<');
                    //Msalary:=ROUND((Psalary*"Requested Amount")/Repayment,100,'<');
                    Msalary := ROUND((totnettakehome / (InterestRate / 12 / 100)) * (1 - POWER((1 + (InterestRate / 12 / 100)), -RepayPeriod)), 1, '<');
                    // End Qualification As Per Salary
                END;
                //MESSAGE('Gshares%1DepX%2Msalary%3',GShares,DepX,Msalary);

                IF LoanProductSetup.GET(LoanApp."Loan Product Type") THEN BEGIN
                    IF LoanProductSetup."Appraise Deposits" = TRUE THEN BEGIN
                        IF (DepX <= Msalary) AND (DepX <= GShares) THEN
                            Recomend := ROUND(DepX, 100, '<');
                    END;
                    IF LoanProductSetup."Appraise Salary" = TRUE THEN BEGIN
                        IF (Msalary <= DepX) AND (Msalary <= GShares) THEN
                            Recomend := ROUND(Msalary, 100, '<');
                    END;
                    IF LoanProductSetup."Appraise Guarantors" = TRUE THEN BEGIN
                        IF (GShares <= DepX) AND (GShares <= Msalary) THEN
                            Recomend := ROUND(GShares, 100, '<');
                    END;
                END;

                //MESSAGE('Reccomend%1msalary%2',Recomend,Msalary);
                IF Recomm > LoanApp."Requested Amount" THEN
                    Recomm := ROUND(LoanApp."Requested Amount", 100, '<');
                IF Recomm < 0 THEN BEGIN
                    Recomm := ROUND(Recomm, 100, '<');
                END;

                IF Recomend > LoanApp."Requested Amount" THEN
                    Recomend := ROUND(LoanApp."Requested Amount", 100, '<');
                IF Recomend < 0 THEN BEGIN
                    Recomend := ROUND(Recomend, 100, '<');
                END;





                //  Riskamount := LoanApp."Requested Amount" - MAXAvailable;

                //   "Recommended Amount" := Recomm;

                //     LoanApp.MODIFY;
                //Recommended Amount





                /*
                //Identify Defaulters
                LoanApp.RESET;
                LoanApp.SETRANGE(LoanApp."Client Code",Loans."Client Code");
                LoanApp.SETRANGE(LoanApp.Posted,TRUE);
                IF LoanApp.FIND('-') THEN BEGIN
                REPEAT
                LoanApp.CALCFIELDS(LoanApp."Outstanding Balance",LoanApp."Total Repayments",LoanApp."Total Interest",LoanApp."Topup Commission");

                IF LoanApp."Outstanding Balance">0 THEN BEGIN
                IF (LoanApp."Loans Category"=LoanApp."Loans Category"::Substandard) OR
                (LoanApp."Loans Category"=LoanApp."Loans Category"::Doubtful) OR (LoanApp."Loans Category"=LoanApp."Loans Category"::Loss)
                THEN BEGIN
                DefaultInfo:='The member is a defaulter' +'. '+ 'Loan No' + ' '+LoanApp."Loan  No."+' ' + 'is in loan category' +' '+
                FORMAT(LoanApp."Loans Category");
                END;
                END;
                UNTIL LoanApp.NEXT=0;
                END;
                //End Identify Defaulters
                      */

                //Compute monthly Repayments based on repay method

                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                LoanAmount := 0;
                InterestRate := Interest;
                LoanAmount := "Approved Amount";
                RepayPeriod := Installments;
                LBalance := "Approved Amount";



                LoanG.RESET;
                LoanG.SETRANGE(LoanG."Loan No", LoanApp."Loan  No.");
                IF LoanG.FIND('-') THEN BEGIN
                    LoanG.CALCSUMS(LoanG."Amont Guaranteed");
                    TGAmount := LoanG."Amont Guaranteed";
                END;

                LoanApp.RESET;
                LoanApp.SETRANGE(LoanApp."Loan  No.", "Loan  No.");
                IF LoanApp.FIND('-') THEN BEGIN
                    //LoanApp.CALCFIELDS(LoanApp."Topup Commission");kit
                END;

                Lamount := 0;
                LoanApp.reset;
                LoanApp.SetRange(LoanApp."Loan  No.", DataItem4645."Loan  No.");
                if LoanApp.findfirst then begin
                    Lcommit.RESET;

                    Lcommit.SETRANGE(Lcommit."Loan No.", LoanApp."Loan  No.");
                    IF Lcommit.FIND('-') THEN BEGIN
                        REPEAT

                            Lamount := Lamount + Lcommit.Amount;
                        ///END;
                        UNTIL Lcommit.NEXT = 0;
                    END;
                    Lamount := Lamount + LoanApp."Total TopUp Commission";

                    GenSetUp.GET();
                    Charge := 0;
                    IF LoanType.GET("Loan Product Type") THEN BEGIN
                        Pcharges.RESET;
                        Pcharges.SETRANGE(Pcharges."Product Code", "Loan Product Type");
                        IF Pcharges.FIND('-') THEN BEGIN
                            REPEAT
                                Charge := Charge + Pcharges.Amount;
                            UNTIL Pcharges.NEXT = 0;
                        END;

                        JazaLevy := ROUND("Jaza Deposits" * 0.15, 1, '>');
                        //BridgeLevy := LoanApp."Topup Commission";kit

                        IF LoanApp."Top Up Amount" > 0 THEN BEGIN
                            IF BridgeLevy < 500 THEN BEGIN
                                BridgeLevy := 500;
                            END ELSE BEGIN
                                // BridgeLevy := LoanApp."Topup Commission";kit
                            END;
                        END;
                        Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + GenSetUp."Loan Trasfer Fee-Cheque" + SHARES + Charge + Lamount + BridgeLevy + BInt + Deeboster + TOpDeb;
                        IF "Mode of Disbursement" = "Mode of Disbursement"::Cheque THEN
                            Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + GenSetUp."Loan Trasfer Fee-Cheque" + SHARES + Charge + Lamount + BridgeLevy + BInt + Deeboster + TOpDeb
                        ELSE
                            IF "Mode of Disbursement" = "Mode of Disbursement"::EFT THEN
                                Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + GenSetUp."Loan Trasfer Fee-EFT" + SHARES + Charge + Lamount + BridgeLevy + BInt + Deeboster + TOpDeb
                            ELSE
                                IF "Mode of Disbursement" = "Mode of Disbursement"::"FOSA Account" THEN
                                    Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + GenSetUp."Loan Trasfer Fee-FOSA" + SHARES + Charge + Lamount + BridgeLevy + BInt + Deeboster + TOpDeb
                                ELSE
                                    //Enock
                                    IF "Mode of Disbursement" = "Mode of Disbursement"::"Cheque NonMember" THEN
                                        Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + SHARES + Charge + Lamount + BridgeLevy + BInt + Deeboster + TOpDeb
                                    ELSE

                                        //End Enock
                                        IF "Mode of Disbursement" = "Mode of Disbursement"::RTGS THEN
                                            Upfronts := BRIGEDAMOUNT + "Jaza Deposits" + "Deposit Reinstatement" + JazaLevy + GenSetUp."Loan Trasfer Fee-RTGS" + SHARES + Charge + Lamount + BInt + Deeboster + TOpDeb;
                        //Message('TotalEarnings%1ThirdBasic%2TotalDeductions%3BridegedRepayment%4TotalRepayment%5',LoanApp."Total Earnings(Salary)",LoanApp."Third basic",LoanApp."Total Deductions(Salary)",BridgedRepayment,TotalRepayments);
                        Netdisbursed := "Approved Amount"; //- Upfronts;
                    END;
                    Charge := 0.03 * LoanApp."Approved Amount";
                    Netdisbursed := Netdisbursed;//; - Charge;

                    "Loan Processing Fee" := Charge;
                    //"Checked By":=USERID;
                    "Loan Appraisal Fee" := SHARES;
                    "Loan Disbursed Amount" := Netdisbursed;
                    MODIFY;

                    IF Netdisbursed < 0 THEN
                        MESSAGE('Net Disbursed cannot be 0 or Negative');

                    IF MAXAvailable < 0 THEN
                        WarnDeposits := UPPERCASE('WARNING: Insufficient Deposits to cover the loan applied: Risk %1')
                    ELSE
                        WarnDeposits := '';
                    IF MAXAvailable < 0 THEN
                        RiskDeposits := LoanApp."Requested Amount" - MAXAvailable;


                    IF Msalary < LoanApp."Requested Amount" THEN
                        WarnSalary := UPPERCASE('WARNING: Salary is Insufficient to cover the loan applied: Risk')
                    ELSE
                        WarnSalary := '';
                    IF Msalary < LoanApp."Requested Amount" THEN
                        Riskamount := LoanApp."Requested Amount" - Msalary;

                    IF GShares < LoanApp."Requested Amount" THEN
                        WarnGuarantor := UPPERCASE('WARNING: Guarantors do not sufficiently cover the loan: Risk')
                    ELSE
                        WarnGuarantor := '';
                    IF GShares < LoanApp."Requested Amount" THEN
                        RiskGshares := LoanApp."Requested Amount" - GShares;

                END;

                //Update Checkoff matrix loan codes
                CheckoffMatrix.RESET;
                CheckoffMatrix.SETRANGE(CheckoffMatrix."Employer Code", LoanApp."Employer Code");
                CheckoffMatrix.SETRANGE(CheckoffMatrix."Loan Product Code", LoanApp."Loan Product Type");
                CheckoffMatrix.SETRANGE(CheckoffMatrix."check Interest", FALSE);
                IF CheckoffMatrix.FIND('-') THEN BEGIN
                    IF LoanApp."Emp Loan Codes" = '' THEN
                        LoanApp."Emp Loan Codes" := CheckoffMatrix."Check off Code";
                    LoanApp.MODIFY;
                END;

                SalaryAmount := 0;
                SalaryAmount := LoanApp."Two Thirds Basic" - (Fosarepayment - BridgedRepayment);
                SalaryAmount := SalaryAmount;
                IF SalaryAmount >= RepaymentAmount THEN BEGIN
                    QualifiedRepayment := RepaymentAmount;
                    TotalSalaryAmount := RepaymentAmount;//LoanApp."Requested Amount";
                END ELSE BEGIN
                    QualifiedRepayment := SalaryAmount;
                    TotalSalaryAmount := 1 - (1 / POWER((1 + (LoanApp.Interest / 12 / 100)), LoanApp.Installments));
                    InstalmentAMount := ROUND(QualifiedRepayment / (LoanApp.Interest / 12 / 100));
                    TotalSalaryAmount := TotalSalaryAmount * InstalmentAMount;
                    //ROUND(QualifiedRepayment/(LoanApp.Interest/12/100));
                END;

                //MESSAGE('Reccomend%1',Msalary);
                // IF LoanApp."Net take Home">RepaymentAmount THEN
                // Recomend:=LoanApp."Requested Amount"
                // ELSE
                // Recomend:=TotalSalaryAmount;
                /*SalAmount:=0;
                SalAmount:=TotalSalaryAmount*LoanApp.Installments;
                IF (SalAmount>0) AND (SalAmount>GShares) THEN BEGIN
                IF GShares>0 THEN
                QualAmount:=GShares
                ELSE
                QualAmount:=SalAmount;
                END ELSE BEGIN
                QualAmount:=SalAmount;
                END;
                IF (QualAmount>0) AND  (QualAmount>DepX) THEN BEGIN
                IF DepX>0 THEN
                Recomend:=DepX
                ELSE
                Recomend:=QualAmount;
                END ELSE BEGIN
                Recomend:=QualAmount;
                END;*/
                StandingOrder.RESET;
                StandingOrder.SETRANGE(StandingOrder."BOSA Account No.", LoanApp."BOSA No");
                StandingOrder.SETRANGE(StandingOrder.Status, StandingOrder.Status::Approved);
                StandingOrder.SETRANGE(StandingOrder.Effected, TRUE);
                IF StandingOrder.FIND('-') THEN BEGIN
                    REPEAT
                        TotalStandingOrder := TotalStandingOrder + StandingOrder.Amount;
                    UNTIL StandingOrder.NEXT = 0;
                END;
                //MESSAGE('Total%1',TotalStandingOrder);
                LoanApp."Other Deductions" := TotalStandingOrder;
                totnettakehome := totnettakehome - TotalStandingOrder;
                //MESSAGE('Take%1Amout%2',totnettakehome,TotalStandingOrder);
                totnettakehome := totnettakehome + LoanApp."Other Incomes";
                //MESSAGE('Take2%1',totnettakehome);
                LoanApp."Net take Home" := totnettakehome;
                //check ability vs repayment

                // Message('Repayment%1net%2', LoanApp.Repayment, LoanApp."Net take Home");
                IF LoanApp.Repayment < LoanApp."Net take Home" THEN
                    Recomend := LoanApp."Requested Amount"
                ELSE BEGIN
                    // Recomend:=LoanApp."Net take Home"*LoanApp.Installments;
                    Recomend := ROUND((totnettakehome / (InterestRate / 12 / 100)) * (1 - POWER((1 + (InterestRate / 12 / 100)), -RepayPeriod)), 1, '<');


                    LoanApp."Loan Principle Repayment" := Recomend / LoanApp.Installments;
                    LoanApp."Loan Interest Repayment" := totnettakehome - LoanApp."Loan Principle Repayment";
                    LoanApp.Repayment := totnettakehome;

                    Generate.AutogeneratescheduleBuffer(LoanApp."Loan  No.");
                END;
                //end of check
                // Message('Tke%1Req%2', DataItem4645."Net take Home", LoanApp."Requested Amount");
                IF DataItem4645."Net take Home" > LoanApp."Requested Amount" THEN
                    Recomend := LoanApp."Requested Amount"
                ELSE
                    Recomend := DataItem4645."Net take Home";


                if DataItem4645."Approved Amount" <> 0 then
                    Recomend := DataItem4645."Approved Amount";

                RepaymentAmount := (Recomend * DataItem4645.Interest / 100) + Recomend;// ROUND((DataItem4645.Interest / 12 / 100) / (1 - POWER((1 + (DataItem4645.Interest / 12 / 100)), -(DataItem4645.Installments))) * (Recomend), 0.05, '>');
                InterestAmount := (Recomend * DataItem4645.Interest / 100);//ROUND(Recomend / 100 / 12 * DataItem4645.Interest, 0.05, '>');
                PrincipleAmount := Recomend; //RepaymentAmount - InterestAmount;
                //message('Interest%1', InterestAmount);
                DataItem4645."Loan Principle Repayment" := PrincipleAmount;
                DataItem4645."Loan Interest Repayment" := InterestAmount;
                DataItem4645.Repayment := RepaymentAmount;
                DataItem4645."Approved Amount" := Recomend;
                DataItem4645."Recommended Amount" := Recomend;
                Netdisbursed := LoanApp."Approved Amount";// - Upfronts;
                DataItem4645."Appraised By" := USERID;
                DataItem4645."Appraised Time" := TIME;
                DataItem4645.MODIFY;

                TotalDeduction := LoanApp."Total Deductions(Salary)" + BRIGEDAMOUNT;
                IF TotalDeduction < 0 THEN
                    TotalDeduction := TotalDeduction * -1;

            end;
            // end;

            trigger OnPreDataItem()
            begin
                Recomend := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF GenSetUp.GET(0) THEN
            CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        Initials: Code[10];
        CustRec: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        Cust: Record Customer;
        CustRecord: Record Customer;
        TShares: Decimal;
        TLoans: Decimal;
        LoanApp: Record "Loans Register";
        LoanShareRatio: Decimal;
        Eligibility: Decimal;
        TotalSec: Decimal;
        saccded: Decimal;
        saccded2: Decimal;
        grosspay: Decimal;
        Tdeduct: Decimal;
        Cshares: Decimal;
        "Cshares*3": Decimal;
        "Cshares*4": Decimal;
        QUALIFY_SHARES: Decimal;
        salary: Decimal;
        LoanG: Record "Loans Guarantee Details";
        GShares: Decimal;
        Recomm: Decimal;
        GShares1: Decimal;
        NETTAKEHOME: Decimal;
        Msalary: Decimal;
        RecPeriod: Integer;
        FOSARecomm: Decimal;
        FOSARecoPRD: Integer;
        "Asset Value": Decimal;
        InterestRate: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        SecuredSal: Decimal;
        Linterest1: Integer;
        LOANBALANCE: Decimal;
        BRIDGEDLOANS: Record "Loan Offset Details";
        BRIDGEBAL: Decimal;
        LOANBALANCEFOSASEC: Decimal;
        TotalTopUp: Decimal;
        TotalIntPayable: Decimal;
        GTotals: Decimal;
        TempVal: Decimal;
        TempVal2: Decimal;
        "TempCshares*4": Decimal;
        "TempCshares*3": Decimal;
        InstallP: Decimal;
        RecomRemark: Text[150];
        InstallRecom: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        "Interest Payable": Decimal;
        LoanType: Record "Loan Products Setup";
        "general set-up": Record "Sacco General Set-Up";
        Days: Integer;
        EndMonthInt: Decimal;
        BRIDGEBAL2: Decimal;
        DefaultInfo: Text[80];
        TOTALBRIDGED: Decimal;
        DEpMultiplier: Decimal;
        MAXAvailable: Decimal;
        SalDetails: Record "Salary Details";
        Earnings: Decimal;
        Deductions: Decimal;
        BrTopUpCom: Decimal;
        LoanAmount: Decimal;
        CompanyInfo: Record 79;
        CompanyAddress: Code[20];
        CompanyEmail: Text[30];
        CompanyTel: Code[20];
        CurrentAsset: Decimal;
        CurrentLiability: Decimal;
        FixedAsset: Decimal;
        Equity: Decimal;
        Sales: Decimal;
        SalesOnCredit: Decimal;
        AppraiseDeposits: Boolean;
        AppraiseShares: Boolean;
        AppraiseSalary: Boolean;
        AppraiseGuarantors: Boolean;
        AppraiseBusiness: Boolean;
        TLoan: Decimal;
        LoanBal: Decimal;
        GuaranteedAmount: Decimal;
        RunBal: Decimal;
        TGuaranteedAmount: Decimal;
        GuarantorQualification: Boolean;
        Loan_Appraisal_AnalysisCaptionLbl: Label 'Loan Appraisal Analysis';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Loan_Application_DetailsCaptionLbl: Label 'Loan Application Details';
        Loan_TypeCaptionLbl: Label 'Loan Type';
        MemberCaptionLbl: Label 'Member';
        Amount_AppliedCaptionLbl: Label 'Amount Applied';
        Deposits__3CaptionLbl: Label 'Deposits* 3';
        Eligibility_DetailsCaptionLbl: Label 'Eligibility Details';
        Maxim__Amount_Avail__for_the_LoanCaptionLbl: Label 'Maxim. Amount Avail. for the Loan';
        Outstanding_LoanCaptionLbl: Label 'Outstanding Loan';
        Member_DepositsCaptionLbl: Label 'Member Deposits';
        Amount_AppliedCaption_Control1102760132Lbl: Label 'Amount Applied';
        MemberCaption_Control1102760133Lbl: Label 'Member';
        Loan_TypeCaption_Control1102760134Lbl: Label 'Loan Type';
        Loan_Application_DetailsCaption_Control1102760151Lbl: Label 'Loan Application Details';
        RepaymentCaptionLbl: Label 'Repayment';
        Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150Lbl: Label 'Maxim. Amount Avail. for the Loan';
        Total_Outstand__Loan_BalanceCaptionLbl: Label 'Total Outstand. Loan Balance';
        Deposits___MulitiplierCaptionLbl: Label 'Deposits * Mulitiplier';
        Member_DepositsCaption_Control1102760148Lbl: Label 'Member Deposits';
        Deposits_AnalysisCaptionLbl: Label 'Deposits Analysis';
        Bridged_AmountCaptionLbl: Label 'Bridged Amount';
        Out__Balance_After_Top_upCaptionLbl: Label 'Out. Balance After Top-up';
        Recommended_AmountCaptionLbl: Label 'Recommended Amount';
        Net_Loan_Disbursement_CaptionLbl: Label 'Net Loan Disbursement:';
        V3__Qualification_as_per_GuarantorsCaptionLbl: Label '3. Qualification as per Guarantors';
        Defaulter_Info_CaptionLbl: Label 'Defaulter Info:';
        V2__Qualification_as_per_SalaryCaptionLbl: Label '2. Qualification as per Salary';
        V1__Qualification_as_per_SharesCaptionLbl: Label '1. Qualification as per Shares';
        QUALIFICATIONCaptionLbl: Label 'QUALIFICATION';
        Insufficient_Deposits_to_cover_the_loan_applied__RiskCaptionLbl: Label 'Insufficient Deposits to cover the loan applied: Risk';
        WARNING_CaptionLbl: Label 'WARNING:';
        Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaptionLbl: Label 'Salary is Insufficient to cover the loan applied: Risk';
        WARNING_Caption_Control1000000140Lbl: Label 'WARNING:';
        WARNING_Caption_Control1000000141Lbl: Label 'WARNING:';
        Guarantors_do_not_sufficiently_cover_the_loan__RiskCaptionLbl: Label 'Guarantors do not sufficiently cover the loan: Risk';
        WARNING_Caption_Control1000000020Lbl: Label 'WARNING:';
        Shares_Deposits_BoostedCaptionLbl: Label 'Shares/Deposits Boosted';
        I_Certify_that_the_foregoing_details_and_member_information_is_true_statement_of_the_account_maintained_CaptionLbl: Label 'I Certify that the foregoing details and member information is true statement of the account maintained.';
        Loans_Asst__Officer______________________CaptionLbl: Label 'Loans Asst. Officer:_____________________';
        Signature__________________CaptionLbl: Label 'Signature:_________________';
        Date___________________CaptionLbl: Label 'Date:__________________';
        General_Manger______________________CaptionLbl: Label 'General Manger:_____________________';
        Signature__________________Caption_Control1102760039Lbl: Label 'Sign:_________________';
        Date___________________Caption_Control1102760040Lbl: Label 'Date:__________________';
        Signature__________________Caption_Control1102755017Lbl: Label 'Sign:_________________';
        Date___________________Caption_Control1102755018Lbl: Label 'Date:__________________';
        Loans_Officer______________________CaptionLbl: Label 'Officer''s Comments:_____________________';
        Chairman_Signature______________________CaptionLbl: Label 'Chairman Signature:_____________________';
        Secretary_s_Signature__________________CaptionLbl: Label 'Secretary''s Signature:_________________';
        Members_Signature______________________CaptionLbl: Label 'Members Signature:_____________________';
        Credit_Committe_Minute_No______________________CaptionLbl: Label 'Credit Committe Minute No._____________________';
        Date___________________Caption_Control1102755074Lbl: Label 'Date:__________________';
        Comment____________CaptionLbl: Label 'Comment :____________________________________________________________________________________';
        Amount_Approved___CaptionLbl: Label 'Amount Approved:_____________________';
        Signatory_1_CaptionLbl: Label 'Signatory 1:_________________';
        Signatory_2_CaptionLbl: Label 'Signatory 2:_________________';
        Signatory_3_CaptionLbl: Label 'Signatory 3:_________________';
        FOSA_SIGNATORIES_CaptionLbl: Label 'FOSA SIGNATORIES:';
        Comment_____Caption_Control1102755070Lbl: Label 'Comment :____________________________________________________________________________________';
        FINANCE_CaptionLbl: Label 'FINANCE:';
        Disbursed_By__________________CaptionLbl: Label 'Disbursed By:_________________';
        Signature__________________Caption_Control1102755081Lbl: Label 'Sign:_________________';
        Date___________________Caption_Control1102755082Lbl: Label 'Date:__________________';
        Salary_Details_AnalysisCaptionLbl: Label 'Salary Details Analysis';
        Total_EarningsCaptionLbl: Label 'Total Earnings';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        Net_SalaryCaptionLbl: Label 'Net Salary';
        Qualification_as_per_SalaryCaptionLbl: Label 'Qualification as per Salary';
        V1_3_of_Gross_PayCaptionLbl: Label '1/3 of Gross Pay';
        Amount_GuaranteedCaptionLbl: Label 'Amount Guaranteed';
        Loan_GuarantorsCaptionLbl: Label 'Loan Guarantors';
        RatioCaptionLbl: Label 'Ratio';
        Total_Amount_GuaranteedCaptionLbl: Label 'Total Amount Guaranteed';
        Total_TopupsCaptionLbl: Label 'Total Topups';
        Bridged_LoansCaptionLbl: Label 'Bridged Loans';
        Loan_No_CaptionLbl: Label 'Loan No.';
        Principal_Top_UpCaptionLbl: Label 'Principal Top Up';
        Client_CodeCaptionLbl: Label 'Client Code';
        Loan_TypeCaption_Control1102755059Lbl: Label 'Loan Type';
        TotalsCaptionLbl: Label 'Totals';
        Total_Amount_BridgedCaptionLbl: Label 'Total Amount Bridged';
        Bridging_total_higher_than_the_qualifing_amountCaptionLbl: Label 'Bridging total higher than the qualifing amount';
        WARNING_Caption_Control1102755044Lbl: Label 'WARNING:';
        TotalLoanBalance: Decimal;
        TGAmount: Decimal;
        NetSalary: Decimal;
        Riskamount: Decimal;
        WarnBridged: Text;
        WarnSalary: Text;
        WarnDeposits: Text;
        WarnGuarantor: Text;
        WarnShare: Text;
        RiskGshares: Decimal;
        RiskDeposits: Decimal;
        BasicEarnings: Decimal;
        DepX: Decimal;
        LoanPrincipal: Decimal;
        loanInterest: Decimal;
        AmountGuaranteed: Decimal;
        StatDeductions: Decimal;
        GuarOutstanding: Decimal;
        TwoThirds: Decimal;
        Bridged_AmountCaption: Integer;
        LNumber: Code[20];
        TotalLoanDeductions: Decimal;
        TotalRepayments: Decimal;
        Totalinterest: Decimal;
        Band: Decimal;
        TotalOutstanding: Decimal;
        BANDING: Record "Deposit Tier Setup";
        NtTakeHome: Decimal;
        ATHIRD: Decimal;
        Psalary: Decimal;
        LoanApss: Record "Loans Register";
        TotalLoanBal: Decimal;
        TotalBand: Decimal;
        LoanAp: Record "Loans Register";
        TotalRepay: Decimal;
        TotalInt: Decimal;
        LastFieldNo: Integer;
        TotLoans: Decimal;
        JazaLevy: Decimal;
        BridgeLevy: Decimal;
        Upfronts: Decimal;
        Netdisbursed: Decimal;
        TotalLRepayments: Decimal;
        BridgedRepayment: Decimal;
        OutstandingLrepay: Decimal;
        Loantop: Record "Loan Offset Details";
        BRIGEDAMOUNT: Decimal;
        TOTALBRIGEDAMOUNT: Decimal;
        FinalInst: Decimal;
        NonRec: Decimal;
        OTHERDEDUCTIONS: Decimal;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        CDeposits: Decimal;
        CustDiv: Record Customer;
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record Customer;
        BASIC: Decimal;
        SHARES: Decimal;
        Pcharges: Record "Loan Product Charges";
        Charge: Decimal;
        Commision: Decimal;
        LBalance1: Decimal;
        Ttype: Text;
        Lcommit: Record "Other Commitements Clearance";
        Lamount: Decimal;
        BInt: Decimal;
        Deeboster: Decimal;
        TOpDeb: Decimal;
        Recomend: Decimal;
        CheckoffMatrix: Record "Checkoff Distributed Matrix";
        totnettakehome: Decimal;
        Fosarepayment: Decimal;
        OtherIncome: Decimal;
        TotalDeductionsSalary: Decimal;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        EMPLCODE: Code[20];
        Generate: Codeunit "Generate Schedule";
        BufferSchedule: Record "Loan Repayment Schedule Buffer";
        RepaymentAmount: Decimal;
        QualifiedRepayment: Decimal;
        SalaryAmount: Decimal;
        TotalSalaryAmount: Decimal;
        PrincipleAmount: Decimal;
        InterestAmount: Decimal;
        InstalmentAMount: Decimal;
        TotalDeduction: Decimal;
        LoanProductSetup: Record "Loan Products Setup";

    procedure ComputeTax()
    begin
    end;
}



