/* Report 173051 "Loans Under Recovery Report"

{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Layouts/LoansUnderRecoveryReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where ("Outstanding Balance" = filter(>0)
            //, "Loans Category" = const("Perfoming")
            );
            RequestFilterFields = "Client Code", "Loan  No.", "Loan Product Type", "Employer Code", "Outstanding Balance", "Recovery Mode";
            column(Company_Logo;Company.Picture)
            {}
            column(Company_Address;Company.Address)
            {}
            column(Company_Phoneno;Company."Phone No.")
            {}
            column(Company_Add2;Company."Address 2")
            {}
            column(Company_Email;Company."E-Mail")
            {}
            column(Loan__No_;"Loan  No.")
            {}
            column(Loan_Product_Type;"Loan Product Type")
            {}
            column(Loan_Account_No;"Loan Account No")
            {}
            column(Loan_Product_Type_Name;"Loan Product Type Name")
            {}
            column(Recovery_Mode;"Recovery Mode")
            {}
            column(Outstanding_Balance;"Outstanding Balance")
            {}
            column(Outstanding_Interest;"Outstanding Interest")
            {}
            column(Client_Code;"Client Code")
            {}
            column(Client_Name;"Client Name")
            {}
            column(Loans_Category;"Loans Category")
            {}
            column(Approved_Amount;"Approved Amount")
            {}
            column(Installments;Installments)
            {}
            column(color;color)
            {}
            column(InterestPaid;InterestPaid)
            {}
            column(principalPaid;principalPaid)
            {}
            column(principalPaiddate;principalPaiddate)
            {}
            column(interestPaiddate;interestPaiddate)
            {}
            column(Loan_Disbursement_Date;"Loan Disbursement Date")
            {}
            column(days;days)
            {}
            column(monthly;monthly){}
            column(behindPayment;behindPayment)
            {}
            column(remainderInst;remainderInst)
            {}
            column(totalRepay;totalRepay)
            {}
            column(sum;sum)
            {}
            column(repayVariance;repayVariance)
            {}
            
            trigger
            OnAfterGetRecord()
            begin
                days := 0;
                sum := 0;
                i := 0;
                monthly := 0;
                installements := 0;
                totalRepay := 0;
                currBal := 0;
                behindPayment := false;
                remainderInst := 0;
                remInt:= 0;
                remPrincipal:= 0;
                currentInt:= 0;
                totalInst:= 0;
                currentPrincipal:= 0;
                pastInst := 0;
                repayVariance := 0;
                installements := "Loans Register".Installments;
                loanNo := "Loans Register"."Loan  No.";
                
                "Loans Register".CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance");
                currBal := "Loans Register"."Total Outstanding Balance";
                installements := "Loans Register".Installments;
                remainderInst := "Loans Register".Installments;
                actualInt := "Loans Register"."Outstanding Interest";
                actualPrincipal := "Loans Register"."Outstanding Balance";

                LoanRepSchedule.Reset();
                LoanRepSchedule.SetRange("Loan No.", loanNo);
                LoanRepSchedule.SetFilter("Repayment Date", '..%1', Today);
                if LoanRepSchedule.FindSet() then begin
                    currentInst:= LoanRepSchedule.Count();
                    LoanRepSchedule.CalcSums("Monthly Interest");
                    LoanRepSchedule.CalcSums("Principal Repayment");
                    currentInt := LoanRepSchedule."Monthly Interest";
                    currentPrincipal := LoanRepSchedule."Principal Repayment";
                end;

                LoanRepSchedule.Reset();
                LoanRepSchedule.SetRange("Loan No.", loanNo);
                LoanRepSchedule.SetFilter("Repayment Date", '..%1', "Loans Register"."Expected Date of Completion");
                if LoanRepSchedule.FindSet() then begin
                    totalInst:= LoanRepSchedule.Count();
                    LoanRepSchedule.CalcSums("Monthly Interest");
                    LoanRepSchedule.CalcSums("Principal Repayment");
                    totalInt := LoanRepSchedule."Monthly Interest";
                    totalPrincipal := LoanRepSchedule."Principal Repayment";
                end;

                days := totalInst - currentInst;
                
                //Message('This many months since disbursement %1 and this total expected repayment %2 a single one being %3 and a remainder of %4 installemnts.', days, sum, monthly, remainderInst);

                LoanRepSchedule.Reset();
                LoanRepSchedule.SetRange("Loan No.", loanNo);
                if LoanRepSchedule.Find('-') then begin
                    monthly := loanrepschedule."Monthly Repayment";
                    sum := totalInst*monthly;
                    i := sum;

                    for i:= sum downto currBal do begin
                        i := i - monthly;
                        remainderInst := remainderInst - 1;
                    end;
                    if remainderInst < 0 then remainderInst := 0;
                end;

                // Last repayment dates
                member:="Loans Register"."Loan  No.";
                repayment:= dCustledger."Transaction Type"::Repayment;
                principalPaid:= 0;
                dCustledger.Reset();
                dCustledger.SetRange("Loan No", member);
                dCustledger.SetRange("Transaction Type", Repayment);
                dCustledger.SetFilter("Posting Date", '..%1', Today);
                if dCustledger.FindSet() then
                begin
                    principalRepexits:= true;
                    repeat
                    principalPaid := -1 * dCustledger.Amount;
                    principalPaiddate := dCustledger."Posting Date";
                    until dCustledger.Next = 0;
                end;
                if "Loans Register"."Outstanding Balance" < "Loans Register"."Approved Amount" then begin
                    principalRepexits := true;
                    remPrincipal:= "Loans Register"."Approved Amount" - "Loans Register"."Outstanding Balance";
                end else begin
                    principalPaiddate:= 0D;
                    principalRepexits:= false;
                end;

                member:="Loans Register"."Loan  No.";
                repayment:= dCustledger."Transaction Type"::"Interest Paid";
                InterestPaid:= 0;
                dCustledger.Reset();
                dCustledger.SetRange("Loan No", member);
                dCustledger.SetRange("Transaction Type", Repayment);
                dCustledger.SetFilter("Posting Date", '..%1', Today);
                if dCustledger.FindSet() then
                begin
                    interestRepexists:= true;
                    repeat
                    InterestPaid := -1 * dCustledger.Amount;
                    interestPaiddate := dCustledger."Posting Date";
                    until dCustledger.Next = 0;
                end;
                if totalInt >= currentInt then begin
                    interestRepexists := true;
                    remInt:= currentInt - actualInt;
                end else begin
                    interestPaiddate:= 0D;
                    interestRepexists:= false;
                end;

                // if //(principalRepexits = false) or 
                // (interestRepexists = false) then
                // begin
                //     remainderInst := installements;
                // end;

                totalRepay := (remPrincipal + remInt);
                //Message('The expected monthly payment is %1, the current total principal is %2 and the current total interest is %3 and the sum of the payments is %4.', sum, totalPrincipal, totalInt, totalRepay);
                if sum<>0 then
                begin
                    // repayVariance := ((sum-totalRepay)/sum)*100;
                    repayVariance := sum-totalRepay;
                end;

                if totalRepay >= sum then begin
                    behindPayment := false;
                end
                else begin
                    behindPayment := true;
                end;
                // else
                // begin
                //     //Message('The code failed @ %1.', days);
                // end;
            end;
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin


    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);

    end;

    var
        monthly: Decimal;
        i: Decimal;
        currBal: Decimal;
        StyleExprTxt: text[500];
        BankDetails: Text[250];
        LoanCategory: Record "Loan Products Setup";
        Cust: Record Customer;
        LoansR: Record "Loans Register";
        Company: Record "Company Information";
        LoanSetup: Record "Loan Products Setup";
        vend: Record Vendor;
        color: Text[50];
        member: Code[20];
        dCustledger: Record "Detailed Cust. Ledg. Entry";
        LoanRepSchedule: Record "Loan Repayment Schedule";
        principalPaid: Decimal;
        InterestPaid: Decimal;
        interestPaiddate: Date;
        principalPaiddate: Date;
        sum: Decimal;
        loanNo: Code[20];
        days: Decimal;
        currentInt: Decimal;
        actualInt: Decimal;
        totalInt: Decimal;
        remInt: Decimal;
        currentPrincipal: Decimal;
        actualPrincipal: Decimal;
        totalPrincipal: Decimal;
        remPrincipal: Decimal;
        totalRepay: Decimal;
        behindPayment: Boolean;
        totalInst: Integer;
        currentInst: Integer;
        remainderInst: Decimal;
        installements: Decimal;
        repayVariance: Decimal;
        pastInst: Decimal;
        principalRepexits: Boolean;
        interestRepexists: Boolean;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
 */
