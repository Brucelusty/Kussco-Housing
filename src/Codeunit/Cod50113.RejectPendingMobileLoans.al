codeunit 50113 "Reject Pending Mobile Loans"
{
    trigger OnRun()
    begin
        RunRejectPendingMobiloans();
    end;

    procedure RunRejectPendingMobiloans()
    var
        myInt: Integer;
    begin
        checkingDate:= 0D;
        checkingDate := CalcDate('<-1D>', Today);
        loansReg.Reset();
        loansReg.SetRange("Requires Guarantors Mobile", true);
        loansReg.SetRange(Posted, false);
        loansReg.SetRange(loansReg."Approval Status", loansReg."Approval Status"::Pending);
        loansReg.SetRange("Archive Loan", false);
        loansReg.SetFilter("Application Date", '<=%1', checkingDate);
        if loansReg.FindSet() then begin
            repeat
                loansReg."Archive Loan":= true;
                loansReg."Approval Status":= loansReg."Approval Status"::Rejected;
                loansReg."Loan Status":= loansReg."Loan Status"::Rejected;
                loansReg.modify;
            until loansReg.Next()=0;
        end;
    end;
    
    var
    myInt: Integer;
    checkingDate: Date;
    cust: Record Customer;
    vend: Record Vendor;
    loansReg: Record "Loans Register";
}
