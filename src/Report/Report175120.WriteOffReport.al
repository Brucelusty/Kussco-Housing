report 50778 "Write Off"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(WriteOff = filter(true));
            column(Loan__No_; "Loan  No.")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Staff_No; "Staff No")
            {

            }
            column(Client_Code; "Client Code")
            {

            }
            column(Write_Off_Amount; "Write Off Amount")
            {

            }
            column(Client_Name; "Client Name")
            {

            }
            column(Outstanding_Balance; "Outstanding Balance")
            {

            }
            column(Outstanding_Interest; "Outstanding Interest")
            {

            }
            column(Requested_Amount; "Requested Amount")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Debt_Collector_Name; "Debt Collector Name")
            {

            }
            column(Amount_Paid; Amt)
            {

            }
            column(company_Name; company.Name)
            { }
            column(company_Pic; company.Picture)
            { }
            column(company_Address; company.Address)
            { }
            column(company_Phone; company."Phone No.")
            { }
            column(company_Email; company."E-Mail")
            { }
            column(company_Motto; company.Motto)
            { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                detailedCust.Reset();
                detailedCust.SetFilter("Posting Date", '%1..%2', CALCDATE('<-CM>', TODAY), TODAY);
                detailedCust.SetRange("Loan No", "Loan  No.");
                detailedCust.SetRange("Customer No.", "Client Code");
                detailedCust.SetRange(detailedCust."Transaction Type", detailedCust."Transaction Type"::Repayment);
                detailedCust.SetRange(Reversed, false);
                if detailedCust.FindSet() then begin
                    repeat
                        Amt += detailedCust.Amount;
                    until detailedCust.Next() = 0;
                end;

                // if amt <= 0 then
                //     CurrReport.Skip();

            end;

        }

    }


    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/writeoff.rdlc';
        }
    }
    trigger OnInitReport()
    begin
        company.Get();
        company.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        detailedCust: Record "Detailed Cust. Ledg. Entry";
        Amt: Decimal;
        company: Record "Company Information";
}


