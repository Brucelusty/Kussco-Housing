report 50715 "Over-Guaranteed Members"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/Over-Guaranteed Members.rdlc';
    DefaultLayout = RDLC;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = sorting("No.") where("Over-Guaranteed" = const(true));
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Payroll_No;"Payroll No")
            {}
            column(deposits;deposits)
            {}
            column(depositMulti;depositMulti)
            {}
            column(Amount_Guaranteed;"Amount Guaranteed")
            {}
            column(Current_Ability;"Current Ability")
            {}
            column(company_Name;company.Name)
            {}
            column(company_Pic;company.Picture)
            {}
            column(company_Add;company.Address)
            {}
            column(company_Email;company."E-Mail")
            {}
            column(company_No;company."Phone No.")
            {}
            // column()
            // {}
            
            trigger
            OnAfterGetRecord()
            begin
                accType:= '102';
                deposits:= 0;
                depositMulti:= 0;
                saccoGen.Get();
                vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                vend.SetRange("Account Type", accType);
                if vend.Find('-') then
                begin
                    vend.CalcFields(Balance);
                    deposits:= vend.Balance;
                    depositMulti:= deposits * saccoGen."Guarantors Multiplier";
                end;
            end;
        }
        
    }
    
    trigger
    OnInitReport()
    begin
        company.Get();
        company.CalcFields(Picture);
    end;

    var
    myInt: Integer;
    company: Record "Company Information";
    loansReg: Record "Loans Register";
    cust: Record Customer;
    vend: Record Vendor;
    loansGuar: Record "Loans Guarantee Details";
    saccoGen: Record "Sacco General Set-Up";
    accType: Code[20];
    depositMulti: Decimal;
    deposits: Decimal;
}
