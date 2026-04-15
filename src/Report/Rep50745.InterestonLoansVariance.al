report 50745 "Interest on Loans Variance"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = IntonLoansVar;
    
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = where(Posted = filter(true));
            RequestFilterFields = "Loan  No.", "Repayment Start Date", "Loan Disbursement Date", "Approved Amount";
            column(Loan__No_;"Loan  No.")
            {}
            column(Client_Code;"Client Code")
            {}
            column(Loan_Product_Type;"Loan Product Type")
            {}
            column(Loan_Product_Type_Name;"Loan Product Type Name")
            {}
            column(Client_Name;"Client Name")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Repayment_Start_Date;"Repayment Start Date")
            {}
            column(Interest;Interest)
            {}
            column(interestRate;interestRate)
            {}
            column(intonSchedule;intonSchedule)
            {}
            column(intCharged;intCharged)
            {}
            column(intPaid;intPaid)
            {}
            column(variance;variance)
            {}
            column(asAt;asAt)
            {}
            // column()
            // {}
            column(company_Pic;company.Picture)
            {}
            column(company_Name;company.Name)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Email;company."E-Mail")
            {}

            trigger OnAfterGetRecord() begin
                interestRate:= 0;
                loanSetup.Reset();
                loanSetup.SetRange(Code, "Loans Register"."Loan Product Type");
                if loanSetup.Find('-') then begin
                    interestRate := loanSetup."Interest rate";
                    interestRate := (interestRate)/1200;
                end;

                intonSchedule:= 0;
                repSchedule.Reset();
                repSchedule.SetRange("Loan No.", "Loans Register"."Loan  No.");
                repSchedule.SetFilter("Repayment Date", '..%1', asAt);
                if repSchedule.FindSet() then begin
                    repSchedule.CalcSums("Monthly Interest");
                    intonSchedule:= repSchedule."Monthly Interest";
                end;

                intCharged:= 0;
                intChargedtwo:= 0;
                detCust.Reset();
                detCust.SetRange("Customer No.", "Loans Register"."Client Code");
                detCust.SetRange("Loan No", "Loans Register"."Loan  No.");
                detCust.SetFilter("Posting Date", '..%1', asAt);
                detCust.SetRange(detCust."Transaction Type", detCust."Transaction Type"::"Interest Due");
                if detCust.FindSet() then begin
                    detCust.CalcSums(Amount);
                    intCharged:= detCust.Amount;
                end;

                intPaid:= 0;
                detCust.Reset();
                detCust.SetRange("Customer No.", "Loans Register"."Client Code");
                detCust.SetRange("Loan No", "Loans Register"."Loan  No.");
                detCust.SetFilter("Posting Date", '..%1', asAt);
                detCust.SetRange(detCust."Transaction Type", detCust."Transaction Type"::"Interest Paid");
                if detCust.FindSet() then begin
                    detCust.CalcSums(Amount);
                    intPaid:= (detCust.Amount) *-1;
                end;
                
                variance:= 0;
                if (intCharged <> 0) or (intonSchedule <> 0) then begin
                    variance := intonSchedule - intCharged;
                end else variance:= 0;
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
                    field(asAt;asAt)
                    {
                    ApplicationArea = All;
                        
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(IntonLoansVar)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/LoansInterestVariance.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    interestRate: Decimal;
    intonSchedule: Decimal;
    intCharged: Decimal;
    intChargedtwo: Decimal;
    intPaid: Decimal;
    variance: Decimal;
    asAt: Date;
    options: Option "Interest Due","Interest Paid";
    company: Record "Company Information";
    loansReg: Record "Loans Register";
    loanSetup: Record "Loan Products Setup";
    detCust: Record "Detailed Cust. Ledg. Entry";
    repSchedule: Record "Loan Repayment Schedule";
    cust: Record Customer;
    vend: Record Vendor;
}



