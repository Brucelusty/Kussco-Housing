//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50685 "EFT/RTGS Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "EFT/RTGS Header";
    PromotedActionCategories = 'New,Process,Reports,Approval,Attachments';

    layout
    {
        area(content)
        {
            group("EFT Batch")
            {
                Caption = 'EFT Batch';
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Expected Amount"; Rec."Expected Amount")
                {
                    Caption = 'Amount';
                    Editable = TransactionDescriptionEditable;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    Editable = TransactionDescriptionEditable;
                }
                field(Total; Rec.Total)
                {
                }
                field("Total Count"; Rec."Total Count")
                {
                    Caption = 'Record Count';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Caption = 'EFT/RTGS Ref No.';
                    // Editable = EnablePost;
                }
                field("Reason for EFT/RTGS"; Rec."Reason for EFT/RTGS")
                {
                    // Editable = not EnablePost;
                }
                field(Transferred; Rec.Transferred)
                {
                    Editable = false;
                }
                field("Date Transferred"; Rec."Date Transferred")
                {
                }
                field("Time Transferred"; Rec."Time Transferred")
                {
                }
                field("Transferred By"; Rec."Transferred By")
                {
                }
                field(Failed;Rec.Failed)
                {
                }
                field("Reason for EFT/RTGS Failure";Rec."Reason for EFT/RTGS Failure")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Importance = Additional;
                }
            }
            part(Control1; "EFT/RTGS Details")
            {
                Editable = BankCodeEditable;
                SubPageLink = "Header No" = field(No);
            }
        }

        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"EFT/RTGS Header"), "No." = field(No);
            }
        }
    }

    actions
    {

        area(Reporting)
        {
            action(Attachment)
            {
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
        area(processing)
        {
            action("Post Transfer")
            {
                //Enabled = EnablePost;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Rec.Transferred = true then begin
                        Error(ErrorAlreadyPosted);
                    end;

                    Rec.TestField("Cheque No");

                    BATCH_TEMPLATE := 'PURCHASES';
                    BATCH_NAME := 'FTRANS';
                    DOCUMENT_NO := Rec.No;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        GenJournalLine.DeleteAll;
                    end;

                    // if Rec."Cheque No" = '' then begin
                    //     Rec."Cheque No" := FnRunAssignChequeNo;
                    // end;

                    Rec.CalcFields(Total);
                    FnPostDebitSourceAccounts(Rec.Failed);//-------------Post Transaction

                    // CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;

                    bankLedger.Reset();
                    bankLedger.SetRange("Document No.", DOCUMENT_NO);
                    bankLedger.SetRange(Reversed, false);
                    if bankLedger.Find('-') then begin
                        Rec.Transferred := true;
                        Rec."Date Transferred" := Today;
                        Rec."Time Transferred" := Time;
                        Rec."Transferred By" := UserId;
                        Rec.Modify;

                        EFTDetails.Reset();
                        EFTDetails.SetRange("Header No", Rec.No);
                        if EFTDetails.Find('-') then begin
                            repeat
                                EFTDetails.Transferred := true;
                                EFTDetails."Date Transferred" := Today;
                                EFTDetails."Time Transferred" := Time;
                                EFTDetails."Transferred By" := UserId;
                                EFTDetails.Modify;
                            until EFTDetails.Next() = 0;
                        end;

                        ObjEFTRTGSDetailsII.Reset;
                        ObjEFTRTGSDetailsII.SetRange("Header No", Rec.No);
                        if ObjEFTRTGSDetailsII.Find('-') then begin
                            Accounts.Reset();
                            Accounts.SetRange("No.", ObjEFTRTGSDetailsII."Account No");
                            if Accounts.Find('-') then begin
                                if Rec.Failed then begin
                                    EFTInitiated := 'Dear ' + custName.NameStyle(Accounts."BOSA Account No") + ', your EFT of Ksh.' + Format(ObjEFTRTGSDetailsII.Amount) + ' has failed with the following reason: ' + Rec."Reason for EFT/RTGS Failure" + '. Thank you for banking with us.';
                                    smsManagement.SendSmsWithID(Source::EFT_EFFECTED, Accounts."Mobile Phone No", EFTInitiated, Accounts."No.", Accounts."No.", true, 250, true, 'CBS', CreateGuid(), 'CBS');
                                    Message('Transaction Posted successfully and Reversed and member notified via SMS.');
                                end else begin
                                    if ObjEFTRTGSDetailsII.Amount >= 1000000 then begin
                                        EFTPosted := 'Dear ' + custName.NameStyle(Accounts."BOSA Account No") + ', your RTGS of Ksh.' + Format(ObjEFTRTGSDetailsII.Amount) + ' has been completed. Thank you for banking with us.';
                                        smsManagement.SendSmsWithID(Source::EFT_EFFECTED, Accounts."Mobile Phone No", EFTPosted, Accounts."No.", Accounts."No.", true, 250, true, 'CBS', CreateGuid(), 'CBS');
                                        Message('Transaction Posted successfully and member notified via SMS.');
                                    end else begin
                                        EFTPosted := 'Dear ' + custName.NameStyle(Accounts."BOSA Account No") + ', your EFT of Ksh.' + Format(ObjEFTRTGSDetailsII.Amount) + ' has been completed. Thank you for banking with us.';
                                        smsManagement.SendSmsWithID(Source::EFT_EFFECTED, Accounts."Mobile Phone No", EFTPosted, Accounts."No.", Accounts."No.", true, 250, true, 'CBS', CreateGuid(), 'CBS');
                                        Message('Transaction Posted successfully and member notified via SMS.');
                                    end;
                                end;
                            end;
                        end;
                        Message('Transaction Posted successfully.');
                    end else
                        Message('Transaction NOT Posted.');

                    //========================================Update Issued Cheque Nos
                    // Muia
                    // EFTs are not captured as cheques, thus this isn't needed.
                    // ObjEFTRTGSDetailsII.Reset;
                    // ObjEFTRTGSDetailsII.SetRange(ObjEFTRTGSDetailsII."Header No",Rec. No);
                    // if ObjEFTRTGSDetailsII.Find('-') then begin
                    //     repeat
                    //         ObjChequeNosII.Reset;
                    //         ObjChequeNosII.SetRange(ObjChequeNosII."Cheque No.", ObjEFTRTGSDetailsII."Cheque No");
                    //         if ObjChequeNosII.FindSet then begin
                    //             ObjChequeNosII.Issued := true;
                    //             ObjChequeNosII.Modify;
                    //         end;
                    //     until ObjEFTRTGSDetailsII.Next = 0;
                    // end;
                end;
            }
            action("View Schedule")
            {
                Caption = 'View Slip';
                Image = Form;
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    EFTHeader.Reset;
                    EFTHeader.SetRange(EFTHeader.No, Rec.No);
                    if EFTHeader.Find('-') then begin
                        Report.run(172997, true, true, EFTHeader);
                    end;
                end;
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
                    // ObjEFTRTGSDetailsII.Reset;
                    // ObjEFTRTGSDetailsII.SetRange("Header No", Rec.No);
                    // if ObjEFTRTGSDetailsII.Find('-') then begin
                    //     repeat
                    //         ObjEFTRTGSDetailsII.TestField(ObjEFTRTGSDetailsII."Destination Account No");
                    //         ObjEFTRTGSDetailsII.TestField(ObjEFTRTGSDetailsII."Destination Account Name");
                    //     until ObjEFTRTGSDetailsII.Next = 0;
                    // end;
                    Rec.TestField("Reason for EFT/RTGS");

                    Rec.CalcFields(Total);
                    if Rec.Total <> Rec."Expected Amount" then Error(ErrorAmountsNotEqual);

                    // docFactbox.Reset();
                    // docFactbox.SetRange("Table ID", Database::"EFT/RTGS Header");
                    // docFactbox.SetRange("No.", Rec.No);
                    // if docFactbox.FindSet() then begin
                    //     noOfRecords := docFactbox.Count;
                    // end;
                    // if noOfRecords <= 0 then Error(ErrorNoAttachments);

                    if workflowintegration.CheckEFTRTGSApprovalsWorkflowEnabled(Rec) then begin
                        workflowintegration.OnSendEFTRTGSForApproval(Rec);

                        ObjEFTRTGSDetailsII.Reset;
                        ObjEFTRTGSDetailsII.SetRange("Header No", Rec.No);
                        if ObjEFTRTGSDetailsII.Find('-') then begin
                            Accounts.Reset();
                            Accounts.SetRange("No.", ObjEFTRTGSDetailsII."Account No");
                            if Accounts.Find('-') then begin
                                if ObjEFTRTGSDetailsII.Amount >= 1000000 then begin
                                    EFTInitiated := 'Dear ' + custName.NameStyle(Accounts."BOSA Account No") + ', your RTGS of Ksh.' + Format(ObjEFTRTGSDetailsII.Amount) + ' has been initiated, we will notify you once the process is complete. Thank you for banking with us.';
                                    smsManagement.SendSmsWithID(Source::EFT_EFFECTED, Accounts."Mobile Phone No", EFTInitiated, Accounts."No.", Accounts."No.", true, 250, true, 'CBS', CreateGuid(), 'CBS');
                                end else begin
                                    EFTInitiated := 'Dear ' + custName.NameStyle(Accounts."BOSA Account No") + ', your EFT of Ksh.' + Format(ObjEFTRTGSDetailsII.Amount) + ' has been initiated, we will notify you once the process is complete. Thank you for banking with us.';
                                    smsManagement.SendSmsWithID(Source::EFT_EFFECTED, Accounts."Mobile Phone No", EFTInitiated, Accounts."No.", Accounts."No.", true, 250, true, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;
                        end;
                    end;
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
                    if Confirm('Are you sure you want to cancel this approval request?', false) = true then
                        workflowintegration.OnCancelEFTRTGSApprovalRequest(Rec);
                end;
            }

            action("Open Document")
            {
                Caption = 'Open Document';
                // Enabled = CanCancelApprovalForRecord;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category4;
                visible = false;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to Re-Open This Document?', false) = true then
                        Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                end;
            }
            action("Mark As Transferred")
            {
                Caption = 'Mark As Transferred';
                // Enabled = CanMark As TransferredCancelApprovalForRecord;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                    eftdet: Record "EFT/RTGS Details";
                begin
                    if Confirm('Are you sure you want to Mark This Document As Transferred?', false) = true then
                        Rec.Transferred := true;
                    Rec.Modify();
                    EFTDetails.Reset();
                    EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                    if EFTDetails.FindFirst() then begin
                        EFTDetails.Transferred := true;
                        EFTDetails.Modify();
                    end;

                end;
            }
            action(Approval)
            {
                Caption = 'Approvals';
                Enabled = OpenApprovalEntriesExist;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    approvalDoc: Enum "Approval Document Type";
                begin
                    Rec.CalcFields(Total);

                    if Rec.Total >= 1000000 then begin
                        ApprovalEntries.SetRecordFilters(Database::"EFT/RTGS Header", approvalDoc::RTGS, Rec.No);
                        ApprovalEntries.Run;
                    end else begin
                        ApprovalEntries.SetRecordFilters(Database::"EFT/RTGS Header", approvalDoc::EFT, Rec.No);
                        ApprovalEntries.Run;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnablePost := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnablePost := true;

        TransactionDescriptionEditable := true;
        BankCodeEditable := true;
        if Rec.Status <> Rec.Status::Open then begin
            TransactionDescriptionEditable := false;
            BankCodeEditable := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        EnablePost := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnablePost := true;

        TransactionDescriptionEditable := true;
        BankCodeEditable := true;
        if Rec.Status <> Rec.Status::Open then begin
            TransactionDescriptionEditable := false;
            BankCodeEditable := false;
        end;
    end;

    trigger OnOpenPage()
    begin
        EnablePost := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnablePost := true;

        TransactionDescriptionEditable := true;
        BankCodeEditable := true;
        if Rec.Status <> Rec.Status::Open then begin
            TransactionDescriptionEditable := false;
            BankCodeEditable := false;
        end;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        smsManagement: Codeunit "Sms Management";
        custName: Codeunit "SMS Reminders";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY,MEMBER_ALLOWANCES;
        EFTInitiated: Text[1900];
        EFTPosted: Text[1900];
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        noOfRecords: Integer;
        EFTDetails: Record "EFT/RTGS Details";
        STORegister: Record "Standing Order Register";
        Accounts: Record Vendor;
        EFTHeader: Record "EFT/RTGS Header";
        Transactions: Record Transactions;
        TextGen: Text[250];
        STO: Record "Standing Orders";
        ReffNo: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        SFactory: Codeunit "Au Factory";
        // ObjRTGSCharges: Record "EFT/RTGS Charges Setup";
        ObjRTGSCharges: Record "EFT - RTGS Charges";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EnablePost: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS;
        BankCodeEditable: Boolean;
        TransactionDescriptionEditable: Boolean;
        ErrorAlreadyPosted: label 'Transaction Already Posted.';
        ErrorAmountsNotEqual: label 'The Expected Amount Should Be Equal To The Total Amount In The Lines.';
        ErrorNoAttachments: label 'Kindly attach the required statement to this EFT/RTGS.';
        ObjChequeNosII: Record "Cheque Book Register";
        docFactbox: Record "Document Attachment";
        bankLedger: Record "Bank Account Ledger Entry";
        ObjEFTRTGSDetailsII: Record "EFT/RTGS Details";
        workflowintegration: Codeunit WorkflowIntegration;

    local procedure FnPostDebitSourceAccounts(fail: Boolean)
    var
        ObjAccounts: Record Vendor;
        ObjEFTRTGSDetails: Record "EFT/RTGS Details";
        VarSaccoCharge: Decimal;
        VarSaccoCommissionAccount: Code[20];
        VarBankAccount: Code[20];
        VarTotalRtgsCommission: Decimal;
    begin
        GenSetup.Get;

        ObjEFTRTGSDetails.Reset;
        ObjEFTRTGSDetails.SetRange("Header No", Rec.No);
        if ObjEFTRTGSDetails.Find('-') then begin
            repeat
                ObjRTGSCharges.Reset;
                ObjRTGSCharges.SetFilter("Lower Limit", '<=%1', ObjEFTRTGSDetails.Amount);
                ObjRTGSCharges.SetFilter("Upper Limit", '>=%1', ObjEFTRTGSDetails.Amount);
                if ObjRTGSCharges.Find('-') then begin
                    VarSaccoCharge := ObjRTGSCharges."Charge Amount";
                    VarSaccoCommissionAccount := ObjRTGSCharges."Charge Account";
                    VarBankAccount := ObjRTGSCharges."Bank Account";
                end;

                //------------------------------------1. CREDIT CASH BOOK  A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"Bank Account", VarBankAccount, Today, ObjEFTRTGSDetails.Amount * -1, 'FOSA', '',
                Rec."Transaction Description" + ': ' + 'Ref No.' + ' ' + Rec."Cheque No", ObjEFTRTGSDetails."Cheque No", GenJournalLine."application source"::" ");
                //--------------------------------(Credit Cash Book Account)-------------------------------------------------------------------------------

                //------------------------------------1.1. Debit Member Source EFT/RTGs Amount A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjEFTRTGSDetails."Account No", Today, ObjEFTRTGSDetails.Amount, 'FOSA', '',
                ObjEFTRTGSDetails."Transaction Description" + ': ' + 'Ref No.' + ' ' + Rec."Cheque No", ObjEFTRTGSDetails."Cheque No", GenJournalLine."application source"::" ");
                //--------------------------------(Debit Member Source Account EFT/RTGs Amount)-------------------------------------------------------------------------------

                //------------------------------------1.2. Debit Member Source EFT Charge A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjEFTRTGSDetails."Account No", Today, VarSaccoCharge, 'FOSA', '',
                'EFT/RTGS Charge - ' + Format(Rec.No), Rec."Cheque No", GenJournalLine."application source"::" ");
                //--------------------------------(Debit Member Source Bank Charge)-------------------------------------------------------------------------------

                //------------------------------------1.3. Credit Charge to G/L A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", VarSaccoCommissionAccount, Today, VarSaccoCharge * -1, 'FOSA', '',
                'EFT/RTGS Charge - ' + Format(Rec.No), Rec."Cheque No", GenJournalLine."application source"::" ");

                if fail then begin
                    //------------------------------------1. CREDIT CASH BOOK  A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"Bank Account", VarBankAccount, Today, ObjEFTRTGSDetails.Amount, 'FOSA', '',
                    Rec."Reason for EFT/RTGS Failure" + ': ' + 'Ref No.' + ' ' + Rec."Cheque No", ObjEFTRTGSDetails."Cheque No", GenJournalLine."application source"::" ");
                    //--------------------------------(Credit Cash Book Account)-------------------------------------------------------------------------------

                    //------------------------------------1.1. Debit Member Source EFT/RTGs Amount A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjEFTRTGSDetails."Account No", Today, ObjEFTRTGSDetails.Amount * -1, 'FOSA', '',
                    Rec."Reason for EFT/RTGS Failure" + ': ' + 'Ref No.' + ' ' + Rec."Cheque No", ObjEFTRTGSDetails."Cheque No", GenJournalLine."application source"::" ");
                    //--------------------------------(Debit Member Source Account EFT/RTGs Amount)-------------------------------------------------------------------------------
                end;

            until ObjEFTRTGSDetails.Next = 0;
        end;
    end;

    local procedure FnRunAssignChequeNo() VarChequeNo: Code[20]
    var
        ObjChequeRegsiter: Record "Cheque Book Register";
        ObjEFTLines: Record "EFT/RTGS Details";
        VarDestinationBank: Code[30];
    begin
        /*ObjEFTLines.RESET;
        ObjEFTLines.SETRANGE(ObjEFTLines."Header No",No);
        ObjEFTLines.SETFILTER(ObjEFTLines.Amount,'<>%1',0);
        IF ObjEFTLines.FINDFIRST THEN
          BEGIN
            VarDestinationBank:=ObjEFTLines."Destination Cash Book";
            END;
        ObjChequeRegsiter.RESET;
        ObjChequeRegsiter.SETRANGE(ObjChequeRegsiter."Bank Account",VarDestinationBank);
        ObjChequeRegsiter.SETRANGE(ObjChequeRegsiter.Issued,FALSE);
        ObjChequeRegsiter.SETRANGE(ObjChequeRegsiter.Cancelled,FALSE);
        IF ObjChequeRegsiter.FINDFIRST THEN
          BEGIN
            VarChequeNo:=ObjChequeRegsiter."Cheque No.";
            EXIT(VarChequeNo);
            END;*/

    end;
}






