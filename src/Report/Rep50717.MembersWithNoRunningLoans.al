report 50717 "Members with no Running Loans"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Memberswithnorunningloans.rdlc';
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            CalcFields = "Total Loan Balance";
            // DataItemLink = "No." =field("Client Code");
            DataItemTableView = sorting("No.") where("Total Loan Balance" = const(0), "Membership Status" = filter(Active));
            RequestFilterFields = Status;
            column(Name;Name)
            {}
            column(No_;"No.")
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(FOSA_Account_No_;"FOSA Account No.")
            {}
            column(Status;Status)
            {}
            column(Mobile_Phone_No;"Mobile Phone No")
            {}
            column(Membership_Status;"Membership Status")
            {}
            column(Total_Loan_Balance;"Total Loan Balance")
            {}
            column(paymentMode;paymentMode)
            {}
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
            // column()
            // {}
            trigger OnAfterGetRecord()
            begin
                salaryDetails.Reset();
                salaryDetails.SetRange("Member No", Customer."No.");
                salaryDetails.SetFilter("Posting Date", '%1..%2', CalcDate('-<3M>', Today), Today);
                if salaryDetails.Find('-') then begin
                    paymentMode := 'SALARY';
                end else paymentMode := 'CHECKOFF';
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
    paymentMode: Code[20];
    company: Record "Company Information";
    salaryDetails: Record "Salary Details";
}
