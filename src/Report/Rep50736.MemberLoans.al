report 50736 "Member Loans"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = MemberLoans;
    
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(>0));
            RequestFilterFields = "Client Code";
            column(Loan__No_;"Loan  No.")
            {}
            column(Client_Code;"Client Code")
            {}
            column(Loan_Product_Type_Name;"Loan Product Type Name")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Outstanding_Balance;"Outstanding Balance")
            {}
            column(Loan_Disbursement_Date;"Loan Disbursement Date")
            {}
            // column()
            // {}
            // column()
            // {}
            // column()
            // {}
            // column()
            // {}
            // column()
            // {}
            // column()
            // {}
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
                    
                }
            }
        }
    }
    
    rendering
    {
        layout(MemberLoans)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/MemberLoans.rdlc';
        }
    }
    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    number: Integer;
    company: Record "Company Information";
}
