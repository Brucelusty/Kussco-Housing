report 50673 "Cheques on Processing Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/ChequesonProcessingReport.rdlc';
    
    dataset
    {
        dataitem("Cheque Clearing Header";"Cheque Clearing Header")
        {
            RequestFilterFields = "Date Entered", No;
            DataItemTableView = sorting(No) where(Posted = const(False));
            
            column(No;No)
            {

            }
            column(Date_Entered;"Date Entered")
            {

            }
            column(Entered_By;"Entered By")
            {

            }
            column(Expected_Date_Of_Clearing;"Expected Date Of Clearing")
            {

            }
            column(Time_Entered;"Time Entered")
            {

            }
            dataitem("Cheque Clearing Lines";"Cheque Clearing Lines")
            {
                DataItemLink = "Header No" = field("No");
                column(Account_No;"Account No")
                {

                }
                column(Account_Name;"Account Name")
                {

                }
                column(Transaction_No;"Transaction No")
                {

                }
                column(Transaction_Type;"Transaction Type")
                {

                }
                column(Amount;Amount)
                {

                }
                column(Cheque_No;"Cheque No")
                {

                }
                column(Cheque_Type;"Cheque Type")
                {}
            }

            trigger
            OnPreDataItem()
            begin

            end;
            trigger
            OnAfterGetRecord()
            begin

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

    end;
    
    var
        myInt: Integer;
        time: DateTime;
        currentTime: DateTime;
        trans: record Transactions;
}
