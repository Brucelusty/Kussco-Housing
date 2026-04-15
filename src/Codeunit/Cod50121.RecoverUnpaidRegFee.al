codeunit 50121 "Recover Unpaid Reg Fee"
{
    trigger OnRun()
    begin
        FnRecoverUnpaidRegistrationFee();
    end;

    procedure FnRecoverUnpaidRegistrationFee()
    var
        myInt: Integer;
    begin
        LineNo := 0;
        deficitmount := 0;
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'REGFEEREM';
        DOCUMENT_NO := '';

        GenBatches.Reset();
        GenBatches.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenBatches.SetRange(Name, BATCH_NAME);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init();
            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
            GenBatches.Name := BATCH_NAME;
            GenBatches.Description := 'Unpaid Member Registration Fees';
            GenBatches.Insert();
        end;

        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll();
        end;

        postingDate := 0D;
        saccoGen.Get();
        saccoGen.TestField("Registration Fee", 1000);
        cust.Reset();
        cust.SetRange(ISNormalMember, true);
        cust.SetFilter("Current Shares", '>%1', 0);
        if cust.Find('-') then begin
            repeat
            postingDate := CalcDate('<-CY-1D>', Today);

            cust.CalcFields("Current Shares", "Registration Fee Paid");
            if cust."Registration Fee Paid" < saccoGen."Registration Fee" then begin
                deficitmount := saccoGen."Registration Fee" - cust."Registration Fee Paid";
                DOCUMENT_NO := cust."No."+'-REGFEE';
                if cust."Current Shares" > deficitmount then begin
                    LineNo += 10000;
                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                    cust."Deposits Account No", postingDate, deficitmount, 'BOSA', 'BOSA', cust."No."+'Unpaid Registration Fee Recovery', '', GenJournalLine."Application Source"::CBS);
                    LineNo += 10000;
                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Registration Fee", GenJournalLine."Account Type"::Customer,
                    cust."No.", postingDate, deficitmount*-1, 'BOSA', 'BOSA', cust."No."+'Unpaid Registration Fee Recovery', '', GenJournalLine."Application Source"::CBS);
                end else begin
                    LineNo += 10000;
                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                    cust."Deposits Account No", postingDate, (cust."Current Shares"), 'BOSA', 'BOSA', cust."No."+'Unpaid Registration Fee Recovery', '', GenJournalLine."Application Source"::CBS);
                    LineNo += 10000;
                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Registration Fee", GenJournalLine."Account Type"::Customer,
                    cust."No.", postingDate, (cust."Current Shares")*-1, 'BOSA', 'BOSA', cust."No."+'Unpaid Registration Fee Recovery', '', GenJournalLine."Application Source"::CBS);
                end;
            end;
            until cust.Next() = 0;
        end;
    end;
    
    var
    myInt: Integer;
    LineNo: Integer;
    deficitmount: Decimal;
    BATCH_TEMPLATE: Code[60];
    BATCH_NAME: Code[80];
    DOCUMENT_NO: Code[40];
    postingDate: Date;
    AUFactory: Codeunit "Au Factory";
    saccoGen: Record "Sacco General Set-Up";
    finalMemberLedgerBuffer: Record "Final CustLedgerEntries Buffer";
    cust: Record Customer;
    GenJournalLine: Record "Gen. Journal Line";
    GenBatches: Record "Gen. Journal Batch";
}
