report 50731 "Loan Repayment List"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LoanRepayment;
    
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where(Posted = filter(True), "Outstanding Balance" = filter(>0));
            RequestFilterFields = "Loan  No.", "Client Code", "Loan Disbursement Date", "Approved Amount", "Outstanding Balance";
            column(Loan__No_;"Loan  No.")
            {}
            column(Client_Code;"Client Code")
            {}
            column(Loan_Product_Type_Name;"Loan Product Type Name")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Installments;Installments)
            {}
            column(Loan_Disbursement_Date;"Loan Disbursement Date")
            {}
            column(Outstanding_Balance;"Outstanding Balance")
            {}
            column(principalPaid;principalPaid)
            {}
            column(Interest_Paid;"Interest Paid")
            {}
            column(Interest_Due;"Total Loan Interest Due")
            {}
            column(Last_Repayment_Date;"Last Repayment Date")
            {}
            column(actualPrincipalpaid;actualPrincipalpaid)
            {}
            column(actualInterestpaid;actualInterestpaid)
            {}
            column(expectedPrincipalpaid;expectedPrincipalpaid)
            {}
            column(expectedInterestpaid;expectedInterestpaid)
            {}
            column(principalVar;principalVar)
            {}
            column(interestVar;interestVar)
            {}
            // column()
            // {}
            column(company_Name;company.Name)
            {}
            column(company_Pic;company.Picture)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Email;company."E-Mail")
            {}
            column(company_Phone;company."Phone No.")
            {}
            
            trigger OnAfterGetRecord() begin
                principalPaid:= 0;
                actualInterestpaid:= 0;
                actualPrincipalpaid:= 0;
                expectedInterestpaid:= 0;
                expectedPrincipalpaid:= 0;

                loans.Reset();
                loans.SetRange("Loan  No.", "Loans Register"."Loan  No.");
                if loans.Find('-') then begin
                    loans.CalcFields("Outstanding Balance");
                    loans.CalcFields("Interest Due");
                    principalPaid:= (loans."Approved Amount"-loans."Outstanding Balance")-loans."Interest Due";
                end;

                repaySchedule.Reset();
                repaySchedule.SetRange("Loan No.", "Loans Register"."Loan  No.");
                repaySchedule.SetFilter("Repayment Date", '%1..%2',fromDate,toDate);
                if repaySchedule.FindSet() then begin
                    repeat
                        expectedPrincipalpaid:= expectedPrincipalpaid + repaySchedule."Principal Repayment";
                        expectedInterestpaid:= expectedInterestpaid + repaySchedule."Monthly Interest";
                    until repaySchedule.Next()= 0;
                end;

                detailedCust.Reset();
                detailedCust.SetRange("Loan No", "Loans Register"."Loan  No.");
                detailedCust.SetRange(Reversed, false);
                detailedCust.SetRange("Transaction Type", detailedCust."Transaction Type"::Repayment);
                detailedCust.SetFilter("Posting Date", '%1..%2',fromDate, toDate);
                if detailedCust.FindSet() then begin
                    repeat
                        if detailedCust."Transaction Type" = detailedCust."Transaction Type"::Repayment then begin
                            detailedCust.CalcSums(Amount);
                            actualPrincipalpaid:= (detailedCust.Amount)*-1;
                        end;
                    until detailedCust.Next()=0;
                end;

                detailedCust.Reset();
                detailedCust.SetRange("Loan No", "Loans Register"."Loan  No.");
                detailedCust.SetRange(Reversed, false);
                detailedCust.SetRange("Transaction Type", detailedCust."Transaction Type"::"Interest Paid");
                detailedCust.SetFilter("Posting Date", '%1..%2',fromDate, toDate);
                if detailedCust.FindSet() then begin
                    repeat
                        if detailedCust."Transaction Type" = detailedCust."Transaction Type"::"Interest Paid" then begin
                            detailedCust.CalcSums(Amount);
                            actualInterestpaid:= (detailedCust.Amount)*-1;
                        end;
                    until detailedCust.Next()=0;
                end;
                
                principalVar:= expectedPrincipalpaid - actualPrincipalpaid;
                interestVar:= expectedInterestpaid - actualInterestpaid;
            end;
        }
    }
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Start Date"; fromDate)
                    {
                    ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("End Date"; toDate)
                    {
                    ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(LoanRepayment)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/LoanRepaymentList.rdlc';
        }
    }
    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    principalPaid: Decimal;
    fromDate: Date;
    toDate: Date;
    actualPrincipalpaid: Decimal;
    expectedPrincipalpaid: Decimal;
    actualInterestpaid: Decimal;
    expectedInterestpaid: Decimal;
    interestVar: Decimal;
    principalVar: Decimal;

    loans: Record "Loans Register";
    company: Record "Company Information";
    detailedCust: Record "Detailed Cust. Ledg. Entry";
    repaySchedule: Record "Loan Repayment Schedule";
}



