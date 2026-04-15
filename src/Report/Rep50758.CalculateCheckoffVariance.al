report 50758 "Calculate Checkoff Variance"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem("Checkoff Lines-Distributed-NT";"Checkoff Lines-Distributed-NT")
        {
            RequestFilterFields = "Checkoff No";
            column("Checkoff_No";"Checkoff No")
            {}
            trigger OnPreDataItem() begin
                varianceBuffer.Reset();
                varianceBuffer.SetRange("Document No", "Checkoff Lines-Distributed-NT"."Checkoff No");
                if varianceBuffer.FindSet() then begin
                    varianceBuffer.DeleteAll();
                end;
                
                entryNo := 1;
            end;

            trigger OnAfterGetRecord() begin
                essContr:= 0;
                depContr:= 0;
                bbf:= 300;
                expectedContr:= 0;
                expectedLoanDed:= 0;
                expectedDed:= 0;
                actualDed:= 0;
                paymentVar:= 0;

                checkoffNo := "Checkoff Lines-Distributed-NT"."Checkoff No";

                checkoffHeader.Reset();
                checkoffHeader.SetRange(No, "Checkoff Lines-Distributed-NT"."Checkoff No");
                if checkoffHeader.Find('-') then begin
                    loanCutoff := checkoffHeader."Loan CutOff Date";
                    loanRepayDate := CalcDate('<CM>', loanCutoff);
                end;

                cust.Reset();
                cust.SetRange("No.", "Checkoff Lines-Distributed-NT"."Member No");
                if cust.Find('-') then begin
                    essContr := cust."ESS Contribution";
                    depContr := cust."Monthly Contribution";
                    expectedContr := cust."Monthly Contribution" + cust."ESS Contribution" + bbf;
                end;

                loansReg.Reset();
                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                loansReg.SetRange("Client Code", "Checkoff Lines-Distributed-NT"."Member No");
                loansReg.SetFilter("Loan Disbursement Date", '<%1', loanCutoff);
                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                if loansReg.FindSet() then begin
                    repeat
                    loanRepay.Reset();
                    loanRepay.SetRange("Loan No.", loansReg."Loan  No.");
                    loanRepay.SetRange("Repayment Date", loanRepayDate);
                    if loanRepay.Find('-') then begin
                        expectedLoanDed := expectedLoanDed + loanRepay."Monthly Repayment";
                    end;
                    until loansReg.Next()=0;
                end;

                expectedDed := expectedLoanDed + expectedContr;

                actualDed := "Checkoff Lines-Distributed-NT".Amount;
                
                paymentVar := expectedDed - actualDed;

                varianceBuffer.Init;
                varianceBuffer."Entry No" := entryNo;
                varianceBuffer."Member No" := "Checkoff Lines-Distributed-NT"."Member No";
                varianceBuffer.Validate("Member No");
                varianceBuffer."Member Salary" := "Checkoff Lines-Distributed-NT".Amount;
                varianceBuffer."Expected Deduction" := expectedDed;
                varianceBuffer."Actual Deduction" := actualDed;
                varianceBuffer.Variance := paymentVar;
                varianceBuffer.Month := Date2DMY(loanCutoff, 2);
                varianceBuffer.Year := Date2DMY(loanCutoff, 3);
                varianceBuffer."Document No" := "Checkoff Lines-Distributed-NT"."Checkoff No";
                if not varianceBuffer.Insert then varianceBuffer.Modify;

                entryNo := entryNo + 1;
            end;
            trigger OnPostDataItem() begin
                varianceBuffer.Reset();
                varianceBuffer.SetRange("Document No", checkoffNo);
                if varianceBuffer.FindSet() then begin
                    Report.Run(175108, false, true, varianceBuffer);
                end;
            end;
        }
    }
    
    var
    myInt: Integer;
    entryNo: Integer;
    bbf: Decimal;
    essContr: Decimal;
    depContr: Decimal;
    expectedContr: Decimal;
    actualContr: Decimal;
    expectedLoanDed: Decimal;
    actualLoanDed: Decimal;
    expectedDed: Decimal;
    actualDed: Decimal;
    paymentVar: Decimal;
    loanCutoff: Date;
    loanRepayDate: Date;
    checkoffNo: Code[20];
    varianceBuffer: Record "Member Salary Variance Buffer";
    checkoffHeader: Record "Checkoff Header-Distributed";
    checkoffLines: Record "Checkoff Lines-Distributed-NT";
    cust: Record Customer;
    vend: Record Vendor;
    loansReg: Record "Loans Register";
    loanRepay: Record "Loan Repayment Schedule";
    stos: Record "Standing Orders";
}
