codeunit 50116 "Recover Default Mobile Advance"
{
    trigger OnRun()
    begin
        
    end;

    procedure FnRecoverMobiAdvance(member: Code[20])
    var
        myInt: Integer;
    begin
        genTemplate:= 'PAYMENTS';
        genBatch:= 'A03RECOV';

        generalJournal.Reset();
        generalJournal.SetRange("Journal Template Name", genTemplate);
        generalJournal.SetRange("Journal Batch Name", genBatch);
        if generalJournal.FindSet() then begin
            generalJournal.DeleteAll();
        end;

        generalBatch.Reset();
        generalBatch.SetRange("Journal Template Name", genTemplate);
        generalBatch.SetRange(Name, genBatch);
        if generalBatch.Find('-') = false then begin
            generalBatch.Init();
            generalBatch."Journal Template Name":= genTemplate;
            generalBatch.Name:= genBatch;
            generalBatch.Description:= 'Recover Defaulted A03 Loans From FOSA';
            generalBatch.Insert();
        end;
        
        loanNo := '';
        accountBal := 0;
        docNo := '';
        lineNo := 0;
        defaultAmount := 0;
        recoveredAmount := 0;
        loansReg.Reset();
        loansReg.SetRange("Client Code", member);
        loansReg.SetRange("Loan Product Type", 'A03');
        loansReg.SetAutoCalcFields("Total Outstanding Balance");
        loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
        loansReg.SetFilter("Expected Date of Completion", '<%1', Today);
        if loansReg.Find('-') then begin
            loansReg.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");

            loanNo := loansReg."Loan  No.";
            docNo := loanNo;
            defaultAmount := loansReg."Total Outstanding Balance";

            vend.Reset();
            vend.SetRange("BOSA Account No", member);
            vend.SetRange("Account Type", '103');
            if vend.Find('-') then begin
                accountBal := vend.GetAvailableBalance();

                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::" ",
                generalJournal."Account Type"::Vendor, vend."No.", Today, defaultAmount, 'BOSA', member, 'Defaulted A03 '+loanNo+' Recovery',
                loanNo, generalJournal."Application Source"::" ");

                if loansReg."Outstanding Penalty" > accountBal then begin
                    recoveredAmount := accountBal
                end else recoveredAmount := loansReg."Outstanding Penalty";
                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::"Loan Penalty Paid",
                generalJournal."Account Type"::Customer, member, Today, (recoveredAmount*-1), 'BOSA', member, loanNo+'-Penalty Recovery',
                loanNo, generalJournal."Application Source"::" ");
                accountBal := accountBal - recoveredAmount;

                if loansReg."Outstanding Interest" > accountBal then begin
                    recoveredAmount := accountBal;
                end else recoveredAmount := loansReg."Outstanding Interest";
                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::"Interest Paid",
                generalJournal."Account Type"::Customer, member, Today, (recoveredAmount*-1), 'BOSA', member, loanNo+'-Interest Recovery',
                loanNo, generalJournal."Application Source"::" ");
                accountBal := accountBal - recoveredAmount;

                if loansReg."Outstanding Balance" > accountBal then begin
                    recoveredAmount := accountBal;
                end else recoveredAmount := loansReg."Outstanding Balance";
                lineNo := lineNo + 1000;
                AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::Repayment,
                generalJournal."Account Type"::Customer, member, Today, (recoveredAmount*-1), 'BOSA', member, loanNo+'-Principal Recovery',
                loanNo, generalJournal."Application Source"::" ");

                // generalJournal.Reset();
                // generalJournal.SetRange("Journal Batch Name", genBatch);
                // generalJournal.SetRange("Journal Template Name", genTemplate);
                // if generalJournal.Find('-') then begin
                //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", generalJournal);
                // end;
            end;
        end;
    end;
    
    var
    myInt: Integer;
    lineNo: Integer;
    loanNo: Code[20];
    genBatch: Code[20];
    genTemplate: Code[20];
    docNo: Code[20];
    refDate: date;
    defaultAmount: Decimal;
    accountBal: Decimal;
    recoveredAmount: Decimal;
    AUFactory: Codeunit "Au Factory";
    cust: Record Customer;
    vend: Record Vendor;
    loansReg: Record "Loans Register";
    detailedVend: Record "Detailed Vendor Ledg. Entry";
    generalBatch: Record "Gen. Journal Batch";
    generalJournal: Record "Gen. Journal Line";
}
