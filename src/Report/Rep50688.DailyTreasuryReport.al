report 50688 "Daily Treasury Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/DailyTreasuryTransactionsReport.rdlc';
    
    dataset
    {
        dataitem("Bank Account Ledger Entry";"Bank Account Ledger Entry")
        {
            //DataItemLink = no = field("No.");
            RequestFilterFields = "Bank Account No.", "Posting Date";
            DataItemTableView = sorting("Bank Account No.", "Posting Date");
            PrintOnlyIfDetail = true;
            column(Company_Logo;Company.Picture)
            {}
            column(Company_Address;Company.Address)
            {}
            column(Company_Phoneno;Company."Phone No.")
            {}
            column(Company_Add2;Company."Address 2")
            {}
            column(Company_Email;Company."E-Mail")
            {}
            column(Bank_Account_No_;"Bank Account No.")
            {}
            column(Bal__Account_No_;"Bal. Account No.")
            {}
            column(Document_No_;"Document No.")
            {}
            column(Description;Description)
            {}
            column(Transaction_Date;"Posting Date")
            {}
            column(Transaction_Time;postingTime)
            {}
            column(Amount_;Amount)
            {}
            column(openingBal;openingBal)
            {}
            column(closingBal;closingBal)
            {}
            dataitem("Treasury Coinage";"Treasury Coinage")
            {
                DataItemLink = No = field("Document No.");
                column(Code;Code)
                {
                    
                }
                column(Description_;Description)
                {
                    
                }
                column(Value;Value)
                {
                    
                }
                column(Quantity;Quantity)
                {
                    
                }
                column(Total_Amount;"Total Amount")
                {
                    
                }
            }
            trigger
            OnAfterGetRecord()
            begin
                bank := "Bank Account Ledger Entry"."Bank Account No.";
                postingDate := "Bank Account Ledger Entry"."Posting Date";
                closingBal := 0;
                bankLedger.Reset();
                bankLedger.SetRange("Bank Account No.", bank);
                bankLedger.SetFilter("Posting Date", '..%1', postingDate);
                if bankLedger.FindSet() then 
                begin
                    postingTime := DT2Time(bankLedger.SystemCreatedAt);
                    //Message('The time is %1.', postingTime);
                    if bankLedger.Find('-') then begin
                        bankLedger.CalcSums(Amount);
                        closingBal := bankLedger.Amount;
                        finalclosingBal := closingBal;
                    end;
                end;

                openingBal := 0;
                testDate:= '<-1D>';
                transDate1 := CalcDate(testDate, postingDate);
                bankLedger.Reset();
                bankLedger.SetRange("Bank Account No.", bank);
                bankLedger.SetFilter("Posting Date", '..%1', transDate1);
                if bankLedger.FindSet() then
                begin
                    if bankLedger.FindFirst() then
                    begin
                        cash := "Bank Account Ledger Entry".Amount;
                        bankLedger.CalcSums(Amount);
                        openingBal := bankLedger.Amount + cash;
                    end;
                    
                end;
            end;
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
        currentTime:= CurrentDateTime;
        teller := telltreasuryTrans."From Account";
        company.Get();
        company.CalcFields(Picture);
    end;
    
    var
        myInt: Integer;
        company: Record "Company Information";
        time: DateTime;
        currentTime: DateTime;
        date: Date;
        openingBal: Decimal;
        closingBal: Decimal;
        bankLedger: Record "Bank Account Ledger Entry";
        bank: Code[20];
        telltreasuryTrans: Record "Treasury Transactions";
        teller: Text[50];
        postingTime: Time;
        postingDate: Date;
        testDate: Text[100];
        transDate1: Date;
        finalClosingBal: Decimal;
        cash: Decimal;
}
