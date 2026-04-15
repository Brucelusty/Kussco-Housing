report 50741 "Matured Exit Notices"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = MaturedNotices;
    
    dataset
    {
        dataitem("Withdrawal Notice";"Withdrawal Notice")
        {
            RequestFilterFields = "Maturity Date";
            // DataItemTableView = where("Maturity Date" = filter(<>Today))
            column(Member_No;"Member No")
            {}
            column(Name;Name)
            {}
            column(Notice_Date;"Notice Date")
            {}
            column(Maturity_Date;"Maturity Date")
            {}
            column(deposits;deposits)
            {}
            column(ESSShares;ESSShares)
            {}
            column(withdrawalFee;withdrawalFee)
            {}
            column(totalLoans;totalLoans)
            {}
            column(currentLiability;currentLiability)
            {}
            column(totalRefund;totalRefund)
            {}
            // column()
            // {}
            column(company_Pic; company.Picture)
            { }
            column(company_Name; company.Name)
            { }
            column(company_Address; company.Address)
            { }
            column(company_Phone; company."Phone No.")
            { }
            column(company_Email; company."E-Mail")
            { }
            column(company_Motto; company.Motto)
            { }
            trigger OnAfterGetRecord() begin
                deposits:= 0;
                ESSShares:= 0;
                totalRefund:= 0;
                totalLoans:= 0;
                currentLiability:= 0;
                totalCredit:= 0;
                totalDebit:= 0;

                cust.Reset();
                cust.SetRange("No.", "Withdrawal Notice"."Member No");
                if cust.Find('-') then begin
                    cust.CalcFields("Current Shares", "School Fees Shares", "Total Loan Balance");
                    deposits:= cust."Current Shares";
                    ESSShares:= cust."School Fees Shares";
                    totalLoans:= cust."Total Loan Balance";

                    loansGuar.Reset();
                    loansGuar.SetRange("Member No", cust."No.");
                    loansGuar.SetRange(Substituted, false);
                    if loansGuar.Find('-') then begin
                        repeat
                            loansReg.Reset();
                            loansReg.SetRange("Loan  No.", loansGuar."Loan No");
                            loansReg.SetFilter("Outstanding Balance", '>%1',0);
                            if loansReg.Find('-') then begin
                                loansReg.CalcFields("Outstanding Balance");
                                currentLiability := currentLiability + Round(((loansReg."Outstanding Balance"/loansReg."Approved Amount")*loansGuar."Amont Guaranteed"), 0.01, '=');                            end;
                        until loansGuar.Next() = 0;
                    end;

                    if "Withdrawal Notice"."Withdrawal Type" = "Withdrawal Notice"."Withdrawal Type"::Death then begin
                        deposits:= deposits * 2;
                    end;
                    
                    totalCredit:= deposits + ESSShares;
                    totalDebit:= withdrawalFee + totalLoans + currentLiability;
                    totalRefund:= totalCredit - totalDebit;
                end;
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    
        actions
        {
            
        }
    }
    
    rendering
    {
        layout(MaturedNotices)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/MaturedNotices.rdlc';
        }
    }
    trigger OnInitReport() begin
        company.Get();
        company.CalcFields(Picture);

        withdrawalFee:= 0;
        saccoGen.Get();
        withdrawalFee:= saccoGen."Withdrawal Fee";
    end;
    
    var
    myInt: Integer;
    totalCredit: Decimal;
    totalDebit: Decimal;
    withdrawalFee: Decimal;
    currentLiability: Decimal;
    totalLoans: Decimal;
    totalRefund: Decimal;
    deposits: Decimal;
    ESSShares: Decimal;
    company: Record "Company Information";
    saccoGen: Record "Sacco General Set-Up";
    cust: Record Customer;
    vend: Record Vendor;
    loansReg: Record "Loans Register";
    loansGuar: Record "Loans Guarantee Details";
}
