codeunit 50112 "Charge SMS"
{
    trigger OnRun()
    begin
        
    end;

    procedure RunChargeSMS(FOSAAcc: Code[20]; receiver: Code[20]) insufficient: Boolean
    var
        myInt: Integer;
    begin
        smsCharge:= 0;
        exciseDuty:= 0;
        totalCharge:= 0;
        smsChargeAC:= '';
        exciseDutyAC:= '';
        docNo := '';
        batchTemplate := 'GENERAL';
        batchName := 'SMSCHARGE';
        lineNo := 0;

        saccoGenSetup.Get();
        smsCharge:= saccoGenSetup."SMS Fee Amount";
        smsChargeAC:= saccoGenSetup."SMS Fee Account";
        exciseDuty:= (smsCharge)* (saccoGenSetup."Excise Duty(%)"/100);
        exciseDutyAC:= saccoGenSetup."Excise Duty Account";
        totalCharge:= exciseDuty + smsCharge;

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
            GenBatches.Description := 'SMS Charges';
            GenBatches.Insert();
        end;

        vend.Reset();
        vend.SetRange("No.", FOSAAcc);
        if vend.Find('-') then begin
            docNo:= 'SMS-'+receiver;
            //Debit FOSA A/C SMS Charge
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ", 
            GenJournalLine."Account Type"::Vendor, vend."No.", Today, smsCharge, '', 'SMS Charge', '');
            //Credit SMS Charges A/C
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ", 
            GenJournalLine."Account Type"::"G/L Account", smsChargeAC, Today, smsCharge*-1, '', 'SMS Charge', '');
            //Debit FOSA A/C Excise Duty
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ", 
            GenJournalLine."Account Type"::Vendor, vend."No.", Today, exciseDuty, '', 'Excise Duty on SMS Charge', '');
            //Credit Excise Duty A/c
            lineNo := lineNo + 10000;
            AUFactory.FnCreateGnlJournalLines(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ", 
            GenJournalLine."Account Type"::"G/L Account", exciseDutyAC, Today, exciseDuty*-1, '', 'Excise Duty on SMS Charge', '');

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", batchTemplate);
            GenJournalLine.SetRange("Journal Batch Name", batchName);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
            
            if vend.GetAvailableBalance() > totalCharge then begin    
                insufficient:= false;
            end else insufficient:= true;
        end;
    end;

    procedure FnCheckAccBal(fosa: Code[20]; recepient: Code[20]) sufficient: Boolean
    var
        myInt: Integer;
    begin

        saccoGenSetup.Get();
        smsCharge:= saccoGenSetup."SMS Fee Amount";
        smsChargeAC:= saccoGenSetup."SMS Fee Account";
        exciseDuty:= (smsCharge)* (saccoGenSetup."Excise Duty(%)"/100);
        exciseDutyAC:= saccoGenSetup."Excise Duty Account";
        totalCharge:= exciseDuty + smsCharge;
        
        vend.Reset();
        vend.SetRange("No.", fosa);
        if vend.Find('-') then begin
            if vend.GetAvailableBalance() > totalCharge then begin    
                sufficient:= false;
            end else sufficient:= true;
        end;
    end;
    
    var
    lineNo: Integer;
    smsCharge: Decimal;
    exciseDuty: Decimal;
    totalCharge: Decimal;
    accBal: Decimal;
    docNo: Code[20];
    batchName: Code[20];
    batchTemplate: Code[20];
    smsChargeAC: Code[20];
    exciseDutyAC: Code[20];
    AUFactory: Codeunit "Au Factory";
    smsManagement: Codeunit "Sms Management";
    cust: Record Customer;
    vend: Record Vendor;
    saccoGenSetup: Record "Sacco General Set-Up";
    GenBatches: Record "Gen. Journal Batch";
    GenJournalLine: Record "Gen. Journal Line";
}
