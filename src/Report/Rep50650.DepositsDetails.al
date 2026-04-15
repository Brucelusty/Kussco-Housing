report 50650 "Deposits Details"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/DepositsDetails.RDLC';
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            CalcFields = "Member Deposits";
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Registration Date";
            column(No_;"No.")
            {}
            column(Name;Name)
            {}
            column(Date_Of_Birth;"Date Of Birth")
            {}
            column(ID_No_;"ID No.")
            {}
            column(Gender;Gender)
            {}
            column(Member_Deposits;"Member Deposits")
            {}
            // column()
            // {}
            column(policy;"hr set-up"."Policy No.")
            {}
            column(scheme;"hr set-up"."Scheme Name")
            {}
            column(renewalDate;"hr set-up"."Renewal Date")
            {}
            column(company_Pic;company.Picture)
            {}
            column(company_Name;company.Name)
            {}
            column(company_Add;company.Address)
            {}
            column(company_Phone;company."Phone No.")
            {}
            column(company_Email;company."E-Mail")
            {}
            // column()
            // {}
            trigger
            OnAfterGetRecord()
            begin
                // vendLedger.Reset();
                // vendLedger.SetRange("Vendor No.", Customer."Deposits Account No");
                // vendLedger.SetRange("Posting Date", "Last Deposit Contr Date");
                // if vendLedger.FindLast() then
                // begin
                //     depContr:= (vendLedger.Amount)*(-1);
                // end
                // else
                // begin
                //     depContr:= 0;
                // end;
            end;
        }
    }
    
    var
        myInt: Integer;
        "hr set-up": Record "HR Setup";
        company: Record "Company Information";
        vendLedger: Record "Detailed Vendor Ledg. Entry";
        depContr: Decimal;

    trigger
    OnInitReport()
    begin
        "hr set-up".Get();
        company.Get();
        company.CalcFields(Picture);
    end;
}
