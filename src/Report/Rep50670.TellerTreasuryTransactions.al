report 50670 "Teller Treasury Transactions"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/Tellerzz Transactions Report.rdlc';
    
    dataset
    {
        dataitem("Bank Account";"Bank Account")
        {
            //DataItemLink = CashierID = field("Posted By");
            DataItemTableView = sorting("No.") where ("Account Type" = filter(Cashier));
            RequestFilterFields = "No.";
            column(No;"No.")
            {}
            column(CashierID;CashierID)
            {}
            dataitem("TreasuryTransactions";"Treasury Transactions")
            {
                DataItemLink = "Posted By" = field(CashierID);
                RequestFilterFields = "Transaction Date";
                DataItemTableView = sorting(No) where(Posted = filter(true));
                column(treasury_No;No)
                {

                }
                column(treasury_fromAcc;"From Account")
                {

                }
                column(treasury_toAcc;"To Account")
                {

                }
                column(treas_tDate;"Transaction Date")
                {

                }
                column(treas_tTime;"Transaction Time")
                {

                }
                column(treasury_tType;"Transaction Type")
                {

                }
                column(treasury_Desc;Description)
                {

                }
                column(treasury_Amount;Amount)
                {

                }
                column(treasury_tillBal;"Till/Treasury Balance")
                {

                }
                column(treasury_actualTillBal;"Actual Teller Till Balance")
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
                    tellerNo := "Bank Account"."No.";
                    transDate2 := TreasuryTransactions."Transaction Date";
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
                    tellerNo := "Bank Account"."No.";
                    transDate2 := TreasuryTransactions."Transaction Date";
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
            
            // trigger
            // OnPostDataItem()
            // begin
            //     tellNo := "No.";
            //     Message('In the first code, the tellor is %1.', tellNo);
            // end;
            }
            trigger
            OnPreDataItem()
            begin
                tellerNo := "No.";
                //Message('For the second code, the tellor is %1.', tellerNo);
            end;
            
        }
        
    }
    
    trigger
    OnInitReport()
    begin
    end;
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
        testDate: Text[30];
        finalclosingBal: Decimal;
        summingBal: Decimal;
        tellNo : Code[20];
}
