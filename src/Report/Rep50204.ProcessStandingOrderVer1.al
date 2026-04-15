//<---------------------------------------------------------------------->															
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings															
Report 50204 "Process Standing Order Ver1"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Standing Orders"; "Standing Orders")
        {
            RequestFilterFields = "No.", "Source Account No.";
            DataItemTableView = where(Status = filter(Approved), "Is Active" = filter(true), "Standing Order Dedution Type" = filter("Other Income"));
            column(No_;"No.")
            {}

            trigger OnAfterGetRecord()
            begin
                docNo := "Standing Orders"."No.";
                accountBal := 0;
                ExpectedAmount := 0;
                principleAmount := 0;
                interestAmount := 0;
                penaltyAmount := 0;
                recoveredAmount := 0;

                vend.Reset();
                vend.SetRange(vend."No.","Standing Orders"."Source Account No.");
                vend.SetRange(vend.Blocked,vend.Blocked::" ");
                if vend.FindFirst() then begin
               // if vend.Get("Standing Orders"."Source Account No.") then begin
                    accountBal := vend.GetAvailableBalance();
                    "Standing Orders".CalcFields("Allocated Amount");

                    if accountBal < "Standing Orders"."Allocated Amount" then begin
                        // FnRegisterProcessedStandingOrder("Standing Orders", docNo, recoveredAmount, DeductStatus::Failed);
                        // CurrReport.Skip();
                        runBal := accountBal;
                    end else runBal := "Standing Orders"."Allocated Amount";

                    runBal := accountBal;

                    stoLines.Reset();
                    stoLines.SetRange("Document No", "Standing Orders"."No.");
                    if stoLines.FindSet() then begin
                        repeat
                        if stoLines."STO Account Type" = stoLines."STO Account Type"::Member then begin
                            if stoLines."Loan No." <> '' then begin
                                loanNo := stoLines."Loan No.";

                                loansReg.Reset();
                                if loansReg.Get(loanNo) then begin
                                    loansReg.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");
                                    principleAmount := loansReg."Outstanding Balance";
                                    interestAmount := loansReg."Outstanding Interest";
                                    penaltyAmount := loansReg."Outstanding Penalty";

                                    if Date2DMY(Today, 1) > 15 then begin
                                        repDate := CalcDate('<CM>', Today);
                                    end else repDate := CalcDate('<-1D>', CalcDate('<-CM>', Today));

                                    loansRepayment.Reset();
                                    loansRepayment.SetRange("Loan No.", loansReg."Loan  No.");
                                    loansRepayment.SetFilter("Repayment Date", '..%1', repDate);
                                    if loansRepayment.Find('+') then begin
                                        ExpectedAmount := loansRepayment."Loan Balance";
                                        arrears := principleAmount - ExpectedAmount;
                                        if arrears <= 0 then begin
                                            arrears := 0;
                                        end;

                                        if principleAmount > loansRepayment."Principal Repayment" then begin
                                            principleAmount := loansRepayment."Principal Repayment" + arrears;
                                        end else begin
                                            principleAmount := principleAmount;
                                        end;
                                    end;

                                    if interestAmount > 0 then begin
                                        
                                        if runBal > interestAmount then begin
                                            amountToPay := interestAmount;
                                        end else begin
                                            amountToPay := runBal;
                                        end;

                                        lineNo := lineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::" ",
                                        generalJournal."Account Type"::Vendor, vend."No.", Today, amountToPay, 'BOSA', docNo, docNo+'- Loan Interest Repayment'+loanNo,
                                        loanNo, generalJournal."Application Source"::" ");

                                        lineNo := lineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::"Interest Paid",
                                        generalJournal."Account Type"::Customer, stoLines."Member No", Today, amountToPay * -1, 'BOSA', loanNo, docNo+'- Loan Interest Repayment'+loanNo,
                                        loanNo, generalJournal."Application Source"::" ");

                                        recoveredAmount := recoveredAmount + amountToPay;
                                        runBal := runBal - amountToPay;
                                    end;
                                    if principleAmount > 0 then begin
                                        
                                        if runBal > principleAmount then begin
                                            amountToPay := principleAmount;
                                        end else begin
                                            amountToPay := runBal;
                                        end;

                                        lineNo := lineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::" ",
                                        generalJournal."Account Type"::Vendor, vend."No.", Today, amountToPay, 'BOSA', docNo, docNo+'- Loan Repayment '+loanNo,
                                        loanNo, generalJournal."Application Source"::" ");

                                        lineNo := lineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::Repayment,
                                        generalJournal."Account Type"::Customer, stoLines."Member No", Today, amountToPay * -1, 'BOSA', loanNo, docNo+'- Loan Repayment '+loanNo,
                                        loanNo, generalJournal."Application Source"::" ");

                                        recoveredAmount := recoveredAmount + amountToPay;
                                        runBal := runBal - amountToPay;
                                    end;
                                end;
                            end;
                            if (stoLines."Transaction Type" = stoLines."Transaction Type"::" ") then begin
                                
                                if runBal > stoLines.Amount then begin
                                    amountToPay := stoLines.Amount;
                                end else begin
                                    amountToPay := runBal;
                                end;

                                lineNo := lineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::" ",
                                generalJournal."Account Type"::Vendor, vend."No.", Today, amountToPay, 'BOSA', docNo, docNo+'- Benevolent Fund Contribution',
                                '', generalJournal."Application Source"::" ");

                                lineNo := lineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::" ",
                                generalJournal."Account Type"::Customer, stoLines."Member No", Today, amountToPay * -1, 'BOSA', docNo, docNo+'- Benevolent Fund Contribution',
                                '', generalJournal."Application Source"::" ");
                                recoveredAmount := recoveredAmount + amountToPay;
                                runBal := runBal - amountToPay;
                            end;
                        end else if stoLines."STO Account Type" = stoLines."STO Account Type"::"FOSA Account" then begin
                            if runBal > stoLines.Amount then begin
                                amountToPay := stoLines.Amount;
                            end else begin
                                amountToPay := runBal;
                            end;

                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::" ",
                            generalJournal."Account Type"::Vendor, vend."No.", Today, amountToPay, 'FOSA', "Standing Orders"."No.", docNo+' -'+getAccountType(stoLines."Member No"),
                            '', generalJournal."Application Source"::" ");
                            
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(genTemplate, genBatch, docNo, lineNo, generalJournal."Transaction Type"::" ",
                            generalJournal."Account Type"::Vendor, stoLines."Member No", Today, amountToPay * -1, 'FOSA', "Standing Orders"."No.", docNo+' -'+getAccountType(stoLines."Member No"),
                            '', generalJournal."Application Source"::" ");
                            
                            recoveredAmount := recoveredAmount + amountToPay;
                            runBal := runBal - amountToPay;
                        end;
                        
                        until stoLines.Next() = 0;

                        // if recoveredAmount = "Standing Orders"."Allocated Amount" then begin
                        //     FnRegisterProcessedStandingOrder("Standing Orders", docNo, recoveredAmount, DeductStatus::Successfull);
                        // end else if (recoveredAmount < "Standing Orders"."Allocated Amount") and (recoveredAmount > 0) then begin
                        //     FnRegisterProcessedStandingOrder("Standing Orders", docNo, recoveredAmount, DeductStatus::"Partial Deduction");
                        // end else if recoveredAmount <= 0 then begin
                        //     FnRegisterProcessedStandingOrder("Standing Orders", docNo, recoveredAmount, DeductStatus::Failed);
                        // end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                genTemplate:= 'PAYMENTS';
                genBatch:= 'MANUALSTOS';

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
                    generalBatch.Description:= 'Process Other Income Standing Orders';
                    generalBatch.Insert();
                end;
            end;

            trigger OnPostDataItem() begin
                generalJournal.Reset();
                generalJournal.SetRange("Journal Template Name", genTemplate);
                generalJournal.SetRange("Journal Batch Name", genBatch);
                if generalJournal.FindSet() then begin
                    Message('Journal Lines have been populated successfully. Batch Template %1, Batch Name %2.', genTemplate, genBatch);
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
    myInt: Integer;
    lineNo: Integer;
    loanNo: Code[20];
    genBatch: Code[20];
    genTemplate: Code[20];
    docNo: Code[20];
    repDate: date;
    arrears: Decimal;
    principleAmount: Decimal;
    interestAmount: Decimal;
    penaltyAmount: Decimal;
    accountBal: Decimal;
    runBal: Decimal;
    amountToPay: Decimal;
    ExpectedAmount: Decimal;
    recoveredAmount: Decimal;
    DeductStatus: Option Successfull,"Partial Deduction",Failed;
    AUFactory: Codeunit "Au Factory";
    cust: Record Customer;
    vend: Record Vendor;
    stos: Record "Standing Orders";
    stoLines: Record "Receipt Allocation";
    processedSTOs: Record "Standing Order Register";
    accTypes: Record "Account Types-Saving Products";
    loansReg: Record "Loans Register";
    loansRepayment: Record "Loan Repayment Schedule";
    generalBatch: Record "Gen. Journal Batch";
    generalJournal: Record "Gen. Journal Line";

    local procedure getAccountType(account: Code[50]) Type: Code[50]
    begin
        Vend.Reset();
        Vend.SetRange("No.", account);
        if Vend.Find('-') then begin
            if accTypes.Get(Vend."Account Type") then begin
                Type := accTypes.Description;
            end;
        end;
    end;

    local procedure FnRegisterProcessedStandingOrder(sto: Record "Standing Orders"; docNo: Code[50]; AmountToDeduct: Decimal; DedStatus: Option Successfull,"Partial Deduction",Failed)
    var
        stoReg: Record "Standing Order Register";
    begin
        stoReg.Reset;
        stoReg.SetRange("Document No.", docNo);
        if stoReg.Find('-') then stoReg.DeleteAll;

        stoReg.Init;
        stoReg."Register No." := '';
        stoReg.Validate(stoReg."Register No.");
        stoReg."Standing Order No." := sto."No.";
        stoReg."Source Account No." := sto."Source Account No.";
        stoReg."Staff/Payroll No." := sto."Staff/Payroll No.";
        stoReg.Date := Today;
        stoReg."Account Name" := sto."Account Name";
        stoReg."Destination Account Type" := sto."Destination Account Type";
        stoReg."Destination Account No." := sto."Destination Account No.";
        stoReg."Destination Account Name" := sto."Destination Account Name";
        stoReg."BOSA Account No." := sto."BOSA Account No.";
        stoReg."Effective/Start Date" := sto."Effective/Start Date";
        stoReg."End Date" := sto."End Date";
        stoReg.Duration := sto.Duration;
        stoReg.Frequency := sto.Frequency;
        stoReg."Don't Allow Partial Deduction" := sto."Don't Allow Partial Deduction";
        stoReg."Deduction Status" := DedStatus;
        stoReg.Remarks := sto."Standing Order Description";
        stoReg.Amount := sto.Amount;
        stoReg."Amount Deducted" := AmountToDeduct;
        if sto."Destination Account Type" = sto."destination account type"::"Member Account" then
            stoReg.EFT := true;
        stoReg."Document No." := docNo;
        if not stoReg.Insert(true) then stoReg.Modify(true);
    end;

}




