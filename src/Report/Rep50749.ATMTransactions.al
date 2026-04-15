report 50749 "ATM Transactions"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = ATM;
    
    dataset
    {
        dataitem("ATM Log Entries3";"ATM Log Entries3")
        {
            column(Date_;"Date Time")
            {}
            column(Time_;"Date Time")
            {}
            column(ATM_No;"ATM No")
            {}
            column(Account_No;"Account No")
            {}
            column(Account_Name;"Account Name")
            {}
            column(Withdrawal_Location;"Withdrawal Location")
            {}
            column(Connection_Mode;"Connection Mode")
            {}
            column(Amount;Amount)
            {}
            column(Transaction_Type;"Transaction Type")
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
        layout(ATM)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/ATMTransactions.rdlc';
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



