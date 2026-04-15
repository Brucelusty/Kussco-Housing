//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50947 "Salary Processing Card(Posted)"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = true;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Salary Processing Headerr";///

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    Editable = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Member Bonus?"; Rec."Member Bonus?")
                {
                    //Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    Editable = false;
                }
                field("Loan Cutoff"; Rec."Loan Cutoff")
                {
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Exempt Loan Repayment"; Rec."Exempt Loan Repayment")
                {
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    Visible = false;
                }
                field("Total Count"; Rec."Total Count")
                {
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = false;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Editable = false;
                }
                field(Discard; Rec.Discard)
                {
                    Visible = false;
                }
                field("Pre-Post Blocked Status Update"; Rec."Pre-Post Blocked Status Update")
                {
                    Caption = 'Pre-Post Blocked Status Updated';
                    Editable = false;
                    Visible = false;
                }
                field("Post-Post Blocked Statu Update"; Rec."Post-Post Blocked Statu Update")
                {
                    Caption = 'Post-Post Blocked Status Updated';
                    Editable = false;
                    Visible = false;
                }
            }
            part("172000"; "Salary Processing Lines")
            {
                Caption = 'Salary Processing Lines';
                SubPageLink = "Salary Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1102755021)
            {
                action("SMS Posted")
                {
                    Image = PostBatch;
                    Caption = 'Send SMS';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Cust: record Customer;
                        MessageX: Text[1200];
                        MonthName: text[40];
                        smsManagement: Codeunit "Sms Management";
                        LoanSweeping: Codeunit "Loan Sweeping";
                        ZeroDeductions: Decimal;
                        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
                    begin
                        if Confirm('Are you sure you want to mark this process as Complete thus notifying the members via SMS?', true) = false then exit;

                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);
                        salarybuffer.SetRange("SMS Received", false);
                        if salarybuffer.Find('-') then begin
                            repeat
                                salarybuffer.CalcFields("Mobile Phone Number");

                                mobilePhoneNo := salarybuffer."Mobile Phone Number";
                                if CopyStr(salarybuffer."Mobile Phone Number", 1, 1) = '7' then begin
                                    mobilePhoneNo := InsStr(salarybuffer."Mobile Phone Number", '254', 1);
                                end else if CopyStr(salarybuffer."Mobile Phone Number", 1, 1) = '+' then begin
                                    mobilePhoneNo := DelChr(salarybuffer."Mobile Phone Number", '=', '+');
                                end;

                                Cust.Reset;
                                Cust.Setrange(Cust."No.", salarybuffer."Member No");
                                If Cust.Find('-') then begin
                                    if Rec."Transaction Type" = Rec."Transaction Type"::"Normal Salary" then begin
                                        LoanSweeping.SweepAllDefaultedLoansInd(Cust."No.");
                                        if (Cust."Mobile Phone No" <> '') or (mobilePhoneNo <> '') then begin
                                            MessageX := '';
                                            MonthName := '';
                                            MonthName := FORMAT(Rec."Loan Cutoff", 0, '<Month Text>');
                                            if Rec.Type <> rec.Type::Salary then begin
                                                if Rec."Member Bonus?"=false then
                                                MessageX := 'Dear ' + Cust."First Name" + ', Your ' + MonthName + ' ' + Format(Rec.Type) + ' of Amount Ksh ' + Format(salarybuffer.Amount) + ' has been credited to your account, access through the ATM and M-Banking. Thank you for your patronage.'
                                                else
                                                MessageX := 'Dear ' + Cust."First Name" + ', Your bonus of Amount Ksh ' + Format(salarybuffer.Amount) + ' has been credited to your account, access through the ATM and M-Banking. Thank you for your patronage.';
                                            end;
                                            if Rec.Type = rec.Type::Salary then begin
                                                if salarybuffer."Expected Amount" = 0 then begin
                                                    MessageX := 'Dear ' + Cust."First Name" + ', Your ' + MonthName + ' ' + Format(Rec.Type) + ' of Amount Ksh ' + Format(salarybuffer.Amount) + ' has been credited to your account, access through the ATM and M-Banking. Thank you for your patronage.';
                                                end;

                                                if (salarybuffer."Expected Amount" > 0) and (salarybuffer."Expected Amount" = salarybuffer."Amount Deducted") then begin
                                                    MessageX := 'Dear ' + Cust."First Name" + ', Your ' + MonthName + ' ' + Format(Rec.Type) + ' of Amount Ksh ' + Format(salarybuffer.Amount) + ' has been credited to your account and deductions of Ksh ' + Format(salarybuffer."Amount Deducted") + ', net pay is Ksh ' + Format(salarybuffer.Amount - salarybuffer."Amount Deducted") + ' Thank you for your patronage.';
                                                end;

                                                if (salarybuffer."Expected Amount" > salarybuffer."Amount Deducted") then begin
                                                    MessageX := 'Dear ' + Cust."First Name" + ', Your ' + MonthName + ' ' + Format(Rec.Type) + ' of Amount Ksh ' + Format(salarybuffer.Amount) + ' has been credited to your account and deductions of Ksh ' + Format(salarybuffer."Amount Deducted") + ', net pay is Ksh' + Format(salarybuffer.Amount - salarybuffer."Amount Deducted") + '.You have an outstanding balance of Ksh ' + Format(salarybuffer."Expected Amount" - salarybuffer."Amount Deducted") + ' to be paid.Thank you for your patronage.';
                                                end
                                            end;
                                            smsManagement.SendSmsWithID(Source::SALARY_PROCESSING, mobilePhoneNo, MessageX, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');

                                            salarybuffer."SMS Received" := true;
                                            salarybuffer.Modify;
                                        end;
                                    end else if Rec."Transaction Type" = Rec."Transaction Type"::Mdosi then begin
                                        if (Cust."Mobile Phone No" <> '') or (mobilePhoneNo <> '') then begin
                                            MessageX := 'Dear ' + Cust."First Name" + ', Your New Mdosi Junior account has been credited with the KES 500 boost! Thank you for starting your child''s financial journey with us.';
                                            smsManagement.SendSmsWithID(Source::SALARY_PROCESSING, mobilePhoneNo, MessageX, Cust."No.", Cust."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');

                                            salarybuffer."SMS Received" := true;
                                            salarybuffer.Modify;
                                        end;
                                    end;

                                end;
                            until salarybuffer.Next = 0;
                            Message('Account Holders have received Salary Processing notifications via SMS.');
                        end;
                    end;
                }
                action("Clear Lines")
                {
                    Enabled = not ActionEnabled;
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('This Action will clear all the Lines for the current Salary Document. Do you want to Continue') = false then
                            exit;
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        salarybuffer.DeleteAll;

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'CHECKOFF';
                        DOCUMENT_NO := Rec.Remarks;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                    end;
                }
                action("Import Salaries")
                {
                    Enabled = not ActionEnabled;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = XMLport "Import Salaries";
                }
                action("Validate Data")
                {
                    Enabled = not ActionEnabled;
                    Image = ViewCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(No);
                        Rec.TestField("Document No");
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                salarybuffer."Account Name" := '';
                                salarybuffer.Modify;
                            until salarybuffer.Next = 0;
                        end;
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                ObjVendor.Reset;
                                ObjVendor.SetRange("No.", salarybuffer."Account No.");
                                if ObjVendor.Find('-') then
                                    salarybuffer."Account Name" := ObjVendor.Name;
                                salarybuffer."Mobile Phone Number" := ObjVendor."Phone No.";
                                salarybuffer.Modify;
                            until salarybuffer.Next = 0;
                        end;
                        Message('Validation completed successfully.');
                    end;
                }
                action("Process Salaries")
                {
                    Enabled = not ActionEnabled;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Transfer this Salary to Journals ?') = false then
                            exit;

                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        Datefilter := '..' + Format(Rec."Posting date");
                        if Rec.Amount <> Rec."Scheduled Amount" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'SALARIES';
                        DOCUMENT_NO := Rec."Document No";
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        ObjGenSetup.Get();
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            Window.Open('Processing Salary: @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                            TotalCount := salarybuffer.Count;
                            repeat
                                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                Counter := Counter + 1;
                                Window.Update(1, Percentage);
                                Window.Update(2, Counter);

                                RunBal := salarybuffer.Amount;
                                RunBal := FnPostSalaryToFosa(salarybuffer, RunBal);
                                RunBal := FnRecoverStatutories(salarybuffer, RunBal);
                                RunBal := FnRecoverMobileLoanInterest(salarybuffer, RunBal);
                                RunBal := FnRunInterest(salarybuffer, RunBal);
                                RunBal := FnRecoverMobileLoanPrincipal(salarybuffer, RunBal);
                                RunBal := FnRunPrinciple(salarybuffer, RunBal);
                                FnRunStandingOrders(salarybuffer, RunBal);

                            until salarybuffer.Next = 0;
                        end;
                        //Balancing Journal Entry
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        Rec."Account Type", Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', Rec."Document No", DOCUMENT_NO, '', GenJournalLine."application source"::" ");
                        Message('Salary journals Successfully Generated. BATCH NO=SALARIES.');
                        Window.Close;
                    end;
                }
                action("Mark as Posted")
                {
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to mark this process as Complete ?') = false then
                            exit;
                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            Window.Open('Sending SMS to Members: @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                            TotalCount := salarybuffer.Count;
                            repeat
                                salarybuffer.CalcFields(salarybuffer."Mobile Phone Number");
                                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                Counter := Counter + 1;
                                Window.Update(1, Percentage);
                                Window.Update(2, Counter);
                                if Rec."Transaction Type" = Rec."transaction type"::"Normal Salary" then
                                    SFactory.FnSendSMS('SALARIES', 'Dear ' + SFactory.FnRunSplitString(salarybuffer."Account Name", ' ') + ', your salary has been processed to your Account No. ' +
                                     salarybuffer."Account No.", salarybuffer."Account No.", salarybuffer."Mobile Phone Number")
                                else
                                    SFactory.FnSendSMS('SALARIES', 'Dear ' + SFactory.FnRunSplitString(salarybuffer."Account Name", ' ') + ', your Sacco Savings have been processed to your Account No. ' +
                                      salarybuffer."Account No.", salarybuffer."Account No.", salarybuffer."Mobile Phone Number");
                                if ObjVendor.Get(salarybuffer."Account No.") then begin
                                    if ObjVendor."Salary Processing" = false then begin
                                        ObjVendor."Salary Processing" := true;
                                        ObjVendor.Modify;
                                    end
                                end
                            until salarybuffer.Next = 0;
                        end;
                        Message('Process Completed Successfully. Account Holders will receive Salary processing notification via SMS');
                        Window.Close;
                    end;
                }
                action(Journals)
                {
                    Caption = 'General Journal';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    RunObject = Page "General Journal";
                }
                action("Salaries Deductions")
                {
                    Caption = 'Salary Deductions';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Report "Salary Deductions";
                }
                action("Variance Report")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        SalaryProcessingLines.Reset;
                        SalaryProcessingLines.SetRange(SalaryProcessingLines."Salary Header No.", Rec.No);
                        if SalaryProcessingLines.Find('-') then begin
                            Report.run(175132, true, false, SalaryProcessingLines);
                        end;
                    end;
                }

                action("Variance Loans Report")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        SalaryProcessingLines.Reset;
                        SalaryProcessingLines.SetRange(SalaryProcessingLines."Salary Header No.", Rec.No);
                        if SalaryProcessingLines.Find('-') then begin
                            Report.run(175135, true, false, SalaryProcessingLines);
                        end;
                    end;
                }

                action("Detailed Variance Report")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        SalaryProcessing: Record "Salary Processing Headerr";
                    begin
                        SalaryProcessing.Reset;
                        SalaryProcessing.SetRange(SalaryProcessing.No, Rec.No);
                        if SalaryProcessing.Find('-') then begin
                            Report.run(175140, true, false, SalaryProcessing);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ObjVendorLedger.Reset;
        ObjVendorLedger.SetRange(ObjVendorLedger."Document No.", Rec."Document No");
        if ObjVendorLedger.Find('-') then
            ActionEnabled := true;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        SalaryProcessingLines: Record "Salary Processing Lines";
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        mobilePhoneNo: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record "Members Register";
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
        ELoanBuffer: Record "E-Loan Salary Buffer";
        ObjVendor: Record Vendor;
        MembLedg: Record "Member Ledger Entry";
        SFactory: Codeunit "Au Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        ObjVendorLedger: Record "Vendor Ledger Entry";
        ObjGenSetup: Record "Sacco General Set-Up";
        Charges: Record Charges;
        SalProcessingFee: Decimal;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        ObjSTORegister: Record "Standing Order Register";
        ObjLoanProducts: Record "Loan Products Setup";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;

    local procedure FnPostSalaryToFosa(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjSalaryLines.Amount * -1, 'FOSA', Rec."Document No", 'Salary', '', GenJournalLine."application source"::" ");
        exit(RunningBalance);
    end;

    local procedure FnRecoverStatutories(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        ObjGenSetup.Get();
        if Charges.Get('SALARYP') then begin
            //---------EARN-------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", Charges."GL Account", Rec."Posting date", Charges."Charge Amount" * -1, 'FOSA', Rec."Document No",
            'Processing Fee', '', GenJournalLine."application source"::" ");
            //-----------RECOVER--------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", Charges."Charge Amount", 'FOSA', Rec."Document No",
            'Processing Fee', '', GenJournalLine."application source"::" ");
            SalProcessingFee := Charges."Charge Amount";
            RunningBalance := RunningBalance - SalProcessingFee;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", SalProcessingFee * -0.1, 'FOSA', Rec."Document No",
            'Salary Processing', '', GenJournalLine."application source"::" ");
            //--------------RECOVER------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", SalProcessingFee * 0.1, 'FOSA', Rec."Document No",
            'Excise Duty(10%)', '', GenJournalLine."application source"::" ");
            RunningBalance := RunningBalance - SalProcessingFee * 0.1;
        end;

        if Charges.Get('SMSFEE') then begin
            //--------------EARN----------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", Charges."GL Account", Rec."Posting date", Charges."Charge Amount" * -1, 'FOSA', Rec."Document No",
            'Salary Processing', '', GenJournalLine."application source"::" ");
            //--------------RECOVER------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", Charges."Charge Amount", 'FOSA', Rec."Document No",
            'SMS Charges', '', GenJournalLine."application source"::" ");
            RunningBalance := RunningBalance - Charges."Charge Amount";
        end;
        exit(RunningBalance);
    end;

    local procedure FnRecoverMobileLoanInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Interest");
                    if (SFactory.FnGetInterestDueFiltered(LoanApp, Datefilter) - Abs(LoanApp."Outstanding Interest")) > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := SFactory.FnGetInterestDueFiltered(LoanApp, Datefilter) - Abs(LoanApp."Outstanding Interest");
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            //-------------PAY----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Member, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, 'FOSA', DOCUMENT_NO,
                            Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                            //-------------RECOVER------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, 'FOSA', DOCUMENT_NO,
                            Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");

                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRecoverMobileLoanPrincipal(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then
                if RunningBalance > 0 then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    if LoanApp."Outstanding Balance" > 0 then begin
                        varLRepayment := 0;
                        varLRepayment := LoanApp."Loan Principle Repayment";
                        if LoanApp."Loan Product Type" = 'GUR' then
                            varLRepayment := LoanApp.Repayment;
                        if varLRepayment > 0 then begin
                            if varLRepayment > LoanApp."Outstanding Balance" then
                                varLRepayment := LoanApp."Outstanding Balance";

                            if RunningBalance > 0 then begin
                                if RunningBalance > varLRepayment then begin
                                    AmountToDeduct := varLRepayment;
                                end
                                else
                                    AmountToDeduct := RunningBalance;
                            end;
                            //---------------------PAY-------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."account type"::Member, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, 'FOSA', DOCUMENT_NO,
                            Format(GenJournalLine."Transaction Type"::Repayment), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                            //--------------------RECOVER-----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, 'FOSA', DOCUMENT_NO,
                            Format(GenJournalLine."Transaction Type"::Repayment) + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            if LoanApp.Find('-') then begin
                repeat
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            LoanApp.CalcFields(LoanApp."Outstanding Interest");
                            if (SFactory.FnGetInterestDueFiltered(LoanApp, Datefilter) - Abs(LoanApp."Outstanding Interest")) > 0 then begin
                                if RunningBalance > 0 then begin
                                    AmountToDeduct := 0;
                                    AmountToDeduct := SFactory.FnGetInterestDueFiltered(LoanApp, Datefilter) - Abs(LoanApp."Outstanding Interest");
                                    if RunningBalance <= AmountToDeduct then
                                        AmountToDeduct := RunningBalance;
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                    GenJournalLine."account type"::Member, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), DOCUMENT_NO,
                                    Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), DOCUMENT_NO,
                                    Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                                    RunningBalance := RunningBalance - AmountToDeduct;
                                end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            if LoanApp.Find('-') then begin
                repeat
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            if RunningBalance > 0 then begin
                                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                if LoanApp."Outstanding Balance" > 0 then begin
                                    varLRepayment := 0;
                                    PRpayment := 0;
                                    varLRepayment := LoanApp."Loan Principle Repayment";
                                    if LoanApp."Loan Product Type" = 'GUR' then
                                        varLRepayment := LoanApp.Repayment;
                                    if varLRepayment > 0 then begin
                                        if varLRepayment > LoanApp."Outstanding Balance" then
                                            varLRepayment := LoanApp."Outstanding Balance";

                                        if RunningBalance > 0 then begin
                                            if RunningBalance > varLRepayment then begin
                                                AmountToDeduct := varLRepayment;
                                            end
                                            else
                                                AmountToDeduct := RunningBalance;
                                        end;
                                        //-------------PAY------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                        GenJournalLine."account type"::Member, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), DOCUMENT_NO,
                                        Format(GenJournalLine."Transaction Type"::Repayment), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                                        //-------------RECOVER---------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), DOCUMENT_NO,
                                        Format(GenJournalLine."Transaction Type"::Repayment) + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                                        RunningBalance := RunningBalance - AmountToDeduct;
                                    end;
                                end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunStandingOrders(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            ObjStandingOrders.Reset;
            ObjStandingOrders.SetCurrentkey("No.", "Source Account No.");
            ObjStandingOrders.SetRange("Source Account No.", ObjRcptBuffer."Account No.");
            ObjStandingOrders.SetRange(Status, ObjStandingOrders.Status::Approved);
            ObjStandingOrders.SetRange("Is Active", true);
            ObjStandingOrders.SetRange("Standing Order Dedution Type", ObjStandingOrders."standing order dedution type"::Salary);
            if ObjStandingOrders.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        if ObjStandingOrders."Next Run Date" = 0D then
                            ObjStandingOrders."Next Run Date" := ObjStandingOrders."Effective/Start Date";

                        //ObjStandingOrders.CALCFIELDS("Allocated Amount");
                        if RunningBalance >= ObjStandingOrders.Amount then begin
                            AmountToDeduct := ObjStandingOrders.Amount;
                            DedStatus := Dedstatus::Successfull;
                            if AmountToDeduct >= ObjStandingOrders.Balance then begin
                                AmountToDeduct := ObjStandingOrders.Balance;
                                ObjStandingOrders.Balance := 0;
                                ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                                ObjStandingOrders.Unsuccessfull := false;
                            end
                            else begin
                                ObjStandingOrders.Balance := ObjStandingOrders.Balance - AmountToDeduct;
                                ObjStandingOrders.Unsuccessfull := true;
                            end;
                        end
                        else begin
                            if ObjStandingOrders."Don't Allow Partial Deduction" = true then begin
                                AmountToDeduct := 0;
                                DedStatus := Dedstatus::Failed;
                                ObjStandingOrders.Balance := ObjStandingOrders.Amount;
                                ObjStandingOrders.Unsuccessfull := true;
                            end
                            else begin
                                DedStatus := Dedstatus::"Partial Deduction";
                                ObjStandingOrders.Balance := ObjStandingOrders.Amount - AmountToDeduct;
                                ObjStandingOrders.Unsuccessfull := true;
                            end;
                        end;



                        if ObjStandingOrders."Destination Account Type" <> ObjStandingOrders."destination account type"::"Other Banks Account" then
                            RunningBalance := FnNonBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                        else begin
                            RunningBalance := FnBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                        end;


                        ObjStandingOrders.Effected := true;
                        ObjStandingOrders."Date Reset" := Today;
                        ObjStandingOrders."Next Run Date" := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 2), Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 3))));
                        ObjStandingOrders.Modify;

                        FnRegisterProcessedStandingOrder(ObjStandingOrders, AmountToDeduct);
                    end;
                until ObjStandingOrders.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnCheckIfStandingOrderIsRunnable(ObjStandingOrders: Record "Standing Orders") DontEffect: Boolean
    begin
        DontEffect := false;

        if ObjStandingOrders."Effective/Start Date" <> 0D then begin
            if ObjStandingOrders."Effective/Start Date" > Today then begin
                if Date2dmy(Today, 2) <> Date2dmy(ObjStandingOrders."Effective/Start Date", 2) then
                    DontEffect := true;
            end;
        end;
        exit(DontEffect);
    end;

    local procedure FnNonBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            //-------------RECOVER-----------------------
            if ObjVendor.Get(ObjRcptBuffer."Destination Account No.") then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", ObjRcptBuffer.Amount, 'FOSA', ObjRcptBuffer."No.",
                'Standing Order to ' + ObjVendor."Account Type", '', GenJournalLine."application source"::" ");
            end;
            //-------------PAY----------------------------
            if ObjVendor.Get(ObjRcptBuffer."Source Account No.") then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Destination Account No.", Rec."Posting date", ObjRcptBuffer.Amount * -1, 'FOSA', ObjRcptBuffer."No.",
                'Standing Order From ' + ObjVendor."Account Type", '', GenJournalLine."application source"::" ");
                RunningBalance := RunningBalance - ObjRcptBuffer.Amount;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                repeat
                    if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::Repayment then begin
                        //-------------RECOVER principal-----------------------
                        if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."account type"::Member, LoanApp."Client Code", Rec."Posting date", (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") * -1,
                            'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment), ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ");

                            //-------------PAY Principal----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                            ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                            Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name", '', GenJournalLine."application source"::" ");

                            RunningBalance := RunningBalance - (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");

                            //-------------RECOVER Interest-----------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Member, LoanApp."Client Code", Rec."Posting date", ObjReceiptTransactions."Interest Amount" * -1,
                            'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment), ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ");

                            //-------------PAY Interest----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                            ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                            Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name", '', GenJournalLine."application source"::" ");

                            RunningBalance := RunningBalance - ObjReceiptTransactions."Interest Amount";
                        end;

                    end
                    else begin
                        //-------------RECOVER BOSA NONLoan Transactions-----------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                        GenJournalLine."account type"::Member, ObjRcptBuffer."BOSA Account No.", Rec."Posting date", ObjReceiptTransactions.Amount * -1,
                        'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type"), '', GenJournalLine."application source"::" ");

                        //-------------PAY BOSA NONLoan Transaction----------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", ObjReceiptTransactions.Amount,
                        'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type"), '', GenJournalLine."application source"::" ");

                        RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;

                    end

                until ObjReceiptTransactions.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRegisterProcessedStandingOrder(ObjStandingOrders: Record "Standing Orders"; AmountToDeduct: Decimal)
    begin
        ObjSTORegister.Reset;
        ObjSTORegister.SetRange("Document No.", Rec.No);
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
        ObjSTORegister."Deduction Status" := DedStatus;
        ObjSTORegister.Remarks := ObjStandingOrders."Standing Order Description";
        ObjSTORegister.Amount := ObjStandingOrders.Amount;
        ObjSTORegister."Amount Deducted" := AmountToDeduct;
        if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Member Account" then
            ObjSTORegister.EFT := true;
        ObjSTORegister."Document No." := Rec.No;
        ObjSTORegister.Insert(true);
    end;
}




