report 51199 "Loan Offer Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'Layouts/LoanOfferReport.docx';

    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {
            column(Format_to_today; Format(Today, 0, 4)) { }
            column(Application_Date; "Application Date")
            {

            }

            column(Client_Code; "Client Code")
            {
                
            }
            column(Approved_Amount; "Approved Amount")
            {

            }

            column(Client_Name; "Client Name")
            {

            }

            column(Address; Address)
            {

            }

            column(Phone_No; "Phone No")
            {

            }

            column(Current_Location; "Current Location")
            {

            }

            column(Installments; "Installments")
            {

            }

            column(Interest; Interest)
            {

            }

            column(Monthly_Contribution; "Monthly Contribution")
            {

            }

            // if the above fails try the field: loan reschedule instalments

            column(Loan_Appraisal_Fee; "Loan Appraisal Fee")
            {

            }



            column(Property_Location_Description; "Property Location Description")
            {

            }

            column(Loan_Purpose; "Loan Purpose")
            {

            }

            column(Company_Logo; Company.Picture)
            { }
            column(Company_Address; Company.Address)
            { }
            column(Company_Phoneno; Company."Phone No.")
            { }
            column(Company_Add2; Company."Address 2")
            { }
            column(Company_Email; Company."E-Mail")
            { }
        }
    }

    var
        Company: Record "Company Information";
}
