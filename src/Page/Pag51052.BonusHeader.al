//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51052 "Bonus-Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Bonus Header";

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
                    Visible = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Visible = false;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                }
                field("Posting date"; Rec."Posting date")
                {
                }

                field("Loan Cutoff"; Rec."Loan Cutoff")
                {
                    Visible = false;
                }
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                    Visible = false;
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
                    //Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Balancing Account Balance"; Rec."Balancing Account Balance")
                {
                    Editable = false;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ShowMandatory = true;
                }
                field(Posted; Rec.Posted)
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Visible = false;
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
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part("172000"; "Bonus Lines")
            {
                Caption = 'Bonus Lines';
                Enabled = false;
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
                        BATCH_NAME := 'SALARIES';

                        DOCUMENT_NO := Rec.Remarks;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                    end;
                }
                action("Import Bonus")
                {
                    Enabled = not ActionEnabled;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = XMLport "Import Bonus";
                }
                action("Import Delayed Salaries")
                {
                    Enabled = not ActionEnabled;
                    Image = Import;
                    Promoted = true;
                    Visible = false;
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
                    var
                        VendX: Record Vendor;
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
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                Members.Reset();
                                Members.SetRange(Members."Payroll No", salarybuffer."Staff No.");
                                if Members.FindFirst() then begin
                                    if salarybuffer."Account No." <> '' then begin
                                        salarybuffer."Account Name" := Members.Name;
                                        salarybuffer."Mobile Phone Number" := Members."Phone No.";
                                        salarybuffer."Member No" := Members."No.";
                                        salarybuffer."Account No." := Members."FOSA Account No.";
                                        salarybuffer.Modify;
                                    end;

                                    if salarybuffer."Account No." = '' then begin
                                        VendX.Reset();
                                        VendX.SetRange(VendX."BOSA Account No", Members."No.");
                                        VendX.SetFilter(VendX."Account Type", '103');
                                        VendX.Setfilter(VendX.Status,'%1|%2',VendX.Status::Active,VendX.Status::Dormant);
                                        if VendX.FindFirst() then begin
                                            salarybuffer."Account Name" := Members.Name;
                                            salarybuffer."Mobile Phone Number" := Members."Phone No.";
                                            salarybuffer."Member No" := Members."No.";
                                            salarybuffer."Account No." := VendX."No.";
                                            salarybuffer.Modify;
                                            Members."FOSA Account" := VendX."No.";
                                            Members.Modify();
                                        end;

                                    end;

                                end;
                            until salarybuffer.Next = 0;

                            Message('Validation completed successfully.');
                        end;
                    END;
                }

                action("Process Bonus")
                {
                    //Enabled = EnableProcessing;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Transfer this Salary to Journals ?') = false then
                            exit;

                        Rec.CalcFields("Scheduled Amount");
                        VarAvailableBal := SFactory.FnRunGetAccountAvailableBalance(Rec."Account No");
                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        Rec.TestField("Cheque No.");
                        Rec.TestField("Transaction Description");
                        Datefilter := '..' + Format(Rec."Posting date");
                        if Rec.Amount <> Rec."Scheduled Amount" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'SALARIES';
                        DOCUMENT_NO := Rec."Document No";
                        EXTERNAL_DOC_NO := "Cheque No.";
                        SMSCODE := '';
                        Counter := 0;
                        FnSalaryProcessing();
                    end;
                }
                action("NET Pay To FOSA")
                {
                    Caption = 'NetPay to FOSA';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()

                    begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Document No.", Rec.No);
                        GenJournalLine.SetRange(GenJournalLine."Account Type", GenJournalLine."Account Type"::Vendor);
                        if GenJournalLine.Find('-') then
                            Report.Run(172136, true, false, GenJournalLine);
                    end;
                }
                action("Salary Processing Report")
                {
                    //172137
                    Caption = 'Salary Processing Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()

                    begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Document No.", Rec.No);
                        GenJournalLine.SetRange(GenJournalLine."Account Type", GenJournalLine."Account Type"::Vendor);
                        if GenJournalLine.Find('-') then
                            Report.Run(172137, true, false, GenJournalLine);
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
                    var
                        Cust: record Customer;
                        MessageX: Text[1200];
                        MonthName: text[40];
                        smsManagement: Codeunit "Sms Management";
                        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
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
                                Cust.Reset;
                                Cust.Setrange(Cust."No.", salarybuffer."Member No");
                                If Cust.Find('-') then begin
                                    if Rec."Transaction Type" = Rec."Transaction Type"::"Normal Salary" then begin
                                        if (Cust."Mobile Phone No" <> '') then begin
                                            MessageX := '';
                                            MonthName := '';
                                            MonthName := FORMAT(Rec."Loan Cutoff", 0, '<Month Text>');
                                            MessageX := 'Dear ' + Cust."First Name" + ', Your ' + MonthName + ' ' + Format(Rec.Type) + ' has been credited to your account, access through the ATM and M-Banking. Thank you for your patronage.';

                                            smsManagement.SendSmsWithID(Source::SALARY_PROCESSING, Cust."Mobile Phone No", MessageX, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                        end;
                                    end;
                                    if ObjVendor.Get(salarybuffer."Account No.") then begin
                                        if ObjVendor."Salary Processing" = false then begin
                                            ObjVendor."Salary Processing" := true;
                                            ObjVendor.Modify;
                                        end;
                                    end;
                                end;
                            until salarybuffer.Next = 0;
                        end;
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec.Modify();
                        Message('Process Completed Successfully. Account Holders will receive Salary processing notification via SMS');

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
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //  if workflowintegration.CheckSalaryProcessingApprovalsWorkflowEnabled(Rec) then
                        //  workflowintegration.OnSendSalaryProcessingForApproval(Rec);

                        /*SalHeader.RESET;
                        SalHeader.SETRANGE(SalHeader.No,No);
                        IF SalHeader.FINDSET THEN
                        BEGIN
                          SalHeader.Status:=SalHeader.Status::Approved;
                          SalHeader.MODIFY;
                        END;*/

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        //  if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        //  workflowintegration.OnCancelSalaryProcessingApprovalRequest(Rec);

                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::SalaryProcessing;
                        ApprovalEntries.SetRecordFilters(Database::"Bonus Header", DocumentType, Rec.No);
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*ObjVendorLedger.RESET;
        ObjVendorLedger.SETRANGE(ObjVendorLedger."Document No.","Document No");
        ObjVendorLedger.SETRANGE("External Document No.","Cheque No.");
        IF ObjVendorLedger.FIND('-') THEN
        ActionEnabled:=TRUE;
        */


        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;

        if (Rec.Status = Rec.Status::Approved) and (Rec.Posted = false) then
            EnableProcessing := true;

    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];

        ExciseDutyP: Decimal;
        Members: Record Customer;
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Bonus Lines";
        SalHeader: Record "Bonus Header";
        Sto: Record "Standing Orders";
        ELoanBuffer: Record "E-Loan Salary Buffer";
        ObjVendor: Record Vendor;
        MembLedg: Record "Cust. Ledger Entry";
        SFactory: Codeunit "Au Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;

        AuSal: Codeunit "Au Factory";
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

        RunningNet: Decimal;

        Saldetails: Record "Salary Details";
        Counter: Integer;
        Percentage: Integer;
        EXTERNAL_DOC_NO: Code[40];
        SMSCODE: Code[30];
        VarAvailableBal: Decimal;
        VarCreditDescription: Text[250];
        VarMemberName: Text;
        ObjSalaryProcessingLines: Record "Bonus Lines";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement,InwardChequeClearing,InValidPaybillTransactions,InternalPV,SalaryProcessing;
        EnableProcessing: Boolean;
        workflowintegration: Codeunit WorkflowIntegration;

    local procedure FnPostSalaryToFosa(ObjSalaryLines: Record "Bonus Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250]): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjSalaryLines.Amount * -1, 'FOSA',
        EXTERNAL_DOC_NO, 'Gross Pay', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");



        ObjGenSetup.Get();
        if ObjGenSetup."Salary Processing Fee" > 0 then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjGenSetup."Salary Processing Fee", 'FOSA',
            EXTERNAL_DOC_NO, 'Salary processing fee ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
            RunningBalance := RunningBalance - ObjGenSetup."Salary Processing Fee";

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Rec."Posting date", -ObjGenSetup."Salary Processing Fee", 'FOSA',
            EXTERNAL_DOC_NO, 'Salary processing fee ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");



            ExciseDutyP := ROUND((ObjGenSetup."Salary Processing Fee" * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ExciseDutyP, 'FOSA',
            EXTERNAL_DOC_NO, 'Excise Duty on salary ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", -ExciseDutyP, 'FOSA',
            EXTERNAL_DOC_NO, 'Excise Duty on salary ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

            RunningBalance := RunningBalance - ExciseDutyP;

            exit(RunningBalance);
        end;
    end;

    local procedure FnPostBonusToFosa(ObjSalaryLines: Record "Bonus Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250])
    var
        AmountToDeduct: Decimal;
        PAYEAmount: Decimal;
        Payroll: Codeunit "Payroll Processing";
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjSalaryLines.Amount * -1, 'FOSA',
        EXTERNAL_DOC_NO, 'Staff Bonus', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");

        PAYEAmount := 0;
        PAYEAmount := Payroll.fnGetEmployeePaye(ObjSalaryLines.Amount);
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", PAYEAmount, 'FOSA',
        EXTERNAL_DOC_NO, 'PAYE on Bonus', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::" ");

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", '200-000-201', Rec."Posting date", PAYEAmount * -1, 'FOSA',
        EXTERNAL_DOC_NO, 'PAYE on Bonus', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");



    end;


    local procedure FnPostSalaryToCustomer(ObjSalaryLines: Record "Bonus Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250]): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
         GenJournalLine."Account Type"::Customer, Rec."Account No", Rec."Posting date", ObjSalaryLines.Amount, 'FOSA',
        EXTERNAL_DOC_NO, 'Gross Pay', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");



        ObjGenSetup.Get();
        if RunningBalance > ObjGenSetup."Salary Processing Fee" then begin
            /*          LineNo := LineNo + 10000;
                   SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."Account Type"::Customer, Rec."Account No", Rec."Posting date", ObjGenSetup."Salary Processing Fee", 'FOSA',
                   EXTERNAL_DOC_NO, 'Salary processing fee', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee"); */


            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Rec."Posting date", -ObjGenSetup."Salary Processing Fee", 'FOSA',
            EXTERNAL_DOC_NO, 'Salary processing fee', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
            RunningBalance := RunningBalance - ObjGenSetup."Salary Processing Fee";


            ExciseDutyP := ROUND((ObjGenSetup."Salary Processing Fee" * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
            /*           LineNo := LineNo + 10000;
                      SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                      GenJournalLine."Account Type"::Customer, Rec."Account No", Rec."Posting date", ExciseDutyP, 'FOSA',
                      EXTERNAL_DOC_NO, 'Excise Duty on salary', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty"); */

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", -ExciseDutyP, 'FOSA',
            EXTERNAL_DOC_NO, 'Excise Duty on salary', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");
            //Message('Run%1Excise%2',RunningBalance,ExciseDutyP);
            RunningBalance := RunningBalance - ExciseDutyP;


        end;
        exit(RunningBalance);
    end;

    local procedure FnPostSalaryToSuspense(ObjSalaryLines: Record "Bonus Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250]): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        ObjGenSetup.Get();
        ObjGenSetup.TestField("Suspense Account");
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", ObjGenSetup."Suspense Account", Rec."Posting date", RunningBalance * -1, 'FOSA',
        EXTERNAL_DOC_NO, 'Gross Pay Suspense', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");




        /*         if ObjGenSetup."Salary Processing Fee" > 0 then begin
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGenSetup."Suspense Account", Rec."Posting date", ObjGenSetup."Salary Processing Fee", 'FOSA',
                    EXTERNAL_DOC_NO, 'Salary processing fee', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");


                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Rec."Posting date", -ObjGenSetup."Salary Processing Fee", 'FOSA',
                    EXTERNAL_DOC_NO, 'Salary processing fee', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");

                    RunningBalance := RunningBalance - ObjGenSetup."Salary Processing Fee";

                    ExciseDutyP := ROUND((ObjGenSetup."Salary Processing Fee" * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGenSetup."Suspense Account", Rec."Posting date", ExciseDutyP, 'FOSA',
                    EXTERNAL_DOC_NO, 'Excise Duty on salary', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", -ExciseDutyP, 'FOSA',
                    EXTERNAL_DOC_NO, 'Excise Duty on salary', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");
                    //Message('Run%1Excise%2',RunningBalance,ExciseDutyP);
                    RunningBalance := RunningBalance - ExciseDutyP;


                end; */
        exit(RunningBalance);
    end;

    local procedure FnRecoverStatutories(ObjSalaryLines: Record "Bonus Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        ObjGenSetup.Get();
        if Charges.Get('SALARYP') then begin
            //---------EARN-------------------------
            Message('Start Processing Charges');
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", Charges."GL Account", Rec."Posting date", Charges."Charge Amount" * -1, 'FOSA', EXTERNAL_DOC_NO,
            Rec."Transaction Description" + ' Fee', '', GenJournalLine."application source"::" ");
            Message('Charges."Charge Amount" * -1 %1', Charges."Charge Amount" * -1);
            //-----------RECOVER--------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", Charges."Charge Amount", 'FOSA', EXTERNAL_DOC_NO,
            'Processing Fee', '', GenJournalLine."application source"::" ");
            SalProcessingFee := Charges."Charge Amount";
            RunningBalance := RunningBalance - SalProcessingFee;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", SalProcessingFee * -1 * ObjGenSetup."Excise Duty(%)" / 100, 'FOSA', EXTERNAL_DOC_NO,
            Rec."Transaction Description", '', GenJournalLine."application source"::" ");
            //--------------RECOVER------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", SalProcessingFee * ObjGenSetup."Excise Duty(%)" / 100, 'FOSA', EXTERNAL_DOC_NO,
            '10% Excise Duty on ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ");
            RunningBalance := RunningBalance - SalProcessingFee * 0.1;
        end;

        if Charges.Get(SMSCODE) then begin
            //--------------EARN----------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", Charges."GL Account", Rec."Posting date", Charges."Charge Amount" * -1, 'FOSA', EXTERNAL_DOC_NO,
            Rec."Transaction Description", '', GenJournalLine."application source"::" ");
            //--------------RECOVER------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", Charges."Charge Amount", 'FOSA', EXTERNAL_DOC_NO,
            Charges.Description, '', GenJournalLine."application source"::" ");
            RunningBalance := RunningBalance - Charges."Charge Amount";
        end;
        exit(RunningBalance);
    end;

    local procedure FnRecoverMobileLoanInterest(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            //LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Account No", ObjRcptBuffer."Account No.");
            //LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            //LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            //LoanApp.SetFilter("Loan Product Type", 'MSADV');
            if LoanApp.Find('-') then begin
                Message('Test');
                repeat
                    LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                    // if (SFactory.FnGetInterestDueFiltered(LoanApp, Datefilter) - Abs(LoanApp."Outstanding Interest")) > 0 then begin
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;
                        AmountToDeduct := SFactory.FnGetInterestDueFiltered(LoanApp, Datefilter) - Abs(LoanApp."Outstanding Interest");
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        //-------------PAY----------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Customer, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, 'FOSA', EXTERNAL_DOC_NO,
                        Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                        //-------------RECOVER------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                        Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");

                        RunningBalance := RunningBalance - AmountToDeduct;
                    end;
                //end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRecoverMobileLoanPrincipal(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            // LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Account No", ObjRcptBuffer."Account No.");
            //LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            //LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            //LoanApp.SetFilter("Loan Product Type", 'MSADV');
            // LoanApp.SetFilter(Posted, 'Yes');
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
                            // Message('start');
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                            GenJournalLine."account type"::Customer, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, 'FOSA', EXTERNAL_DOC_NO,
                            Format(GenJournalLine."transaction type"::Repayment), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                            //--------------------RECOVER-----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                            Format(GenJournalLine."transaction type"::Repayment) + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        LoanPro: Record "Loan Products Setup";

    begin
        if RunningBalance > 0 then begin

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Loan Product Type", '<>%1|%2', 'M_OD', 'A16');
            LoanApp.SetFilter(LoanApp."Disbursement Date", '..%1', Rec."Loan Cutoff");
            LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
            if LoanApp.Find('-') then begin
                repeat

                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin

                        LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                        if (SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff")) > 0 then begin

                            if RunningBalance > 0 then begin
                                AmountToDeduct := 0;
                                AmountToDeduct := SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff");
                                if RunningBalance <= AmountToDeduct then
                                    AmountToDeduct := RunningBalance;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                 Rec."Transaction Description" + ' ' + Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                 Rec."Transaction Description" + ' ' + Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");
                                RunningBalance := RunningBalance - AmountToDeduct;
                                //  end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunBenevolent(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        LoanPro: Record "Loan Products Setup";
        SaccoGen: Record "Sacco General Set-Up";

    begin
        if RunningBalance > 0 then begin
            SaccoGen.Get();

            AmountToDeduct := 0;
            AmountToDeduct := SaccoGen."Benevolent Fund Contribution";
            if RunningBalance <= AmountToDeduct then
                AmountToDeduct := RunningBalance;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
             Rec."Transaction Description" + ' ' + Format(GenJournalLine."transaction type"::" ") + '.', LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::" ");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
             Rec."Transaction Description" + ' ' + Format(GenJournalLine."transaction type"::" ") + '.', LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::" ");
            RunningBalance := RunningBalance - AmountToDeduct;


            exit(RunningBalance);
        end;
    end;


    local procedure FnRunBenevolentDelayed(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        LoanPro: Record "Loan Products Setup";

    begin
        if RunningBalance > 0 then begin


            AmountToDeduct := 0;
            AmountToDeduct := 3;
            if RunningBalance <= AmountToDeduct then
                AmountToDeduct := RunningBalance;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
             Rec."Transaction Description" + ' ' + Format(GenJournalLine."transaction type"::" ") + '.', LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::" ");
            /* 
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                        Format(GenJournalLine."transaction type"::" ") + '.', LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::" "); */
            RunningBalance := RunningBalance - AmountToDeduct;


            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterestDelayed(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Bonus Header"): Decimal
    var
        AmountToDeduct: Decimal;

    begin
        if RunningBalance > 0 then begin

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Loan Product Type", '<>%1|%2', 'M_OD', 'A16');
            LoanApp.SetFilter(LoanApp."Disbursement Date", '..%1', Rec."Loan Cutoff");
            LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
            if LoanApp.Find('-') then begin
                repeat

                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin

                        LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                        if (SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff")) > 0 then begin

                            if RunningBalance > 0 then begin
                                AmountToDeduct := 0;
                                AmountToDeduct := SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff");
                                if RunningBalance <= AmountToDeduct then
                                    AmountToDeduct := RunningBalance;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                 Rec."Transaction Description" + ' ' + Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");
                                RunningBalance := RunningBalance - AmountToDeduct;
                                //  end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnTransferNetDelayed(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Bonus Header")
    var
        AmountToDeduct: Decimal;
        SaccoGeneral: Record "Sacco General Set-Up";
    begin
        if RunningBalance > 0 then begin



            if RunningBalance > 0 then begin
                AmountToDeduct := 0;
                AmountToDeduct := RunningBalance;
                LineNo := LineNo + 10000;
                SaccoGeneral.Get();
                SaccoGeneral.TestField("Delayed Net Account");
                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."Account Type"::"G/L Account", SaccoGeneral."Delayed Net Account", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                Rec."Transaction Description" + ' ' + 'Net Pay', '', GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"Net Pay");

                /*                 LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."Account Type"::Customer, ObjRcptRec."Account No", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                'Net Pay', '', GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"Net Pay"); */
                RunningBalance := RunningBalance - AmountToDeduct;
                //  end;
            end;


        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        AmountPaid: Decimal;
        ScheduleAmount: Decimal;
        Arrears: Decimal;
        LoanApps: Record "Loans Register";
        MonthlyRepayment: Decimal;
        MonthlyArrears: Decimal;
        OutstandingInterest: decimal;
        LoanPro: Record "Loan Products Setup";

    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            AmountPaid := 0;
            MonthlyArrears := 0;
            MonthlyRepayment := 0;
            OutstandingInterest := 0;

            LoanApps.Reset;
            //LoanApps.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApps.SetRange(LoanApps."Client Code", ObjRcptBuffer."Member No");
            LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
            LoanApps.SetRange(LoanApps."Recovery Mode", LoanApps."recovery mode"::Salary);
            LoanApps.SetFilter(LoanApps."Disbursement Date", '..%1', Rec."Loan Cutoff");
            LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
            LoanApps.SetFilter(LoanApps."Outstanding Balance", '>%1', 0);
            //LoanApps.SetFilter(LoanApps."Loan Product Type", '<>%1|%2', 'A16', 'M_OD');
            if LoanApps.FindSet() then begin
                repeat

                    //if (LoanApps."Loan Product Type" <> 'A16') or (LoanApps."Loan Product Type" <> 'M_OD') then begin
                    if ObjLoanProducts.Get(LoanApps."Loan Product Type") then begin
                        if (ObjLoanProducts."Charge Interest Upfront" = false) then begin
                            //AND  (LoanApps."Recovery Mode"=LoanApps."Recovery Mode"::Salary) then begin
                            //if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            if RunningBalance > 0 then begin
                                /*   LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
                                 AmountPaid := LoanApp."Approved Amount" - LoanApp."Outstanding Balance";
                                 ScheduleAmount := 0;
                                 Arrears := 0;
                                 LSchedule.RESET;
                                 LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
                                 LSchedule.setfilter(LSchedule."Repayment Date", '..%1', calcdate('CM', Rec."Loan Cutoff"));
                                 if LSchedule.FindLast() then begin
                                     //LSchedule.CalcSums(LSchedule."Principal Repayment");
                                     ScheduleAmount := LSchedule."Loan Balance";
                                     MonthlyRepayment := LSchedule."Monthly Repayment";
                                 end;
                                 Arrears := Round((LoanApp."Outstanding Balance" - ScheduleAmount), 0.01, '=');
                                 if Arrears < 0 then
                                     Arrears := 0
                                 else
                                     Arrears := Arrears;

                                 LoanPro.Get(LoanApp."Loan Product Type");

                                 //-------------PAY------------------
                                 LineNo := LineNo + 10000;
                                 SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                 GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", Arrears * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                 'Loan Arrears Repayment ' + Format(LoanPro."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                 //-------------RECOVER---------------
                                 LineNo := LineNo + 10000;
                                 SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                 GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", Arrears, Format(LoanApp.Source), LoanApp."Loan  No.",
                                 'Loan Arrears ' + Format(GenJournalLine."Transaction Type"::Repayment) + '-' + LoanPro."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                 RunningBalance := RunningBalance - Arrears;

                                 MonthlyRepayment := 0;
                                 LSchedule.RESET;
                                 LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
                                 LSchedule.setfilter(LSchedule."Repayment Date", '%1..%2', calcdate('-CM', Rec."Loan Cutoff"), calcdate('CM', Rec."Loan Cutoff"));
                                 if LSchedule.FindFirst() then begin
                                     //LSchedule.CalcSums(LSchedule."Principal Repayment");
                                     ScheduleAmount := LSchedule."Loan Balance";
                                     MonthlyRepayment := LSchedule."Principal Repayment";
                                 end;
                                 MonthlyArrears := MonthlyRepayment;// - LoanApp."Outstanding Interest";


                                 //if LoanApp."Outstanding Balance" > 0 then begin
                                     varLRepayment := 0;
                                     PRpayment := 0;
                                     varLRepayment := MonthlyArrears;
                                    // if varLRepayment > 0 then begin
                                         if varLRepayment > LoanApp."Outstanding Balance" then
                                             varLRepayment := LoanApp."Outstanding Balance"; */

                                AmountToDeduct := 0;
                                varLRepayment := 0;
                                ScheduleAmount := 0;
                                MonthlyRepayment := 0;
                                LSchedule.RESET;
                                LSchedule.SetRange(LSchedule."Loan No.", LoanApps."Loan  No.");
                                LSchedule.setfilter(LSchedule."Repayment Date", '%1..%2', calcdate('-CM', Rec."Loan Cutoff"), calcdate('CM', Rec."Loan Cutoff"));
                                if LSchedule.FindFirst() then begin
                                    LSchedule.CalcSums(LSchedule."Principal Repayment");
                                    ScheduleAmount := LSchedule."Loan Balance";
                                    MonthlyRepayment := LSchedule."Principal Repayment";
                                end;
                                varLRepayment := MonthlyRepayment;
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                //-------------PAY------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
                                Rec."Transaction Description" + ' Loan Repayment ' + Format(ObjLoanProducts."Product Description"), LoanApps."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                //-------------RECOVER---------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApps.Source), LoanApp."Loan  No.",
                                Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjLoanProducts."Product Description", LoanApps."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                RunningBalance := RunningBalance - AmountToDeduct;
                                // end;

                            end;
                        end;
                    end;
                until LoanApps.Next = 0;
            end;

            LoanApp.Reset;
            //LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            // LoanApp.SetRange(LoanApp."Loan  No.", 'LN012628');
            //LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
            LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
            LoanApp.SetFilter(LoanApp."Loan Product Type", '%1|%2', 'A16', 'M_OD');
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
            //LoanApps.SetFilter(LoanApps."Disbursement Date", '..%1', Rec."Loan Cutoff");
            // LoanApp.SetFilter(LoanApp."Loan Product Type", '%1|%2', 'M_OD', 'A16');
            if LoanApp.FindSet() then begin
                repeat
                    // if (LoanApp."Loan Product Type" = 'A16') or (LoanApp."Loan Product Type" = 'M_OD') then begin
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if (ObjLoanProducts."Charge Interest Upfront" = true) /* AND (LoanApps."Recovery Mode" = LoanApps."Recovery Mode"::Salary) */ then begin
                            //if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            if RunningBalance > 0 then begin
                                /*   LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
                                 AmountPaid := LoanApp."Approved Amount" - LoanApp."Outstanding Balance";
                                 ScheduleAmount := 0;
                                 Arrears := 0;
                                 LSchedule.RESET;
                                 LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
                                 LSchedule.setfilter(LSchedule."Repayment Date", '..%1', calcdate('CM', Rec."Loan Cutoff"));
                                 if LSchedule.FindLast() then begin
                                     //LSchedule.CalcSums(LSchedule."Principal Repayment");
                                     ScheduleAmount := LSchedule."Loan Balance";
                                     MonthlyRepayment := LSchedule."Monthly Repayment";
                                 end;
                                 Arrears := Round((LoanApp."Outstanding Balance" - ScheduleAmount), 0.01, '=');
                                 if Arrears < 0 then
                                     Arrears := 0
                                 else
                                     Arrears := Arrears;

                                 LoanPro.Get(LoanApp."Loan Product Type");

                                 //-------------PAY------------------
                                 LineNo := LineNo + 10000;
                                 SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                 GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", Arrears * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                 'Loan Arrears Repayment ' + Format(LoanPro."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                 //-------------RECOVER---------------
                                 LineNo := LineNo + 10000;
                                 SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                 GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", Arrears, Format(LoanApp.Source), LoanApp."Loan  No.",
                                 'Loan Arrears ' + Format(GenJournalLine."Transaction Type"::Repayment) + '-' + LoanPro."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                 RunningBalance := RunningBalance - Arrears;

                                 MonthlyRepayment := 0;
                                 LSchedule.RESET;
                                 LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
                                 LSchedule.setfilter(LSchedule."Repayment Date", '%1..%2', calcdate('-CM', Rec."Loan Cutoff"), calcdate('CM', Rec."Loan Cutoff"));
                                 if LSchedule.FindFirst() then begin
                                     //LSchedule.CalcSums(LSchedule."Principal Repayment");
                                     ScheduleAmount := LSchedule."Loan Balance";
                                     MonthlyRepayment := LSchedule."Principal Repayment";
                                 end;
                                 MonthlyArrears := MonthlyRepayment;// - LoanApp."Outstanding Interest";


                                 //if LoanApp."Outstanding Balance" > 0 then begin
                                     varLRepayment := 0;
                                     PRpayment := 0;
                                     varLRepayment := MonthlyArrears;
                                    // if varLRepayment > 0 then begin
                                         if varLRepayment > LoanApp."Outstanding Balance" then
                                             varLRepayment := LoanApp."Outstanding Balance"; */
                                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                AmountToDeduct := 0;
                                varLRepayment := 0;
                                ScheduleAmount := 0;
                                MonthlyRepayment := 0;

                                MonthlyRepayment := LoanApp."Approved Amount" / LoanApp.Installments;
                                if MonthlyRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance"
                                else
                                    varLRepayment := MonthlyRepayment;
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                //-------------PAY------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                Rec."Transaction Description" + ' Loan Repayment ' + Format(ObjLoanProducts."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                //-------------RECOVER---------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                RunningBalance := RunningBalance - AmountToDeduct;
                                // end;

                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrincipleDelayed(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Bonus Header"): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        AmountPaid: Decimal;
        ScheduleAmount: Decimal;
        Arrears: Decimal;
        LoanApps: Record "Loans Register";
        MonthlyRepayment: Decimal;
        MonthlyArrears: Decimal;
        OutstandingInterest: decimal;
        LoanPro: Record "Loan Products Setup";

    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            AmountPaid := 0;
            MonthlyArrears := 0;
            MonthlyRepayment := 0;
            OutstandingInterest := 0;

            LoanApps.Reset;
            //LoanApps.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApps.SetRange(LoanApps."Client Code", ObjRcptBuffer."Member No");
            LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
            LoanApps.SetRange(LoanApps."Recovery Mode", LoanApps."recovery mode"::Salary);
            LoanApps.SetFilter(LoanApps."Disbursement Date", '..%1', Rec."Loan Cutoff");
            LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
            LoanApps.SetFilter(LoanApps."Outstanding Balance", '>%1', 0);
            //LoanApps.SetFilter(LoanApps."Loan Product Type", '<>%1|%2', 'A16', 'M_OD');
            if LoanApps.FindSet() then begin
                repeat

                    //if (LoanApps."Loan Product Type" <> 'A16') or (LoanApps."Loan Product Type" <> 'M_OD') then begin
                    if ObjLoanProducts.Get(LoanApps."Loan Product Type") then begin
                        if (ObjLoanProducts."Charge Interest Upfront" = false) then begin
                            //AND  (LoanApps."Recovery Mode"=LoanApps."Recovery Mode"::Salary) then begin
                            //if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            if RunningBalance > 0 then begin
                                /*   LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
                                 AmountPaid := LoanApp."Approved Amount" - LoanApp."Outstanding Balance";
                                 ScheduleAmount := 0;
                                 Arrears := 0;
                                 LSchedule.RESET;
                                 LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
                                 LSchedule.setfilter(LSchedule."Repayment Date", '..%1', calcdate('CM', Rec."Loan Cutoff"));
                                 if LSchedule.FindLast() then begin
                                     //LSchedule.CalcSums(LSchedule."Principal Repayment");
                                     ScheduleAmount := LSchedule."Loan Balance";
                                     MonthlyRepayment := LSchedule."Monthly Repayment";
                                 end;
                                 Arrears := Round((LoanApp."Outstanding Balance" - ScheduleAmount), 0.01, '=');
                                 if Arrears < 0 then
                                     Arrears := 0
                                 else
                                     Arrears := Arrears;

                                 LoanPro.Get(LoanApp."Loan Product Type");

                                 //-------------PAY------------------
                                 LineNo := LineNo + 10000;
                                 SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                 GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", Arrears * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                 'Loan Arrears Repayment ' + Format(LoanPro."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                 //-------------RECOVER---------------
                                 LineNo := LineNo + 10000;
                                 SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                 GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", Arrears, Format(LoanApp.Source), LoanApp."Loan  No.",
                                 'Loan Arrears ' + Format(GenJournalLine."Transaction Type"::Repayment) + '-' + LoanPro."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                 RunningBalance := RunningBalance - Arrears;

                                 MonthlyRepayment := 0;
                                 LSchedule.RESET;
                                 LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
                                 LSchedule.setfilter(LSchedule."Repayment Date", '%1..%2', calcdate('-CM', Rec."Loan Cutoff"), calcdate('CM', Rec."Loan Cutoff"));
                                 if LSchedule.FindFirst() then begin
                                     //LSchedule.CalcSums(LSchedule."Principal Repayment");
                                     ScheduleAmount := LSchedule."Loan Balance";
                                     MonthlyRepayment := LSchedule."Principal Repayment";
                                 end;
                                 MonthlyArrears := MonthlyRepayment;// - LoanApp."Outstanding Interest";


                                 //if LoanApp."Outstanding Balance" > 0 then begin
                                     varLRepayment := 0;
                                     PRpayment := 0;
                                     varLRepayment := MonthlyArrears;
                                    // if varLRepayment > 0 then begin
                                         if varLRepayment > LoanApp."Outstanding Balance" then
                                             varLRepayment := LoanApp."Outstanding Balance"; */

                                AmountToDeduct := 0;
                                varLRepayment := 0;
                                ScheduleAmount := 0;
                                MonthlyRepayment := 0;
                                LSchedule.RESET;
                                LSchedule.SetRange(LSchedule."Loan No.", LoanApps."Loan  No.");
                                LSchedule.setfilter(LSchedule."Repayment Date", '%1..%2', calcdate('-CM', Rec."Loan Cutoff"), calcdate('CM', Rec."Loan Cutoff"));
                                if LSchedule.FindFirst() then begin
                                    LSchedule.CalcSums(LSchedule."Principal Repayment");
                                    ScheduleAmount := LSchedule."Loan Balance";
                                    MonthlyRepayment := LSchedule."Principal Repayment";
                                end;
                                varLRepayment := MonthlyRepayment;
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                //-------------PAY------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
                                Rec."Transaction Description" + ' ' + 'Loan Repayment ' + Format(LoanPro."Product Description"), LoanApps."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                RunningBalance := RunningBalance - AmountToDeduct;
                                // end;

                            end;
                        end;
                    end;
                until LoanApps.Next = 0;
            end;

            LoanApp.Reset;
            //LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            // LoanApp.SetRange(LoanApp."Loan  No.", 'LN012628');
            //LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
            LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
            LoanApp.SetFilter(LoanApp."Loan Product Type", '%1|%2', 'A16', 'M_OD');
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
            //LoanApps.SetFilter(LoanApps."Disbursement Date", '..%1', Rec."Loan Cutoff");
            // LoanApp.SetFilter(LoanApp."Loan Product Type", '%1|%2', 'M_OD', 'A16');
            if LoanApp.FindSet() then begin
                repeat
                    // if (LoanApp."Loan Product Type" = 'A16') or (LoanApp."Loan Product Type" = 'M_OD') then begin
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if (ObjLoanProducts."Charge Interest Upfront" = true) /* AND (LoanApps."Recovery Mode" = LoanApps."Recovery Mode"::Salary) */ then begin
                            //if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            if RunningBalance > 0 then begin
                                /*   LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
                                 AmountPaid := LoanApp."Approved Amount" - LoanApp."Outstanding Balance";
                                 ScheduleAmount := 0;
                                 Arrears := 0;
                                 LSchedule.RESET;
                                 LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
                                 LSchedule.setfilter(LSchedule."Repayment Date", '..%1', calcdate('CM', Rec."Loan Cutoff"));
                                 if LSchedule.FindLast() then begin
                                     //LSchedule.CalcSums(LSchedule."Principal Repayment");
                                     ScheduleAmount := LSchedule."Loan Balance";
                                     MonthlyRepayment := LSchedule."Monthly Repayment";
                                 end;
                                 Arrears := Round((LoanApp."Outstanding Balance" - ScheduleAmount), 0.01, '=');
                                 if Arrears < 0 then
                                     Arrears := 0
                                 else
                                     Arrears := Arrears;

                                 LoanPro.Get(LoanApp."Loan Product Type");

                                 //-------------PAY------------------
                                 LineNo := LineNo + 10000;
                                 SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                 GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", Arrears * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                 'Loan Arrears Repayment ' + Format(LoanPro."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                 //-------------RECOVER---------------
                                 LineNo := LineNo + 10000;
                                 SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                 GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", Arrears, Format(LoanApp.Source), LoanApp."Loan  No.",
                                 'Loan Arrears ' + Format(GenJournalLine."Transaction Type"::Repayment) + '-' + LoanPro."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                 RunningBalance := RunningBalance - Arrears;

                                 MonthlyRepayment := 0;
                                 LSchedule.RESET;
                                 LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
                                 LSchedule.setfilter(LSchedule."Repayment Date", '%1..%2', calcdate('-CM', Rec."Loan Cutoff"), calcdate('CM', Rec."Loan Cutoff"));
                                 if LSchedule.FindFirst() then begin
                                     //LSchedule.CalcSums(LSchedule."Principal Repayment");
                                     ScheduleAmount := LSchedule."Loan Balance";
                                     MonthlyRepayment := LSchedule."Principal Repayment";
                                 end;
                                 MonthlyArrears := MonthlyRepayment;// - LoanApp."Outstanding Interest";


                                 //if LoanApp."Outstanding Balance" > 0 then begin
                                     varLRepayment := 0;
                                     PRpayment := 0;
                                     varLRepayment := MonthlyArrears;
                                    // if varLRepayment > 0 then begin
                                         if varLRepayment > LoanApp."Outstanding Balance" then
                                             varLRepayment := LoanApp."Outstanding Balance"; */
                                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                AmountToDeduct := 0;
                                varLRepayment := 0;
                                ScheduleAmount := 0;
                                MonthlyRepayment := 0;

                                MonthlyRepayment := LoanApp."Approved Amount" / LoanApp.Installments;
                                if MonthlyRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance"
                                else
                                    varLRepayment := MonthlyRepayment;
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                //-------------PAY------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                Rec."Transaction Description" + ' ' + 'Loan Repayment ' + Format(LoanPro."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                                RunningBalance := RunningBalance - AmountToDeduct;
                                // end;

                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunStandingOrders(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal): Decimal
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
            //ObjStandingOrders.SetRange("Standing Order Dedution Type", ObjStandingOrders."standing order dedution type"::Salary);
            if ObjStandingOrders.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        // if ObjStandingOrders."Next Run Date" = 0D then
                        //   ObjStandingOrders."Next Run Date" := ObjStandingOrders."Effective/Start Date";

                        //ObjStandingOrders.CALCFIELDS("Allocated Amount");
                        /*                       if RunningBalance >= ObjStandingOrders.Amount then begin
                                                  AmountToDeduct := ObjStandingOrders.Amount;
                                                  DedStatus := Dedstatus::Successfull;
                                                  if AmountToDeduct >= ObjStandingOrders.Balance then begin
                                                      AmountToDeduct := ObjStandingOrders.Balance;
                                                      ObjStandingOrders.Balance := 0;
                                                      //  ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
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
                                                      DedStatus := Dedstatus::"Partial Deduction";Kit
                                                      ObjStandingOrders.Balance := ObjStandingOrders.Amount - AmountToDeduct;
                                                      ObjStandingOrders.Unsuccessfull := true;
                                                  end;
                                              end; */

                        //Message('Here');


                        RunningBalance := FnBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance);



                        ObjStandingOrders.Effected := true;
                        ObjStandingOrders."Date Reset" := Today;
                        //ObjStandingOrders."Next Run Date" := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 2), Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 3))));
                        ObjStandingOrders.Modify;

                        FnRegisterProcessedStandingOrder(ObjStandingOrders, AmountToDeduct);
                    end;
                until ObjStandingOrders.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunStandingOrdersDelayed(ObjRcptBuffer: Record "Bonus Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Bonus Header"): Decimal
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
            //ObjStandingOrders.SetRange("Standing Order Dedution Type", ObjStandingOrders."standing order dedution type"::Salary);
            if ObjStandingOrders.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        // if ObjStandingOrders."Next Run Date" = 0D then
                        //   ObjStandingOrders."Next Run Date" := ObjStandingOrders."Effective/Start Date";

                        //ObjStandingOrders.CALCFIELDS("Allocated Amount");
                        /*                         if RunningBalance >= ObjStandingOrders.Amount then begin
                                                    AmountToDeduct := ObjStandingOrders.Amount;
                                                    DedStatus := Dedstatus::Successfull;
                                                    if AmountToDeduct >= ObjStandingOrders.Balance then begin
                                                        AmountToDeduct := ObjStandingOrders.Balance;
                                                        ObjStandingOrders.Balance := 0;
                                                        //  ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
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
                                                end; */



                        //if ObjStandingOrders."Destination Account Type" <> ObjStandingOrders."destination account type"::"Other Banks Account" then
                        // RunningBalance := FnNonBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                        // else begin
                        RunningBalance := FnBosaStandingOrderTransactionDelayed(ObjStandingOrders, RunningBalance, ObjRcptRec);
                        //end;


                        ObjStandingOrders.Effected := true;
                        ObjStandingOrders."Date Reset" := Today;
                        //ObjStandingOrders."Next Run Date" := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 2), Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 3))));
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
        RemainBal: Decimal;
        InterestBal: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                repeat
                    if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::Member then begin
                        if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::Repayment then begin
                            //-------------RECOVER principal-----------------------
                            if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                                if LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary then begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                    GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") * -1,
                                    'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                    //-------------PAY Principal----------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                                    ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                    Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                    RunningBalance := RunningBalance - (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");
                                end;


                                if LoanApp."Recovery Mode" <> LoanApp."Recovery Mode"::Salary then begin
                                    RemainBal := 0;
                                    InterestBal := 0;
                                    RemainBal := ObjReceiptTransactions.Amount;
                                    LoanApp.CalcFields(LoanApp."Outstanding Interest");
                                    if RemainBal > LoanApp."Outstanding Interest" then
                                        InterestBal := LoanApp."Outstanding Interest"
                                    else
                                        InterestBal := RemainBal;


                                    //-------------RECOVER Interest-----------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                    GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", InterestBal * -1,
                                    'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                    //-------------PAY Interest----------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                                    InterestBal, 'FOSA', ObjRcptBuffer."No.",
                                    Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");
                                    RemainBal := RemainBal - InterestBal;
                                    RunningBalance := RunningBalance - LoanApp."Outstanding Interest";

                                    if RemainBal > 0 then begin
                                        //-------------PAY Principal----------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                        GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", (RemainBal) * -1,
                                        'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");


                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                                        RemainBal, 'FOSA', ObjRcptBuffer."No.",
                                         Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                        RunningBalance := RunningBalance - (RemainBal);

                                    end;
                                end;
                            end;

                        end
                        else begin
                            //-------------RECOVER BOSA NONLoan Transactions-----------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                            GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", ObjReceiptTransactions.Amount * -1,
                            'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                            //-------------PAY BOSA NONLoan Transaction----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", ObjReceiptTransactions.Amount,
                            'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                            RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;

                        end;
                    end else begin
                        if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::"FOSA Account" then begin
                            // Message('Here%1');
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                            GenJournalLine."account type"::Vendor, ObjReceiptTransactions."Member No", Rec."Posting date", ObjReceiptTransactions.Amount * -1,
                            'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                            //-------------PAY BOSA NONLoan Transaction----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", ObjReceiptTransactions.Amount,
                            'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                            RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;
                        end;

                    end;

                until ObjReceiptTransactions.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;


    local procedure FnBosaStandingOrderTransactionDelayed(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal; ObjRcptRec: Record "Bonus Header"): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
        RemainBal: Decimal;
        InterestBal: Decimal;
        FosaAmount: Decimal;
        CustomerAmount: Decimal;
    begin

        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                repeat
                    if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::Member then begin
                        if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::Repayment then begin
                            //-------------RECOVER principal-----------------------
                            if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin

                                if LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary then begin
                                    If RunningBalance > 0 then begin
                                        LineNo := LineNo + 100000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                        GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") * -1,
                                        'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                        //-------------PAY Principal----------------------------
                                        /*                                     LineNo := LineNo + 10000;
                                                                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                                            GenJournalLine."Account Type"::Customer, ObjRcptRec."Account No", Rec."Posting date",
                                                                            ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                                                            Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO"); */

                                        RunningBalance := RunningBalance - (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");
                                    end;
                                end;


                                if LoanApp."Recovery Mode" <> LoanApp."Recovery Mode"::Salary then begin
                                    If RunningBalance > 0 then begin
                                        RemainBal := 0;
                                        InterestBal := 0;
                                        RemainBal := ObjReceiptTransactions.Amount;
                                        LoanApp.CalcFields(LoanApp."Outstanding Interest");
                                        if RemainBal > LoanApp."Outstanding Interest" then
                                            InterestBal := LoanApp."Outstanding Interest"
                                        else
                                            InterestBal := RemainBal;


                                        //-------------RECOVER Interest-----------------------
                                        LineNo := LineNo + 100000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", InterestBal * -1,
                                        'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");


                                        RemainBal := RemainBal - InterestBal;
                                        RunningBalance := RunningBalance - LoanApp."Outstanding Interest";
                                    end;
                                    If RunningBalance > 0 then begin
                                        if RemainBal > 0 then begin

                                            //-------------PAY Principal----------------------------
                                            LineNo := LineNo + 10000;
                                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                            GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", (RemainBal) * -1,
                                            'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");


                                            RunningBalance := RunningBalance - (RemainBal);
                                        end;
                                    end;
                                end;
                            end;

                        end
                        else begin
                            //-------------RECOVER BOSA NONLoan Transactions-----------------------
                            If RunningBalance > 0 then begin
                                CustomerAmount := 0;
                                CustomerAmount := ObjReceiptTransactions.Amount;
                                if CustomerAmount < RunningBalance then
                                    CustomerAmount := CustomerAmount
                                else
                                    CustomerAmount := RunningBalance;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                                GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", CustomerAmount * -1,
                                'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                //-------------PAY BOSA NONLoan Transaction----------------------------
                                /*                             LineNo := LineNo + 10000;
                                                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                                                            GenJournalLine."Account Type"::Customer, ObjRcptRec."Account No", Rec."Posting date", ObjReceiptTransactions.Amount,
                                                            'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO"); */

                                RunningBalance := RunningBalance - CustomerAmount;
                            end;
                        end;
                    end else begin
                        if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::"FOSA Account" then begin
                            If RunningBalance > 0 then begin
                                FosaAmount := 0;
                                FosaAmount := ObjReceiptTransactions.Amount;
                                if FosaAmount < RunningBalance then
                                    FosaAmount := FosaAmount
                                else
                                    FosaAmount := RunningBalance;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                                GenJournalLine."account type"::Vendor, ObjReceiptTransactions."Member No", Rec."Posting date", FosaAmount * -1,
                                'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                //-------------PAY BOSA NONLoan Transaction----------------------------
                                /*                             LineNo := LineNo + 10000;
                                                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                                                            GenJournalLine."Account Type"::Customer, ObjRcptRec."Account No", Rec."Posting date", ObjReceiptTransactions.Amount,
                                                            'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO"); */

                                RunningBalance := RunningBalance - FosaAmount;
                            end;
                        end;

                    end;

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

    local procedure FnSalaryProcessing()
    var
        Vends: record Vendor;
        SalNo: Integer;
        Sal: Record "Salary Details";
        Cust: record Customer;
        MessageX: Text[1200];
        MonthName: text[40];
        smsManagement: Codeunit "Sms Management";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := Rec."Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        ObjGenSetup.Get();

        VarCreditDescription := '';

        Saldetails.Reset();
        Saldetails.SetRange(Saldetails."Document Number", Rec.No);
        if Saldetails.FindSet() then begin
            Saldetails.DeleteAll();
        end;

        SalNo := 0;
        Sal.Reset();
        if Sal.FindLast() then
            SalNo := Sal."Entry No" + 1
        else
            SalNo := 1;
        //Message('SalNo%1', SalNo);
        salarybuffer.Reset;
        salarybuffer.SetRange("Salary Header No.", Rec.No);
        if salarybuffer.Find('-') then begin
           // Window.Open(Format(Rec."Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
               // Percentage := (ROUND(Counter / TotalCount * 10000, 1));
               // Counter := Counter + 1;
                //Window.Update(1, Percentage);
                //Window.Update(2, Counter);
                RunBal := 0;
                FnPostBonusToFosa(salarybuffer, RunBal, salarybuffer."Credit Narration");

                Cust.Reset;
                Cust.Setrange(Cust."No.", salarybuffer."Member No");
                If Cust.Find('-') then begin
                    if (Cust."Mobile Phone No" <> '') then begin
                        MessageX := '';
                        MonthName := '';
                        MonthName := FORMAT(Rec."Loan Cutoff", 0, '<Month Text>');
                        MessageX := 'Dear ' + Cust."First Name" + ', Your bonus amount of Ksh '+Format(salarybuffer.Amount)+' has been credited to your account, access through the ATM and M-Banking.';
                        smsManagement.SendSmsWithID(Source::SALARY_PROCESSING, Cust."Mobile Phone No", MessageX, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');

                    end;
                end;
            until salarybuffer.Next = 0;
        end;
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", Rec."Account Type",
        Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ");

        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
        end;
        Rec.Posted := true;
        Rec."Posted By" := UserId;
        Rec."Posting date" := WorkDate;
        Rec.Modify;
        Message('Salaries Processed Successfuly');
       // Window.Close;
    end;

    local procedure FnNISProcessing()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := Rec."Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        ObjGenSetup.Get();
        salarybuffer.Reset;
        salarybuffer.SetRange("Salary Header No.", Rec.No);
        if salarybuffer.Find('-') then begin
            Window.Open(Format(Rec."Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);

                RunBal := salarybuffer.Amount;
                RunBal := FnPostSalaryToFosa(salarybuffer, RunBal, salarybuffer."Credit Narration");
                RunBal := FnRecoverStatutories(salarybuffer, RunBal);
            until salarybuffer.Next = 0;
        end;
        //Balancing Journal Entry
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        Rec."Account Type", Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', EXTERNAL_DOC_NO, DOCUMENT_NO, '', GenJournalLine."application source"::" ");
        Message('NIS journals Successfully Generated. BATCH NO=SALARIES.');
        Window.Close;
    end;

    local procedure FnRunSalaryProcessingSMS()
    var
        ObjAccount: Record Vendor;
        VarLoanProductName: Code[30];
        ObjCust: Record Customer;
        VarSMSBody: Text;
    begin
        ObjSalaryProcessingLines.Reset;
        ObjSalaryProcessingLines.SetRange(ObjSalaryProcessingLines."Salary Header No.", Rec.No);
        if ObjSalaryProcessingLines.FindSet then begin
            repeat
                SFactory.FnRunAfterCashDepositProcess(ObjSalaryProcessingLines."Account No.");

                ObjSalaryProcessingLines.CalcFields(ObjSalaryProcessingLines."Mobile Phone Number");
                VarMemberName := SFactory.FnRunSplitString(ObjSalaryProcessingLines."Account Name", ' ');
                VarSMSBody := 'Dear ' + VarMemberName + ', your salary of Ksh. ' + Format(ObjSalaryProcessingLines.Amount)
                  + ' has been processed to your Account No. ' + ObjSalaryProcessingLines."Account No.";
                SFactory.FnSendSMS('SALARY', VarSMSBody, ObjSalaryProcessingLines."Account No.", ObjSalaryProcessingLines."Mobile Phone Number");
            until ObjSalaryProcessingLines.Next = 0;
        end;
    end;

    local procedure FnRunLoanRecovery(ObjRcptBuffer: Record "Bonus Lines"; VarHeader: Code[50]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        VarAvailableBal: Decimal;
    begin
        ObjRcptBuffer.Reset;
        ObjRcptBuffer.SetRange(ObjRcptBuffer."Salary Header No.", VarHeader);
        if ObjRcptBuffer.FindSet then begin
            repeat
                LoanApp.Reset;
                LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Employer Code");
                LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
                //LoanApp.SetRange(LoanApp."Loan Status", LoanApp."loan status"::Disbursed);
                //LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
                if LoanApp.Find('-') then begin
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'SALARIES';
                    DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;
                    ;
                    EXTERNAL_DOC_NO := Rec."Document No";
                    repeat
                        if ObjVendor.Get(ObjRcptBuffer."Account No.") then begin
                            VarAvailableBal := SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze(ObjVendor."No.", WorkDate);
                            SFactory.FnCreateLoanRecoveryJournalsAdvance(LoanApp."Loan  No.", BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LoanApp."Client Code",
                            Rec."Posting date", EXTERNAL_DOC_NO, ObjRcptBuffer."Account No.", ObjRcptBuffer."Account Name", VarAvailableBal);

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        end;
                    until LoanApp.Next = 0;
                end;
            until ObjRcptBuffer.Next = 0;
        end;
    end;
}






