page 50040 "Approved Funeral Rider Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "Funeral Rider Processing";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("FR No."; Rec."FR No.")
                {
                }
                field("Member No."; Rec."Member No.")
                {
                    ShowMandatory = True;
                    Editable = canSendApproval;
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("Member Deceased"; Rec."Member Deceased")
                {
                    trigger OnValidate()
                    begin
                        if rec."Member Deceased" = true then begin
                            nokVisible := false;
                        end else
                            nokVisible := true;
                    end;
                }
                field("Next of Kin Deceased"; Rec."Next of Kin Deceased")
                {
                    trigger OnValidate()
                    begin
                        if rec."Next of Kin Deceased" = true then begin
                            nokVisible := true;
                        end else
                            nokVisible := false;
                    end;
                }
                group("Next of Kin")
                {
                    Visible = nokVisible;
                    field("NoK ID No."; Rec."NoK ID No.")
                    {
                        ShowMandatory = true;
                    }
                    field("NoK Name"; Rec."NoK Name")
                    {
                    }
                    field("NoK Relationship"; Rec."NoK Relationship")
                    {
                    }
                    field("NoK is Member"; Rec."NoK is Member")
                    {
                    }
                }
                field("Has BBF Contributions"; Rec."Has BBF Contributions")
                {
                }
                field("Burial Permit No"; Rec."Burial Permit No")
                {
                    ShowMandatory = true;
                    Editable = canSendApproval;
                }
                field("Processing Status"; Rec."Processing Status")
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
                field("Reason For Rejection"; Rec."Reason For Rejection")
                {
                    Editable = not rec."FR Fee Paid";
                }
                field("Captured On"; Rec."Captured On")
                {
                }
                // field()
                // {
                // }
            }
        }
        area(Factboxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = canSendApproval;
                Visible = False;

                trigger OnAction()
                begin
                    if rec."Member No." = '' then Error('Kindly fill in the member no.');
                    if rec."Member Deceased" = false and rec."Next of Kin Deceased" = false then Error('Kindly select who is deceased.');
                    if (rec."Next of Kin Deceased" = true) and (rec."NoK Name" = '') then Error('Kindly fill in the next ok kin details.');
                    if rec."Burial Permit No" = '' then Error('Kindly fill in the burial permit no.');

                    if rec."Approval Status" = rec."Approval Status"::Open then begin
                        workflowInt.CheckFRFeePayApprovalsWorkflowEnabled(Rec);
                        workflowInt.OnSendFRFeePayForApproval(Rec);
                    end;
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = CanCancelApprovalForRecord;
                Visible = False;

                trigger OnAction()
                begin
                    if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then begin
                        workflowInt.OnCancelFRFeePayApprovalRequest(Rec);
                    end;
                end;
            }
            action(Approval)
            {
                Caption = 'Approval';
                Image = Approvals;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = OpenApprovalEntriesExistForCurrUser;
                Visible = False;

                trigger OnAction()
                var
                    approvalEntries: Page "Approval Entries";
                    approvalDoc: Enum "Approval Document Type";
                begin
                    approvalEntries.SetRecordFilters(Database::"Funeral Rider Processing", approvalDoc::FRFeePay, Rec."FR No.");
                    approvalEntries.RunModal();
                end;
            }
            action(FRPayment)
            {
                Caption = 'Pay FR Fee';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = canCreate and (not rec."FR Fee Paid");
                Visible = canCreate;

                trigger OnAction()
                begin
                    payment := 0;
                    FRFeeAccount := '';
                    saccoGenSetup.Get();
                    payment := saccoGenSetup."Funeral Expense Amount";
                    FRFeeAccount := saccoGenSetup."Funeral Expenses Account";
                    if payment = 0 then Error('Confirm that the funeral rider payment is set up in the sacco setup.');

                    if Confirm('Do you wish to proceed with posting the funeral rider for this member', true) = false then exit;

                    batchTemplate := 'PAYMENTS';
                    batchName := 'FUNERAL';
                    docNo := 'FRFEE' + Rec."Member No." + '-' + Rec."FR No.";
                    lineNo := 0;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                    GenJournalLine.SetRange("Journal Batch Name", 'FUNERAL');
                    if GenJournalLine.FindSet() then begin
                        GenJournalLine.DeleteAll
                    end;

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
                    GenBatches.SetRange(GenBatches.Name, 'FUNERAL');
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'PAYMENTS';
                        GenBatches.Name := 'FUNERAL';
                        GenBatches.Description := 'FUNERAL RIDER PAYMENT';
                        GenBatches.Insert;
                    end;

                    if vend.Get(Rec."Member FOSA Account") then begin
                        if rec."Next of Kin Deceased" = true then begin
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", FRFeeAccount, Today, payment, '', '',
                            'Funeral Rider-SPOUSE-' + Rec."Member No." + ' Payment', '', GenJournalLine."Application Source"::" ");
                            //--------------------------------(CREDIT Funeral Rider Account)---------------------------------------------

                            //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, Vend."No.", Today, payment * -1, ' ', '',
                            'Funeral Rider-SPOUSE-' + Rec."Member No." + ' Payment', '', GenJournalLine."Application Source"::" ");
                            FnMarkTheBOSAandFOSAasDeceased();
                        end else begin
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", FRFeeAccount, Today, payment, '', '',
                            'Funeral Rider-MEMBER-' + Rec."Member No." + ' Payment', '', GenJournalLine."Application Source"::" ");
                            //--------------------------------(CREDIT Funeral Rider Account)---------------------------------------------

                            //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                            lineNo := lineNo + 10000;
                            AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, Vend."No.", Today, payment * -1, ' ', '',
                            'Funeral Rider-MEMBER-' + Rec."Member No." + ' Payment', '', GenJournalLine."Application Source"::" ");

                            if (rec."Next of Kin Deceased" = true) and (rec."Nok is Member" = True) and (rec."NoK Member No." <> '') then begin
                                lineNo := lineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", FRFeeAccount, Today, payment, '', '',
                                'Funeral Rider-SPOUSE-' + Rec."NoK Member No." + ' Payment', '', GenJournalLine."Application Source"::" ");
                                //--------------------------------(CREDIT Funeral Rider Account)---------------------------------------------

                                //------------------------------------2. DEBIT FOSA A/C---------------------------------------------------------------------------------------------
                                lineNo := lineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::Vendor, Vend."No.", Today, payment * -1, ' ', '',
                                'Funeral Rider-SPOUSE-' + Rec."NoK Member No." + ' Payment', '', GenJournalLine."Application Source"::" ");
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", batchTemplate);
                        GenJournalLine.SetRange("Journal Batch Name", batchName);
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        detVend.Reset();
                        detVend.SetRange("Vendor No.", rec."Member FOSA Account");
                        detVend.SetRange("Document No.", docNo);
                        if detVend.Find('-') then begin
                            rec."FR Fee Paid" := true;
                            rec."Processing Status" := rec."Processing Status"::Paid;
                            rec."Payment Doc No" := docNo;
                            rec."Paid By" := UserId;
                            rec."Paid On" := Today;
                            rec.modify;
                            Message('The payment process completed successfully.');
                        end else
                            Error('The payment did not go through successfully');

                        frPay.Reset();
                        frPay.SetRange("Member No.", rec."Member No.");
                        frPay.SetRange("FR No.", Rec."FR No.");
                        if frPay.Find('-') then begin
                            Report.Run(175080, false, true, frPay);
                        end;

                        if cust.get(rec."Member No.") then begin
                            exitNotif := 'Dear ' + cust.Name + ', we are sorry for your loss at this very trying time. Your funeral rider payment of Ksh.' + Format(payment) + ' has been posted to your FOSA A/C.';
                            smsManagement.SendSmsWithID(Source::MEMBER_EXIT, cust."Mobile Phone No", exitNotif, cust."No.", cust."FOSA Account No.", TRUE, 230, TRUE, 'CBS', CreateGuid(), 'CBS');
                        end;
                    end;

                end;
            }
            action(RejectRecord)
            {
                Caption = 'Reject Record';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = not canCreate and (not rec."FR Fee Paid");
                // Visible = canCreate;

                trigger OnAction()
                begin
                    if Rec."Reason For Rejection" <> '' then begin
                        Rec."Processing Status" := rec."Processing Status"::Rejected;
                        rec."Approval Status" := rec."Approval Status"::Rejected;
                        rec.modify;
                    end else
                        Error('Kindly fill in the reason for rejection.');
                end;
            }
            action(FuneralPaymentSLip)
            {
                Caption = 'FR-Payment Slip';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // Enabled = rec."FR Fee Paid";

                trigger OnAction()
                begin
                    frPay.Reset();
                    frPay.SetRange("Member No.", rec."Member No.");
                    frPay.SetRange("FR No.", Rec."FR No.");
                    if frPay.Find('-') then begin
                        Report.Run(175080, true, false, frPay);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();

        nokVisible := false;
        if rec."Next of Kin Deceased" = true then begin
            nokVisible := true;
        end else
            nokVisible := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();

        nokVisible := false;
        if rec."Next of Kin Deceased" = true then begin
            nokVisible := true;
        end else
            nokVisible := false;
    end;

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

    var
        nokVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        canSendApproval: Boolean;
        canCreate: Boolean;
        lineNo: Integer;
        payment: Decimal;
        docNo: Code[30];
        batchName: Code[20];
        batchTemplate: Code[20];
        FRFeeAccount: Code[20];
        exitNotif: Text[1500];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT;
        smsManagement: Codeunit "Sms Management";
        frPay: Record "Funeral Rider Processing";
        workflowInt: Codeunit WorkflowIntegration;
        AUFactory: Codeunit "Au Factory";
        saccoGenSetup: Record "Sacco General Set-Up";
        GenBatches: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        cust: Record Customer;
        vend: Record Vendor;
        detVend: Record "Detailed Vendor Ledg. Entry";

    local procedure FnMarkTheBOSAandFOSAasDeceased()
    var
        myInt: Integer;
        Vendor: Record Vendor;
        Customer: Record Customer;
    begin
        Vendor.Reset();
        Vendor.SetRange("No.", Rec."Member FOSA Account");
        If Vendor.FindFirst() then begin
            // Vendor.Status := Vendor.Status::Closed;
            Vendor."Membership Status" := Vendor."Membership Status"::Deceased;
            Vendor.Modify(true)
        end;

        Customer.Reset();
        Customer.SetRange("No.", Rec."Member No.");
        If Customer.FindFirst() then begin
            // Customer.Status := Customer.Status::Closed;
            Customer."Membership Status" := Customer."Membership Status"::Deceased;
            Customer.Modify(true);
        end;

    end;
}


