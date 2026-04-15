report 50656 "Transactions Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/Transactions Report.rdlc';

    dataset
    {
        dataitem(Transactions; Transactions)
        {
            RequestFilterFields = "Transaction Date";
            DataItemTableView = sorting(No, "Member No") where(Posted = filter(true));
            column(No; No)
            {

            }
            column(Account_No; "Account No")
            {

            }
            column(Account_Name; "Account Name")
            {

            }
            column(Transaction_Type; "Transaction Type")
            {

            }
            column(Type__Transactions; "Type _Transactions")
            { }
            column(Cashier; Cashier)
            {

            }
            column(Transaction_Date; "Transaction Date")
            { }
            column(Transaction_Time; "Transaction Time")
            { }
            column(time; time)
            {

            }
            column(Amount; Amount)
            {

            }
            column(Account_Description; "Account Description")
            {

            }
            column(Account_Type; "Account Type")
            {

            }
            column(Authorisation_Requirement; "Authorisation Requirement")
            {

            }
        }
    }
    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }
    var
        myInt: Integer;
        time: DateTime;
        currentTime: DateTime;
        trans: Record Transactions;
        transtypes: Record "Transaction Types";
}
