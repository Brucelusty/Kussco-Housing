report 50658 "Teller Cashier Transactions"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/Teller Cashier Transactions Report.rdlc';
    
    dataset
    {
        dataitem("BankAccount";"Bank Account")
        {
            DataItemTableView = sorting("No.") where ("Account Type" = filter(Cashier));
            RequestFilterFields = "No.";
            column(No;"No.")
            {}
            column(CashierID;CashierID)
            {}

            dataitem(Transaction;Transactions)
            {
                DataItemLink = "cashier" = field(CashierID);
                RequestFilterFields = "Transaction Date";
                DataItemTableView = sorting(No, "Member No") where(Posted = filter(true));
                column(Transaction_No;No)
                {
                    
                }
                column(Transaction_accNo;"Account No")
                {
                    
                }
                column(Transaction_accName;"Account Name")
                {
                    
                }
                column(Transaction_tType_;"Transaction Type")
                {
                    
                }
                column(Type__Transactions;"Type _Transactions")
                {}
                column(Transaction_Cashier;Cashier)
                {
                    
                }
                column(Trans_tDate_;"Transaction Date")
                {}
                column(Trans_tTime_;"Transaction Time")
                {}
                // column(time;time)
                // {
                    
                // }
                column(Transaction_Amount;Amount)
                {
                    
                }
                column(Transaction_accDesc;"Account Description")
                {
                    
                }
                column(Transaction_accType;"Account Type")
                {
                    
                }
                column(Transaction_authRequirement;"Authorisation Requirement")
                {

                }
                
                column(trans_Date;transDate2)
                {}
                column(opening_Bal;openingBalance)
                {}
                column(closing_Bal;finalclosingBal)
                {}
                trigger OnAfterGetRecord()
                begin
                    tellerNo := BankAccount."No.";
                    transDate2 := Transaction."Transaction Date";
                    openingBalance := 0;
                    closingBalance := 0;
                    bankLedgerEntry.Reset();
                    bankLedgerEntry.SetRange("Bank Account No.", tellerNo);
                    bankLedgerEntry.SetFilter("Posting Date", '..%1', transDate2);
                    if bankLedgerEntry.FindSet() then
                    begin
                        if bankLedgerEntry.Find('-') then
                        begin
                            bankLedgerEntry.CalcSums(Amount);
                            closingBalance := bankLedgerEntry.Amount;
                            finalclosingBal := closingBalance;
                            //MESSAGE('The last balance for teller %1 are %2 on %3', tellerNo, finalclosingBal, Format(transDate2));
                        end;
                        
                    end;
                    tellerNo := "BankAccount"."No.";
                    transDate2 := Transaction."Transaction Date";
                    openingBalance := 0;
                    testDate:= '<-1D>';
                    transDate1 := CalcDate(testDate, transDate2);
                    bankLedgerEntry.Reset();
                    bankLedgerEntry.SetRange("Bank Account No.", tellerNo);
                    bankLedgerEntry.SetFilter("Posting Date", '..%1', transDate1);
                    if bankLedgerEntry.FindSet() then
                    begin
                        if bankLedgerEntry.Find('-') then
                        begin
                            bankLedgerEntry.CalcSums(Amount);
                            openingBalance := bankLedgerEntry.Amount;
                            //MESSAGE('The first balance for teller %1 are %2 on %3', tellerNo, openingBalance, Format(transDate1));
                        end;
                        
                    end
                end;
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
        openingBalance: Decimal;
        closingBalance: Decimal;
        transDate: Date;
        page: Page "Bank Account Ledger Entries";
        transDate1: Date;
        transDate2: Date;
        testDate: Text[30];
        finalclosingBal: Decimal;
        summingBal: Decimal;
        tellNo : Code[20];
}
