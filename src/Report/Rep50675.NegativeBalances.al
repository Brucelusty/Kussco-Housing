report 50675 NegativeBalances
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\NegativeBalances.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance" = FILTER(< 0));
            RequestFilterFields = "Loan Product Type", "Loans Category", "Loan Status";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Loan__No_; "Loan  No.")
            {
            }
            column(Client_Name; "Client Name")
            {

            }
            column(Loan_Product_Type; "Loan Product Type")
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            // column(Loan_Product_Type_Name;Loanpro."Product Description")
            // {
            // }
            column(Client_Code; "Client Code")
            {
            }
            column(Loans_Category; "Loans Category")
            {
            }
            column(Outstanding_Balance; "Outstanding Balance")
            {
            }
            column(Loan_Status; "Loan Status")
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            var
                Memb: Record Customer;
            begin
                LoanReg.Reset();
                LoanReg.SetRange(LoanReg."Loan  No.", "Loans Register"."Loan  No.");
                LoanReg.SetRange(LoanReg."Client Code", Memb."No.");

                if LoanReg."Outstanding Balance" < 0 then begin
                    LoanReg.SetFilter(LoanReg."Outstanding Balance", '< 0');
                    "Outstanding Balance" := LoanReg."Outstanding Balance";
                end;
                LoanPro.Reset();
                LoanPro.SetRange(LoanPro.Code, LoanReg."Loan Product Type");
                if LoanPro.Find('-') then begin
                    repeat
                        "Loan Product Type" := Loanpro."Product Description";
                    until Loanpro.next() = 0;
                end;
            end;

            trigger OnPreDataItem()
            var
                DateFilter: Text[30];
            begin
                if CurrentDate = 0D then
                    CurrentDate := Today;
                DateFilter := '..' + format(CurrentDate);
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
                    field(CurrentDate; CurrentDate)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CurrentDate: date;
        CompanyInfo: Record "Company Information";
        LoanReg: Record "Loans Register";
        Loanpro: Record "Loan Products Setup";

}



