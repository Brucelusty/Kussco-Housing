report 50674 "OverdrawnOTCTransactionsReport"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/OverdrawnOvertheCounterTransactions.rdlc';
    
    dataset
    {
        dataitem(Transactions;Transactions)
        {
            DataItemTableView = sorting(No, "Member No") where (//"Supervisor Checked" = const(true),
            "Needs Approval" = const(Yes), "Transaction Type" = filter('ORDINARYCW'|'ORDCW'), "Authorisation Requirement" = const('Over draft'));
            RequestFilterFields = "Transaction Date";
            column(No;No)
            {
                
            }
            column(Account_No;"Account No")
            {
                
            }
            column(Account_Name;"Account Name")
            {
                
            }
            column(Transaction_Type;"Transaction Type")
            {
                
            }
            column(Type__Transactions;"Type _Transactions")
            {}
            column(Cashier;Cashier)
            {
                
            }
            column(Transaction_Date;"Transaction Date")
            {}
            column(Transaction_Time;"Transaction Time")
            {}
            column(Amount;Amount)
            {
                
            }
            column(Account_Description;"Account Description")
            {
                
            }
            column(Account_Type;"Account Type")
            {
                
            }
            column(Authorisation_Requirement;"Authorisation Requirement")
            {

            }
            column(Checked_By;"Checked By")
            {
                
            }
            column(Overdraft_Expiry_Date;"Overdraft Expiry Date")
            {

            }
        }
    }
    
    requestpage
    {
        // layout
        // {
        //     area(Content)
        //     {
        //         group(GroupName)
        //         {
        //             field(Name; SourceExpression)
        //             {
                        
        //             }
        //         }
        //     }
        // }
    
        // actions
        // {
        //     area(processing)
        //     {
        //         action(ActionName)
        //         {
                    
        //         }
        //     }
        // }
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
}


