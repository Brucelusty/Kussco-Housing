report 50714 "Net Disbursed Loan"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = rdlc;
    RDLCLayout = 'Layouts\Net Disbursed Loan.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Loan Status" = filter("Issued" | "Disbursed"));
            RequestFilterFields = "Loan  No.", "Client Code", "Loan Product Type", "Approved Amount", "Disbursement Date";
            column(Loan__No_; "Loan  No.")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Loan_Disbursement_Date; "Loan Disbursement Date")
            { }
            column(mainLoanprocessingFee; mainLoanprocessingFee)
            { }
            column(mainExciseduty; mainExciseduty)
            { }
            column(totalTopupPrincipal; totalTopupPrincipal)
            { }
            column(totalTopupInterest; totalTopupInterest)
            { }
            column(loanRefinancingcharge; loanRefinancingcharge)
            { }
            column(exciseDuty; exciseDuty)
            { }
            column(totalTopupdeductions; totalTopupdeductions)
            { }
            // column()
            // {}
            column(Loan_Disbursed_Amount; "Loan Disbursed Amount")
            {

            }
            column(company_Name; company.Name)
            {

            }
            column(company_Pic; company.Picture)
            {

            }
            column(company_Add; company.Address)
            {

            }
            column(company_Phone; company."Phone No.")
            {

            }
            column(company_Email; company."E-Mail")
            {

            }
            // column()
            // {

            // }
            // dataitem("Loan Offset Details";"Loan Offset Details")
            // {
            //     DataItemLink = "Loan No." = field("Loan  No.");
            //     DataItemTableView = sorting("Loan No.", "Client Code", "Loan Top Up");

            //     column(Loan_No_;"Loan Top Up")
            //     {}
            //     column(loanProductType;loanProductType)
            //     {}
            //     column(Loan_Processing_Fee;"LoanProcessingfee")
            //     {}
            //     column(Principal_Topup;"Principle Top Up")
            //     {}
            //     column(Interest_Topup;"Interest Top Up")
            //     {}
            //     column(loanRefinancingcharge;loanRefinancingcharge)
            //     {}
            //     column(exciseDuty;exciseDuty)
            //     {}
            //     column(totalTopupdeductions;totalTopupdeductions)
            //     {}
            //     // column()
            //     // {}
            //     trigger
            //     OnAfterGetRecord()
            //     begin


            //     end;
            // }
            trigger
            OnAfterGetRecord()
            begin
                totalTopupPrincipal := 0;
                totalTopupInterest := 0;
                mainLoanprocessingFee := 0;
                loanProductchargesCode := 'LPF';
                mainExciseduty := 0;
                loanProcessingfee := 0;
                loanRefinancingcharge := 0;
                exciseDuty := 0;
                //totalTopupdeductions:= 0;

                loanProductcharges.Reset();
                loanProductcharges.SetRange("Product Code", "Loans Register"."Loan Product Type");
                loanProductcharges.SetRange(Code, loanProductchargesCode);
                if loanProductcharges.Find('-') then begin
                    mainLoanprocessingFee := ("Loans Register"."Approved Amount" * ((loanProductcharges.Percentage) / 100));
                    mainExciseduty := (mainLoanprocessingFee * (0.1));
                end;

                loanOffset.Reset();
                loanOffset.SetRange("Loan No.", "Loans Register"."Loan  No.");
                if loanOffset.Find('-') then begin
                    // loans.Reset();
                    // loans.SetRange("Loan  No.", loanOffset."Loan Top Up");
                    // loans.SetRange("Loan Product Type", loanOffset."Loan Type");
                    // if loans.Find('-') then
                    // begin
                    //     loanProductType:= loans."Loan Product Type Name";
                    // end;
                    loanOffset.Reset();
                    loanOffset.SetRange("Loan No.", loanOffset."Loan No.");
                    if loanOffset.FindSet() then begin
                        totalTopupdeductions := 0;
                        topupDeductions := 0;
                        topupPrincipal := 0;
                        topupInterest := 0;
                        repeat
                            loanProduct.Reset();
                            loanProduct.SetRange(Code, loanOffset."Loan Type");
                            if loanProduct.FindSet() then begin
                                topupPrincipal := loanOffset."Principle Top Up";
                                topupInterest := loanOffset."Interest Top Up";

                                loanRefinancingcharge := (loanOffset."Outstanding Balance" * ((loanProduct."Loan Boosting Commission %") / 100));
                                exciseDuty := (loanRefinancingcharge * (0.2));

                                topupDeductions := topupPrincipal + topupInterest + loanRefinancingcharge + exciseDuty;
                            end;
                            totalTopupdeductions := topupDeductions + totalTopupdeductions;
                        until loanOffset.Next() = 0;

                        loanOffset.CalcSums("Principle Top Up");
                        totalTopupPrincipal := loanOffset."Principle Top Up";
                        loanOffset.CalcSums("Interest Top Up");
                        totalTopupInterest := loanOffset."Interest Top Up";
                        totalTopupdeductions := totalTopupdeductions + mainLoanprocessingFee + mainExciseduty;
                    end;

                end;

            end;
        }
    }

    trigger
    OnInitReport()
    begin
        company.Get();
        company.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        loanOffset: Record "Loan Offset Details";
        loans: Record "Loans Register";
        company: Record "Company Information";
        loanProduct: Record "Loan Products Setup";
        loanProductcharges: Record "Loan Product Charges";
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


