report 50761 "AllLoans Disbursed Per Product"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Summaryloansdisbursedbyproduct.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            // DataItemTableView = sorting("Loan Product Type") WHERE(Posted=CONST(True),"Outstanding Balance"=FILTER(>0));
            DataItemTableView = sorting("Loan Product Type") WHERE(Posted=CONST(True), Reversed = const(false), "Loan Status" = filter(Disbursed | Issued));
            RequestFilterFields = "Posting Date","Loan Disbursement Date";
            column(LoanProductTypeName_LoansRegister;"Loans Register"."Loan Product Type Name")
            {
            }
            column(DisbursedBy_LoansRegister;"Loans Register"."Disbursed By")
            {
            }
            column(RequestedAmount_LoansRegister;"Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoansRegister;"Loans Register"."Approved Amount")
            {
            }
            column(Top_Up_Amount_LoansRegister;"Loans Register"."Top Up Amount"){}
            column(netDisbursed;netDisbursed)
            {}
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
            column(Serial;Serial)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Serial:=Serial+1;
                IF "Loans Register".Posted=FALSE THEN CurrReport.SKIP;

                //
                totalTopupPrincipal:= 0;
                totalTopupInterest:= 0;
                mainLoanprocessingFee:= 0;
                loanProductchargesCode:='LPF';
                mainExciseduty:= 0;
                loanProcessingfee:= 0;
                loanRefinancingcharge:= 0;
                exciseDuty:= 0;
                netDisbursed:= 0;
                //totalTopupdeductions:= 0;

                loanProductcharges.Reset();
                loanProductcharges.SetRange("Product Code", "Loans Register"."Loan Product Type");
                loanProductcharges.SetRange(Code, loanProductchargesCode);
                if loanProductcharges.Find('-') then
                begin
                    mainLoanprocessingFee:= ("Loans Register"."Approved Amount" *((loanProductcharges.Percentage)/100));
                    mainExciseduty:= (mainLoanprocessingFee * (0.1));
                end;
                
                loanOffset.Reset();
                loanOffset.SetRange("Loan No.", "Loans Register"."Loan  No.");
                if loanOffset.Find('-') then
                begin
                    // loans.Reset();
                    // loans.SetRange("Loan  No.", loanOffset."Loan Top Up");
                    // loans.SetRange("Loan Product Type", loanOffset."Loan Type");
                    // if loans.Find('-') then
                    // begin
                    //     loanProductType:= loans."Loan Product Type Name";
                    // end;
                    loanOffset.Reset();
                    loanOffset.SetRange("Loan No.", loanOffset."Loan No.");
                    if loanOffset.FindSet() then
                    begin
                        totalTopupdeductions:= 0;
                        topupDeductions:= 0;
                        topupPrincipal:= 0;
                        topupInterest:= 0;
                        repeat
                            loanProduct.Reset();
                            loanProduct.SetRange(Code, loanOffset."Loan Type");
                            if loanProduct.FindSet() then
                            begin
                                topupPrincipal:= loanOffset."Principle Top Up";
                                topupInterest:= loanOffset."Interest Top Up";

                                loanRefinancingcharge:= (loanOffset."Outstanding Balance" * ((loanProduct."Loan Boosting Commission %")/100));
                                exciseDuty:= (loanRefinancingcharge * (0.2));

                                topupDeductions:= topupPrincipal + topupInterest +loanRefinancingcharge + exciseDuty;
                            end;
                            totalTopupdeductions:= topupDeductions + totalTopupdeductions;
                        until loanOffset.Next() = 0;
                        
                        loanOffset.CalcSums("Principle Top Up");
                        totalTopupPrincipal:= loanOffset."Principle Top Up";
                        loanOffset.CalcSums("Interest Top Up");
                        totalTopupInterest:= loanOffset."Interest Top Up";
                        totalTopupdeductions:= totalTopupdeductions + mainLoanprocessingFee + mainExciseduty;
                    end;
                    netDisbursed:= "Loans Register"."Approved Amount" - totalTopupdeductions;
                end else begin
                    netDisbursed:= "Loans Register"."Approved Amount" - (mainLoanprocessingFee + mainExciseduty);
                end;
                
            end;

            trigger OnPreDataItem()
            begin
                Serial:=0;
            end;
        }
    }
            

    requestpage
    {
        
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(CurrentDate;CurrentDate)
                    {
                    ApplicationArea = All;
                    }
                }
            }
        }
    }
           trigger OnPreReport();															
            begin															
                CompanyInfo.Get();															
                CompanyInfo.CalcFields(CompanyInfo.Picture);


                if CurrentDate = 0D then
                    CurrentDate := Today;
                DateFilter := '..' + format(CurrentDate);														
            end;
  

    var
    CompanyInfo: Record "Company Information";
    loanOffset: Record "Loan Offset Details";
    loans: Record "Loans Register";
    loanProduct: Record "Loan Products Setup";
    loanProductcharges: Record "Loan Product Charges";
    CurrentDate: Date;
    DateFilter: Text[30];
    Serial: Integer;netDisbursed: Decimal;
    loanProductchargesCode: Code[50];
    totalTopupPrincipal: Decimal;
    totalTopupInterest: Decimal;
    topupPrincipal: Decimal;
    topupInterest: Decimal;
    loanProcessingfee: Decimal;
    loanRefinancingcharge: Decimal;
    exciseDuty: Decimal;
    mainLoanprocessingFee: Decimal;
    mainLoanrefinancingCharge: Decimal;
    mainExciseduty: Decimal;
    loanProductType: Text[250];
    totalTopupdeductions: Decimal;
    topupDeductions: Decimal;
}



            



