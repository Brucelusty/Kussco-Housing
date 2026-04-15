report 50661 "Treasury Transactions Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/Treasury Transactions Report.rdlc';
    
    dataset
    {
        dataitem("Bank Account";"Bank Account"){
            DataItemTableView = sorting("No.") where ("Account Type" = filter(Treasury|Cashier));
            RequestFilterFields = "No.";
            
            column(No_;"No.")
            {

            }
            column(CashierID;CashierID)
            {

            }

            dataitem("Treasury Transactions";"Treasury Transactions")
            {
                // DataItemLink = "To Account" = field("No.");
                RequestFilterFields = "Transaction Date", "Transaction Type";
                DataItemTableView = sorting(No) where(Posted = filter(true), "Transaction Type" = filter('Issue To Teller'|'Return To Treasury'|'End of Day Return to Treasury'|'Branch Treasury Transactions'|'Intra-Day to Treasury'|'Treasury to Intra-Day'));
                column(No;No)
                {}
                column(From_Account;"From Account")
                {}
                column(To_Account;"To Account")
                {}
                column(Transaction_Date;"Transaction Date")
                {}
                column(Transaction_Time;"Transaction Time")
                {}
                column(Transaction_Type;"Transaction Type")
                {}
                column(Description;Description)
                {}
                column(Amount;Amount)
                {}
            }
        }
    }
    
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(options; RequestOptionsPage)
    //                 {
                        
    //                 }
    //             }
    //         }
    //     }
    
    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
                    
    //             }
    //         }
    //     }
    // }
    
    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }
    trigger
    OnInitReport()
    begin
        //time:= CreateDateTime(Transactions."Transaction Date", Transactions."Transaction Time");
        currentTime:= CurrentDateTime;
        teller := telltreasuryTrans."From Account";
    end;
    
    var
        myInt: Integer;
        time: DateTime;
        currentTime: DateTime;
        date: Date;
        openingBal: Decimal;
        closingBal: Decimal;
        telltreasuryTrans: Record "Treasury Transactions";
        teller: Text[50];
}
