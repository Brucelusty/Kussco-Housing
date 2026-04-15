report 50726 "Update Wrongly Posted Loans"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Batch No.";
            column(Batch_No_;"Batch No.")
            {}
            trigger OnAfterGetRecord() begin
                loansReg.Reset();
                loansReg.SetRange("Batch No.", "Loans Register"."Batch No.");
                if loansReg.Find('-') then begin
                    loansReg."Loan Status":= loansReg."Loan Status"::Approved;
                    loansReg."Issued Date":= 0D;
                    loansReg."Disbursed By":= '';
                    loansReg."Disbursed By Date":= 0D;
                    loansReg."Disbursed By Time":= 0T;
                    loansReg."Disbursed Time":= 0T;
                    loansReg."Offset Eligibility Amount":= 0;
                    loansReg."Posting Date":= 0D;
                    loansReg."Disbursed By":= '';
                    loansReg."Loan Disbursement Date":= 0D;
                    loansReg.Posted:= false;
                    loansReg.Modify;
                    
                    loanBatch.Reset();
                    loanBatch.SetRange("Batch No.", "Loans Register"."Batch No.");
                    if loanBatch.Find('-') then begin
                        loanBatch."Posted By":= '';
                        loanBatch."Posting Date":= 0D;
                        loanBatch.Posted:= false;
                        loanBatch.Modify;
                    end;
                end;
            end;
        }
    }
    
    var
    myInt: Integer;
    loansReg: Record "Loans Register";
    loanBatch: Record "Loan Disburesment-Batching";
}
