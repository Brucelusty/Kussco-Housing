codeunit 50114 "Charge Unpaid Mobile Interest"
{
    trigger OnRun()
    begin
        RunChargeUnchargedMobiLoanInt();
        // FnCorrectErroneousReversals();
    end;

    procedure RunChargeUnchargedMobiLoanInt()
    var
        myInt: Integer;
    begin
        TotalIntCharge:= 0;
        RemInt:= 0;
        loanTypeInt:= 0;
        chargedInt:= 0;
        chargedIntdate:= 0D;
        intChargedAC := '';
        chargeGL := '400-000-201';
        ptfBank := 'BNK00017';
        ptfOldBank := 'BNK00003';
        docNo := 'PTFRECON';
        batchTemplate := 'GENERAL';
        batchName := 'PTFRECON';
        lineNo := 0;

        saccoGenSetup.Get();

        refDate := 20250501D;
        refTime := 000000T;
        refDateTime := CreateDateTime(refDate, refTime);

        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", batchTemplate);
        GenJournalLine.SetRange("Journal Batch Name", batchName);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll();
        end;

        GenBatches.Reset();
        GenBatches.SetRange("Journal Template Name", batchTemplate);
        GenBatches.SetRange(Name, batchName);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init();
            GenBatches."Journal Template Name" := batchTemplate;
            GenBatches.Name := batchName;
            GenBatches.Description := 'Reconciling Journal For PayToFosa';
            GenBatches.Insert();
        end;

        ptf.Reset();
        ptf.SetFilter(TransTime, '>=%1', refDateTime);
        ptf.SetRange(MSIDN, saccoGenSetup."Co-Op PaytoFOSA");
        if ptf.FindSet() then begin
            repeat
            chargedIntdate := DT2Date(ptf.TransTime);

            if ptf.Status = ptf.Status::Posted then begin

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", ptfOldBank, chargedIntdate, (ptf.TransAmount) * -1, '', docNo, 'PAYTOFOSA Trans', '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", ptfBank, chargedIntdate, (ptf.TransAmount), '', docNo, 'PAYTOFOSA Trans', '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", ptfBank, chargedIntdate, (ptf.TransAmount) * -1, '', docNo, 'PAYTOFOSA Trans', '');

            end else begin
                if ptf.BillRefNumber = '0062563604' then begin
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", ptfOldBank, chargedIntdate, (ptf.TransAmount), '', docNo, 'PAYTOFOSA Trans', '');
                end else begin
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", chargeGL, chargedIntdate, (ptf.TransAmount), '', docNo, 'PAYTOFOSA Trans', '');

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(batchTemplate, batchName, docNo, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", ptfBank, chargedIntdate, (ptf.TransAmount) * -1, '', docNo, 'PAYTOFOSA Trans', '');
                end;
            end;
            until ptf.Next() = 0;
        end;
    end;

    procedure FnCorrectErroneousReversals()
    var
        myInt: Integer;
    begin
        // custledger.Reset();
        // custLedger.SetRange("Entry No.", custLedgerEntry);
        // if custLedger.Find('-') then begin
        //     if custLedger.Reversed = true then exit('The selected entry is correctly reversed within the respective Ledger Entry. Kindly investigate further.');

        //     if custLedger.Reversed = false then begin
        //         detCust.Reset();
        //         detCust.SetRange("Cust. Ledger Entry No.", custLedgerEntry);
        //         if detCust.Find('-') then begin
        //             detCust.Reversed := false;
        //             detCust."Reversed Cust Entry" := '';
        //             detCust."Reversal Date" := 0D;
        //             detCust.Modify();
        //         end;
        //     end;
        // end;

        detCust.Reset();
        detCust.SetRange(Reversed, true);
        if detCust.FindSet() then begin
            repeat
            custledger.Reset();
            custLedger.SetRange("Entry No.", detCust."Cust. Ledger Entry No.");
            custLedger.SetRange(Reversed, false);
            if custLedger.Find('-') then begin
                detCust.Reversed := false;
                detCust."Reversed Cust Entry" := '';
                detCust."Reversal Date" := 0D;
                detCust."Correct Reversal Date" := Today;
                detCust.Modify();
            end;
            until detCust.Next() = 0;
        end;
    end;
    
    var
    lineNo: Integer;
    totalIntcharge: Decimal;
    remInt: Decimal;
    chargedInt: Decimal;
    chargedIntdate: Date;
    refDate: Date;
    refTime: Time;
    refDateTime: DateTime;
    docNo: Code[20];
    chargeGL: Code[20];
    ptfBank: Code[20];
    ptfOldBank: Code[20];
    batchName: Code[20];
    batchTemplate: Code[20];
    loanTypeint: Decimal;
    intChargedAC: Code[20];
    AUFactory: Codeunit "Au Factory";
    SFactory: Codeunit "SURESTEP FactoryMobile";
    cust: Record Customer;
    vend: Record Vendor;
    loansReg: Record "Loans Register";
    custLedger: Record "Cust. Ledger Entry";
    detCust: Record "Detailed Cust. Ledg. Entry";
    loanProduct: Record "Loan Products Setup";
    saccoGenSetup: Record "Sacco General Set-Up";
    GenBatches: Record "Gen. Journal Batch";
    GenJournalLine: Record "Gen. Journal Line";
    ptf: Record "Paybill Transactions";
}
