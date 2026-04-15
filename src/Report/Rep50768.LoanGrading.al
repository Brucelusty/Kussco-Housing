report 50768 "Loan Grading"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LoanGrading;
    
    dataset
    {
        dataitem("PAR Table";"PAR Table")
        {
            RequestFilterFields = "Loan Product";
            DataItemTableView = where("Loan Product" = filter(''));
            column(Total_Performing;"Total Performing")
            {}
            column(Total_Watch;"Total Watch")
            {}
            column(Total_Substandard;"Total Substandard")
            {}
            column(Total_Doubtful;"Total Doubtful")
            {}
            column(Total_Loss;"Total Loss")
            {}
            column(Total_Loan;"Total Loan")
            {}
            column(PAR_Ratio;"PAR Ratio")
            {}
            column(loanTypename;loanTypename)
            {}
            column(asAt;asAt)
            {}
            column(company_Pic;company.Picture)
            {}
            // column()
            // {}

            trigger OnPreDataItem()
            begin
                asAt := month.DetermineMonthText(CalcDate('<-1M>', Today));
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
                    
                }
            }
        }
    }
    
    rendering
    {
        layout(LoanGrading)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/LoanGrading.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    asAt: Text[50];
    loanTypename: Text[250];
    month: Codeunit "Dates Calculation";
    company: Record "Company Information";
    loanTypes: Record "Loan Products Setup";
    approval: Record "Approval Entry";
    approvalEntries: Page 654;
}
