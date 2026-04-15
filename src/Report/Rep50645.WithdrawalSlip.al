report 50645 "Withdrawal Slip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/WithdrawalSlip.rdlc';


    dataset
    {
        dataitem(Transactions; Transactions)
        {
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Country; CompanyInformation."Country/Region Code")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyFaxNo; CompanyInformation."Fax No.")
            {
            }
            column(E_mail; CompanyInformation."E-Mail")
            {
            }
            column(CPic; CompanyInformation.Picture)
            {
            }

            column(Member_No; "Member No")
            {
            }
            column(Member_Name; "Member Name")
            {
            }
            column(Book_Balance; "Book Balance")
            {
            }
            column(Book_Balance_After; "Book Balance After")
            {
            }
            column(Account_No; "Account No")
            {
            }
            column(Amount; Amount)
            {
            }
            column(ID_No; "ID No")
            {
            }
            column(Signature; Signature)
            {
            }
            column(Agent_Name; "Agent Name")
            {
            }

        }
    }



    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
}



