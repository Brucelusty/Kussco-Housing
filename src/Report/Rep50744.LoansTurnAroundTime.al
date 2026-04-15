report 50744 "Loans Turn Around Time"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LoansTAT;

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Application Date", "Loan Status";
            column(Loan__No_;"Loan  No.")
            {}
            column(Client_Name;"Client Name")
            {}
            column(Loan_Status;"Loan Status")
            {}
            column(Mode_Of_Application;"Mode Of Application")
            {}
            column(Captured_By_Date;"Captured By Date")
            {}
            column(Captured_By_Time;"Captured By Time")
            {}
            column(Appraised_Date;"Appraised Date")
            {}
            column(Appraised_Time;"Appraised Time")
            {}
            column(Appraissed_By_Date;"Appraissed By Date")
            {}
            column(Appraissed_By_Time;"Appraissed By Time")
            {}
            column(Approved_Date;"Approved Date")
            {}
            column(Approved_Time;"Approved Time")
            {}
            column(Disbursed_By_Date;"Disbursed By Date")
            {}
            column(Disbursed_By_Time;"Disbursed By Time")
            {}
            column(Loan_Product_Type;"Loan Product Type")
            {}
            column(Loan_Product_Type_Name;"Loan Product Type Name")
            {}
            column(Requested_Amount;"Requested Amount")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
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

        }

        actions
        {

        }
    }

    rendering
    {
        layout(LoansTAT)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/LoansTAT.rdlc';
        }
    }
    trigger OnInitReport()
    begin
        company.Get();
        company.CalcFields(Picture);
        
    end;

    var
        myInt: Integer;
        company: Record "Company Information";
        cust: Record Customer;
        vend: Record Vendor;
        loansReg: Record "Loans Register";
}
