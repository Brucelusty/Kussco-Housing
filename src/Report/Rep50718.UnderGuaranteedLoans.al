report 50718 "Under-Guaranteed Loans"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Under-GuaranteedLoan.rdlc';
    
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            CalcFields = "Guaranteed Amount";
            DataItemTableView = sorting("Loan  No.") where(Posted = const(true), Underguaranteed = const(true), "Requires Guarantors" = const(true));
            RequestFilterFields = "Loan Disbursement Date";
            column(Loan__No_;"Loan  No.")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Guaranteed_Amount;"Guaranteed Amount")
            {}
            column(Client_Code;"Client Code")
            {}
            column(Loan_Product_Type;"Loan Product Type")
            {}
            column(Loan_Disbursement_Date;"Loan Disbursement Date")
            {}
            // column()
            // {}
            column(company_Name;company.Name)
            {}
            column(company_Picture;company.Picture)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Email;company."E-Mail")
            {}
            column(company_Phone;company."Phone No.")
            {}
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
    company: Record "Company Information";
}
