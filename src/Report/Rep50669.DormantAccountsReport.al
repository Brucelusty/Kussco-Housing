report 50669 "Dormant Accounts Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/DormantAccountsReport.rdlc';
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.") where (status = const(Dormant));
            RequestFilterFields = "BOSA Account No","Account Type"
            //, "Sales Person"
            ;
            column(No_;"No.")
            {
                
            }
            column(BOSA_Account_No;"BOSA Account No")
            {}
            column(Status;Status)
            {}
            column(Account_Type_Name;"Account Type Name")
            {}
            column(Balance;Balance)
            {}
            column(lastTransactDate;lastTransactDate)
            {}
            column(Postal_Code;"Postal Code")
            {}
            column(Address;Address)
            {}
            column(Mobile_Phone_No_;"Mobile Phone No.")
            {}
            // column(Relationship_Manager;"Relationship Manager")
            // {}
            dataitem(Customer;Customer)
            {
                DataItemLink = "No." = field("BOSA Account No");
                RequestFilterFields = "Salesperson Code";
                column(Salesperson_Code;"Salesperson Code")
                {}
                column(Customer_Service_Rep_;"Customer Service Rep.")
                {}
            }
            trigger
            OnAfterGetRecord()
            begin
                VendorLedgerEntry.Reset();
                vendorLedgerEntry.SetRange("Vendor No.", VendorNo);
                vendorLedgerEntry.SetRange("Posting Date", 0D, Today);
                if vendorLedgerEntry.FindFirst()then
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
        lastTransactDate: Date;
        vend: Record Vendor;
        LastPostedDate: Date;
        VendorNo: Code[20];
        VendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
}


