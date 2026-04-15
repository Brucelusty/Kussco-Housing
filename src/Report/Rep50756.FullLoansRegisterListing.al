report 50756 "Full Loans Register Listing"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = AllLoans;
    
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            // DataItemTableView = where("Loan Status" = filter(Disbursed|Approved|Issued));
            RequestFilterFields = "Loan  No.", "Employer Code", "Client Code", "Total Outstanding Balance", "Loan Status", "Loan Disbursement Date", "Last Repayment Date", "Date filter";
            column(Loan__No_;"Loan  No.")
            {}
            column(Client_Code;"Client Code")
            {}
            column(Client_Name;"Client Name")
            {}
            column(Application_Date;"Application Date")
            {}
            column(Appraissed_By_Date;"Appraissed By Date")
            {}
            column(Approved_By_Date;"Approved By Date")
            {}
            column(Loan_Disbursement_Date;"Loan Disbursement Date")
            {}
            column(Requested_Amount;"Requested Amount")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Loan_Product_Type_Name;"Loan Product Type Name")
            {}
            column(Disbursed_Amount;"Disbursed Amount")
            {}
            column(Outstanding_Balance;"Outstanding Balance")
            {}
            column(Total_Outstanding_Balance;"Total Outstanding Balance")
            {}
            column(Captured_By;"Captured By")
            {}
            column(Appraissed_By;"Appraissed By")
            {}
            column(Approved_By;"Approved By")
            {}
            column(Disbursed_By;"Disbursed By")
            {}
            column(Installments;Installments)
            {}
            column(monthlyInst;monthlyInst)
            {}
            column(Last_Repayment_Date;"Last Repayment Date")
            {}
            column(Expected_Date_of_Completion;"Expected Date of Completion")
            {}
            column(Loan_Status;"Loan Status")
            {}
            // column()
            // {}
            column(company_Name;company.Name)
            {}
            column(company_Pic;company.Picture)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Email;company."E-Mail")
            {}
            column(company_Motto;company.Motto)
            {}
            trigger OnAfterGetRecord() begin
                monthlyInst := 0;
                loanRepSchedule.Reset();
                loanRepSchedule.SetRange("Loan No.", "Loans Register"."Loan  No.");
                if loanRepSchedule.Find('-') then begin
                    monthlyInst:= loanRepSchedule."Monthly Repayment";
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
                group(GroupName)
                {
                    field(refDate;refDate)
                    {
                    ApplicationArea = All;
                        
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(AllLoans)
        {
            Type = rdlc;
            LayoutFile = 'Layouts/FullLoansRegisterListing.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    monthlyInst: Decimal;
    refDate: Date;
    company: Record "Company Information";
    loanRepSchedule: Record "Loan Repayment Schedule";
}



