report 50649 "Next of Kin Details"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/NextofKinDetails.RDLC';
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "No of Next of Kin";
            DataItemTableView = where(ISNormalMember = filter(true), "No of Next of Kin" = filter(>0));
            column(No_MembersRegister;Customer."No.")
            {
                
            }
            column(Name_MembersRegister;Customer.Name)
            {
                
            }
            column(Payroll_No;Customer."Payroll No")
            {
                
            }
            column(ID_No_;Customer."ID No.")
            {
                
            }
            column(Phone_No_;Customer."Mobile Phone No")
            {
                
            }
            column(Date_Of_Birth;Customer."Date Of Birth")
            {
                
            }
            column(company_Name;company.Name)
            {}
            column(company_Picture;company.Picture)
            {}
            column(company_Add;company.Address)
            {}
            column(company_email;company."E-Mail")
            {}
            column(company_Phone;company."Phone No.")
            {}
            // column()
            // {}
            dataitem("Members Next of Kin";"Members Next of Kin"){
                DataItemLink = "Account No" = field("No.");
                DataItemTableView = sorting("Account No", Name, "Entry No");
                RequestFilterFields = Relationship;
                column(Account_No;"Account No")
                {

                }
                column(Relationship;Relationship)
                {
                    
                }
                column(Name_;Name)
                {
                    
                }
                column(ID_No__;"ID No.")
                {
                    
                }
                column(Date_of_Birth_Kin;"Date of Birth")
                {}
                column(Telephone;Telephone)
                {
                    
                }
            }
        }
    }
    var
        myInt: Integer;
        company: Record "Company Information";

    trigger
    OnInitReport()
    begin
        company.Get();
        company.CalcFields(Picture);
    end;
}
