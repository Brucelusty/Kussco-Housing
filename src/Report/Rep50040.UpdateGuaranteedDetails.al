report 50040 "Update Guaranteed Details"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // DefaultLayout = RDLC;
    // RDLCLayout = 'Layouts\UpdateGuaranteedStatus.rdlc';
    ProcessingOnly = true;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
//            RequestFilterFields = "No.";
            column(No_;"No.")
            {
                
            }
            trigger
            OnAfterGetRecord()
            begin
                cust.Reset();
                cust.SetRange("No.", Customer."No.");
                if cust.FindSet() then
                begin
                    repeat
                        AmountCommitted := 0;
                        Ability:= 0;
                        currentAbility:= 0;
                        loanGuar.Reset();
                        loanGuar.SetRange("Member No", Customer."No.");
                        loanGuar.SetRange(Substituted, false);
                        if loanGuar.findfirst then begin
                            repeat
                                LoanApp.reset;
                                LoanApp.setrange(LoanApp."Loan  No.", loanGuar."Loan No");
                                LoanApp.setautocalcfields(LoanApp."Outstanding Balance");
                                LoanApp.setfilter(LoanApp."Outstanding Balance", '>%1', 0);
                                if LoanApp.findfirst then begin
                                    AmountCommitted := loanGuar."Amont Guaranteed" + AmountCommitted;
                                    if loanApp."Approved Amount" > 0 then
                                    begin
                                        Ability:= Round(((loanApp."Outstanding Balance" / loanApp."Approved Amount") * loanGuar."Amont Guaranteed"), 0.01, '=');
                                        currentAbility:= Ability + currentAbility;
                                    end
                                    else
                                    begin
                                        currentAbility:= 0;
                                    end;
                                end;
                            until loanGuar.next = 0;

                            memberDep:= 0;
                            vend.Reset();
                            vend.SetRange("BOSA Account No", Customer."No.");
                            vend.SetRange("Account Type", '102');
                            if vend.Find('-') then
                            begin
                                vend.CalcFields(Balance);
                                memberDep:= vend.Balance;
                            end;
                            MaximumAmountToCommit := 0;
                            SaccoSetup.get();
                            MaximumAmountToCommit := memberDep * SaccoSetup."Guarantors Multiplier";
                            if currentAbility > MaximumAmountToCommit then begin
                                cust."Over-Guaranteed":= true;
                                cust."Amount Guaranteed":= AmountCommitted;
                                cust."Current Ability":= currentAbility;
                                cust.Modify(true);
                            end else begin
                                cust."Over-Guaranteed":= false;
                                cust."Amount Guaranteed":= AmountCommitted;
                                cust."Current Ability":= currentAbility;
                                cust.Modify(true);
                            end;
                        end
                        else
                        begin
                            AmountCommitted:= 0;
                            currentAbility:= 0;
                            cust."Amount Guaranteed":= AmountCommitted;
                            cust."Current Ability":= currentAbility;
                            cust.Modify(true);
                        end;
                    until cust.Next() = 0;
                end;
            end;
        }
    }
    
    var
    myInt: Integer;
    loanGuar: Record "Loans Guarantee Details";
    cust: Record Customer;
    loanApp: Record "Loans Register";
    SaccoSetup: Record "Sacco General Set-Up";
    vend: Record Vendor;
    AmountCommitted: Decimal;
    MaximumAmountToCommit: Decimal;
    BalanceToCommit: Decimal;
    memberDep: Decimal;
    Ability: Decimal;
    currentAbility: Decimal;
}
