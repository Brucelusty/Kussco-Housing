report 50723 "Posted Loans List"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/PostedLoansList.rdlc';
    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance";
            // DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Total Outstanding Balance" = filter(<>0), Reversed = const(false), "Loan Status" = filter(Approved|Issued|Disbursed));
            RequestFilterFields = "Date filter", "Loan Product Type", "Loan Application Mode";
            column(myInt; myInt)
            { }
            column(Loan__No_; "Loan  No.")
            { }
            column(Client_Code; "Client Code")
            { }
            column(Client_Name; "Client Name")
            { }
            column(Staff_No; "Staff No")
            { }
            column(Employer_Name; "Employer Name")
            { }
            column(Employer_Code; "Employer Code")
            { }
            column(Phone_No_; "Phone No.")
            { }
            column(Loan_Product_Type; "Loan Product Type")
            { }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            { }
            column(Repayment_Method; "Repayment Method")
            { }
            column(Installments; Installments)
            { }
            column(Interest; Interest)
            { }
            column(Outstanding_Interest; "Outstanding Interest")
            { }
            column(Principal_In_Arrears; "Principal In Arrears")
            { }
            column(Requested_Amount; "Requested Amount")
            { }
            column(Disbursed_Amount; "Disbursed Amount")
            { }
            column(Top_Up_Amount; "Top Up Amount")
            { }
            column(Repayment_Frequency; "Repayment Frequency")
            { }
            column(Loan_Disbursement_Date; "Loan Disbursement Date")
            { }
            column(Approved_Amount; "Approved Amount")
            { }
            column(Expected_Date_of_Completion; "Expected Date of Completion")
            { }
            column(Repayment_Start_Date;"Repayment Start Date")
            { }
            column(Outstanding_Balance; "Outstanding Balance")
            { }
            column(Days_In_Arrears; "Days In Arrears")
            { }
            column(Loans_Category; "Loans Category")
            { }
            column(netDisbursed; netDisbursed)
            { }
            column(IdNo;IdNo)
            {}
            column(dob;dob)
            {}
            column(custGender;custGender)
            {}
            column(Last_Pay_Date;"Last Pay Date")
            {}
            column(Last_Repayment;"Last Repayment")
            {}
            // column()
            // {}
            column(company_Name; company.Name)
            { }
            column(company_Picture; company.Picture)
            { }
            column(company_Address; company.Address)
            { }
            column(company_Email; company."E-Mail")
            { }
            column(company_Phone; company."Phone No.")
            { }
            trigger OnAfterGetRecord()
            begin
                // "Loans Register".CalcFields("Outstanding Balance");
                if "Loans Register"."Outstanding Balance" = 0 then CurrReport.Skip();
                if "Loans Register"."Employer Code" <> '' then begin
                    employer.Reset();
                    employer.Get("Loans Register"."Employer Code");
                    "Loans Register"."Employer Name" := employer."Employer Name";
                end;

                cust.Reset();
                cust.SetRange("No.", "Loans Register"."Client Code");
                if cust.Find('-') then begin
                    IdNo := cust."ID No.";
                    dob := cust."Date Of Birth";
                    custGender := Format(cust.Gender);
                end;
                //
                totalTopupPrincipal := 0;
                totalTopupInterest := 0;
                mainLoanprocessingFee := 0;
                loanProductchargesCode := 'LPF';
                mainExciseduty := 0;
                loanProcessingfee := 0;
                loanRefinancingcharge := 0;
                exciseDuty := 0;
                netDisbursed := 0;
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
                    netDisbursed := "Loans Register"."Approved Amount" - totalTopupdeductions;
                end else begin
                    netDisbursed := "Loans Register"."Approved Amount" - (mainLoanprocessingFee + mainExciseduty);
                end;
                myInt := myInt + 1;
            end;
        }
    }

    var
        myInt: Integer;
        netDisbursed: Decimal;
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
        IdNo: Text[250];
        custGender: Text[250];
        dob: Date;
        totalTopupdeductions: Decimal;
        topupDeductions: Decimal;
        company: Record "Company Information";
        cust: Record Customer;
        employer: Record "Employers Register";
        loanOffset: Record "Loan Offset Details";
        loans: Record "Loans Register";
        loanProduct: Record "Loan Products Setup";
        loanProductcharges: Record "Loan Product Charges";

    trigger OnInitReport()
    begin
        company.Get();
        company.CalcFields(Picture);
        myInt := 0;
    end;
}
