report 50770 "Running Loans No Repayment"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LoansNoRepaymentSchedule;
    
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            CalcFields = "Total Outstanding Balance";
            DataItemTableView = where("Total Outstanding Balance" = filter(>0));
            column(Loan__No_;"Loan  No.")
            {}
            column(Client_Code;"Client Code")
            {}
            column(Loan_Product_Type;"Loan Product Type")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Loan_Disbursement_Date;"Loan Disbursement Date")
            {}
            column(Client_Name;"Client Name")
            {}
            column(Outstanding_Balance;"Outstanding Balance")
            {}
            trigger OnAfterGetRecord() begin
                loanRepay.Reset();
                loanRepay.SetRange("Loan No.", "Loans Register"."Loan  No.");
                if loanRepay.Find('-') then begin
                    CurrReport.Skip();
                end;
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
            }
        }
    }
    
    rendering
    {
        layout(LoansNoRepaymentSchedule)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/RunningLoansNowRepaymentSchedule.rdlc';
        }
    }
    
    var
    myInt: Integer;
    loanNo: Code[20];
    employerCode: Code[20];
    recoveryMode: Code[20];
    vend: Record Vendor;
    loansReg: Record "Loans Register";
    loanRepay: Record "Loan Repayment Schedule";
}
