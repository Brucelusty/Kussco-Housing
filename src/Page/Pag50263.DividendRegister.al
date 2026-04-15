page 50263 "Dividend Register"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Dividends Progression";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No";Rec."Member No")
                {
                }
                field(Date;Rec.Date)
                {
                }
                field("Qualifying Shares";Rec."Qualifying Shares") 
                {
                }
                field("Gross Dividends";Rec."Gross Dividends") 
                {
                }
                field(Shares;Rec.Shares)
                {
                }
                field("Net Dividends";Rec."Net Dividends") 
                {
                }
                field("Witholding Tax";Rec."Witholding Tax") 
                {
                }
                field("Deposit Type";Rec."Deposit Type")
                {
                }
                field(Posted;Rec.Posted)
                {
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Process Payment")
            {
                Image = VoucherGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                begin
                    selected := 0;
                    selected := StrMenu(options, 3, request);
                    if selected = 2 then begin
                        LineNo := 0;
                        dividend := 0;
                        netBal := 0;
                        postingDate := Today;
                        BATCH_TEMPLATE := 'PAYMENTS';
                        BATCH_NAME := 'DEPINT';

                        GenBatches.Reset();
                        GenBatches.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenBatches.SetRange(Name, BATCH_NAME);
                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init();
                            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
                            GenBatches.Name := BATCH_NAME;
                            GenBatches.Description := 'Interest Earned on BOSA Deposit Contributions.';
                            GenBatches.Insert();
                        end;

                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.FindSet() then begin
                            GenJournalLine.DeleteAll();
                        end;

                        cust.Reset();
                        if cust.FindSet() then begin
                            repeat
                            cust.CalcFields("Deposits Gross Interest Amount", "Deposits Net Interest Amount", "Deposits WHT Amount");
                            if cust."Deposits Gross Interest Amount" >= 0 then begin
                                DOCUMENT_NO := 'DEPINT-2024';
                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                cust."Ordinary Savings Acc", postingDate, cust."Deposits Net Interest Amount" * -1, '', '', 'Net Interest on BOSA Deposits - 2024', '', GenJournalLine."Application Source"::CBS);
                                if cust."Deposits Gross Interest Amount" >= 250 then begin
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, cust."Deposits Net Interest Amount" * 0.01, '', '', 'Processing Fee Interest on BOSA Deposits - 2024', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, (cust."Deposits Net Interest Amount" * 0.01) * 0.2, '', '', 'Excise Duty on Processing Fee', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, 10, '', '', 'SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, 2, '', '', 'Excise Duty on SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                
                                    netBal := cust."Deposits Gross Interest Amount" - (((cust."Deposits Net Interest Amount" * 0.01) * 0.2) + (cust."Deposits Net Interest Amount" * 0.01) + 12);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '300-000-066', postingDate, cust."Deposits Net Interest Amount" * -0.01, '', '', 'Processing Fee Interest on BOSA Deposits - 2024', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '200-000-168', postingDate, (cust."Deposits Net Interest Amount" * -0.01) * 0.2, '', '', 'Excise Duty on Processing Fee', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '300-000-055', postingDate, -10, '', '', 'SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '200-000-168', postingDate, -2, '', '', 'Excise Duty on SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                end else begin
                                    netBal := cust."Deposits Gross Interest Amount";
                                end;

                                runningBal := netBal;
                                loansReg.Reset();
                                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                                loansReg.SetRange( "Client Code", cust."No.");
                                loansReg.SetFilter("Expected Date of Completion", '<%1', Today);
                                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                                if loansReg.FindSet() then begin
                                    repeat
                                    if runningBal > 0 then begin
                                        loansReg.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");
                                        if loansReg."Outstanding Penalty" < runningBal then begin
                                            loanRepay := loansReg."Outstanding Penalty";
                                        end else begin
                                            loanRepay := runningBal;
                                        end;
                                        
                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                        cust."Ordinary Savings Acc", postingDate, loanRepay, '', loansReg."Loan  No.", 'Penalty Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);

                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Paid", GenJournalLine."Account Type"::Customer,
                                        cust."No.", postingDate, loanRepay * -1, '', loansReg."Loan  No.", 'Penalty Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);
                                            
                                        runningBal := runningBal - loanRepay;
                                        loanRepay := 0;

                                        if loansReg."Outstanding Interest" < runningBal then begin
                                            loanRepay := loansReg."Outstanding Interest";
                                        end else begin
                                            loanRepay := runningBal;
                                        end;
                                        
                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                        cust."Ordinary Savings Acc", postingDate, loanRepay, '', loansReg."Loan  No.", 'Interest Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);

                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer,
                                        cust."No.", postingDate, loanRepay * -1, '', loansReg."Loan  No.", 'Interest Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);
                                        
                                        runningBal := runningBal - loanRepay;
                                        loanRepay := 0;

                                        if loansReg."Outstanding Balance" < runningBal then begin
                                            loanRepay := loansReg."Outstanding Balance";
                                        end else begin
                                            loanRepay := runningBal;
                                        end;
                                        
                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                        cust."Ordinary Savings Acc", postingDate, loanRepay, '', loansReg."Loan  No.", 'Repayment Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);

                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."Account Type"::Customer,
                                        cust."No.", postingDate, loanRepay * -1, '', loansReg."Loan  No.", 'Repayment Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);
                                        
                                        runningBal := runningBal - loanRepay;
                                        loanRepay := 0;
                                    end;
                                until loansReg.Next() = 0;
                                end;

                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                '200-000-176', postingDate, cust."Deposits WHT Amount" * -1, '', '', 'Withholding Tax on BOSA Deposits - 2024', '', GenJournalLine."Application Source"::CBS);

                                dividend := dividend + cust."Deposits Gross Interest Amount";
                            end;
                            until cust.Next() = 0;

                            if dividend > 0 then begin
                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                '200-000-188', postingDate, dividend, '', '', 'Interest Earned on BOSA Deposits - 2024', '', GenJournalLine."Application Source"::CBS);

                                Message('BOSA Deposits Interest Processing Done.');
                            end;
                        end;
                    end else if selected = 1 then begin
                        LineNo := 0;
                        dividend := 0;
                        netBal := 0;
                        postingDate := Today;
                        BATCH_TEMPLATE := 'PAYMENTS';
                        BATCH_NAME := 'DIVINT';

                        GenBatches.Reset();
                        GenBatches.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenBatches.SetRange(Name, BATCH_NAME);
                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init();
                            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
                            GenBatches.Name := BATCH_NAME;
                            GenBatches.Description := 'Interest Earned on Share Capital Contributions.';
                            GenBatches.Insert();
                        end;

                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.FindSet() then begin
                            GenJournalLine.DeleteAll();
                        end;

                        cust.Reset();
                        if cust.FindSet() then begin
                            repeat
                            cust.CalcFields("Dividend Gross Interest Amount", "Dividend Net Interest Amount", "Dividend WHT Amount");
                            if cust."Dividend Gross Interest Amount" >= 0 then begin
                                DOCUMENT_NO := 'DIVINT-2024';
                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                cust."Ordinary Savings Acc", postingDate, cust."Dividend Net Interest Amount" * -1, '', '', 'Net Interest on Dividend - 2024', '', GenJournalLine."Application Source"::CBS);
                                if cust."Dividend Gross Interest Amount" >= 250 then begin
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, cust."Dividend Net Interest Amount" * 0.01, '', '', 'Processing Fee Interest on Dividend - 2024', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, (cust."Dividend Net Interest Amount" * 0.01) * 0.2, '', '', 'Excise Duty on Processing Fee', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, 10, '', '', 'SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, 2, '', '', 'Excise Duty on SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                
                                    netBal := cust."Dividend Gross Interest Amount" - (((cust."Dividend Net Interest Amount" * 0.01) * 0.2) + (cust."Dividend Net Interest Amount" * 0.01) + 12);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '300-000-066', postingDate, cust."Dividend Net Interest Amount" * -0.01, '', '', 'Processing Fee Interest on Dividend - 2024', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '200-000-168', postingDate, (cust."Dividend Net Interest Amount" * -0.01) * 0.2, '', '', 'Excise Duty on Processing Fee', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '300-000-055', postingDate, -10, '', '', 'SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '200-000-168', postingDate, -2, '', '', 'Excise Duty on SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                end else begin
                                    netBal := cust."Dividend Gross Interest Amount";
                                end;
                                
                                runningBal := netBal;
                                loansReg.Reset();
                                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                                loansReg.SetRange( "Client Code", cust."No.");
                                loansReg.SetFilter("Expected Date of Completion", '<%1', Today);
                                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                                if loansReg.FindSet() then begin
                                    repeat
                                    if runningBal > 0 then begin
                                        loansReg.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");
                                        if loansReg."Outstanding Penalty" < runningBal then begin
                                            loanRepay := loansReg."Outstanding Penalty";
                                        end else begin
                                            loanRepay := runningBal;
                                        end;
                                        
                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                        cust."Ordinary Savings Acc", postingDate, loanRepay, '', loansReg."Loan  No.", 'Penalty Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);

                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Paid", GenJournalLine."Account Type"::Customer,
                                        cust."No.", postingDate, loanRepay * -1, '', loansReg."Loan  No.", 'Penalty Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);
                                            
                                        runningBal := runningBal - loanRepay;
                                        loanRepay := 0;

                                        if loansReg."Outstanding Interest" < runningBal then begin
                                            loanRepay := loansReg."Outstanding Interest";
                                        end else begin
                                            loanRepay := runningBal;
                                        end;
                                        
                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                        cust."Ordinary Savings Acc", postingDate, loanRepay, '', loansReg."Loan  No.", 'Interest Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);

                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer,
                                        cust."No.", postingDate, loanRepay * -1, '', loansReg."Loan  No.", 'Interest Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);
                                        
                                        runningBal := runningBal - loanRepay;
                                        loanRepay := 0;

                                        if loansReg."Outstanding Balance" < runningBal then begin
                                            loanRepay := loansReg."Outstanding Balance";
                                        end else begin
                                            loanRepay := runningBal;
                                        end;
                                        
                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                        cust."Ordinary Savings Acc", postingDate, loanRepay, '', loansReg."Loan  No.", 'Repayment Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);

                                        LineNo := LineNo + 1000;
                                        AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."Account Type"::Customer,
                                        cust."No.", postingDate, loanRepay * -1, '', loansReg."Loan  No.", 'Repayment Paid on Defaulted '+loansReg."Loan Product Type Name"+' Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);
                                        
                                        runningBal := runningBal - loanRepay;
                                        loanRepay := 0;
                                    end;
                                until loansReg.Next() = 0;
                                end;

                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                '200-000-176', postingDate, cust."Dividend WHT Amount" * -1, '', '', 'Withholding Tax on Dividend - 2024', '', GenJournalLine."Application Source"::CBS);

                                dividend := dividend + cust."Dividend Gross Interest Amount";
                            end;
                            until cust.Next() = 0;

                            if dividend > 0 then begin
                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                '200-000-188', postingDate, dividend, '', '', 'Interest Earned on Dividend - 2024', '', GenJournalLine."Application Source"::CBS);

                                Message('Dividend Processing Done.');
                            end;
                        end;
                    end else if selected = 3 then begin
                        LineNo := 0;
                        dividend := 0;
                        netBal := 0;
                        // postingDate := 20250214D;
                        postingDate := Today;
                        BATCH_TEMPLATE := 'PAYMENTS';
                        BATCH_NAME := 'ESSINT';

                        GenBatches.Reset();
                        GenBatches.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenBatches.SetRange(Name, BATCH_NAME);
                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init();
                            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
                            GenBatches.Name := BATCH_NAME;
                            GenBatches.Description := 'Interest Earned on ESS Deposit Contributions.';
                            GenBatches.Insert();
                        end;

                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.FindSet() then begin
                            GenJournalLine.DeleteAll();
                        end;

                        cust.Reset();
                        if cust.FindSet() then begin
                            repeat
                            cust.CalcFields("ESS Gross Interest Amount", "ESS Net Interest Amount", "ESS WHT Amount");
                            if cust."ESS Gross Interest Amount" >= 0 then begin
                                DOCUMENT_NO := 'ESSINT-2024';
                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                cust."Ordinary Savings Acc", postingDate, cust."ESS Net Interest Amount" * -1, '', '', 'Net Interest on ESS Deposits - 2024', '', GenJournalLine."Application Source"::CBS);
                                if cust."ESS Gross Interest Amount" >= 250 then begin
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, cust."ESS Net Interest Amount" * 0.01, '', '', 'Processing Fee Interest on ESS Deposits - 2024', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, (cust."ESS Net Interest Amount" * 0.01) * 0.2, '', '', 'Excise Duty on Processing Fee', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, 10, '', '', 'SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, 2, '', '', 'Excise Duty on SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                
                                    netBal := cust."ESS Gross Interest Amount" - (((cust."ESS Net Interest Amount" * 0.01) * 0.2) + (cust."ESS Net Interest Amount" * 0.01) + 12);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '300-000-066', postingDate, cust."ESS Net Interest Amount" * -0.01, '', '', 'Processing Fee Interest on ESS Deposits - 2024', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '200-000-168', postingDate, (cust."ESS Net Interest Amount" * -0.01) * 0.2, '', '', 'Excise Duty on Processing Fee', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '300-000-055', postingDate, -10, '', '', 'SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                    '200-000-168', postingDate, -2, '', '', 'Excise Duty on SMS Charge', '', GenJournalLine."Application Source"::CBS);
                                end else begin
                                    netBal := cust."ESS Gross Interest Amount";
                                end;

                                loansReg.Reset();
                                loansReg.SetAutoCalcFields("Total Outstanding Balance");
                                loansReg.SetRange( "Client Code", cust."No.");
                                loansReg.SetRange("Loan Product Type", 'L04');
                                loansReg.SetFilter("Expected Date of Completion", '<%1', Today);
                                loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
                                if loansReg.Find('-') then begin
                                    loansReg.CalcFields("Outstanding Balance", "Outstanding Interest");
                                    runningBal := netBal;
                                    if loansReg."Outstanding Interest" < runningBal then begin
                                        loanRepay := loansReg."Outstanding Interest";
                                    end else begin
                                        loanRepay := runningBal;
                                    end;
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, loanRepay, '', loansReg."Loan  No.", 'Interest Paid on Defaulted ESS Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);

                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer,
                                    cust."No.", postingDate, loanRepay * -1, '', loansReg."Loan  No.", 'Interest Paid on Defaulted ESS Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);
                                    
                                    runningBal := runningBal - loanRepay;

                                    if loansReg."Outstanding Balance" < runningBal then begin
                                        loanRepay := loansReg."Outstanding Balance";
                                    end else begin
                                        loanRepay := runningBal;
                                    end;
                                    
                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
                                    cust."Ordinary Savings Acc", postingDate, loanRepay, '', loansReg."Loan  No.", 'Repayment Paid on Defaulted ESS Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);

                                    LineNo := LineNo + 1000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."Account Type"::Customer,
                                    cust."No.", postingDate, loanRepay * -1, '', loansReg."Loan  No.", 'Repayment Paid on Defaulted ESS Loan - '+loansReg."Loan  No.", loansReg."Loan  No.", GenJournalLine."Application Source"::CBS);
                                end;

                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                '200-000-176', postingDate, cust."ESS WHT Amount" * -1, '', '', 'Withholding Tax on ESS Deposits - 2024', '', GenJournalLine."Application Source"::CBS);

                                dividend := dividend + cust."ESS Gross Interest Amount";
                            end;
                            until cust.Next() = 0;

                            if dividend > 0 then begin
                                LineNo := LineNo + 1000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account",
                                '200-000-188', postingDate, dividend, '', '', 'Interest Earned on ESS Deposits - 2024', '', GenJournalLine."Application Source"::CBS);

                                Message('ESS Interest Processing Done.');
                            end;
                        end;
                    end;
                end;
            }
            action("Send Alerts")
            {
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    selected := 0;
                    selected := StrMenu(options, 2, requestMsg);
                    if selected = 1 then begin
                        cust.Reset();
                        if cust.FindSet() then begin
                            repeat
                            msg := '';
                            cust.CalcFields("Dividend Gross Interest Amount");
                            if cust."Dividend Gross Interest Amount" > 0 then begin
                                msg := 'Dear '+cust."First Name"+', your Dividends 2024 has been credited to your FOSA A/C.';
                                smsManagement.SendSmsWithID(Source::DIVIDEND_PROCESSING, cust."Mobile Phone No", msg, cust."No.", cust."Ordinary Savings Acc", false, 240, false, 'CBS', CreateGuid(), 'CBS');
                            end;
                            until cust.Next() = 0;
                        end;
                        
                        divProgress.Reset();
                        divProgress.SetRange("Deposit Type", divProgress."Deposit Type"::"Share Capital");
                        if divProgress.FindSet() then begin
                            repeat
                            divProgress.Posted := true;
                            divProgress.Modify;
                            until divProgress.Next() = 0;
                        end;
                    end else if selected = 2 then begin
                        cust.Reset();
                        if cust.FindSet() then begin
                            repeat
                            msg := '';
                            cust.CalcFields("Deposits Gross Interest Amount");
                            if cust."Deposits Gross Interest Amount" > 0 then begin
                                msg := 'Dear '+cust."First Name"+', your Interest on BOSA Deposit Savings 2024 has been credited to your FOSA A/C.';
                                smsManagement.SendSmsWithID(Source::DIVIDEND_PROCESSING, cust."Mobile Phone No", msg, cust."No.", cust."Ordinary Savings Acc", false, 240, false, 'CBS', CreateGuid(), 'CBS');
                            end;
                            until cust.Next() = 0;
                        end;
                        
                        divProgress.Reset();
                        divProgress.SetRange("Deposit Type", divProgress."Deposit Type"::Deposits);
                        if divProgress.FindSet() then begin
                            repeat
                            divProgress.Posted := true;
                            divProgress.Modify;
                            until divProgress.Next() = 0;
                        end;
                    end else if selected = 3 then begin
                        cust.Reset();
                        if cust.FindSet() then begin
                            repeat
                            msg := '';
                            cust.CalcFields("ESS Gross Interest Amount");
                            if cust."ESS Gross Interest Amount" > 0 then begin
                                msg := 'Dear '+cust."First Name"+', your Interest on ESS Savings 2024 has been credited to your FOSA A/C.';
                                smsManagement.SendSmsWithID(Source::DIVIDEND_PROCESSING, cust."Mobile Phone No", msg, cust."No.", cust."Ordinary Savings Acc", false, 240, false, 'CBS', CreateGuid(), 'CBS');
                            end;
                            until cust.Next() = 0;
                        end;
                        
                        divProgress.Reset();
                        divProgress.SetRange("Deposit Type", divProgress."Deposit Type"::ESS);
                        if divProgress.FindSet() then begin
                            repeat
                            divProgress.Posted := true;
                            divProgress.Modify;
                            until divProgress.Next() = 0;
                        end;
                    end;
                end;
            }
        }
    }

    var
    options: Label 'Dividends, Interest on Deposits, Interest on ESS';
    request: Label 'Kindy select which interest you wish to process...';
    requestMsg: Label 'Kindy select which interest you wish to alert members about...';
    selected: Integer;
    LineNo: Integer;
    dividend: Decimal;
    loanRepay: Decimal;
    runningBal: Decimal;
    netBal: Decimal;
    BATCH_TEMPLATE: Code[60];
    BATCH_NAME: Code[80];
    DOCUMENT_NO: Code[40];
    member: Code[20];
    msg: Text[2000];
    postingDate: Date;
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY,MEMBER_ALLOWANCES,DIVIDEND_PROCESSING;
    AUFactory: Codeunit "Au Factory";
    smsManagement: Codeunit "Sms Management";
    loansReg: Record "Loans Register";
    divProgress: Record "Dividends Progression";
    simplifiedDiv: Record "Dividends Prog Simplified";
    cust: Record Customer;
    GenJournalLine: Record "Gen. Journal Line";
    GenBatches: Record "Gen. Journal Batch";

}


