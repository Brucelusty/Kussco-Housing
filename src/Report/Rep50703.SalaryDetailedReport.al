report 50703 "Salary Detailed Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // DefaultLayout = RDLC;
    // RDLCLayout = 'Layouts/SalaryDetailedStatement.rdlc';
    DefaultRenderingLayout = SalaryDetailedSummary;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Employer Code";
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(Employer_Code;"Employer Code")
            {}
            column(company_Name;company.Name)
            {}
            column(company_Pic;company.Picture)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Add;company.Address)
            {}
            column(company_Email;company."E-Mail")
            {}
            column(company_Add2;company."Address 2")
            {}
            // column()
            // {}
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
    
        actions
        {
            area(processing)
            {
                
            }
        }
    }

    rendering
    {
        layout(SalaryDetailedSummary)
        {
            Type = Excel;
            LayoutFile = 'Layouts/SalariesDetailedStatement.xlsx';
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
        closingBal: Decimal;
}
