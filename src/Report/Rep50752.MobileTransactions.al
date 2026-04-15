report 50752 "Mobile Transactions"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = Mobile;
    
    dataset
    {
        dataitem("Mpesa Withdawal Buffer";"Mpesa Withdawal Buffer")
        {
            RequestFilterFields = "Transaction Date", Reversed, Posted;
            column(Transaction_Date;"Transaction Date")
            {}
            column(Posted_Time;"Posted Time")
            {}
            column(Vendor_No;"Vendor No")
            {}
            column(Vendor_Name;"Vendor Name")
            {}
            column(Telephone_No;"Telephone No")
            {}
            column(Amount_Requested;"Amount Requested")
            {}
            column(Reversed;Reversed)
            {}
            column(Originator_ID;"Originator ID")
            {}
            column(Trace;Trace)
            {}
            column(Posted;Posted)
            {}
            // column()
            // {}
            column(company_Pic;company.Picture)
            {}
            column(company_Name;company.Name)
            {}
            column(company_Address;company.Address)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Email;company."E-Mail")
            {}
        }
    }
    
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(asAt;asAt)
                    {
                    ApplicationArea = All;
                        
                    }
                }
            }
        }
    }
    
    rendering
    {
        layout(Mobile)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/MobileTransactions.rdlc';
        }
    }

    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);
        saccoGen.Get();
    end;
    
    var
    myInt: Integer;
    asAt: Date;
    company: Record "Company Information";
    saccoGen: Record "Sacco General Set-Up";
    atmEntries: Record "ATM Log Entries3";
    bank: Record "Bank Account";
    bankLedger: Record "Bank Account Ledger Entry";
}



