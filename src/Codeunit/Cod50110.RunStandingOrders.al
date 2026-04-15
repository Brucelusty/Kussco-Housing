codeunit 50110 "Run Standing Orders"
{
    trigger OnRun()
    begin
        GetDailyBusinessSTO();
    end;

    procedure GetDailyBusinessSTO()
    var
        myInt: Integer;
    begin
        posted:= false;
        BATCH_TEMPLATE:= 'GENERAL';
        BATCH_NAME:= 'AUTOSTO';

        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll();
        end;

        GenBatches.Reset();
        GenBatches.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenBatches.SetRange(Name, BATCH_NAME);
        if not GenBatches.Find('-') then begin
            GenBatches.Init();
            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
            GenBatches.Name := BATCH_NAME;
            GenBatches.Description := 'Automatic STOs';
            GenBatches.Insert();
        end;

        objSTO.Reset();
        objSTO.SetRange("Standing Order Dedution Type", objSTO."Standing Order Dedution Type"::"Other Income");
        objSTO.SetFilter("Effective/Start Date",'<=%1',Today);
        objSTO.SetFilter("Next Run Date", '<=%1', Today);
        objSTO.SetRange(Status, objSTO.Status::Approved);
        objSTO.SetRange("Is Active", true);
        if objSTO.Find('-') then begin
            repeat
                objSTO.CalcFields("Allocated Amount");
                if (objSTO."Allocated Amount" > 0) then begin
                    posted:= RunDailySTO(objSTO."No.", objSTO."Source Account No.");
                end else posted := false;
                if posted = true then begin
                    DedStatus:= DedStatus::Successfull;
                    objSTO.Effected := true;
                end else  begin
                    DedStatus:= DedStatus::Failed;
                    objSTO.Effected := false;
                end;
                FnRegisterProcessedStandingOrder(objSTO, objSTO."Allocated Amount", objSTO."No.", DedStatus);

                objSTO."Next Run Date" := CalcDate(objSTO.Frequency, Today);
                objSTO."Date Reset":= Today;
                objSTO.Modify();

            until objSTO.Next()= 0;
        end;
    end;

    procedure RunDailySTO(stoNo: Code[20]; FOSAAcc: Code[20]) success: Boolean
    var
        myInt: Integer;
    begin
        BATCH_TEMPLATE:= 'GENERAL';
        BATCH_NAME:= 'AUTOSTO';
        DOCUMENT_NO:= stoNo;
        LineNo:= 0;

        objReceiptAlloc.Reset();
        objReceiptAlloc.SetRange("Document No", stoNo);
        if objReceiptAlloc.FindSet() then begin
            if objReceiptAlloc."STO Account Type" = objReceiptAlloc."STO Account Type"::"FOSA Account" then begin
                ObjVendor.Get(objReceiptAlloc."Member No");
                ObjVendor.CalcFields(Balance);
                if ObjVendor.Balance >= objReceiptAlloc.Amount then begin
                    //--------------------------------------Debit Business A/C-----------------------------
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, objReceiptAlloc."Member No", Today, objReceiptAlloc.Amount, 'FOSA',
                    'STO Deduction-'+ objReceiptAlloc.Description, '');
                    //----------------------------------------Credit FOSA A/C--------------------------------
                    LineNo := LineNo + 10000;
                    AUFactory.FnCreateGnlJournalLines(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, FOSAAcc, Today, objReceiptAlloc.Amount*-1, 'FOSA',
                    'STO Deduction-'+ objReceiptAlloc.Description, '');
                    
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                    
                    success:= true;

                end else success:= false;
            end;
        end;
    end;

    procedure FnRegisterProcessedStandingOrder(ObjStandingOrders: Record "Standing Orders"; AmountToDeduct: Decimal; member: Code[20]; status: Option Successfull,"Partial Deduction",Failed)
    begin
        ObjSTORegister.Reset;
        ObjSTORegister.SetRange("Document No.", member);
        if ObjSTORegister.Find('-') then
            ObjSTORegister.DeleteAll;

        ObjSTORegister.Init;
        ObjSTORegister."Register No." := '';
        ObjSTORegister.Validate(ObjSTORegister."Register No.");
        ObjSTORegister."Standing Order No." := ObjStandingOrders."No.";
        ObjSTORegister."Source Account No." := ObjStandingOrders."Source Account No.";
        ObjSTORegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
        ObjSTORegister.Date := Today;
        ObjSTORegister."Account Name" := ObjStandingOrders."Account Name";
        ObjSTORegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
        ObjSTORegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
        ObjSTORegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
        ObjSTORegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
        ObjSTORegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
        ObjSTORegister."End Date" := ObjStandingOrders."End Date";
        ObjSTORegister.Duration := ObjStandingOrders.Duration;
        ObjSTORegister.Frequency := ObjStandingOrders.Frequency;
        ObjSTORegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
        ObjSTORegister."Deduction Status" := status;
        ObjSTORegister.Remarks := ObjStandingOrders."Standing Order Description";
        ObjSTORegister.Amount := ObjStandingOrders.Amount;
        ObjSTORegister."Amount Deducted" := AmountToDeduct;
        if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Member Account" then
            ObjSTORegister.EFT := true;
        ObjSTORegister."Document No." := member;
        ObjSTORegister.Insert(true);
    end;


    var
    Vend: Record Vendor;
    accTypes: Record "Account Types-Saving Products";
    LineNo: Integer;
    RunBal: Decimal;
    DedStatus: Option Successfull,"Partial Deduction",Failed;
    BATCH_NAME: Code[50];
    BATCH_TEMPLATE: Code[50];
    DOCUMENT_NO: Code[40];
    posted: Boolean;
    AUFactory: Codeunit "Au Factory";
    ObjVendor: Record Vendor;
    objCust: Record Customer;
    objSTO: Record "Standing Orders";
    objReceiptAlloc: Record "Receipt Allocation";
    objLoanReg: Record "Loans Register";
    GenJournalLine: Record "Gen. Journal Line";
    GenBatches: Record "Gen. Journal Batch";
    ObjGenSetup: Record "Sacco General Set-Up";
    ObjSTORegister: Record "Standing Order Register";
    ObjLoanProducts: Record "Loan Products Setup";
}
