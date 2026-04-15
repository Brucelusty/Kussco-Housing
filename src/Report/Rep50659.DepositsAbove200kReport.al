report 50659 "Deposits Above 200k Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/DepositsAbove200k.rdlc';
    
    dataset
    {
        dataitem(Transactions;Transactions)
        {
            RequestFilterFields = "Transaction Date";
            DataItemTableView = sorting(No, "Member No") where(Posted = filter(true), "Type _Transactions" = const("Cash Deposit"), Amount = filter(>200000));
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
            column(time;time)
            {
                
            }
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
            trigger
            OnPreDataItem()
            begin

            end;
            trigger
            OnAfterGetRecord()
            begin
                time:= CreateDateTime(trans."Transaction Date", trans."Transaction Time");
            end;
            trigger
            OnPostDataItem()
            begin
                
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
        time:= CreateDateTime(Transactions."Transaction Date", Transactions."Transaction Time");
        currentTime:= CurrentDateTime;

    end;
    
    var
        myInt: Integer;
        time: DateTime;
        currentTime: DateTime;
        trans: record Transactions;
}
