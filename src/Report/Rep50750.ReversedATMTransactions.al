report 50750 "Reversed ATM Transactions"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = ReversedATM;
    
    dataset
    {
        dataitem("Bank Account Ledger Entry";"Bank Account Ledger Entry")
        {
            DataItemTableView = where("Bank Account No." = filter('BNK00008'), Reversed = filter(true));
            RequestFilterFields = "Posting Date", Reversed;
            column(Posting_Date;"Posting Date")
            {}
            column(Document_No_;"Document No.")
            {}
            column(Description;Description)
            {}
            column(Amount;Amount)
            {}
            column(Account_Affected;"Account Affected")
            {}
            column(User_ID;"User ID")
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
        layout(ReversedATM)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/ReversedATMTransactions.rdlc';
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



