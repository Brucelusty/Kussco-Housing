report 50652 "Accounts Listing"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/Accounts Listing.RDLC';
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Account Type", Gender, "Employer Code";
            column(No_;"No.")
            {
                
            }
            column(BOSA_Account_No;"BOSA Account No")
            {
                
            }
            column(Account_Type_Name;"Account Type Name")
            {
                
            }
            column(Balance;Balance)
            {
                
            }
            column(Registration_Fee;"Registration Fee")
            {
                
            }
            column(Status;Status)
            {
                
            }
            column(lastTransactDate;lastTransactDate)
            {
                
            }
            column(Address;Address)
            {

            }
            column(Phone_No_;"Phone No.")
            {}
            // column(Sales_Person;"Sales Person")
            // {}
            // column(Relationship_Manager;"Relationship Manager")
            // {}
            column(contrFreq;contrFreq)
            {}
            column(Member_Type;"Member Type")
            {}
            column(Monthly_Contribution;"Monthly Contribution")
            {}
            column(Name;Name)
            {}
            dataitem(Customer;Customer)
            {
                DataItemLink = "No." = field("BOSA Account No");
                column(Salesperson_Code;"Salesperson Code")
                {}
                column(Customer_Service_Rep_;"Customer Service Rep.")
                {}
            }
            trigger
            OnAfterGetRecord()
            begin
                VendorNo := "No.";
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
    
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
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
    
    var
        myInt: Integer;
        currentDate: DateTime;
        salesPerson: Label 'Sales Person: ';
        contributionFreq: Integer;
        contrFreq: Integer;
        vend: Record Vendor;
        lastTransactDate: Date;
        LastPostedDate: Date;
        VendorNo: Code[20];
        VendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
    trigger
    OnInitReport()
    begin
        currentDate:= CurrentDateTime;
    end;
}
