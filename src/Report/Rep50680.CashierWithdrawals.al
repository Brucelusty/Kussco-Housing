report 50680 "Cashier Withdrawals"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\CashierWithdrawals.rdlc';


    dataset
    {
        dataitem(Transactions; Transactions)
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;
            column(No; No)
            {
            }
            column(Account_No_; "Account No")
            { }
            column(Account_Name; "Account Name")
            { }
            column(Amount; Amount)
            {
            }
            column(ID_No; "ID No")
            { }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(BOSA_Account_No; "BOSA Account No")
            { }
            column(companyPicture; CompanyInfo.Picture)
            { }
            column(ComapanyName; CompanyInfo.Name)
            { }
            column(CompanyAddress; CompanyInfo.Address)
            { }
            column(CompanyAddress2; CompanyInfo."Address 2")
            { }
            column(CompanyPhone; CompanyInfo."Phone No.")
            { }
            column(CompanyEmail; CompanyInfo."E-Mail")
            { }
            column(Book_Balance; "Book Balance")
            { }
            column(Available_Balance; "Available Balance")
            {
            }
            column(SumTransactionCharges; SumTransactionCharges)
            {
            }
            column(served; served)
            {
            }
            dataitem("Transaction Charges"; "Transaction Charges")
            {
                DataItemLink = "Transaction Type" = field("Transaction Type");
                column(Charge_Amount; "Transaction Charges"."Charge Amount")
                { }
                column(ChAmount; ChAmount)
                {
                }
                column(Total_Charges; "Total Charges")
                { }

                trigger OnAfterGetRecord()
                begin
                    IF "Transaction Charges"."Use Percentage" = TRUE THEN
                        ChAmount := ("Transaction Charges"."Percentage of Amount" * Transactions.Amount) * 0.01
                    ELSE
                        ChAmount := "Transaction Charges"."Charge Amount";
                end;

            }

            trigger OnPreDataItem();
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord()

            begin

                ATMBalance := 0;

                //"Transactions 1".CALCFIELDS("Transactions 1"."Book Balance");

                LoanGuaranteed := 0;
                UnClearedBalance := 0;
                TotalGuaranted := 0;
                BookBal := 0;
                //  MESSAGE('ChAmount',ChAmount);

                TransactionCharges.RESET;
                TransactionCharges.SETRANGE(TransactionCharges."Transaction Type", "Transaction Type");

                TCharges := 0;
                AvailableBalance := 0;
                MinAccBal := 0;

                //CALCFIELDS("Book Balance");

                AccountTypes.RESET;
                AccountTypes.SETRANGE(AccountTypes.Code, "Account Type");

                IF AccountTypes.FIND('-') THEN BEGIN
                    MinAccBal := AccountTypes."Minimum Balance";
                    FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";
                END;

                IF Posted = FALSE THEN BEGIN

                    IF TransactionCharges.FIND('-') THEN
                        REPEAT

                            ////////
                            IF TransactionCharges."Use Percentage" = TRUE THEN BEGIN
                                IF TransactionCharges."Percentage of Amount" = 0 THEN
                                    ERROR('Percentage of amount cannot be zero.');
                                //USE BOOK BALANCE FOR ESTIMATING PERCENTAGE OF AMOUNT
                                TCharges := TCharges + (TransactionCharges."Percentage of Amount" / 100) * "Book Balance";
                                //TCharges:=TCharges+(TransactionCharges."Percentage of Amount"/100)*Amount;
                            END
                            ELSE BEGIN
                                TCharges := TCharges + TransactionCharges."Charge Amount";
                            END;
                        /////////

                        //TCharges:=TCharges+TransactionCharges."Charge Amount";
                        UNTIL TransactionCharges.NEXT = 0;

                    TransactionCharges.RESET;

                    ///// CHECK LAST WITHDRAWAL DATE AND FIND IF CHARGE IS APPLICABLE AND CHARGE
                    IntervalPenalty := 0;
                    Members.RESET;
                    IF Members.GET("Account No") THEN BEGIN

                        // IF Members.Status <> Members.Status::New THEN BEGIN
                        //     /*
                        //     IF Type='Withdrawal' THEN BEGIN
                        //     AccountTypes.RESET;
                        //     AccountTypes.SETRANGE(AccountTypes.Code,"Account Type");
                        //     IF AccountTypes.FIND('-') THEN  BEGIN
                        //     IF CALCDATE(AccountTypes."Withdrawal Interval",Members."Last Withdrawal Date") > TODAY THEN BEGIN
                        //     IntervalPenalty:=AccountTypes."Withdrawal Penalty";
                        //     END;
                        //     END;
                        //     END;
                        //     */
                        // END;
                    END;

                    //////////////



                    /////////////
                    //FIXED DEPOSIT

                    ChargesOnFD := 0;

                    Members.RESET;
                    IF Members.GET("Account No") THEN BEGIN

                        AccountTypes.RESET;
                        IF AccountTypes.GET(Members."Account Type") THEN BEGIN
                            IF AccountTypes."Fixed Deposit" = TRUE THEN BEGIN

                                IF Members."Expected Maturity Date" > TODAY THEN BEGIN
                                    ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                                END;

                            END;
                        END;


                    END;

                    Members.RESET;

                    ///////////

                END;


                //UNCLEARED CHEQUES
                chqtransactions.RESET;
                chqtransactions.SETRANGE(chqtransactions."Account No", "Account No");
                chqtransactions.SETRANGE(chqtransactions.Deposited, TRUE);
                chqtransactions.SETRANGE(chqtransactions."Cheque Processed", FALSE);

                IF chqtransactions.FIND('-') THEN BEGIN

                    REPEAT

                        TotalUnprocessed := TotalUnprocessed + chqtransactions.Amount;

                    UNTIL chqtransactions.NEXT = 0;

                END;


                //ATM BALANCE
                AccountHolders.RESET;
                AccountHolders.SETRANGE(AccountHolders."No.", "Account No");
                IF AccountHolders.FIND('-') THEN BEGIN
                    //AccountHolders.CALCFIELDS(AccountHolders."ATM Transactions");
                    ATMBalance := AccountHolders."ATM Transactions";
                END;


                IF LoanGuaranteed < 0 THEN
                    LoanGuaranteed := 0;

                IF UnClearedBalance < 0 THEN
                    UnClearedBalance := 0;

                AccountTypes.RESET;
                IF AccountTypes.GET("Account Type") THEN BEGIN
                    IF AccountTypes."Fixed Deposit" = FALSE THEN BEGIN
                        IF "Book Balance" < MinAccBal THEN
                            AvailableBalance := "Book Balance" - FeeBelowMinBal - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance
                        ELSE
                            AvailableBalance := "Book Balance" - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance;


                    END ELSE
                        AvailableBalance := "Book Balance" - TCharges - ChargesOnFD;
                END;


                IF Account.GET(Transactions."Account No") THEN BEGIN
                    Account.CALCFIELDS(Account."Balance (LCY)", Account."Uncleared Cheques");
                    AvailableBalance := Account."Balance (LCY)" - (Account."Uncleared Cheques");
                    BookBal := Account."Balance (LCY)";

                END;

                IF Transactions."Branch Transaction" = TRUE THEN BEGIN
                    Transactions."Book Balance" := 0;
                    BookBal := 0;
                    AvailableBalance := 0;
                END;


                vatTotalHolder := Transactions.Amount;

                TillNo := '';
                TellerTill.RESET;
                TellerTill.SETRANGE(TellerTill."Cashier ID", Transactions.Cashier);
                IF TellerTill.FIND('-') THEN BEGIN
                    TillNo := TellerTill."No.";
                END;


                //calculate the charges
                VendLedgerEntry.RESET;
                VendLedgerEntry.SETRANGE("Vendor No.", Transactions."Account No");
                VendLedgerEntry.SETRANGE("Document No.", Transactions.No);
                IF VendLedgerEntry.FINDSET THEN
                    REPEAT
                        VendLedgerEntry.CALCSUMS(Amount);
                        SumTransactionCharges := VendLedgerEntry.Amount - Transactions.Amount;
                    UNTIL VendLedgerEntry.NEXT = 0;


                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Amount, ' ');

            end;
        }
    }


    var
        members: Record Vendor;
        TotalGuaranted: Decimal;
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        LoanGuaranteed: Decimal;
        DepositerName: Text[80];
        chqtransactions: Record Transactions;
        AccountHolders: Record Vendor;
        UnClearedBalance: Decimal;
        SourceofFunds: Text[30];

        Purpose: Text[70];

        Signature: Text[20];

        served: label 'You were served by:';
        TransactionCharges: Record "Transaction Charges";
        AccountTypes: Record "Account Types-Saving Products";
        TotalCharges: decimal;
        TCharges: Decimal;
        AvailableBalance: decimal;
        ATMBalance: decimal;
        MinAccBal: Decimal;
        TotalUnprocessed: Decimal;
        IntervalPenalty: Decimal;
        Account: Record Vendor;
        FeeBelowMinBal: Decimal;
        ExciseDuty: Decimal;
        ChargesOnFD: Decimal;
        SumTransactionCharges: Decimal;
        ChAmount: Decimal;
        VendLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        TellerTill: Record "Bank Account";
        BookBal: Decimal;
        TillNo: Code[20];
        vatTotalHolder: Decimal;



    procedure CalAvailableBal()
    begin
        ATMBalance := 0;
        TCharges := 0;
        AvailableBalance := 0;
        MinAccBal := 0;
        TotalUnprocessed := 0;
        IntervalPenalty := 0;
        if Account.Get(Transactions."Account No") then begin
            Account.CalcFields(Account.Balance);
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Transactions."Account Type");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance";
                FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";
                //Check Withdrawal Interval															
                if Account.Status <> Account.Status::Deceased then begin
                    if Transactions.Type = 'Withdrawal' then begin
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Transactions."Account Type");
                        if Account."Last Withdrawal Date" <> 0D then begin
                            if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then
                                IntervalPenalty := AccountTypes."Withdrawal Penalty";
                        end;
                    end;
                    //Check Withdrawal Interval															
                    //Fixed Deposit															
                    ChargesOnFD := 0;
                    if AccountTypes."Fixed Deposit" = true then begin
                        if Account."Expected Maturity Date" > Today then
                            ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    end;
                    //Fixed Deposit															
                    //Current Charges															
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", Transactions."Transaction Type");
                    if TransactionCharges.Find('-') then begin
                        repeat
                            if TransactionCharges."Use Percentage" = true then begin
                                TransactionCharges.TestField("Percentage of Amount");
                                TCharges := TCharges + (TransactionCharges."Percentage of Amount" / 100) * Transactions."Book Balance";
                            end else begin
                                "Transaction Charges"."Total Charges" := TCharges + TransactionCharges."Charge Amount";
                            end;
                        until TransactionCharges.Next = 0;
                    end;
                    TotalUnprocessed := Account."Uncleared Cheques";
                    ATMBalance := Account."ATM Transactions";
                    //FD															
                    if AccountTypes."Fixed Deposit" = false then begin
                        if Account.Balance < MinAccBal then
                            AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance
                        else
                            AvailableBalance := Account.Balance - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance;
                    end else begin
                        AvailableBalance := Account.Balance - TCharges - ChargesOnFD;
                        Transactions."Available Balance" := AvailableBalance;
                    end;
                end;
                //FD															
                //MESSAGE('The available balance is %1',AvailableBalance);															
            end;
        end;
    end;
}


