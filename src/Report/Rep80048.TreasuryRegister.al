namespace TelepostSacco.TelepostSacco;
using Microsoft.Bank.Ledger;

report 80048 "Treasury Register"
{
    ApplicationArea = All;
    Caption = 'Treasury Register';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/TreasuryRegister.RDLC';
    dataset
    {
        dataitem(TreasuryTransactions; "Treasury Transactions")
        {
            DataItemTableView = sorting("No") WHERE(Posted = filter(true));
            column(No; No)
            {
            }
            column(TransactionDate; "Date Posted")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(FromAccount; "From Account")
            {
            }
            column(FromAccountUser; "From Account User")
            {
            }
            column(ToAccount; "To Account")
            {
            }
            column(ToAccountUser; "To Account User")
            {
            }
            column(Amount; Amount)
            {
            }
            column(OneTHousand; OneTHousand)
            {
            }
            column(FiveHundred; FiveHundred)
            {
            }
            column(TwoHundred; TwoHundred)
            {
            }
            column(OneHundred; OneHundred)
            {
            }
            column(FiftyShillings; FiftyShillings)
            {
            }
            column(FortySHillings; FortySHillings)
            {
            }
            column(TwentySHillings; TwentySHillings)
            {
            }
            column(TenShillings; TenShillings)
            {
            }
            column(FiveShillings; FiveShillings)
            {
            }
            column(OneShilling; OneShilling)
            {
            }
            column(OneCent; OneCent)
            {
            }
            column(OneTHousandDen; OneTHousandDen)
            {
            }
            column(FiveHundredDen; FiveHundredDen)
            {
            }
            column(TwoHundredDen; TwoHundredDen)
            {
            }
            column(OneHundredDen; OneHundredDen)
            {
            }
            column(FiftyShillingsDen; FiftyShillingsDen)
            {
            }
            column(FortySHillingsDen; FortySHillingsDen)
            {
            }
            column(TwentySHillingsDen; TwentySHillingsDen)
            {
            }
            column(TenShillingsDen; TenShillingsDen)
            {
            }
            column(FiveShillingsDen; FiveShillingsDen)
            {
            }
            column(OneShillingDen; OneShillingDen)
            {
            }
            column(OneCentDen; OneCentDen)
            {
            }
            column(TotalDen; TotalDen)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(RegisterDate; RegisterDate)
            {
            }
            column(FromDate; FromDate)
            {
            }
            column(BFBalance; BFBalance)
            {
            }
            column(RunningBalance; RunningBalance)
            {
            }
            column(OneTHousandCD; OneTHousandCD)
            {
            }
            column(FiveHundredCD; FiveHundredCD)
            {
            }
            column(TwoHundredCD; TwoHundredCD)
            {
            }
            column(OneHundredCD; OneHundredCD)
            {
            }
            column(FiftyShillingsCD; FiftyShillingsCD)
            {
            }
            column(FortySHillingsCD; FortySHillingsCD)
            {
            }
            column(TwentySHillingsCD; TwentySHillingsCD)
            {
            }
            column(TenShillingsCD; TenShillingsCD)
            {
            }
            column(FiveShillingsCD; FiveShillingsCD)
            {
            }
            column(OneShillingCD; OneShillingCD)
            {
            }
            column(OneCentCD; OneCentCD)
            {
            }
            column(OneTHousandBF; OneTHousandBF)
            {
            }
            column(FiveHundredBF; FiveHundredBF)
            {
            }
            column(TwoHundredBF; TwoHundredBF)
            {
            }
            column(OneHundredBF; OneHundredBF)
            {
            }
            column(FiftyShillingsBF; FiftyShillingsBF)
            {
            }
            column(FortySHillingsBF; FortySHillingsBF)
            {
            }
            column(TwentySHillingsBF; TwentySHillingsBF)
            {
            }
            column(TenShillingsBF; TenShillingsBF)
            {
            }
            column(FiveShillingsBF; FiveShillingsBF)
            {
            }
            column(OneShillingBF; OneShillingBF)
            {
            }
            column(OneCentBF; OneCentBF)
            {
            }
            column(OneTHousandBFAf; OneTHousandBFAf)
            {
            }
            column(FiveHundredBFAf; FiveHundredBFAf)
            {
            }
            column(TwoHundredBFAf; TwoHundredBFAf)
            {
            }
            column(OneHundredBFAf; OneHundredBFAf)
            {
            }
            column(FiftyShillingsBFAf; FiftyShillingsBFAf)
            {
            }
            column(FortySHillingsBFAf; FortySHillingsBFAf)
            {
            }
            column(TwentySHillingsBFAf; TwentySHillingsBFAf)
            {
            }
            column(TenShillingsBFAf; TenShillingsBFAf)
            {
            }
            column(FiveShillingsBFAf; FiveShillingsBFAf)
            {
            }
            column(OneShillingBFAf; OneShillingBFAf)
            {
            }
            column(OneCentBFAf; OneCentBFAf)
            {
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //              if RegisterDate = 0D then
                //       RegisterDate := Today;
                BFBalance := 0;
                TreasuryTransactions.SetFilter(TreasuryTransactions."Transaction Date", '%1..%2', FromDate, RegisterDate);
                //  TreasuryTransactions.SetRange(TreasuryTransactions."Transaction Date", FromDate);
                BankEntry.Reset();
                BankEntry.SetRange(BankEntry."Bank Account No.", 'TREASURY');
                // BankEntry.SetFilter(BankEntry."Posting Date", '..%1', FromDate);
                BankEntry.SetFilter(BankEntry."Posting Date", '..%1', CalcDate('<-1D>', FromDate));
                if BankEntry.FindSet() then begin
                    BankEntry.CalcSums(BankEntry.Amount);
                    BFBalance := BankEntry.Amount;
                    //Message('Balnce%1',BFBalance);
                end;
                RunningBalance := BFBalance;
                OneTHousandBF := 698000;
                FiveHundredBF := 4000;
                TwoHundredBF := 0;
                OneHundredBF := 100;
                FiftyShillingsBF := 2500;
                FortyShillingsBF := 800;
                TenShillingsBF := 590;
                FiveShillingsBF := 25;
                OneShillingBF := 7;

                OneTHousandBFAf := 698000;
                FiveHundredBFAf := 4000;
                TwoHundredBFAf := 0;
                OneHundredBFAf := 100;
                FiftyShillingsBFAf := 2500;
                FortyShillingsBFAf := 800;
                TenShillingsBFAf := 590;
                FiveShillingsBFAf := 25;
                OneShillingBFAf := 7;

                Ttrans.Reset();
                // Ttrans.SetFilter(Ttrans."Date Posted", '..%1', FromDate);
                Ttrans.SetFilter(Ttrans."Date Posted", '%1..%2', 20250101D, CalcDate('-1D', FromDate));
                Ttrans.SetRange(Ttrans.Posted, true);
                Ttrans.SetRange(Ttrans."Ignore Trans", false);
                if Ttrans.FindFirst() then begin
                    repeat
                        // --- ADD transaction types ---
                        if Ttrans."Transaction Type" in [
                            Ttrans."Transaction Type"::"End of Day Return to Treasury",
                                Ttrans."Transaction Type"::"Issue From Bank",
                            Ttrans."Transaction Type"::"Return To Treasury"
                        ] then begin
                            TCoinage.Reset();
                            TCoinage.SetRange(TCoinage.No, Ttrans.No);
                            if TCoinage.FindFirst() then begin

                                repeat
                                    case TCoinage.Code of
                                        '001':
                                            OneTHousandBF += TCoinage."Total Amount";
                                        '002':
                                            FiveHundredBF += TCoinage."Total Amount";
                                        '003':
                                            TwoHundredBF += TCoinage."Total Amount";
                                        '004':
                                            OneHundredBF += TCoinage."Total Amount";
                                        '005':
                                            FiftyShillingsBF += TCoinage."Total Amount";
                                        '006':
                                            FortySHillingsBF += TCoinage."Total Amount";
                                        '007':
                                            TwentySHillingsBF += TCoinage."Total Amount";
                                        '008':
                                            TenShillingsBF += TCoinage."Total Amount";
                                        '009':
                                            FiveShillingsBF += TCoinage."Total Amount";
                                        '010':
                                            OneShillingBF += TCoinage."Total Amount";
                                        '011':
                                            OneCentBF += TCoinage."Total Amount";
                                    end;
                                // Message('AddThousand%1TcoinageTOtal%2', OneTHousandBF, TCoinage."Total Amount");
                                until TCoinage.Next() = 0;

                            end;
                        end;

                        // --- SUBTRACT transaction types ---
                        if Ttrans."Transaction Type" in [
                           Ttrans."Transaction Type"::"Issue To Teller",
                        //Ttrans."Transaction Type"::"Inter Teller Transfers",
                        Ttrans."Transaction Type"::"Return To Bank"
                       ] then begin
                            TCoinage.Reset();
                            TCoinage.SetRange(TCoinage.No, Ttrans.No);
                            if TCoinage.FindFirst() then begin

                                repeat

                                    case TCoinage.Code of
                                        '001':
                                            OneTHousandBF -= TCoinage."Total Amount";
                                        '002':
                                            FiveHundredBF -= TCoinage."Total Amount";
                                        '003':
                                            TwoHundredBF -= TCoinage."Total Amount";
                                        '004':
                                            OneHundredBF -= TCoinage."Total Amount";
                                        '005':
                                            FiftyShillingsBF -= TCoinage."Total Amount";
                                        '006':
                                            FortySHillingsBF -= TCoinage."Total Amount";
                                        '007':
                                            TwentySHillingsBF -= TCoinage."Total Amount";
                                        '008':
                                            TenShillingsBF -= TCoinage."Total Amount";
                                        '009':
                                            FiveShillingsBF -= TCoinage."Total Amount";
                                        '010':
                                            OneShillingBF -= TCoinage."Total Amount";
                                        '011':
                                            OneCentBF -= TCoinage."Total Amount";
                                    end;
                                ///    Message('RemoveThousand%1TcoinageTOtal%2', OneTHousandBF, TCoinage."Total Amount");
                                until TCoinage.Next() = 0;

                            end;
                        end;
                    until Ttrans.Next() = 0;
                end;


                //BalanceAf
                Ttrans.Reset();
                // Ttrans.SetFilter(Ttrans."Date Posted", '..%1', FromDate);
                Ttrans.SetFilter(Ttrans."Date Posted", '%1..%2', 20250101D, FromDate);
                Ttrans.SetRange(Ttrans.Posted, true);
                Ttrans.SetRange(Ttrans."Ignore Trans", false);
                if Ttrans.FindFirst() then begin
                    repeat
                        // --- ADD transaction types ---
                        if Ttrans."Transaction Type" in [
                            Ttrans."Transaction Type"::"End of Day Return to Treasury",
                                Ttrans."Transaction Type"::"Issue From Bank",
                            Ttrans."Transaction Type"::"Return To Treasury"
                        ] then begin
                            TCoinage.Reset();
                            TCoinage.SetRange(TCoinage.No, Ttrans.No);
                            if TCoinage.FindFirst() then begin

                                repeat
                                    case TCoinage.Code of
                                        '001':
                                            OneTHousandBFAf += TCoinage."Total Amount";
                                        '002':
                                            FiveHundredBFAf += TCoinage."Total Amount";
                                        '003':
                                            TwoHundredBFAf += TCoinage."Total Amount";
                                        '004':
                                            OneHundredBFAf += TCoinage."Total Amount";
                                        '005':
                                            FiftyShillingsBFAf += TCoinage."Total Amount";
                                        '006':
                                            FortySHillingsBFAf += TCoinage."Total Amount";
                                        '007':
                                            TwentySHillingsBFAf += TCoinage."Total Amount";
                                        '008':
                                            TenShillingsBFAf += TCoinage."Total Amount";
                                        '009':
                                            FiveShillingsBFAf += TCoinage."Total Amount";
                                        '010':
                                            OneShillingBFAf += TCoinage."Total Amount";
                                        '011':
                                            OneCentBFAf += TCoinage."Total Amount";
                                    end;

                                until TCoinage.Next() = 0;

                            end;
                        end;

                        // --- SUBTRACT transaction types ---
                        if Ttrans."Transaction Type" in [
                           Ttrans."Transaction Type"::"Issue To Teller",
                        //  Ttrans."Transaction Type"::"Inter Teller Transfers",
                        Ttrans."Transaction Type"::"Return To Bank"
                       ] then begin
                            TCoinage.Reset();
                            TCoinage.SetRange(TCoinage.No, Ttrans.No);
                            if TCoinage.FindFirst() then begin

                                repeat

                                    case TCoinage.Code of
                                        '001':
                                            OneTHousandBFAf -= TCoinage."Total Amount";
                                        '002':
                                            FiveHundredBFAf -= TCoinage."Total Amount";
                                        '003':
                                            TwoHundredBFAf -= TCoinage."Total Amount";
                                        '004':
                                            OneHundredBFAf -= TCoinage."Total Amount";
                                        '005':
                                            FiftyShillingsBFAf -= TCoinage."Total Amount";
                                        '006':
                                            FortySHillingsBFAf -= TCoinage."Total Amount";
                                        '007':
                                            TwentySHillingsBFAf -= TCoinage."Total Amount";
                                        '008':
                                            TenShillingsBFAf -= TCoinage."Total Amount";
                                        '009':
                                            FiveShillingsBFAf -= TCoinage."Total Amount";
                                        '010':
                                            OneShillingBFAf -= TCoinage."Total Amount";
                                        '011':
                                            OneCentBFAf -= TCoinage."Total Amount";
                                    end;

                                until TCoinage.Next() = 0;

                            end;
                        end;
                    until Ttrans.Next() = 0;
                end;

                // Message('Thao%1Five%2Two%3Onehun%4Fif%5Forty%6Twenty%7TenSh%8FiveSh%9OneShi%10Onece%11', OneTHousandBF, FiveShillingsBF, TwoHundredBF, OneTHousandBF, FiftyShillingsBF, FortySHillingsBF, TwentySHillingsBF, TenShillingsBF, FiveShillingsBF, OneShillingBF, OneCentBF);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                OneTHousand := 0;
                TotalAmount := 0;
                TotalDen := 0;
                FiveHundred := 0;
                TwoHundred := 0;
                OneHundred := 0;
                FiftyShillings := 0;
                FortySHillings := 0;
                TwentySHillings := 0;
                TenShillings := 0;
                FiveShillings := 0;
                OneShilling := 0;
                OneCent := 0;
                OneTHousandDen := 0;
                FiveHundredDen := 0;
                TwoHundredDen := 0;
                OneHundredDen := 0;
                FiftyShillingsDen := 0;
                FortySHillingsDen := 0;
                TwentySHillingsDen := 0;
                TenShillingsDen := 0;
                FiveShillingsDen := 0;
                OneShillingDen := 0;
                OneCentDen := 0;
                OneTHousandCD := 0;
                FiveHundredCD := 0;
                TwoHundredCD := 0;
                OneHundredCD := 0;
                FiftyShillingsCD := 0;
                FortySHillingsCD := 0;
                TwentySHillingsCD := 0;
                TenShillingsCD := 0;
                FiveShillingsCD := 0;
                OneShillingCD := 0;
                OneCentCD := 0;
                TCoinage.Reset();
                TCoinage.SetRange(TCoinage.No, TreasuryTransactions.No);
                if TCoinage.FindFirst() then begin
                    repeat
                        if TCoinage.Code = '001' then begin
                            OneTHousand := TCoinage."Total Amount";
                            OneTHousandDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '002' then begin
                            FiveHundred := TCoinage."Total Amount";
                            FiveHundredDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '003' then begin
                            TwoHundred := TCoinage."Total Amount";
                            TwoHundredDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '004' then begin
                            OneHundred := TCoinage."Total Amount";
                            OneHundredDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '005' then begin
                            FiftyShillings := TCoinage."Total Amount";
                            FiftyShillingsDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '006' then begin
                            FortySHillings := TCoinage."Total Amount";
                            FortySHillingsDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '007' then begin
                            TwentySHillings := TCoinage."Total Amount";
                            TwentySHillingsDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '008' then begin
                            TenShillings := TCoinage."Total Amount";
                            TenShillingsDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '009' then begin
                            FiveShillings := TCoinage."Total Amount";
                            FiveShillingsDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '010' then begin
                            OneShilling := TCoinage."Total Amount";
                            OneShillingDen := TCoinage.Quantity;
                        end;
                        if TCoinage.Code = '011' then begin
                            OneCent := TCoinage."Total Amount";
                            OneCentDen := TCoinage.Quantity;
                        end;
                        TotalAmount += TCoinage."Total Amount";
                        TotalDen += TCoinage.Quantity;
                    until TCoinage.Next() = 0;
                end;
                if TreasuryTransactions."Transaction Type" = TreasuryTransactions."Transaction Type"::"Issue From Bank" then begin
                    RunningBalance += TotalAmount;
                    OneTHousandCD := -OneTHousand;
                    FiveHundredCD := -FiveHundred;
                    TwoHundredCD := -TwoHundred;
                    OneHundredCD := -OneHundred;
                    FiftyShillingsCD := -FiftyShillings;
                    FortySHillingsCD := -FortySHillings;
                    TwentySHillingsCD := -TwentySHillings;
                    TenShillingsCD := -TenShillings;
                    FiveShillingsCD := -FiveShillings;
                    OneShillingCD := -OneShilling;
                    OneCentCD := -OneCent;
                end else if TreasuryTransactions."Transaction Type" = TreasuryTransactions."Transaction Type"::"Return To Bank" then begin
                    RunningBalance -= TotalAmount;
                    OneTHousandCD := OneTHousand;
                    FiveHundredCD := FiveHundred;
                    TwoHundredCD := TwoHundred;
                    OneHundredCD := OneHundred;
                    FiftyShillingsCD := FiftyShillings;
                    FortySHillingsCD := FortySHillings;
                    TwentySHillingsCD := TwentySHillings;
                    TenShillingsCD := TenShillings;
                    FiveShillingsCD := FiveShillings;
                    OneShillingCD := OneShilling;
                    OneCentCD := OneCent;
                end else if TreasuryTransactions."Transaction Type" = TreasuryTransactions."Transaction Type"::"Issue To Teller" then begin
                    RunningBalance -= TotalAmount;
                    OneTHousandCD := OneTHousand;
                    FiveHundredCD := FiveHundred;
                    TwoHundredCD := TwoHundred;
                    OneHundredCD := OneHundred;
                    FiftyShillingsCD := FiftyShillings;
                    FortySHillingsCD := FortySHillings;
                    TwentySHillingsCD := TwentySHillings;
                    TenShillingsCD := TenShillings;
                    FiveShillingsCD := FiveShillings;
                    OneShillingCD := OneShilling;
                    OneCentCD := OneCent;
                end else if TreasuryTransactions."Transaction Type" = TreasuryTransactions."Transaction Type"::"End of Day Return to Treasury" then begin
                    RunningBalance += TotalAmount;
                    OneTHousandCD := -OneTHousand;
                    FiveHundredCD := -FiveHundred;
                    TwoHundredCD := -TwoHundred;
                    OneHundredCD := -OneHundred;
                    FiftyShillingsCD := -FiftyShillings;
                    FortySHillingsCD := -FortySHillings;
                    TwentySHillingsCD := -TwentySHillings;
                    TenShillingsCD := -TenShillings;
                    FiveShillingsCD := -FiveShillings;
                    OneShillingCD := -OneShilling;
                    OneCentCD := -OneCent;
                end else if TreasuryTransactions."Transaction Type" = TreasuryTransactions."Transaction Type"::"Return To Treasury" then begin
                    RunningBalance += TotalAmount;
                    OneTHousandCD := -OneTHousand;
                    FiveHundredCD := -FiveHundred;
                    TwoHundredCD := -TwoHundred;
                    OneHundredCD := -OneHundred;
                    FiftyShillingsCD := -FiftyShillings;
                    FortySHillingsCD := -FortySHillings;
                    TwentySHillingsCD := -TwentySHillings;
                    TenShillingsCD := -TenShillings;
                    FiveShillingsCD := -FiveShillings;
                    OneShillingCD := -OneShilling;
                    OneCentCD := -OneCent;
                end;
            end;
        }
    }
    requestpage
    {

        layout
        {
            area(content)
            {
                group("Please Select")
                {
                    field(FromDate; FromDate)
                    {
                    ApplicationArea = All;
                    }
                    field(ToDate; RegisterDate)
                    {
                    ApplicationArea = All;
                    }

                }
            }
        }

        actions
        {
        }
    }

    var
        RegisterDate: Date;
        OneTHousand: Decimal;
        FiveHundred: Decimal;
        TwoHundred: Decimal;
        OneHundred: Decimal;
        FiftyShillings: Decimal;
        FortySHillings: Decimal;
        TwentySHillings: Decimal;
        TenShillings: Decimal;
        FiveShillings: Decimal;
        OneShilling: Decimal;
        OneCent: decimal;
        TCoinage: Record "Treasury Coinage";

        OneTHousandDen: Integer;
        FiveHundredDen: Integer;
        TwoHundredDen: Integer;
        OneHundredDen: Integer;
        FiftyShillingsDen: Integer;
        FortySHillingsDen: Integer;
        TwentySHillingsDen: Integer;
        TenShillingsDen: Integer;
        FiveShillingsDen: Integer;
        OneShillingDen: Integer;
        OneCentDen: Integer;
        TotalDen: Integer;
        TotalAmount: Decimal;
        FromDate: Date;

        BankEntry: Record "Bank Account Ledger Entry";
        BFBalance: Decimal;
        RunningBalance: Decimal;
        OneTHousandCD: Decimal;
        FiveHundredCD: Decimal;
        TwoHundredCD: Decimal;
        OneHundredCD: Decimal;
        FiftyShillingsCD: Decimal;
        FortySHillingsCD: Decimal;
        TwentySHillingsCD: Decimal;
        TenShillingsCD: Decimal;
        FiveShillingsCD: Decimal;
        OneShillingCD: Decimal;
        OneCentCD: decimal;

        OneTHousandBF: Decimal;
        FiveHundredBF: Decimal;
        TwoHundredBF: Decimal;
        OneHundredBF: Decimal;
        FiftyShillingsBF: Decimal;
        FortySHillingsBF: Decimal;
        TwentySHillingsBF: Decimal;
        TenShillingsBF: Decimal;
        FiveShillingsBF: Decimal;
        OneShillingBF: Decimal;
        OneCentBF: decimal;

        OneTHousandBFAf: Decimal;
        FiveHundredBFAf: Decimal;
        TwoHundredBFAf: Decimal;
        OneHundredBFAf: Decimal;
        FiftyShillingsBFAf: Decimal;
        FortySHillingsBFAf: Decimal;
        TwentySHillingsBFAf: Decimal;
        TenShillingsBFAf: Decimal;
        FiveShillingsBFAf: Decimal;
        OneShillingBFAf: Decimal;
        OneCentBFAf: decimal;

        Ttrans: Record "Treasury Transactions";


}



