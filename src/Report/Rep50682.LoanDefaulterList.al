report 50682 "Loan Defaulter List"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts\LoanDefaulterList.rdlc';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = WHERE("Loans Category" = filter(Watch | Substandard | Loss | Doubtful));
            RequestFilterFields = "Loans Category", "Loan Product Type", "client code", "Loan  No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Loan__No_; "Loan  No.")
            { }
            column(Client_Code; "Client Code")
            { }
            column(Client_Name; "Client Name")
            { }
            column(Loan_Product_Type; "Loan Product Type")
            { }
            column(Loan_Product_Type_Name; "Loans Register"."Loan Product Type Name")
            {
            }
            column(Loans_Category; "Loans Category")
            { }
            column(Loan_Status; "Loan Status")
            { }
            column(Requested_Amount; "Requested Amount")
            { }
            column(Interest; Interest)
            { }
            column(Approved_Amount; "Approved Amount")
            { }
            column(Installments; Installments)
            { }
            column(Outstanding_Balance; "Outstanding Balance")
            { }
            column(companyPicture; CompanyInfo.Picture)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(CompanyAddress2; CompanyInfo."Address 2")
            { }
            column(CompanyAddress; CompanyInfo.Address)
            { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            { }
            column(CompanyEmail; CompanyInfo."E-Mail")
            { }
            column(Loan_Disbursement_Date; "Loan Disbursement Date")
            { }
            column(loanname; loanname)
            { }
            // trigger OnAfterGetRecord()
            // var
            //    Loanpro: Record "Loan Products Setup";
            // begin
            //       LoanPro.Reset();
            //         LoanPro.SetRange(LoanPro.Code, loanreg."Loan Product Type");
            //         if LoanPro.FindSet() then 
            //         begin
            //            loanreg."Loan Product Type Name" := Loanpro."Product Description";
            //         end;
            // end;


            trigger OnPreDataItem();
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);


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
    var
        CompanyInfo: Record "Company Information";
        CurrentDate: Date;
        DateFilter: Text[30];
        loanssetup: Record "Loan Products Setup";
        loanreg: record "Loans Register";
        loanname: text[50];

}



