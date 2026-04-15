page 50046 "ESS Refund Batch Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approvals';
    SourceTable = "ESS Refund Batch";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(GroupName)
            {
                field("ESSRef Batch No.";Rec."ESSRef Batch No.")
                {
                }
                field("Captured On";Rec."Captured On")
                {
                    
                }
                field("Captured By";Rec."Captured By")
                {
                }
                field(Description;Rec.Description)
                {
                    Editable = not rec.Posted;
                    ShowMandatory = true;
                }
                field("Total Disbursed";Rec."Total Disbursed")
                {
                }
                field("Approval Status";Rec."Approval Status")
                {
                }
                field("Approved By";Rec."Approved By")
                {
                }
                field("Posted On";Rec."Posted On")
                {
                    Caption = 'Posting Date';
                    Editable = not rec.Posted;
                    ShowMandatory = true;
                }
            }
            part("ESS Refunds";"ESS Refund ListPart")
            {
                SubPageLink = "Refund Batch No" = field("ESSRef Batch No.");
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
            action(Post)
            {
                Caption = 'Post Refunds';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (rec."Approval Status" = rec."Approval Status"::Approved);

                trigger OnAction() begin
                    if Rec.Posted = true then Error('The batch has already been posted.');
                    lineNo := 0;
                    essRefund.Reset();
                    essRefund.SetRange("Refund Batch No", rec."ESSRef Batch No.");
                    if essRefund.Find('-') then begin
                        saccoGen.Get();
                        ESSAmount:= 0;
                        batchTemplate := 'PAYMENTS';
                        batchName := 'ESSREFUND';
                        docNo := 'ESSREF-'+ essRefund."Member No";

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'ESSREFUND');
                        if GenJournalLine.FindSet() then begin
                            GenJournalLine.DeleteAll
                        end;
                        
                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
                        GenBatches.SetRange(GenBatches.Name, 'ESSREFUND');
                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name" := 'PAYMENTS';
                            GenBatches.Name := 'ESSREFUND';
                            GenBatches.Description := 'ESS Refund Payment';
                            GenBatches.Insert;
                        end;
                        repeat
                            vend.Reset();
                            vend.SetRange("BOSA Account No", essRefund."Member No");
                            vend.SetRange("Account Type", '103');
                            if vend.Find('-') then begin
                                if essRefund."Early Refund" = true then begin
                                    chargesPayment := (saccoGen."ESS Refund-Early Charges"/100) * essRefund."ESS Refund";
                                    actualAmount := essRefund."ESS Refund" - chargesPayment;

                                    lineNo := lineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, essRefund."ESS Account", Today, essRefund."ESS Refund",
                                    '', '', 'ESS Refund-'+essRefund."Member No"+'-'+Rec.Description, '', GenJournalLine."Application Source"::" ");
                                    //--------------------------------(CREDIT ESS Account)---------------------------------------------

                                    //------------------------------------2. DEBIT FOSA A/C----------------------------------------------------------------
                                    lineNo := lineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, vend."No." , Today, (essRefund."ESS Refund")* -1,
                                    ' ', '', 'ESS Refund-'+essRefund."Member No"+'-'+Rec.Description, '', GenJournalLine."Application Source"::" ");

                                    lineNo := lineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, vend."No.", Today, chargesPayment, '', '',
                                    'ESS Refund-'+essRefund."Member No"+'-Early Charges', '', GenJournalLine."Application Source"::" ");
                                    //--------------------------------3.(CREDIT FOSA A/C)---------------------------------------------

                                    //------------------------------------4. DEBIT Charges A/C---------------------------------------------------------------------------------------------
                                    lineNo := lineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::"G/L Account", saccoGen."ESS Refund-Early Charges A/C", Today, chargesPayment * -1, ' ', '',
                                    'ESS Refund-'+essRefund."Member No"+'-Early Charges', '', GenJournalLine."Application Source"::" ");

                                end else begin

                                    lineNo := lineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, essRefund."ESS Account", Today, essRefund."ESS Refund", '', '',
                                    'ESS Refund-'+essRefund."Member No"+'-'+Rec.Description, '', GenJournalLine."Application Source"::" ");
                                    //--------------------------------(CREDIT ESS Account)---------------------------------------------

                                    //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                    lineNo := lineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::Vendor, vend."No.", Today, essRefund."ESS Refund" * -1, ' ', '',
                                    'ESS Refund-'+essRefund."Member No"+'-'+Rec.Description, '', GenJournalLine."Application Source"::" ");
                                end;
                            end;

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", batchTemplate);
                            GenJournalLine.SetRange("Journal Batch Name", batchName);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;

                            if cust.get(essRefund."Member No") then begin
                                essNotif:= 'Dear ' +cust.Name+ ', Your ESS Refund of Ksh.'+Format(essRefund."ESS Refund")+' has been posted to your FOSA A/C on '+Format(Today)+' '+Format(Time)+'.';
                                smsManagement.SendSmsWithID(Source::ESS_REFUND, cust."Mobile Phone No", essNotif, cust."No.", cust."FOSA Account No.", TRUE, 230, TRUE, 'CBS', CreateGuid(), 'CBS');
                            end;
                            essRefund."Posting Code" := docNo;
                            essRefund.Refunded:= true;
                            essRefund.modify;
                        until essRefund.Next()= 0;
                        rec.Posted:= true;
                        rec."Posted On":= Today;
                        rec."Posted By" := UserId;
                        rec.modify;
                        Message('The ESS refund batch has been posted successfully.');
                    end;
                end;
            }
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = canSendApproval;
                trigger OnAction() begin
                    if Rec."Approval Status" = Rec."Approval Status"::Open then begin
                        if workflowInt.CheckESSRefundBatchApprovalsWorkflowEnabled(Rec) then begin
                            workflowInt.OnSendESSRefundBatchForApproval(Rec);
                        end;
                    end;
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = CanCancelApprovalForRecord;
                trigger OnAction() begin
                    if Rec."Approval Status" = Rec."Approval Status"::Pending then begin
                        workflowInt.OnCancelESSRefundBatchApprovalRequest(Rec);
                    end;
                end;
            }
            action(ApprovalEntries)
            {
                Caption = 'Approval Entries';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Enabled = OpenApprovalEntriesExistForCurrUser;
                trigger OnAction() begin
                    approvalEntries.SetRecordFilters(Database::"ESS Refund Batch", approvalDoc::ESSRefund, rec."ESSRef Batch No.");
                    approvalEntries.RunModal();
                end;
            }
        }
        area(Reporting)
        {
            action(ESSBatchSlip)
            {
                Caption = 'Exit Batch Slip';
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;
                trigger OnAction() begin
                    essRefundbatch.Reset();
                    essRefundbatch.SetRange("ESSRef Batch No.", Rec."ESSRef Batch No.");
                    if essRefundbatch.Find('-') then begin
                        Report.Run(175083, true, false, essRefundbatch);
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord() begin
        SetControlAppearance();
    end;
    trigger OnAfterGetRecord() begin
        SetControlAppearance();
    end;
    var
    lineNo: Integer;
    chargesPayment: Decimal;
    ESSAmount: Decimal;
    actualAmount: Decimal;
    docNo: Code[30];
    bankNo: Code[20];
    batchName: Code[20];
    batchTemplate: Code[20];
    essNotif: Text[1500];
    OpenApprovalEntriesExist: Boolean;
    EnabledApprovalWorkflowsExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    OpenApprovalEntriesExistForCurrUser: Boolean;
    canSendApproval: Boolean;
    canCreate: Boolean;
    approvalDoc: Enum "Approval Document Type";
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND;
    cust: Record Customer;
    vend: Record Vendor;
    GenBatches: Record "Gen. Journal Batch";
    GenJournalLine: Record "Gen. Journal Line";
    saccoGen: Record "Sacco General Set-Up";
    essRefund: Record "ESS Refund";
    essRefundbatch: Record "ESS Refund Batch";
    smsManagement: Codeunit "Sms Management";
    AUFactory: Codeunit "Au Factory";
    workflowInt: Codeunit WorkflowIntegration;
    approvalEntries: Page "Approval Entries";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if rec."Approval Status" = rec."Approval Status"::Open then begin
            canSendApproval := True;
            canCreate := false;
        end
        else if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            canSendApproval := false;
            canCreate := true;
        end
        else begin
            canSendApproval := false;
            canCreate := false
        end;
    end;

    local procedure GetTellerBank(user: Code[20])bank: Code[20]
    var
    bankAcc: Record "Bank Account";
    begin
        bankAcc.Reset();
        bankAcc.SetRange(CashierID, user);
        if bankAcc.Find('-') then begin
            bank:= bankAcc."No.";
        end;
    end;
}


