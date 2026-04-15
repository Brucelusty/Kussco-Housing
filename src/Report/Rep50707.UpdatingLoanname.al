report 50707 "Updating Loan name"
{
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = const(true));
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            { }
            trigger OnAfterGetRecord()
            var
                DataItemName: record "Loans register";
                LoanType: record "Loan Products Setup";
            begin
                LoanType.Reset();
                LoanType.SetRange(LoanType.code, "Loans Register"."Loan Product Type");
                // DataItemName.SetFilter(DataItemName."Mode Of Application", '%1', DataItemName."Mode Of Application"::Mobile);
                if LoanType.FindFirst() then begin
                        "Loans Register"."Loan Product Type Name" := LoanType."Product Description";
                        "Loans Register".Modify(true);
                end;
                //   Regloans.Reset();
                //     Regloans.SetRange(Regloans."Loan Product Type",LoanType.code);
                //     Regloans.SetFilter(Regloans."Mode Of Application", '<>%1', Regloans."Mode Of Application"::Mobile);
                //     if Regloans.Find('-') then begin
                //         if Regloans."Loan Product Type Name" = '' then begin
                //             Regloans."Loan product Type Name" := loantype."Product Description";
                //             Regloans.Modify;
                //         end;
                //     end;

            end;
        }
    }




    var
        loanschedule: Record "Loan Repayment Schedule";
        Regloans: Record "Loans Register";
        LoanType: Record "Loan Products Setup";
}


