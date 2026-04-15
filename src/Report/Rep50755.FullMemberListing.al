report 50755 "Full Member Listing"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = AllMembers;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Mobile_Phone_No;"Mobile Phone No")
            {}
            column(E_Mail;"E-Mail")
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(Employer_Code;"Employer Code")
            {}
            column(Date_Of_Birth;"Date Of Birth")
            {}
            column(ID_No_;"ID No.")
            {}
            column(Pin;Pin)
            {}
            column(Registration_Date;"Registration Date")
            {}
            column(Current_Shares;"Current Shares")
            {}
            column(Shares_Retained;"Shares Retained")
            {}
            column(Membership_Status;"Membership Status")
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
        layout(AllMembers)
        {
            Type = rdlc;
            LayoutFile = 'Layouts/FullMemberListing.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    myInt: Integer;
    refDate: Date;
    company: Record "Company Information";
}



