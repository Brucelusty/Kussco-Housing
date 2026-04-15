report 50774 "Recouple Under-Paid Deposits"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            RequestFilterFields = "No.";
            column(No_;"No.")
            {}

            trigger OnPreDataItem()
            begin
                batchTemplate := 'PAYMENTS';
                batchName := 'RECOUPLE';

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
                    GenBatches.Description := 'Recoupling Unpaid Deposists from FOSA';
                    GenBatches.Insert;
                end;
            end;

            trigger OnAfterGetRecord() begin
                Customer.CalcFields("Current Shares", "School Fees Shares", "Jibambe Savings", "Wezesha Savings", "Mdosi Junior", "Pension Akiba", "Ordinary Savings");
                expectedBal := 0;
                refBal := Customer."Ordinary Savings";
                if refBal <= 0 then CurrReport.Skip();
                
                refDays := Round(((Today - Customer."Registration Date")/ 30.25), 1, '=');
                docNo := 'REC-'+Customer."No.";
                if (Customer."Deposits Account No" <> '') and (Customer."Monthly Contribution" <> 0) then begin
                    if refBal > 0 then begin
                        expectedBal := Customer."Monthly Contribution" * refDays;
                        if Customer."Current Shares" < expectedBal then begin
                            diff := expectedBal - Customer."Current Shares";
                            
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Deposits Account No", Today, diff*-1, 'FOSA', '',
                            'Recoupled Deposit Contributions', '', GenJournalLine."Application Source"::" ");

                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Ordinary Savings Acc", Today, diff, 'FOSA', '',
                            'Recoupled Deposit Contributions', '', GenJournalLine."Application Source"::" ");

                            refBal := refBal - diff;
                        end;
                    end;
                end;
                
                refDays := 0;
                if (Customer."School Fees Shares Account" <> '') and (Customer."ESS Contribution" <> 0) then begin
                    vend.Reset();
                    if vend.Get(Customer."School Fees Shares Account") then begin
                        refDays := Round(((Today - vend."Registration Date")/ 30.25), 1, '=');
                    end;
                    if refBal > 0 then begin
                        expectedBal := Customer."ESS Contribution" * refDays;
                        if Customer."School Fees Shares" < expectedBal then begin
                            diff := expectedBal - Customer."School Fees Shares";
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."School Fees Shares Account", Today, diff*-1, 'FOSA', '',
                            'Recoupled ESS Contributions', '', GenJournalLine."Application Source"::" ");

                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Ordinary Savings Acc", Today, diff, 'FOSA', '',
                            'Recoupled ESS Contributions', '', GenJournalLine."Application Source"::" ");

                            refBal := refBal - diff;
                        end;
                    end;
                end;
                
                refDays := 0;
                if (Customer."Jibambe Savings Acc" <> '') and (Customer."Jibambe Savings Contribution" <> 0) then begin
                    vend.Reset();
                    if vend.Get(Customer."Jibambe Savings Acc") then begin
                        refDays := Round(((Today - vend."Registration Date")/ 30.25), 1, '=');
                    end;
                    if refBal > 0 then begin
                        expectedBal := Customer."Jibambe Savings Contribution" * refDays;
                        if Customer."Jibambe Savings" < expectedBal then begin
                            diff := expectedBal - Customer."Jibambe Savings";
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Jibambe Savings Acc", Today, diff*-1, 'FOSA', '',
                            'Recoupled Jibambe Contributions', '', GenJournalLine."Application Source"::" ");

                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Ordinary Savings Acc", Today, diff, 'FOSA', '',
                            'Recoupled Jibambe Contributions', '', GenJournalLine."Application Source"::" ");

                            refBal := refBal - diff;
                        end;
                    end;
                end;
                
                refDays := 0;
                if (Customer."Wezesha Savings Acc" <> '') and (Customer."Wezesha Savings Contribution" <> 0) then begin
                    vend.Reset();
                    if vend.Get(Customer."Wezesha Savings Acc") then begin
                        refDays := Round(((Today - vend."Registration Date")/ 30.25), 1, '=');
                    end;
                    if refBal > 0 then begin
                        expectedBal := Customer."Wezesha Savings Contribution" * refDays;
                        if Customer."Wezesha Savings" < expectedBal then begin
                            diff := expectedBal - Customer."Wezesha Savings";
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Wezesha Savings Acc", Today, diff*-1, 'FOSA', '',
                            'Recoupled Wezesha Contributions', '', GenJournalLine."Application Source"::" ");

                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Ordinary Savings Acc", Today, diff, 'FOSA', '',
                            'Recoupled Wezesha Contributions', '', GenJournalLine."Application Source"::" ");

                            refBal := refBal - diff;
                        end;
                    end;
                end;
                
                refDays := 0;
                if (Customer."Mdosi Junior Acc" <> '') and (Customer."Mdosi Jr Contribution" <> 0) then begin
                    vend.Reset();
                    if vend.Get(Customer."Mdosi Junior Acc") then begin
                        refDays := Round(((Today - vend."Registration Date")/ 30.25), 1, '=');
                    end;
                    if refBal > 0 then begin
                        expectedBal := Customer."Mdosi Jr Contribution" * refDays;
                        if Customer."Mdosi Junior" < expectedBal then begin
                            diff := expectedBal - Customer."Mdosi Junior";
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Mdosi Junior Acc", Today, diff*-1, 'FOSA', '',
                            'Recoupled Mdosi Junior Contributions', '', GenJournalLine."Application Source"::" ");

                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Ordinary Savings Acc", Today, diff, 'FOSA', '',
                            'Recoupled Mdosi Junior Contributions', '', GenJournalLine."Application Source"::" ");

                            refBal := refBal - diff;
                        end;
                    end;
                end;
                
                refDays := 0;
                if (Customer."Pension Akiba Acc" <> '') and (Customer."Pension Akiba Contribution" <> 0) then begin
                    vend.Reset();
                    if vend.Get(Customer."Pension Akiba Acc") then begin
                        refDays := Round(((Today - vend."Registration Date")/ 30.25), 1, '=');
                    end;
                    if refBal > 0 then begin
                        expectedBal := Customer."Pension Akiba Contribution" * refDays;
                        if Customer."Pension Akiba" < expectedBal then begin
                            diff := expectedBal - Customer."Pension Akiba";
                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Pension Akiba Acc", Today, diff*-1, 'FOSA', '',
                            'Recoupled Pension Akiba Contributions', '', GenJournalLine."Application Source"::" ");

                            lineNo := lineNo + 1000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Vendor", Customer."Ordinary Savings Acc", Today, diff, 'FOSA', '',
                            'Recoupled Pension Akiba Contributions', '', GenJournalLine."Application Source"::" ");

                            refBal := refBal - diff;
                        end;
                    end;
                end;
            end;
        }
    }

    trigger OnInitReport() begin
        companyInfo.Get();
        companyInfo.CalcFields(Picture, "CEO Signature");
    end;
    
    var
        myInt: Integer;
        refDays: Integer;
        lineNo: Integer;
        expectedBal: Decimal;
        refBal: Decimal;
        diff: Decimal;
        regDate: Date;
        docNo: Code[30];
        batchName: Code[20];
        batchTemplate: Code[20];
        AUFactory: Codeunit "Au Factory";
        saccoGenSetup: Record "Sacco General Set-Up";
        GenBatches: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        cust: Record Customer;
        vend: Record Vendor;
        companyInfo: Record "Company Information";
}
