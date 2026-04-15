report 50681 "Teller Closing Summary"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/TellerClosingSummary.rdlc';
    
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

            dataitem("BankAccountLedgerEntry";"Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No.");
                DataItemTableView = sorting("Bank Account No.", "Posting Date");
                RequestFilterFields = "Posting Date";
                column(Document_No_;"Document No.")
                {}
                column(Posting_Date;"Posting Date")
                {}
                column(Amount;Amount)
                {}
                column(Description;Description)
                {}
                column(Bal__Account_No_;"Bal. Account No.")
                {}
                column(finalclosingBal;finalclosingBal)
                {}
                column(openingBalance;openingBalance)
                {}
                column(postingTime;postingTime)
                {}
                column(runnBal;runnBal)
                {}
                trigger OnAfterGetRecord()
                begin

                    // if "Transaction Date" = '' then begin

                    // end;

                    //runnBal := page.
                    postingTime := DT2Time(SystemCreatedAt);
                    tellerNo := BankAccount."No.";
                    transDate2 := BankAccountLedgerEntry."Posting Date";
                    openingBalance := 0;
                    closingBalance := 0;
                    bankLedgerEntry.Reset();
                    bankLedgerEntry.SetRange("Bank Account No.", tellerNo);
                    //bankLedgerEntry.setrange(bankLedgerEntry."Entry No.", "Entry No.");
                    bankLedgerEntry.SetFilter("Posting Date", '..%1', transDate2);
                    if bankLedgerEntry.FindSet() then
                    begin
                        if bankLedgerEntry.Find('-') then
                        begin
                            //Message('The balance is %1.', bankLedgerEntry.CalcSums(Amount));
                            bankLedgerEntry.CalcSums(Amount);
                            closingBalance := bankLedgerEntry.Amount;
                            finalclosingBal := closingBalance;
                            repeat
                                runningBal := CalcRunningAccBalance.GetBankAccBalance(bankLedgerEntry);
                            until bankLedgerEntry.Next() = 0;
                            runnBal := runningBal;
                            
                            //MESSAGE('The last balance for teller %1 are %2 on %3', tellerNo, finalclosingBal, Format(transDate2));
                        end;
                        
                    end;

                    tellerNo := "BankAccount"."No.";
                    transDate2 := BankAccountLedgerEntry."Posting Date";
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
                            //Message('The balance is %1.', bankLedgerEntry.CalcSums(Amount));
                            bankLedgerEntry.CalcSums(Amount);
                            openingBalance := bankLedgerEntry.Amount;
                            //MESSAGE('The first balance for teller %1 are %2 on %3', tellerNo, openingBalance, Format(transDate1));
                        end;
                        
                    end;

                    bankLedgerEntry.Reset();
                    bankLedgerEntry.SetRange("Bank Account No.", tellerNo);
                    bankLedgerEntry.setRange(bankLedgerEntry."Entry No.", "Entry No.");
                    bankLedgerEntry.SetFilter("Posting Date", '..%1', transDate2);
                    if bankLedgerEntry.FindSet() then
                    begin
                        if bankLedgerEntry.Find('-') then
                        begin
                            repeat
                                runningBal := CalcRunningAccBalance.GetBankAccBalance(bankLedgerEntry);
                            until bankLedgerEntry.Next() = 0;
                            runnBal := runningBal;
                            
                            //MESSAGE('The last balance for teller %1 are %2 on %3', tellerNo, finalclosingBal, Format(transDate2));
                        end;
                        
                    end;

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

    end;
    
    var
        CalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";
        myInt: Integer;
        time: DateTime;
        currentTime: DateTime;
        trans: record Transactions;
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
        cashDeposits: Integer;
        cashWithdrawal: Integer;
        MpesaWith: Integer;
        MpesaDep: Integer;
        chequeDeposits: Integer;
        cashier_ID: Code[50];
        transaction_Type: Code[20];
        postingTime: Time;
        runningBal: Decimal;
        runnBal: Decimal;

}
