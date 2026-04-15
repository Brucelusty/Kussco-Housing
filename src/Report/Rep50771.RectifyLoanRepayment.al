report 50771 "Rectify Loan Repayment"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Loan  No.";
            column(Loan__No_;"Loan  No.")
            {}
            column(Client_Code;"Client Code")
            {}
            column(Loan_Product_Type;"Loan Product Type")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Loan_Disbursement_Date;"Loan Disbursement Date")
            {}
            column(Client_Name;"Client Name")
            {}
            column(Outstanding_Balance;"Outstanding Balance")
            {}
            trigger OnAfterGetRecord() begin
                detCust.Reset();
                detCust.SetRange("Loan No", "Loans Register"."Loan  No.");
                detCust.SetRange(Reversed, false);
                detCust.SetFilter("Transaction Type", '%1|%2|%3', detCust."Transaction Type"::Repayment, detCust."Transaction Type"::"Interest Paid", detCust."Transaction Type"::"Loan Penalty Paid");
                if detCust.FindSet() then begin
                    repeat
                    if detCust."Customer No." <> "Loans Register"."Client Code" then begin
                        detCust."Customer No." := "Loans Register"."Client Code";
                        detCust.Modify;
                    end;

                    if detCust."Ledger Entry Amount" then begin
                        custLedger.Reset();
                        custLedger.SetRange("Entry No.", detCust."Cust. Ledger Entry No.");
                        if custLedger.Find('-') then begin
                            if custLedger."Customer No." <> "Loans Register"."Client Code" then begin
                                custLedger."Customer No." := "Loans Register"."Client Code";
                                custLedger.Modify();
                            end;
                        end;
                    end;
                    until detCust.Next() = 0;
                end;
            end;
        }
    }
    
    var
    myInt: Integer;
    loanNo: Code[20];
    employerCode: Code[20];
    recoveryMode: Code[20];
    vend: Record Vendor;
    loansReg: Record "Loans Register";
    loanRepay: Record "Loan Repayment Schedule";
    custLedger: Record "Cust. Ledger Entry";
    detCust: Record "Detailed Cust. Ledg. Entry";
}
