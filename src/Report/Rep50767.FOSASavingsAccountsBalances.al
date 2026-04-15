report 50767 "FOSA Savings Accounts Balances"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = FOSASavAccBal;
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = where("Creditor Type" = filter("FOSA Account"));
            RequestFilterFields = "Account Type", "BOSA Account No", "Date Filter";
            column(No_;"No.")
            {}
            column(BOSA_Account_No;"BOSA Account No")
            {}
            column(Personal_No_;"Personal No.")
            {}
            column(Name;Name)
            {}
            column(Employer_Code;"Employer Code")
            {}
            column(Account_Type;"Account Type")
            {}
            column(Account_Type_Name;"Account Type Name")
            {}
            dataitem("Detailed Vendor Ledg. Entry";"Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Vendor No." = Field("No."), "Posting Date" = Field("Date Filter");
                column(Balance;Amount)
                {}
            }
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
                    field(asAt;asAt)
                    {
                    ApplicationArea = All;
                        
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(FOSASavAccBal)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/FOSAAccBalances.rdlc';
        }
    }
    
    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
    Int: Integer;
    asAt: Date;
    company: Record "Company Information";
    vend: Record Vendor;
    detailedVend: Record "Detailed Vendor Ledg. Entry";
    cust: Record Customer;
}



