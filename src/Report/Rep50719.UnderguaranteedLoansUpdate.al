report 50719 "Underguaranteed Loans Update"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.");
            RequestFilterFields = "Loan  No.", "Loan Disbursement Date";
            column(Loan__No_; "Loan  No.")
            { }
            trigger
            OnAfterGetRecord()
            begin
                guarAmount := 0;
                outstandingBal := 0;
                outstandingInt := 0;
                loanReg.Reset();
                loanReg.SetRange("Loan  No.", "Loans Register"."Loan  No.");
                loanReg.SetRange(Posted, true);
                //loanReg.SetFilter("Approved Amount", '>%1', "Guaranteed Amount");
                if loanReg.Find('-') then begin
                    loanReg.CalcFields("Outstanding Balance");
                    outstandingBal := loanReg."Outstanding Balance";
                    loanReg.CalcFields("Outstanding Interest");
                    outstandingInt := loanReg."Outstanding Interest";
                    if (outstandingBal > 0) or (outstandingInt > 0) then begin
                        if loanType.Get(loanReg."Loan Product Type") then begin
                            if loanType."Requires Guarantors" = true then begin
                                loanReg.Underguaranteed := false;
                                loanReg.CalcFields("Guaranteed Amount");
                                guarAmount := loanReg."Guaranteed Amount";
                                if loanReg."Approved Amount" > guarAmount then begin
                                    loanReg.Underguaranteed := true;
                                    loanReg.Modify(True);
                                    //Message('The underguaranteed loan %1 has a guaranteed amount of %2 and an approved amount of %3.', loanReg."Loan  No.", loanReg."Guaranteed Amount", loanReg."Approved Amount");
                                end;
                            end else begin
                                loanReg.Underguaranteed := false;
                                loanReg.Modify(True);
                            end;
                        end;
                    end
                    else begin
                        loanReg.Underguaranteed := false;
                        loanReg.Modify(True);
                    end;
                end
                else begin
                    loanReg.Underguaranteed := false;
                    loanReg.Modify(True);
                end;
            end;
        }
    }

    var
        myInt: Integer;
        loanReg: Record "Loans Register";
        loanGuar: Record "Loans Guarantee Details";
        loanType: Record "Loan Products Setup";
        guarAmount: Decimal;
        outstandingBal: Decimal;
        outstandingInt: Decimal;
}
