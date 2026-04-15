//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51108 "Recruitment Processing Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Recruitment Commission Header";
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


                field("Posting date"; Rec."Posting date")
                {
                }

                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                    Visible = false;
                }

                field(Remarks; Rec.Remarks)
                {
                    Visible = false;
                }

                field("Posted By"; Rec."Posted By")
                {
                    Visible = false;
                }


                field(Posted; Rec.Posted)
                {
                    Visible = false;
                }

                field("Total Count"; Rec."Total Count")
                {
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    Style = Strong;
                    StyleExpr = true;
                }

                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part("172000"; "Recruitment Lines")
            {
                Caption = 'Recruitment Lines';
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
                action("Import Recruitment Fee")
                {
                    Enabled = not ActionEnabled;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = XMLport "Import Recruitment";
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
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                Members.Reset();
                                Members.SetRange(Members."Payroll No", salarybuffer."Staff No.");
                                Members.SetFilter(Status, '%1|%2', Members."Membership Status"::Active, Members."Membership Status"::Dormant);
                                if Members.FindFirst() then begin
                                    salarybuffer."Member No" := Members."No.";
                                    salarybuffer."Mobile Phone Number" := Members."Mobile Phone No.";
                                    salarybuffer.Modify;
                                end;
                                VendX.Reset();
                                VendX.SetRange(VendX."BOSA Account No", salarybuffer."Member No");
                                VendX.SetFilter(VendX."Account Type", '103');
                                if VendX.FindFirst() then begin
                                    salarybuffer."Account Name" := Members.Name;
                                    salarybuffer."Mobile Phone Number" := Members."Phone No.";
                                    salarybuffer."Account No." := VendX."No.";
                                    salarybuffer.Modify;
                                end;
                            until salarybuffer.Next = 0;
                        end;

                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                Members.Reset();
                                Members.SetRange(Members."Payroll No", salarybuffer."Person Recruited");
                                Members.SetFilter(Status, '%1|%2', Members."Membership Status"::Active, Members."Membership Status"::Dormant);
                                if Members.FindFirst() then begin
                                    if salarybuffer."Person Recruited" <> '' then begin
                                        salarybuffer."Recruited Name" := Members.Name;
                                        salarybuffer.Modify;
                                    end;
                                end;
                            until salarybuffer.Next = 0;
                        end;


                        Message('Validation completed successfully.');
                    END;
                }


                action("Process")
                {
                    //Enabled = EnableProcessing;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;//
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    begin

                        if Confirm('Are you sure you want to Transfer this to Journals ?', true) = false then exit;

                        DocumentsDed := Rec.No;
                        DOCUMENT_NO := Rec."Document No";
                        EXTERNAL_DOC_NO := "Cheque No.";
                        SMSCODE := '';
                        Counter := 0;
                        FnSalaryProcessing(VarPostingDiff);
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
                        VarSMSBody: Text;
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
                        // if workflowintegration.CheckSalaryProcessingApprovalsWorkflowEnabled(Rec) then
                        //   workflowintegration.OnSendSalaryProcessingForApproval(Rec);

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
                        //  if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        //       workflowintegration.OnCancelSalaryProcessingApprovalRequest(Rec);

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
                        ApprovalEntries.SetRecordFilters(Database::"Recruitment Commission Header", DocumentType, Rec.No);
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
        SalaryProcessingLines: Record "Recruitment Lines";
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
        salarybuffer: Record "Recruitment Lines";
        SalHeader: Record "Recruitment Commission Header";
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
        ObjSalaryProcessingLines: Record "Recruitment Lines";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;

        ExpectedAmount: Decimal;

        AmountDeducted: Decimal;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement,InwardChequeClearing,InValidPaybillTransactions,InternalPV,SalaryProcessing;
        EnableProcessing: Boolean;
        workflowintegration: Codeunit WorkflowIntegration;




    local procedure FnPostBonusToFosa(ObjSalaryLines: Record "Recruitment Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250])
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", today, ObjSalaryLines.Amount * -1, 'FOSA',
        EXTERNAL_DOC_NO, 'Recruiment Comm ' + ObjSalaryLines."Recruited Name", '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::" ");

    end;




    local procedure FnSalaryProcessing(ReconAmount: Decimal)
    var
        Vends: record Vendor;
        SalNo: Integer;
        Sal: Record "Salary Details";
        AuFactory: Codeunit "Au Factory";
        AvailableBalanceX: Decimal;
        VarSMSBody: Text[2000];
        Paybill: Codeunit "AU Paybill Automations";
        SendBir: Codeunit "Send Birthday SMS";
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
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll;
        end;
        ObjGenSetup.Get();

        VarCreditDescription := '';




        //Message('SalNo%1', SalNo);
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
                RunBal := 0;
                FnPostBonusToFosa(salarybuffer, RunBal, salarybuffer."Credit Narration");
                Cust.Reset();
                Cust.SetRange(Cust."No.", salarybuffer."Member No");
                if Cust.FindFirst() then begin
                    VarSMSBody := '';
                    VarSMSBody := 'Dear ' + SendBir.NameStyle(Cust."No.") + ', your commission for member recruitment has been posted to your FOSA Account. ';
                    smsManagement.SendSmsWithID(Source::CRM, Cust."Mobile Phone No", VarSMSBody, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                end;
            until salarybuffer.Next = 0;
            Rec.CalcFields(rec."Scheduled Amount");
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", '400-000-076', Today, rec."Scheduled Amount", 'FOSA',
            EXTERNAL_DOC_NO, 'Recruiment Commission ', '', GenJournalLine."application source"::" ",'', GenJournalLine."Salary Receipt Type"::" ");
        end;



        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

        Rec.Posted := true;
        Rec."Posted By" := UserId;
        Rec."Posting date" := WorkDate;
        Rec.Modify;

        //commented by  kitui check start
        Message('Commissions Processed Successfuly');
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
                VarSMSBody := 'Dear ' + VarMemberName + ', your commission for member recruitment has been posted to your FOSA Account. ';
                SFactory.FnSendSMS('COMMISSION', VarSMSBody, ObjSalaryProcessingLines."Account No.", ObjSalaryProcessingLines."Mobile Phone Number");
            until ObjSalaryProcessingLines.Next = 0;
        end;
    end;

}






