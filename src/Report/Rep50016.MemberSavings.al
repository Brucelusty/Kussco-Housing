report 50016 "MemberSavings"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/MemberSavings.Rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(DataItemName; Customer)
        {
            DataItemTableView = order(ascending) where(ISNormalMember = filter(true));
            RequestFilterFields = "No.", Status, "Registration Date","Employer Code",Workstation;
           
            column(Member_No; "No.")
            {


            }
            column(MemberName; Name) { }
            column(Dividend_Amount; "Dividend Amount") { }
            column(Interest_On_Deposits; "Interest On Deposits") { }
            column(Dependant_Savings_1; "Dependant Savings 1") { }
            column(Dependant_Savings_3; "Dependant Savings 3") { }
            column(Dependant_Savings_2; "Dependant Savings 2") { }
            column(HouseHold_Savings; "HouseHold Savings") { }
            column(Holiday_Savings; "Holiday Savings") { }
            column(Utafiti_Housing; "Utafiti Housing") { }

        }
    }

    requestpage
    {
        layout
        {

        }
    }




    var
        myInt: Integer;
}
