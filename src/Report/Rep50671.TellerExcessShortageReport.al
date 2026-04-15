report 50671 "Teller Excess&Shortage Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/TellerExcesses&ShortagesReport.rdlc';
    
    dataset
    {
        dataitem("Bank Account";"Bank Account")
        {
            DataItemTableView = sorting("No.") where ("Account Type" = filter(Cashier));
            RequestFilterFields = "No.";
            column(No;"No.")
            {}
            column(CashierID;CashierID)
            {}
            column(Teller_Excess_Account_balance;"Teller Excess Account balance")
            {}
            column(Teller_Shortage_Account_balance;"Teller Shortage Account balance")
            {}
            column(Teller_Balance;"Teller Balance")
            {}
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
    //                 field(Options; RequestOptionsPage)
    //                 {
    //                     Caption = 'Options';
                        
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
    
    var
        myInt: Integer;
        transactions: Record Transactions;
        treasury: Record "Treasury Transactions";
        bank: Record "Bank Account";
        tellerNo : Code[20];
        bankLedgerEntry: Record "Bank Account Ledger Entry";
        page: Page "Bank Account Ledger Entries";
        openingBalance: Decimal;
        closingBalance: Decimal;
        transDate1: Date;
        transDate2: Date;
        testDate: Date;
}
