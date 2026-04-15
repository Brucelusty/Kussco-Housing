report 65801 LOFHousePurcahse
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './LayoutLOFHousePurchase.docx';

    dataset
    {
        dataitem(Loan; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Client Code";
            column(Loan__No_; "Loan  No.")
            {

            }
            column(Application_Date; "Application Date")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Installments; Installments)
            {

            }
            column(New_Interest_Rate; "New Interest Rate")
            {

            }
            column(Total_Schedule_Repayment; "Total Schedule Repayment")
            {

            }
            column(Property_Location_Description; "Property Location Description")
            {

            }
            column(Loan_Appraisal_Fee; "Loan Appraisal Fee")
            {

            }

            dataitem("Membership Applications"; "Membership Applications")
            {
                DataItemLink = "No." = field("Client Code");

                column(Name; Name)
                {

                }
                column(E_Mail__Personal_; "E-Mail (Personal)")
                {

                }
                column(Mobile_Phone_No; "Mobile Phone No")
                {

                }
                column(Region; Region)
                {

                }
                column(Postal_Code; "Postal Code")
                {

                }
                column(Address; Address)
                {

                }
            }
        }
    }

    var
        myInt: Integer;
}


