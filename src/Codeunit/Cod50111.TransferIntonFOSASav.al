codeunit 50111 "Transfer Int on FOSA Sav"
{
    trigger OnRun()
    begin

    end;

    procedure transferIntonFOSA(startDate: Date; endDate: Date) success: Boolean
    begin
        batchTemplate:= '';
        batchName:= '';
        docNo:= '';
        intAcc:= '';
        lineNo:= 0;
        totalInterest:= 0;

        saccoGenSetup.Get();
        intAcc:= saccoGenSetup."Interest on FOSA A/C";
        
        batchTemplate := 'PAYMENTS';
        batchName := 'FOSAINT';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", batchTemplate);
        GenJournalLine.SetRange("Journal Batch Name", batchName);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll;
        end;

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", batchTemplate);
        GenBatches.SetRange(GenBatches.Name, batchName);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := batchTemplate;
            GenBatches.Name := batchName;
            GenBatches.Description := 'Interest on Savings Transfer';
            GenBatches.Insert;
        end;

        intOnSavMain.Reset();
        intOnSavMain.SetRange("Start Date", startDate);
        intOnSavMain.SetRange("End Date", endDate);
        intOnSavMain.SetRange(Posted, false);
        if intOnSavMain.Find('-') then begin
            docNo:= 'FOSAINT-'+Format(intOnSavMain.Period);
            intOnSavMain.CalcSums("Gross Interest");
            totalInterest:= intOnSavMain."Gross Interest";

            //--------------------------------------------------Credit FOSA Interest A/C---------------------------------
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::"G/L Account", intAcc, endDate, totalInterest*-1, 'FOSA', '',
            'Interest of FOSA Savings '+Format(intOnSavMain.Period), '', GenJournalLine."Application Source"::" ");
            
            intOnSav.Reset();
            intOnSav.SetRange("Start Date", startDate);
            intOnSav.SetRange("End Date", endDate);
            intOnSav.SetRange(Posted, false);
            if intOnSav.Find('-') then begin
                repeat
                    //--------------------------------------------------Debit FOSA Interest A/C---------------------------------
                    lineNo := lineNo + 10000;
                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", intAcc, endDate, intOnSav."Gross Interest", 'FOSA', '',
                    'Interest of FOSA Savings '+Format(intOnSav.Period), '', GenJournalLine."Application Source"::" ");
                    //--------------------------------------------------Credit Interest to FOSA A/C---------------------------------
                    lineNo := lineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, intOnSav."FOSA Account", endDate, (intOnSav."Gross Interest")*-1, 'FOSA', 
                    'Interest on '+intOnSav."Account Type Name"+' '+Format(intOnSav.Period), '');

                    intOnSav.Posted := true;
                    intOnSav.Modify;
                until intOnSav.Next()=0;
            end;

            //--------------------------------------------------Debit FOSA Interest A/C---------------------------------
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::"G/L Account", intAcc, endDate, totalInterest, 'FOSA', '',
            'Interest of FOSA Savings '+Format(intOnSavMain.Period), '', GenJournalLine."Application Source"::" ");
            
            success := true;
        end else success := false;
    end;

    var
        lineNo: Integer;
        accountBal: Decimal;
        currentLiability: Decimal;
        payment: Decimal;
        remainder: Decimal;
        deathDep: Decimal;
        withAmount: Decimal;
        monthlyInterest: Decimal;
        totalInterest: Decimal;
        intAcc: Code[20];
        ESSAccount: Code[20];
        withAccount: Code[20];
        docNo: Code[30];
        batchName: Code[20];
        batchTemplate: Code[20];
        loanNo: Code[20];
        FEAccount: Code[20];
        AUFactory: Codeunit "Au Factory";
        intOnSav: Record "Interest On Savings Prog";
        intOnSavMain: Record "Interest On Savings Prog";
        accType: Record "Account Types-Saving Products";
        saccoGenSetup: Record "Sacco General Set-Up";
        GenBatches: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
}
