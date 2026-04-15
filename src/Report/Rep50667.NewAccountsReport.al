report 50667 "New Accounts Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/NewAccountsReport.rdlc';
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Registration Date", "Account Type";
            column(No_;"No.")
            {
                
            }
            column(Transaction_Date;"Registration Date")
            {}
            column(Status;Status)
            {}
            column(Account_Type_Name;"Account Type Name")
            {}
            column(Balance;Balance)
            {}
            column(Payment_Method_Code;"Payment Method Code")
            {}
            column(Member_Registration_Fee_Receiv;"Member Registration Fee Receiv")
            {}
            column(lastTransactDate;lastTransactDate)
            {}
            trigger
            OnAfterGetRecord()
            begin
                VendorLedgerEntry.Reset();
                vendorLedgerEntry.SetRange("Vendor No.", VendorNo);
                vendorLedgerEntry.SetRange("Posting Date", 0D, Today);
                if vendorLedgerEntry.FindFirst() then
                begin
                    LastPostedDate := vendorLedgerEntry."Posting Date";
                    lastTransactDate:=LastPostedDate;
                end;
            end;
        }
    }
    
    requestpage
    {
        // layout
        // {
        //     area(Content)
        //     {
        //         group(GroupName)
        //         {
        //             field(Name; SourceExpression)
        //             {
                        
        //             }
        //         }
        //     }
        // }
    
        // actions
        // {
        //     area(processing)
        //     {
        //         action(ActionName)
        //         {
                    
        //         }
        //     }
        // }
    }
    
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
        deposits: Decimal;
        savings: Decimal;
        lastTransactDate: Date;
        vend: Record Vendor;
        LastPostedDate: Date;
        VendorNo: Code[20];
        VendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
}


