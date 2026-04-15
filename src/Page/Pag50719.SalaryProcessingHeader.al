//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50719 "Salary Processing Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Salary Processing Headerr";
    PromotedActionCategories = 'New,Process,Report,Approvals,Summary';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;//
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
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                }
                field("Posting date"; Rec."Posting date")
                {
                }

                field("Loan Cutoff"; Rec."Loan Cutoff")
                {
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
                }
                field("Employer Receiveable Acc"; Rec."Employer Receiveable Acc")
                {
                    Editable = false;
                    Importance = Additional;
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
            part("172000"; "Salary Processing Lines")
            {
                Caption = 'Salary Processing Lines';
                Enabled = false;
                SubPageLink = "Salary Header No." = field(No);
            }

            part("172001"; "Net Salary")
            {
                Enabled = false;
                SubPageLink = "Document Number" = field(No);
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
                action("Import Normal Salaries")
                {
                    Enabled = not ActionEnabled;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = XMLport "Import Salaries N";
                }
                action("Import Delayed Salaries")
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
                    var
                        VendX: Record Vendor;
                        refMonth: Integer;
                        refYear: Integer;
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
                                Members.SetFilter(Status, '%1|%2', Members."Membership Status"::Active, Members."Membership Status"::Dormant);
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
                                        //  VendX.SetRange(Status, VendX.Status::Active);
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
                        end;

                        Message('Validation completed successfully.');
                    END;
                }
                action(ValidateAlreadyPosted)
                {
                    Image = CheckDuplicates;
                    Caption = 'Verify Posted';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        CheckDed: Record "Salary Deductions Data";
                        refMonth: Integer;
                        refYear: Integer;
                        selected: Integer;
                        options: Label 'Validate,Undo Validation';
                        question: Label 'Kindly select a validation option';
                    begin
                        selected := 0;
                        selected := Dialog.StrMenu(options, 1, question);

                        if selected = 1 then begin
                            salarybuffer.Reset;
                            salarybuffer.SetRange("Salary Header No.", Rec.No);
                            if salarybuffer.Find('-') then begin
                                repeat
                                    refMonth := Date2DMY(rec."Loan Cutoff", 2);
                                    refYear := Date2DMY(rec."Loan Cutoff", 3);

                                    Saldetails.Reset();
                                    Saldetails.SetRange("Member No", salarybuffer."Member No");
                                    Saldetails.SetRange("Payroll No", salarybuffer."Staff No.");
                                    Saldetails.SetRange("Posting Month", refMonth);
                                    Saldetails.SetRange("Posting Year", refYear);
                                    if Saldetails.Find('-') then begin
                                        salarybuffer."Already Posted" := true;
                                        salarybuffer.modify;
                                    end;
                                until salarybuffer.Next() = 0;

                                Message('Validation Completed Successfully.');
                            end;
                        end else begin
                            salarybuffer.Reset;
                            salarybuffer.SetRange("Salary Header No.", Rec.No);
                            if salarybuffer.Find('-') then begin
                                repeat
                                    salarybuffer."Already Posted" := false;
                                    salarybuffer.modify;
                                until salarybuffer.Next() = 0;

                                Message('Validation Undone Successfully.');
                            end;
                        end;
                    end;
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
                action("Salaries Deductions")
                {
                    Caption = 'Salary Deductions';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Report "Salary Deductions";
                }

                action("Process Salaries")
                {
                    //Enabled = EnableProcessing;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;//
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    begin

                        if Confirm('Are you sure you want to Transfer this Salary to Journals ?', true) = false then exit;

                        Rec.CalcFields("Scheduled Amount");
                        VarPostingDiff := 0;
                        VarAvailableBal := SFactory.FnRunGetAccountAvailableBalance(Rec."Account No");
                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        Rec.TestField("Cheque No.");
                        Rec.TestField("Transaction Description");
                        Datefilter := '..' + Format(Rec."Posting date");
                        // This accomodates for the reconciliation aspect of the PCK advance payment of salaries to new members. Kindly refer for clarification.
                        if Rec.Amount <> Rec."Scheduled Amount" then begin
                            if (Rec."Employer Code" = 'POSTAL CORP') and ((Rec.Type = Rec.Type::Salary) or (Rec.Type = Rec.Type::Pension)) and (Rec."Transaction Type" = Rec."Transaction Type"::"Normal Salary") then begin
                                VarPostingDiff := Rec.Amount - Rec."Scheduled Amount";
                                if VarPostingDiff > 0 then begin
                                    if Rec."Employer Receiveable Acc" = '' then Error('Kindly ensure the employer''s receivable account has a value.');
                                    Message('Kindly note that the Scheduled Amount is not equal to the Cheque Amount by a difference of Ksh. %1', VarPostingDiff);
                                end else begin
                                    Error('The variance between the Scheduled Amount and Cheque Amount is negative. Kindly check the inputted Cheque Amount.');
                                end;
                            end else begin
                                Error('Scheduled Amount must be equal to the Cheque Amount');
                            end;
                        end;

                        DocumentsDed := Rec.No;
                        DOCUMENT_NO := Rec."Document No";
                        EXTERNAL_DOC_NO := "Cheque No.";
                        SMSCODE := '';
                        Counter := 0;
                        AUSal.ClearCheckoffData(Rec.No);

                        FnSalaryProcessing(VarPostingDiff);
                    end;
                }
                action("NET Pay To FOSA")
                {
                    Caption = 'NetPay to FOSA';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    //Visible = false;


                    trigger OnAction()
                    var
                        Saldeductions: Record "Salary Deductions Data";
                    begin
                        // Saldeductions.Reset();
                        // Saldeductions.SetRange(Saldeductions."Document No", Rec.No);
                        //  if Saldeductions.FindFirst() then begin
                        Report.Run(173080);
                        //end;
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

                    trigger OnAction()
                    var
                        Cust: record Customer;
                        MessageX: Text[1200];
                        MonthName: text[40];
                        smsManagement: Codeunit "Sms Management";
                        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
                    begin
                        if Confirm('Are you sure you want to mark this process as Complete?', true) = false then exit;
                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            TotalCount := salarybuffer.Count;
                            repeat
                                salarybuffer.CalcFields(salarybuffer."Mobile Phone Number");//
                                Cust.Reset;
                                Cust.Setrange(Cust."No.", salarybuffer."Member No");
                                If Cust.Find('-') then begin
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
                        Rec."Posting Date" := Today;
                        Rec.Modify();
                        Message('Process Completed Successfully.');
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

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if workflowintegration.CheckSalaryProcessingApprovalsWorkflowEnabled(Rec) then
                            workflowintegration.OnSendSalaryProcessingForApproval(Rec);

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

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            workflowintegration.OnCancelSalaryProcessingApprovalRequest(Rec);

                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::SalaryProcessing;
                        ApprovalEntries.SetRecordFilters(Database::"Salary Processing Headerr", DocumentType, Rec.No);
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
        SalaryProcessingLines: Record "Salary Processing Lines";
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
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
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
        ObjVendorLedger: Record "Vendor Ledger Entry";
        ObjGenSetup: Record "Sacco General Set-Up";
        Charges: Record Charges;
        DocumentsDed: Code[40];
        STOrecType: Code[30];
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
        AUSal: Codeunit "Au Factory";
        SMSCODE: Code[30];
        VarAvailableBal: Decimal;
        VarPostingDiff: Decimal;
        VarCreditDescription: Text[250];
        VarMemberName: Text;
        ObjSalaryProcessingLines: Record "Salary Processing Lines";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;

        ExpectedAmount: Decimal;

        AmountDeducted: Decimal;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement,InwardChequeClearing,InValidPaybillTransactions,InternalPV,SalaryProcessing;
        EnableProcessing: Boolean;
        workflowintegration: Codeunit WorkflowIntegration;

    local procedure FnPostSalaryToFosa(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250]): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjSalaryLines.Amount * -1, 'FOSA',
        EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");

        AUSal.FnInsertSalarydata(DocumentsDed, ObjSalaryLines."Member No", ObjSalaryLines."Account No.", 'Gross Salary', ObjSalaryLines.Amount, ObjSalaryLines.Amount);

        ObjGenSetup.Get();
        if ObjGenSetup."Salary Processing Fee" > 0 then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjGenSetup."Salary Processing Fee", 'FOSA',
            EXTERNAL_DOC_NO, 'Salary processing fee ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
            RunningBalance := RunningBalance - ObjGenSetup."Salary Processing Fee";
            ExpectedAmount += ObjGenSetup."Salary Processing Fee";
            AmountDeducted += ObjGenSetup."Salary Processing Fee";

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Rec."Posting date", -ObjGenSetup."Salary Processing Fee", 'FOSA',
            EXTERNAL_DOC_NO, 'Salary processing fee ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");


            AUSal.FnInsertSalarydata(DocumentsDed, ObjSalaryLines."Member No", ObjSalaryLines."Account No.", 'Salary Processing Fee', ObjGenSetup."Salary Processing Fee", ObjGenSetup."Salary Processing Fee");

            ExciseDutyP := ROUND((ObjGenSetup."Salary Processing Fee" * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ExciseDutyP, 'FOSA',
            EXTERNAL_DOC_NO, 'Excise Duty on salary ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", -ExciseDutyP, 'FOSA',
            EXTERNAL_DOC_NO, 'Excise Duty on salary ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

            AUSal.FnInsertSalarydata(DocumentsDed, ObjSalaryLines."Member No", ObjSalaryLines."Account No.", 'Salary Processing Fee', ExciseDutyP, ExciseDutyP);
            RunningBalance := RunningBalance - ExciseDutyP;
            ExpectedAmount += ExciseDutyP;
            AmountDeducted += ExciseDutyP;
            // Message('RunnBalPr%1',RunningBalance);
            exit(RunningBalance);
        end;
    end;//


    local procedure FnPostPensionToFosa(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250]): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjSalaryLines.Amount * -1, 'FOSA',
        EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");



        ObjGenSetup.Get();
        if ObjGenSetup."Salary Processing Fee" > 0 then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjGenSetup."Salary Processing Fee", 'FOSA',
            EXTERNAL_DOC_NO, 'Pension processing fee ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
            RunningBalance := RunningBalance - ObjGenSetup."Salary Processing Fee";

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Rec."Posting date", -ObjGenSetup."Salary Processing Fee", 'FOSA',
            EXTERNAL_DOC_NO, 'Pension processing fee ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
            ExpectedAmount += ObjGenSetup."Salary Processing Fee";
            AmountDeducted += ObjGenSetup."Salary Processing Fee";


            ExciseDutyP := ROUND((ObjGenSetup."Salary Processing Fee" * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ExciseDutyP, 'FOSA',
            EXTERNAL_DOC_NO, 'Excise Duty on Pension ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", -ExciseDutyP, 'FOSA',
            EXTERNAL_DOC_NO, 'Excise Duty on Pension ' + Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

            RunningBalance := RunningBalance - ExciseDutyP;
            ExpectedAmount += ExciseDutyP;
            AmountDeducted += ExciseDutyP;

            exit(RunningBalance);
        end;
    end;

    local procedure FnPostBonusToFosa(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250])
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjSalaryLines.Amount * -1, 'FOSA',
        EXTERNAL_DOC_NO, 'Gross Pay', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");



    end;


    local procedure FnPostSalaryToCustomer(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250]): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
         GenJournalLine."Account Type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", -ObjSalaryLines.Amount, 'FOSA',
        EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");

        AUSal.FnInsertSalarydata(DocumentsDed, ObjSalaryLines."Member No", ObjSalaryLines."Account No.", 'Gross Salary', ObjSalaryLines.Amount, ObjSalaryLines.Amount);

        ObjGenSetup.Get();
        if RunningBalance > ObjGenSetup."Salary Processing Fee" then
            LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ObjGenSetup."Salary Processing Fee", 'FOSA',
        EXTERNAL_DOC_NO, 'Salary processing fee', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
        RunningBalance := RunningBalance - ObjGenSetup."Salary Processing Fee";

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Rec."Posting date", -ObjGenSetup."Salary Processing Fee", 'FOSA',
        EXTERNAL_DOC_NO, 'Salary processing fee', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");

        AUSal.FnInsertSalarydata(DocumentsDed, ObjSalaryLines."Member No", ObjSalaryLines."Account No.", 'Processing Fee', -ObjGenSetup."Salary Processing Fee", ObjGenSetup."Salary Processing Fee");
        ExciseDutyP := ROUND((ObjGenSetup."Salary Processing Fee" * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", ExciseDutyP, 'FOSA',
        EXTERNAL_DOC_NO, 'Excise Duty on salary', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", -ExciseDutyP, 'FOSA',
        EXTERNAL_DOC_NO, 'Excise Duty on salary', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

        AUSal.FnInsertSalarydata(DocumentsDed, ObjSalaryLines."Member No", ObjSalaryLines."Account No.", 'Excise Duty on Salary Processing Fee', -ExciseDutyP, ExciseDutyP);
        //Message('Run%1Excise%2',RunningBalance,ExciseDutyP);
        RunningBalance := RunningBalance - ExciseDutyP;

        ;
        exit(RunningBalance);
    end;

    local procedure FnPostSalaryToSuspense(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250]): Decimal
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

    local procedure FnRecoverStatutories(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
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

    local procedure FnRecoverMobileLoanInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
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

    local procedure FnRecoverMobileLoanPrincipal(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
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

    local procedure FnRunInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        currentExpected: Decimal;
        LoanPro: Record "Loan Products Setup";

    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Loan Disbursement Date", '..%1', Rec."Loan Cutoff");
            LoanApp.SetAutoCalcFields(LoanApp."Outstanding Interest");
            LoanApp.SetFilter(LoanApp."Outstanding Interest", '>%1', 0);
            LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."recovery mode"::Pension);
            if LoanApp.FindSET then begin
                repeat
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin

                        LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                        if (SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff")) > 0 then begin

                            if RunningBalance > 0 then begin
                                // AmountToDeduct := 0;
                                // AmountToDeduct := LoanApp."Outstanding Interest";
                                // if RunningBalance <= AmountToDeduct then
                                //     AmountToDeduct := RunningBalance;

                                AmountToDeduct := 0;
                                AmountToDeduct := SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff");
                                currentExpected := AmountToDeduct;
                                if RunningBalance <= AmountToDeduct then
                                    AmountToDeduct := RunningBalance;

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");

                                AUSal.FnInsertSalarydata(DocumentsDed, ObjRcptBuffer."Member No", ObjRcptBuffer."Account No.", 'Interest Paid ' + ObjLoanProducts."Product Description", AmountToDeduct, currentExpected);
                                RunningBalance := RunningBalance - AmountToDeduct;
                                AmountDeducted += AmountToDeduct;
                            end;
                        end;

                    end;

                until LoanApp.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;

    procedure FnRunInterestExpectedAmount(ObjRcptBuffer: Record "Salary Processing Lines")
    var
        AmountToDeduct: Decimal;
        LoanPro: Record "Loan Products Setup";

    begin
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
        LoanApp.SetFilter(LoanApp."Loan Disbursement Date", '..%1', Rec."Loan Cutoff");
        LoanApp.SetAutoCalcFields(LoanApp."Outstanding Interest");
        LoanApp.SetFilter(LoanApp."Outstanding Interest", '>%1', 0);
        LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."recovery mode"::Pension);
        if LoanApp.FindSET then begin
            repeat
                if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin

                    LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                    if (SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff")) > 0 then begin


                        AmountToDeduct := 0;
                        AmountToDeduct := SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff");
                        ExpectedAmount += AmountToDeduct;

                    end;

                end;

            until LoanApp.Next = 0;
        end;
    end;

    procedure FnRunInterestExpectedAmountVariance(ObjRcptBuffer: Record "Salary Processing Lines") ExpectedAmounts: Decimal
    var
        AmountToDeduct: Decimal;
        LoanPro: Record "Loan Products Setup";
        Salheader: Record "Salary Processing Headerr";
    begin
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
        LoanApp.SetFilter(LoanApp."Loan Disbursement Date", '..%1', Salheader."Loan Cutoff");
        LoanApp.SetAutoCalcFields(LoanApp."Outstanding Interest");
        LoanApp.SetFilter(LoanApp."Outstanding Interest", '>%1', 0);
        LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."recovery mode"::Pension);
        if LoanApp.FindSET then begin
            repeat
                if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                    Salheader.Get(ObjRcptBuffer."Salary Header No.");
                    LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                    if (SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Salheader."Loan Cutoff")) > 0 then begin


                        AmountToDeduct := 0;
                        AmountToDeduct := SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Salheader."Loan Cutoff");
                        ExpectedAmounts += AmountToDeduct;

                    end;

                end;

            until LoanApp.Next = 0;
        end;
    end;

    local procedure FnRunInterestPension(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
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
                                Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");
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

    local procedure FnRunBenevolent(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
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


    local procedure FnRunBenevolentDelayed(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
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
                        Format(GenJournalLine."transaction type"::"Benevolent Fund") + '.', LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::" "); */
            RunningBalance := RunningBalance - AmountToDeduct;


            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterestDelayed(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Salary Processing Headerr"): Decimal
    var
        AmountToDeduct: Decimal;

    begin
        if RunningBalance > 0 then begin

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Loan Product Type", '<>%1|%2', 'M_OD', 'A16');
            LoanApp.SetFilter(LoanApp."Loan Disbursement Date", '..%1', Rec."Loan Cutoff");
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
                                Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");

                                AUSal.FnInsertSalarydata(DocumentsDed, ObjRcptBuffer."Member No", ObjRcptBuffer."Account No.", 'Interest Paid ' + ObjLoanProducts."Product Description", -AmountToDeduct, SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.", Rec."Loan Cutoff"));
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

    local procedure FnTransferNetDelayed(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Salary Processing Headerr")
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

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."Account Type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                'Net Pay', '', GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"Net Pay");
                RunningBalance := RunningBalance - AmountToDeduct;
                //  end;
            end;


        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        currentExpected: Decimal;
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
        OutLoan: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            AmountPaid := 0;
            MonthlyArrears := 0;
            MonthlyRepayment := 0;
            currentExpected := 0;
            OutstandingInterest := 0;


            LoanApp.Reset;
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
            // LoanApp.SetFilter(LoanApp."Expected Date of Completion", '<=%1', CalcDate('CM', Rec."Loan Cutoff"));
            LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."recovery mode"::Pension);
            LoanApp.SetFilter(LoanApp."Loan Product Type", '%1', 'M_OD');
            if LoanApp.FindSet() then begin
                repeat
                    // if RunningBalance > 0 then begin

                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    AmountToDeduct := 0;
                    varLRepayment := 0;
                    ScheduleAmount := 0;
                    MonthlyRepayment := 0;

                    varLRepayment := LoanApp."Outstanding Balance";
                    currentExpected := varLRepayment;

                    if RunningBalance > 0 then begin
                        if RunningBalance > varLRepayment then begin
                            AmountToDeduct := varLRepayment;
                        end
                        else
                            AmountToDeduct := RunningBalance;
                    end else
                        AmountToDeduct := 0;

                    ObjLoanProducts.Get(LoanApp."Loan Product Type");
                    //-------------PAY------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                    GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                    ' Loan Repayment ' + Format(ObjLoanProducts."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                    //-------------RECOVER---------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                    ' Loan Repayment-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

                    AUSal.FnInsertSalarydata(DocumentsDed, ObjRcptBuffer."Member No", ObjRcptBuffer."Account No.", 'Loan Paid ' + ObjLoanProducts."Product Description", AmountToDeduct, currentExpected);
                    RunningBalance := RunningBalance - AmountToDeduct;
                    AmountDeducted += AmountToDeduct;
                // end;

                // end;
                // end;
                until LoanApp.Next = 0;
            end;


            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Client Code", ObjRcptBuffer."Member No");
            LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
            LoanApps.SetFilter(LoanApps."Recovery Mode", '%1|%2', LoanApps."recovery mode"::Salary, LoanApps."Recovery Mode"::Pension);
            LoanApps.SetFilter(LoanApps."Loan Disbursement Date", '..%1', CalcDate('CM', Rec."Loan Cutoff"));
            LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
            LoanApps.SetFilter(LoanApps."Outstanding Balance", '>%1', 0);
            LoanApps.SetFilter(LoanApps."Loan Product Type", '<>%1', 'M_OD');
            if LoanApps.FindSet() then begin
                repeat

                    if ObjLoanProducts.Get(LoanApps."Loan Product Type") then begin
                        if (ObjLoanProducts."Charge Interest Upfront" = false) then begin

                            // if RunningBalance > 0 then begin

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
                            //  varLRepayment := MonthlyRepayment;
                            if MonthlyRepayment > LoanApps."Outstanding Balance" then
                                varLRepayment := LoanApps."Outstanding Balance"
                            else
                                varLRepayment := MonthlyRepayment;
                            if RunningBalance > 0 then begin
                                if RunningBalance > varLRepayment then begin
                                    AmountToDeduct := varLRepayment;
                                end
                                else
                                    AmountToDeduct := RunningBalance;
                            end else
                                AmountToDeduct := 0;

                            currentExpected := varLRepayment;
                            //-------------PAY------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
                            ' Loan Repayment ' + Format(ObjLoanProducts."Product Description"), LoanApps."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                            //-------------RECOVER---------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApps.Source), LoanApps."Loan  No.",//Rec.NO + 
                            ' Loan Repayment-' + ObjLoanProducts."Product Description", LoanApps."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

                            AUSal.FnInsertSalarydata(DocumentsDed, ObjRcptBuffer."Member No", ObjRcptBuffer."Account No.", 'Loan Paid ' + ObjLoanProducts."Product Description", AmountToDeduct, currentExpected);
                            RunningBalance := RunningBalance - AmountToDeduct;
                            AmountDeducted += AmountToDeduct;
                            // end;


                            // end;
                        end;
                    end;
                until LoanApps.Next = 0;
            end;

            LoanApp.Reset;
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
            LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."Recovery Mode"::Pension);
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
            LoanApp.SetFilter(LoanApp."Loan Product Type", '%1', 'A16');
            if LoanApp.FindSet() then begin
                repeat
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if (ObjLoanProducts."Charge Interest Upfront" = true) then begin
                            // if RunningBalance > 0 then begin
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
                            end else
                                AmountToDeduct := 0;

                            currentExpected := varLRepayment;
                            //-------------PAY------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,//Rec.No + 
                            ' Loan Repayment ' + Format(ObjLoanProducts."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
                            //-------------RECOVER---------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",//Rec.No+ 
                            ' Loan Repayment' + '-' + ObjLoanProducts."Product Description", LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

                            AUSal.FnInsertSalarydata(DocumentsDed, ObjRcptBuffer."Member No", ObjRcptBuffer."Account No.", 'Loan Paid ' + ObjLoanProducts."Product Description", AmountToDeduct, currentExpected);
                            RunningBalance := RunningBalance - AmountToDeduct;
                            AmountDeducted += AmountToDeduct;


                            // end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    procedure FnRunPrincipleExpectedAmount(ObjRcptBuffer: Record "Salary Processing Lines")
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayments: Decimal;
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
        OutLoan: Decimal;
    begin

        varTotalRepay := 0;
        varMultipleLoan := 0;
        AmountPaid := 0;
        MonthlyArrears := 0;
        MonthlyRepayment := 0;
        OutstandingInterest := 0;


        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
        LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
        LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
        LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."recovery mode"::Pension);
        LoanApp.SetFilter(LoanApp."Loan Product Type", '%1', 'M_OD');
        if LoanApp.FindSet() then begin
            repeat
                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                AmountToDeduct := 0;
                varLRepayments := 0;
                ScheduleAmount := 0;
                MonthlyRepayment := 0;

                varLRepayments := LoanApp."Outstanding Balance";
                ExpectedAmount += varLRepayments;

            until LoanApp.Next = 0;
        end;

        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Client Code", ObjRcptBuffer."Member No");
        LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
        LoanApps.SetFilter(LoanApps."Recovery Mode", '%1|%2', LoanApps."recovery mode"::Salary, LoanApps."Recovery Mode"::Pension);
        LoanApps.SetFilter(LoanApps."Loan Disbursement Date", '..%1', CalcDate('CM', Rec."Loan Cutoff"));
        LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
        LoanApps.SetFilter(LoanApps."Outstanding Balance", '>%1', 0);
        LoanApps.SetFilter(LoanApps."Loan Product Type", '<>%1', 'M_OD');
        if LoanApps.FindSet() then begin
            repeat

                if ObjLoanProducts.Get(LoanApps."Loan Product Type") then begin
                    if (ObjLoanProducts."Charge Interest Upfront" = false) then begin

                        AmountToDeduct := 0;
                        varLRepayments := 0;
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

                        if MonthlyRepayment > LoanApps."Outstanding Balance" then
                            varLRepayments := LoanApps."Outstanding Balance"
                        else
                            varLRepayments := MonthlyRepayment;
                        ExpectedAmount += varLRepayments;


                    end;
                end;
            until LoanApps.Next = 0;
        end;

        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
        LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
        LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."Recovery Mode"::Pension);
        LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
        LoanApp.SetFilter(LoanApp."Loan Product Type", '%1', 'A16');
        if LoanApp.FindSet() then begin
            repeat
                if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                    if (ObjLoanProducts."Charge Interest Upfront" = true) then begin

                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        AmountToDeduct := 0;
                        varLRepayments := 0;
                        ScheduleAmount := 0;
                        MonthlyRepayment := 0;

                        MonthlyRepayment := LoanApp."Approved Amount" / LoanApp.Installments;
                        if MonthlyRepayment > LoanApp."Outstanding Balance" then
                            varLRepayments := LoanApp."Outstanding Balance"
                        else
                            varLRepayments := MonthlyRepayment;
                        ExpectedAmount += varLRepayments;

                    end;
                end;
            until LoanApp.Next = 0;
        end;

    end;



    procedure FnRunPrincipleExpectedAmountVariance(ObjRcptBuffer: Record "Salary Processing Lines") ExpectedAmounts: Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayments: Decimal;
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
        OutLoan: Decimal;
        SalHeader: Record "Salary Processing Headerr";
    begin

        varTotalRepay := 0;
        varMultipleLoan := 0;
        AmountPaid := 0;
        MonthlyArrears := 0;
        MonthlyRepayment := 0;
        OutstandingInterest := 0;
        Salheader.Get(ObjRcptBuffer."Salary Header No.");

        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
        LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
        LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
        LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."recovery mode"::Pension);
        LoanApp.SetFilter(LoanApp."Loan Product Type", '%1', 'M_OD');
        if LoanApp.FindSet() then begin
            repeat
                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                AmountToDeduct := 0;
                varLRepayments := 0;
                ScheduleAmount := 0;
                MonthlyRepayment := 0;

                varLRepayments := LoanApp."Outstanding Balance";
                ExpectedAmounts += varLRepayments;

            until LoanApp.Next = 0;
        end;

        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Client Code", ObjRcptBuffer."Member No");
        LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
        LoanApps.SetFilter(LoanApps."Recovery Mode", '%1|%2', LoanApps."recovery mode"::Salary, LoanApps."Recovery Mode"::Pension);
        LoanApps.SetFilter(LoanApps."Loan Disbursement Date", '..%1', CalcDate('CM', Salheader."Loan Cutoff"));
        LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
        LoanApps.SetFilter(LoanApps."Outstanding Balance", '>%1', 0);
        LoanApps.SetFilter(LoanApps."Loan Product Type", '<>%1', 'M_OD');
        if LoanApps.FindSet() then begin
            repeat

                if ObjLoanProducts.Get(LoanApps."Loan Product Type") then begin
                    if (ObjLoanProducts."Charge Interest Upfront" = false) then begin

                        AmountToDeduct := 0;
                        varLRepayments := 0;
                        ScheduleAmount := 0;
                        MonthlyRepayment := 0;
                        LSchedule.RESET;
                        LSchedule.SetRange(LSchedule."Loan No.", LoanApps."Loan  No.");
                        LSchedule.setfilter(LSchedule."Repayment Date", '%1..%2', calcdate('-CM',Salheader."Loan Cutoff"), calcdate('CM', Salheader."Loan Cutoff"));
                        if LSchedule.FindFirst() then begin
                            LSchedule.CalcSums(LSchedule."Principal Repayment");
                            ScheduleAmount := LSchedule."Loan Balance";
                            MonthlyRepayment := LSchedule."Principal Repayment";
                        end;

                        if MonthlyRepayment > LoanApps."Outstanding Balance" then
                            varLRepayments := LoanApps."Outstanding Balance"
                        else
                            varLRepayments := MonthlyRepayment;
                        ExpectedAmounts += varLRepayments;


                    end;
                end;
            until LoanApps.Next = 0;
        end;

        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
        LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
        LoanApp.SetFilter(LoanApp."Recovery Mode", '%1|%2', LoanApp."recovery mode"::Salary, LoanApp."Recovery Mode"::Pension);
        LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
        LoanApp.SetFilter(LoanApp."Loan Product Type", '%1', 'A16');
        if LoanApp.FindSet() then begin
            repeat
                if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                    if (ObjLoanProducts."Charge Interest Upfront" = true) then begin

                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        AmountToDeduct := 0;
                        varLRepayments := 0;
                        ScheduleAmount := 0;
                        MonthlyRepayment := 0;

                        MonthlyRepayment := LoanApp."Approved Amount" / LoanApp.Installments;
                        if MonthlyRepayment > LoanApp."Outstanding Balance" then
                            varLRepayments := LoanApp."Outstanding Balance"
                        else
                            varLRepayments := MonthlyRepayment;
                        ExpectedAmounts += varLRepayments;

                    end;
                end;
            until LoanApp.Next = 0;
        end;

    end;

    local procedure FnRunPrincipleDelayed(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Salary Processing Headerr"): Decimal
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
            LoanApps.SetRange(LoanApps."Client Code", ObjRcptBuffer."Member No");
            LoanApps.SetRange(LoanApps."Recovery Mode", LoanApps."recovery mode"::Salary);
            LoanApps.SetFilter(LoanApps."Loan Disbursement Date", '..%1', Rec."Loan Cutoff");
            LoanApps.SetAutoCalcFields(LoanApps."Outstanding Balance");
            LoanApps.SetFilter(LoanApps."Outstanding Balance", '>%1', 0);
            if LoanApps.FindSet() then begin
                repeat

                    if LoanApps."Loan Disbursement Date" <= Rec."Loan Cutoff" then begin
                        if ObjLoanProducts.Get(LoanApps."Loan Product Type") then begin
                            if (ObjLoanProducts."Charge Interest Upfront" = false) then begin
                                //AND  (LoanApps."Recovery Mode"=LoanApps."Recovery Mode"::Salary) then begin
                                //if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                                // if RunningBalance > 0 then begin
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
                                end else
                                    AmountToDeduct := 0;
                                //-------------PAY------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
                                'Loan Repayment ' + Format(LoanPro."Product Description"), LoanApps."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

                                AUSal.FnInsertSalarydata(DocumentsDed, LoanApps."Client Code", ObjRcptBuffer."Account No.", 'Loan Paid ' + ObjLoanProducts."Product Description", -AmountToDeduct, varLRepayment);
                                RunningBalance := RunningBalance - AmountToDeduct;
                                // end;

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
            LoanApp.SetFilter(LoanApp."Loan Disbursement Date", '..%1', ObjRcptRec."Loan Cutoff");
            // LoanApp.SetFilter(LoanApp."Loan Product Type", '%1|%2', 'M_OD', 'A16');
            if LoanApp.FindSet() then begin
                repeat
                    // if (LoanApp."Loan Product Type" = 'A16') or (LoanApp."Loan Product Type" = 'M_OD') then begin
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if (ObjLoanProducts."Charge Interest Upfront" = true) /* AND (LoanApps."Recovery Mode" = LoanApps."Recovery Mode"::Salary) */ then begin
                            //if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            // if RunningBalance > 0 then begin
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
                            end else
                                AmountToDeduct := 0;
                            //-------------PAY------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."account type"::Customer, ObjRcptBuffer."Member No", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                            'Loan Repayment ' + Format(LoanPro."Product Description"), LoanApp."Loan  No.", GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

                            AUSal.FnInsertSalarydata(ObjRcptBuffer."Document No.", LoanApp."Client Code", ObjRcptBuffer."Account No.", 'Loan Paid ' + ObjLoanProducts."Product Description", -AmountToDeduct, varLRepayment);
                            RunningBalance := RunningBalance - AmountToDeduct;
                            // end;

                            // end;
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
            //ObjStandingOrders.SetRange("Standing Order Dedution Type", ObjStandingOrders."standing order dedution type"::Salary);
            if ObjStandingOrders.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        RunningBalance := FnBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance);

                        ObjStandingOrders.Effected := true;
                        ObjStandingOrders."Date Reset" := Today;
                        ObjStandingOrders.Modify;

                        FnRegisterProcessedStandingOrder(ObjStandingOrders, AmountToDeduct);
                    end;
                until ObjStandingOrders.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunStandingOrdersExpectedAmount(ObjRcptBuffer: Record "Salary Processing Lines")
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
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
                FnBosaStandingOrderTransactionExpectedAmount(ObjStandingOrders);
            until ObjStandingOrders.Next = 0;
        end;

    end;

    local procedure FnRunStandingOrdersDelayed(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Salary Processing Headerr"): Decimal
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
        PrincipleBal: Decimal;
        StoHeader: record "Standing Orders";
        FAmount: Decimal;
        FAAAmount: Decimal;
    begin
        if RunningBalance > 0 then begin
            //Message('Runn%1',RunningBalance);
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                StoHeader.Reset();
                StoHeader.SetRange(StoHeader."No.", ObjReceiptTransactions."Document No");
                if StoHeader.FindFirst() then
                    repeat
                        if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::Member then begin
                            if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::Repayment then begin
                                //-------------RECOVER principal-----------------------
                                if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                                    if LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary then begin
                                        PrincipleBal := 0;

                                        if RunningBalance > (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") then
                                            PrincipleBal := (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount")
                                        else
                                            PrincipleBal := RunningBalance;

                                        if PrincipleBal < 0 then PrincipleBal := 0;
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                        GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", PrincipleBal * -1,
                                        'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                        //-------------PAY Principal----------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", PrincipleBal, 'FOSA',
                                        ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                        AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + 'Standing Order', -PrincipleBal, (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount"));
                                        RunningBalance := RunningBalance - PrincipleBal;

                                        AmountDeducted += PrincipleBal;
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

                                        if InterestBal > RunningBalance then
                                            InterestBal := RunningBalance
                                        else
                                            InterestBal := InterestBal;
                                        if InterestBal < 0 then InterestBal := 0;
                                        //-------------RECOVER Interest-----------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", InterestBal * -1,
                                        'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::"Interest Paid") + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                        //-------------PAY Interest----------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                                        InterestBal, 'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::"Interest Paid") + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.",
                                        '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");
                                        RemainBal := RemainBal - InterestBal;
                                        AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", Format(GenJournalLine."Transaction Type"::"Interest Paid") + '-' + ObjReceiptTransactions."Loan Product Name" + 'Standing Order', -InterestBal, LoanApp."Outstanding Interest");
                                        RunningBalance := RunningBalance - InterestBal;

                                        if RemainBal > 0 then begin
                                            //-------------PAY Principal----------------------------
                                            LineNo := LineNo + 10000;
                                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                            GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", (RemainBal) * -1,
                                            'FOSA', ObjRcptBuffer."No.", Rec."Transaction Description" + ' ' + Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");


                                            LineNo := LineNo + 10000;
                                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                                            RemainBal, 'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                            AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + 'Standing Order', -RemainBal, (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount"));

                                            RunningBalance := RunningBalance - (RemainBal);
                                            AmountDeducted += RemainBal;
                                        end;
                                    end;
                                end;

                            end
                            else begin
                                //-------------RECOVER BOSA NONLoan Transactions-----------------------
                                FAmount := 0;
                                if RunningBalance > ObjReceiptTransactions.Amount then
                                    FAmount := ObjReceiptTransactions.Amount
                                else
                                    FAmount := RunningBalance;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                                GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", FAmount * -1,
                                'FOSA', ObjRcptBuffer."No.", 'BBF Contribution-' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                //-------------PAY BOSA NONLoan Transaction----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", FAmount,
                                'FOSA', ObjRcptBuffer."No.", 'BBF Contribution-' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", 'BBF Contribution - ' + 'Standing Order', -FAmount, ObjReceiptTransactions.Amount);
                                RunningBalance := RunningBalance - FAmount;
                                AmountDeducted += FAmount;

                            end;
                        end else begin
                            if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::"FOSA Account" then begin
                                STOrecType := getSTORecoveryType(ObjReceiptTransactions."Member No");

                                FAAAmount := 0;
                                if RunningBalance > ObjReceiptTransactions.Amount then
                                    FAAAmount := ObjReceiptTransactions.Amount
                                else
                                    FAAAmount := RunningBalance;
                                // Message('Here%1');

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type"::" ",
                                GenJournalLine."account type"::Vendor, ObjReceiptTransactions."Member No", Rec."Posting date", FAAAmount * -1,
                                'FOSA', ObjRcptBuffer."No.", STOrecType + ' - ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                //-------------PAY BOSA NONLoan Transaction----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", FAAAmount,
                                'FOSA', ObjRcptBuffer."No.", STOrecType + ' - ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", STOrecType + ' - Standing Order', -FAAAmount, ObjReceiptTransactions.Amount);
                                RunningBalance := RunningBalance - FAAAmount;
                                AmountDeducted += FAAAmount;
                            end;
                        end;

                    until ObjReceiptTransactions.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;


    local procedure FnBosaStandingOrderTransactionExpectedAmount(ObjRcptBuffer: Record "Standing Orders")
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
        PrincipleBal: Decimal;
        StoHeader: record "Standing Orders";
        FAmount: Decimal;
        FAAAmount: Decimal;
    begin
        //Message('Runn%1',RunningBalance);
        ObjReceiptTransactions.Reset;
        ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
        if ObjReceiptTransactions.Find('-') then begin
            StoHeader.Reset();
            StoHeader.SetRange(StoHeader."No.", ObjReceiptTransactions."Document No");
            if StoHeader.FindFirst() then
                repeat
                    if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::Member then begin
                        if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::Repayment then begin
                            //-------------RECOVER principal-----------------------
                            if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                                if LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary then begin
                                    PrincipleBal := 0;

                                    ExpectedAmount := ExpectedAmount + (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");
                                end;


                                if LoanApp."Recovery Mode" <> LoanApp."Recovery Mode"::Salary then begin
                                    RemainBal := 0;
                                    InterestBal := 0;
                                    RemainBal := ObjReceiptTransactions.Amount;
                                    LoanApp.CalcFields(LoanApp."Outstanding Interest");

                                    ExpectedAmount += RemainBal;
                                end;
                            end;

                        end
                        else begin
                            //-------------RECOVER BOSA NONLoan Transactions-----------------------
                            FAmount := 0;
                            ExpectedAmount += ObjReceiptTransactions.Amount;

                        end;
                    end else begin
                        if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::"FOSA Account" then begin
                            ExpectedAmount += ObjReceiptTransactions.Amount;
                        end;
                    end;

                until ObjReceiptTransactions.Next = 0;
        end;

    end;

    local procedure FnBosaStandingOrderTransactionDelayed(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal; ObjRcptRec: Record "Salary Processing Headerr"): Decimal
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
        StoHeader: record "Standing Orders";
    begin

        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                StoHeader.Reset();
                StoHeader.SetRange(StoHeader."No.", ObjReceiptTransactions."Document No");
                if StoHeader.FindFirst() then
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
                                            'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                            //-------------PAY Principal----------------------------
                                            /*                                     LineNo := LineNo + 10000;
                                                                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                                                GenJournalLine."Account Type"::Customer, ObjRcptRec."Account No", Rec."Posting date",
                                                                                ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                                                                Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO"); */

                                            AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", 'Standing Order', -(ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount"), (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount"));
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
                                            'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");


                                            RemainBal := RemainBal - InterestBal;

                                            AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", 'Standing Order', -LoanApp."Outstanding Interest", LoanApp."Outstanding Interest");
                                            RunningBalance := RunningBalance - LoanApp."Outstanding Interest";
                                        end;
                                        If RunningBalance > 0 then begin
                                            if RemainBal > 0 then begin

                                                //-------------PAY Principal----------------------------
                                                LineNo := LineNo + 10000;
                                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                                GenJournalLine."account type"::Customer, ObjReceiptTransactions."Member No", Rec."Posting date", (RemainBal) * -1,
                                                'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                                AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", 'Standing Order', -RemainBal, (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount"));
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
                                    'FOSA', ObjRcptBuffer."No.", 'BBF Contribution ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                    //-------------PAY BOSA NONLoan Transaction----------------------------
                                    /*                             LineNo := LineNo + 10000;
                                                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                                                                GenJournalLine."Account Type"::Customer, ObjRcptRec."Account No", Rec."Posting date", ObjReceiptTransactions.Amount,
                                                                'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO"); */
                                    AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", 'Standing Order', -CustomerAmount, ObjReceiptTransactions.Amount);
                                    RunningBalance := RunningBalance - CustomerAmount;
                                end;
                            end;
                        end else begin
                            if ObjReceiptTransactions."STO Account Type" = ObjReceiptTransactions."STO Account Type"::"FOSA Account" then begin
                                If RunningBalance > 0 then begin
                                    STOrecType := getSTORecoveryType(ObjReceiptTransactions."Member No");

                                    FosaAmount := 0;
                                    FosaAmount := ObjReceiptTransactions.Amount;
                                    if FosaAmount < RunningBalance then
                                        FosaAmount := FosaAmount
                                    else
                                        FosaAmount := RunningBalance;

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                                    GenJournalLine."account type"::Vendor, ObjReceiptTransactions."Member No", Rec."Posting date", FosaAmount * -1,
                                    'FOSA', ObjRcptBuffer."No.", STOrecType + ' - ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO");

                                    //-------------PAY BOSA NONLoan Transaction----------------------------
                                    /*                             LineNo := LineNo + 10000;
                                                                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                                                                GenJournalLine."Account Type"::Customer, ObjRcptRec."Account No", Rec."Posting date", ObjReceiptTransactions.Amount,
                                                                'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.", GenJournalLine."Salary Receipt Type"::"6-STO"); */
                                    AUSal.FnInsertSalarydata(DocumentsDed, StoHeader."BOSA Account No.", ObjRcptBuffer."Source Account No.", 'Standing Order', -FosaAmount, ObjReceiptTransactions.Amount);
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

    local procedure FnSalaryProcessing(ReconAmount: Decimal)
    var
        Vends: record Vendor;
        SalNo: Integer;
        Sal: Record "Salary Details";
        AuFactory: Codeunit "Au Factory";
        AvailableBalanceX: Decimal;
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := Rec."Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll;
        end;
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
        salarybuffer.SetRange("Already Posted", false);
        if salarybuffer.Find('-') then begin
            Window.Open(Format(Rec."Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);
                RunBal := 0;
                if Rec.Type = Rec.Type::Salary then begin
                    if Rec."Transaction Type" = Rec."Transaction Type"::"Normal Salary" then begin

                        RunBal := salarybuffer.Amount;
                        ExpectedAmount := 0;
                        AmountDeducted := 0;
                        if salarybuffer."Account No." <> '' then begin
                            RunBal := FnPostSalaryToFosa(salarybuffer, RunBal, salarybuffer."Credit Narration");
                            AvailableBalanceX := 0;
                            AvailableBalanceX := AuFactory.FnCalculateAvailableBalance(salarybuffer."Account No.");

                            //RunBal := FnRunBenevolent(salarybuffer, RunBal);

                            //  if (AvailableBalanceX < 1000) and (AvailableBalanceX >= 0) then begin
                            //      RunBal := RunBal - (1000 - AvailableBalanceX);
                            //  end else
                            RunBal := RunBal + AvailableBalanceX;

                            //Message('RunBal%1Ava%2', RunBal, AvailableBalanceX);

                            RunBal := FnRunInterest(salarybuffer, RunBal);
                            FnRunInterestExpectedAmount(salarybuffer);
                            RunBal := FnRunPrinciple(salarybuffer, RunBal);
                            FnRunPrincipleExpectedAmount(salarybuffer);
                            FnRunStandingOrders(salarybuffer, RunBal);
                            FnRunStandingOrdersExpectedAmount(salarybuffer);
                            salarybuffer."Expected Amount" := ExpectedAmount;
                            salarybuffer."Amount Deducted" := AmountDeducted;
                            salarybuffer.Modify();

                            Saldetails.Init();
                            Saldetails."Entry No" := SalNo;
                            Saldetails."FOSA Account No" := salarybuffer."Account No.";
                            Saldetails."Net Salary" := RunBal;
                            Saldetails."Gross Amount" := salarybuffer.Amount;
                            Saldetails.Grade := salarybuffer.Grade;
                            Saldetails."Posting Date" := Rec."Loan Cutoff";
                            Saldetails.Validate("Posting Date");
                            Saldetails.Region := salarybuffer.Region;
                            Saldetails."Document Number" := Rec.No;
                            Saldetails."Salary Type" := Rec.Type;
                            Saldetails."Member No" := salarybuffer."Member No";
                            Saldetails."Payroll No" := salarybuffer."Staff No.";
                            Saldetails."Member Name" := salarybuffer."Account Name";
                            Saldetails.Insert(true);
                            SalNo := SalNo + 1;
                            //end;


                        end;
                        if salarybuffer."Account No." = '' then begin
                            RunBal := FnPostSalaryToSuspense(salarybuffer, RunBal, salarybuffer."Credit Narration")
                        end;
                    end;
                    if Rec."Transaction Type" = Rec."Transaction Type"::"Delayed Salary" then begin
                        RunBal := salarybuffer.Amount;
                        RunBal := FnPostSalaryToCustomer(salarybuffer, RunBal, salarybuffer."Credit Narration");
                        if salarybuffer."Account No." <> '' then begin
                            // RunBal := FnRunInterestDelayed(salarybuffer, RunBal, Rec);
                            // RunBal := FnRunPrincipleDelayed(salarybuffer, RunBal, Rec);
                            // RunBal := FnRunStandingOrdersDelayed(salarybuffer, RunBal, Rec);
                            RunBal := FnRunInterest(salarybuffer, RunBal);
                            RunBal := FnRunPrinciple(salarybuffer, RunBal);
                            RunBal := FnRunStandingOrders(salarybuffer, RunBal);

                            if RunBal > 0 then begin
                                FnTransferNetDelayed(salarybuffer, RunBal, Rec);
                            end;
                            Saldetails.Init();
                            Saldetails."Entry No" := SalNo;
                            Saldetails."FOSA Account No" := salarybuffer."Account No.";
                            Saldetails."Net Salary" := RunBal;
                            Saldetails."Gross Amount" := salarybuffer.Amount;
                            Saldetails.Grade := salarybuffer.Grade;
                            Saldetails.Region := salarybuffer.Region;
                            Saldetails."Document Number" := Rec.No;
                            Saldetails."Posting Date" := Rec."Loan Cutoff";
                            Saldetails.Validate("Posting Date");
                            Saldetails."Salary Type" := Rec.Type;
                            Saldetails."Member No" := salarybuffer."Member No";
                            Saldetails."Payroll No" := salarybuffer."Staff No.";
                            Saldetails."Member Name" := salarybuffer."Account Name";
                            Saldetails.Insert(true);
                            SalNo := SalNo + 1;
                            //end;
                        end;
                        if salarybuffer."Account No." = '' then begin
                            RunBal := FnPostSalaryToSuspense(salarybuffer, RunBal, salarybuffer."Credit Narration")
                        end;
                    end;
                end;

                if Rec.Type = Rec.Type::Pension then begin
                    if Rec."Transaction Type" = Rec."Transaction Type"::"Normal Salary" then begin
                        RunBal := salarybuffer.Amount;
                        ExpectedAmount := 0;
                        AmountDeducted := 0;
                        if salarybuffer."Account No." <> '' then begin
                            RunBal := FnPostPensionToFosa(salarybuffer, RunBal, salarybuffer."Credit Narration");
                            //RunBal := FnRunBenevolent(salarybuffer, RunBal);
                            //Message('Here%1',AuFactory.FnRunGetAccountAvailableBalance(salarybuffer."Account No."));
                            RunBal := RunBal + AuFactory.FnRunGetAccountAvailableBalance(salarybuffer."Account No.");
                            RunBal := FnRunInterest(salarybuffer, RunBal);
                            FnRunInterestExpectedAmount(salarybuffer);
                            RunBal := FnRunPrinciple(salarybuffer, RunBal);
                            FnRunPrincipleExpectedAmount(salarybuffer);
                            FnRunStandingOrders(salarybuffer, RunBal);
                            FnRunStandingOrdersExpectedAmount(salarybuffer);

                            // if RunBal > 0 then begin

                            Saldetails.Init();
                            Saldetails."Entry No" := SalNo;
                            Saldetails."FOSA Account No" := salarybuffer."Account No.";
                            Saldetails."Net Salary" := RunBal;
                            Saldetails."Gross Amount" := salarybuffer.Amount;
                            Saldetails.Grade := salarybuffer.Grade;
                            Saldetails.Region := salarybuffer.Region;
                            Saldetails."Document Number" := Rec.No;
                            Saldetails."Posting Date" := Rec."Loan Cutoff";
                            Saldetails.Validate("Posting Date");
                            Saldetails."Salary Type" := Rec.Type;
                            Saldetails."Member No" := salarybuffer."Member No";
                            Saldetails."Payroll No" := salarybuffer."Staff No.";
                            Saldetails."Member Name" := salarybuffer."Account Name";
                            Saldetails.Insert(true);
                            SalNo := SalNo + 1;

                            salarybuffer."Expected Amount" := ExpectedAmount;
                            salarybuffer."Amount Deducted" := AmountDeducted;
                            salarybuffer.Modify();
                            //end;
                        end;
                        if salarybuffer."Account No." = '' then begin
                            RunBal := FnPostSalaryToSuspense(salarybuffer, RunBal, salarybuffer."Credit Narration")
                        end;
                    end;
                    if Rec."Transaction Type" = Rec."Transaction Type"::"Delayed Salary" then begin
                        RunBal := salarybuffer.Amount;
                        RunBal := FnPostSalaryToCustomer(salarybuffer, RunBal, salarybuffer."Credit Narration");
                        if salarybuffer."Account No." <> '' then begin
                            /*                             RunBal := FnRunInterestDelayed(salarybuffer, RunBal, Rec);
                                                        RunBal := FnRunPrincipleDelayed(salarybuffer, RunBal, Rec);
                                                        RunBal := FnRunStandingOrdersDelayed(salarybuffer, RunBal, Rec); */

                            RunBal := FnRunInterest(salarybuffer, RunBal);
                            RunBal := FnRunPrinciple(salarybuffer, RunBal);
                            RunBal := FnRunStandingOrders(salarybuffer, RunBal);

                            FnTransferNetDelayed(salarybuffer, RunBal, Rec);

                            Saldetails.Init();
                            Saldetails."Entry No" := SalNo;
                            Saldetails."FOSA Account No" := salarybuffer."Account No.";
                            Saldetails."Net Salary" := RunBal;
                            Saldetails."Gross Amount" := salarybuffer.Amount;
                            Saldetails.Grade := salarybuffer.Grade;
                            Saldetails.Region := salarybuffer.Region;
                            Saldetails."Posting Date" := Rec."Loan Cutoff";
                            Saldetails.Validate("Posting Date");
                            Saldetails."Document Number" := Rec.No;
                            Saldetails."Salary Type" := Rec.Type;
                            Saldetails."Member No" := salarybuffer."Member No";
                            Saldetails."Payroll No" := salarybuffer."Staff No.";
                            Saldetails."Member Name" := salarybuffer."Account Name";
                            Saldetails.Insert(true);
                            SalNo := SalNo + 1;
                            //end;
                        end;
                        if salarybuffer."Account No." = '' then begin
                            RunBal := FnPostSalaryToSuspense(salarybuffer, RunBal, salarybuffer."Credit Narration")
                        end;
                    end;
                end;



                if Rec.Type = Rec.Type::Bonus then begin
                    FnPostBonusToFosa(salarybuffer, RunBal, salarybuffer."Credit Narration");
                end;
            until salarybuffer.Next = 0;
            if Rec.Type = Rec.Type::Bonus then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", Rec."Account Type",
                Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ");
            end;
        end;
        if ReconAmount > 0 then begin
            //Reconciliation Entry
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."Account Type"::Customer,
            Rec."Employer Receiveable Acc", Rec."Posting date", (ReconAmount * -1), 'FOSA', EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ");
        end;

        if (Rec."Transaction Type" = Rec."Transaction Type"::"Normal Salary") and (Rec.Type = Rec.Type::Pension) then begin
            //Balancing Journal Entry
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", Rec."Account Type",
            Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ");
        end;
        if (Rec."Transaction Type" = Rec."Transaction Type"::"Normal Salary") and (Rec.Type = Rec.Type::Salary) then begin
            //Balancing Journal Entry
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", Rec."Account Type",
            Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ");
        end;
        if (Rec."Transaction Type" = Rec."Transaction Type"::"Delayed Salary") then begin
            //Balancing Journal Entry
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", Rec."Account Type",
            Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', EXTERNAL_DOC_NO, Rec."Transaction Description", '', GenJournalLine."application source"::" ");
        end;


        //CU posting
        /*         GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then
                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine); */

        // Rec.Posted := true;
        // Rec."Posted By" := UserId;
        // Rec."Posting date" := WorkDate;
        // Rec.Modify;

        //commented by nthale kitui check start
        /* if Rec."Transaction Type" = Rec."transaction type"::"Salary Processing" then begin
             FnRunLoanRecovery(salarybuffer, Rec.No);//=================Recover Loans
             FnRunSalaryProcessingSMS;//============================Salary Processing SMS
         end;*/

        //commented by  kitui check start
        Message('Salaries Processed Successfuly');
        Window.Close;
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

    local procedure FnRunLoanRecovery(ObjRcptBuffer: Record "Salary Processing Lines"; VarHeader: Code[50]): Decimal
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

    local procedure getSTORecoveryType(account: Code[20]) Type: Code[30]
    var
        vend: Record Vendor;
        accType: Code[20];
    begin
        accType := '';
        if vend.Get(account) then begin
            accType := vend."Account Type";
            if accType = '101' then begin
                Type := 'Share Capital Contribution'
            end else if accType = '102' then begin
                Type := 'Deposit Contribution'
            end else if accType = '104' then begin
                Type := 'ESS Contribution'
            end else if accType = '105' then begin
                Type := 'Chamaa Contribution'
            end else if accType = '106' then begin
                Type := 'Jibambe Contribution'
            end else if accType = '107' then begin
                Type := 'Wezesha Contribution'
            end else if accType = '109' then begin
                Type := 'Mdosi Jr Contribution'
            end else if accType = '110' then begin
                Type := 'Pension Contribution'
            end;
        end else begin
            Type := 'STO Recovery'
        end;

    end;
}






