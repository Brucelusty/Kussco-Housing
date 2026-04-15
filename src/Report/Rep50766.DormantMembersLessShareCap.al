report 50766 "Dormant Members Less ShareCap"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = DormantLackShare;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            RequestFilterFields = "Membership Status";
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Membership_Status;"Membership Status")
            {}
            column(Shares_Retained;"Shares Retained")
            {}
            column(Current_Shares;"Current Shares")
            {}
            column(Employer_Code;"Employer Code")
            {}
            column(Registration_Date;"Registration Date")
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(Mobile_Phone_No;"Mobile Phone No")
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
                if Customer."Shares Retained" >= saccoGen."Retained Shares" then CurrReport.Skip();
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
        layout(DormantLackShare)
        {
            Type = rdlc;
            LayoutFile = 'Layouts/DormantMembersLackingMinShareCapital.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
        saccoGen.Get();
    end;
    
    var
    myInt: Integer;
    monthlyInst: Decimal;
    refDate: Date;
    company: Record "Company Information";
    loanRepSchedule: Record "Loan Repayment Schedule";
    saccoGen: Record "Sacco General Set-Up";
}



