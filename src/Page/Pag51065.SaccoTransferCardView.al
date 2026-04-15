//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51065 "Sacco Transfer Card View"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Sacco Transfers";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; rec.No)
                {
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    //Editable = TransactionDateEditable;
                }
                field("Member No"; Rec."Member No")
                {
                    //Editable = VarMemberNoEditable;
                    Visible = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    // Editable = RemarkEditable;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    // Editable = SourceAccountTypeEditable;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                }
                field("Source Transaction Type"; Rec."Source Transaction Type")
                {
                    //Editable = SourceAccountTypeEditable;

                    trigger OnValidate()
                    var
                        SourceLoanVisible: Boolean;
                    begin
                        SourceLoanVisible := false;
                        if (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Charged") or
                            (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Paid") or
                            (rec."Source Transaction Type" = rec."source transaction type"::Repayment) or
                            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Due") or
                            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid")
                          then begin
                            SourceLoanVisible := true;
                        end;
                    end;
                }
                group(DepositDebitType)
                {
                    Caption = 'Deposit Debit Type';
                    //Visible = DepositDebitTypeVisible;
                }
                field("Source Loan No"; Rec."Source Loan No")
                {
                    //Editable = SourceLoanNoEditable;
                    //Visible = SourceLoanVisible;
                }
                field("Header Amount"; Rec."Header Amount")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Charge Transfer Fee"; Rec."Charge Transfer Fee")
                {
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    Editable = false;
                }
                field("Transfer Fee"; rec.GetTransferFee)
                {
                    Editable = false;
                }
                field(NetTransferable; rec.NetTransferable)
                {
                    Editable = false;
                    Caption = 'Total';
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field(Posted; rec.Posted)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Approved; rec.Approved)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Editable = false;
                    Visible = false;
                }
            }
            part(Control1102760014; "Sacco Transfer Schedule")
            {
                SubPageLink = "No." = field(No);
            }
        }
        area(factboxes)
        {
            part(Control2; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Source Account No.");
                Visible = false;
            }
            part(Control1; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Source Account No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        BTRANS.Reset;
                        BTRANS.SetRange(BTRANS.No, rec.No);
                        if BTRANS.Find('-') then begin
                            Report.run(172902, true, true, BTRANS);
                        end;
                    end;
                }
            }
            action("Members Statistics")
            {
                Caption = 'Member Details';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Source Account No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    //  ApprovalsmgtBase: Codeunit "Approvals Mgmt.";
    begin
        AddRecordRestriction();
        SetControlAppearance();

        // EnablePost := false;
        //OpenApprovalEntriesExist := ApprovalsmgtBase.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalFOrRecord := ApprovalsmgtBase.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowExist := true;
        if Rec.Status = rec.Status::Approved then begin
            // OpenApprovalEntriesExist := false;
            // CanCancelApprovalFOrRecord := false;
            EnabledApprovalWorkflowExist := false;
        end;
        if Rec.Status = rec.Status::Approved then
            // EnablePost := true;
        SourceLoanVisible := false;
        if (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Charged") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Paid") or
            (rec."Source Transaction Type" = rec."source transaction type"::Repayment) or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Due") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
        DepositDebitTypeVisible := false;
        if rec."Source Transaction Type" = rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        //"Transaction Date":=TODAY;
        //MODIFY;
    end;

    trigger OnAfterGetRecord()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if rec."Source Transaction Type" = rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        SourceLoanVisible := false;
        if (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Charged") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Paid") or
            (rec."Source Transaction Type" = rec."source transaction type"::Repayment) or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Due") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    trigger OnOpenPage()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if rec."Source Transaction Type" = rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        SourceLoanVisible := false;
        if (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Charged") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Paid") or
            (rec."Source Transaction Type" = rec."source transaction type"::Repayment) or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Due") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "Sacco Transfers Schedule";
        BTRANS: Record "Sacco Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        DoctypeEnum: Enum "Approval Document Type";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers;
        SourceAccountNoEditbale: Boolean;
        SourceAccountNameEditable: Boolean;
        SourceAccountTypeEditable: Boolean;
        SourceTransactionType: Boolean;
        SourceLoanNoEditable: Boolean;
        RemarkEditable: Boolean;
        TransactionDateEditable: Boolean;
        approvalEntries: Page "Approval Entries";
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        ObjSaccoTransfers: Record "Sacco Transfers";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowExist: Boolean;
        CanCancelApprovalFOrRecord: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        canSendApproval: Boolean;
        EnablePost: Boolean;
        Txt0001: label 'You cannot transfer another amount before three months elapse. ';
        DepositDebitTypeVisible: Boolean;
        ObjGensetup: Record "Sacco General Set-Up";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        VarExciseDuty: Decimal;
        VarExciseDutyAccount: Code[30];
        VarDepositDebitTypeEditable: Boolean;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjMember: Record Customer;
        VarMemberNoEditable: Boolean;
        ObjLoans: Record "Loans Register";
        window: Dialog;
        SourceLoanVisible: Boolean;
        cust: Record Customer;

    local procedure AddRecordRestriction()
    begin
        if rec.Status = rec.Status::Open then begin
            SourceAccountNoEditbale := true;
            SourceAccountNameEditable := true;
            SourceAccountTypeEditable := true;
            SourceLoanNoEditable := true;
            SourceTransactionType := true;
            TransactionDateEditable := true;
            VarDepositDebitTypeEditable := true;
            VarMemberNoEditable := true;
            RemarkEditable := true
        end else
            if rec.Status = rec.Status::"Pending Approval" then begin
                SourceAccountNoEditbale := false;
                SourceAccountNameEditable := false;
                SourceAccountTypeEditable := false;
                SourceLoanNoEditable := false;
                SourceTransactionType := false;
                TransactionDateEditable := false;
                VarDepositDebitTypeEditable := false;
                VarMemberNoEditable := false;
                RemarkEditable := false
            end else
                if rec.Status = rec.Status::Approved then begin
                    SourceAccountNoEditbale := false;
                    SourceAccountNameEditable := false;
                    SourceAccountTypeEditable := false;
                    SourceLoanNoEditable := false;
                    SourceTransactionType := false;
                    TransactionDateEditable := false;
                    VarDepositDebitTypeEditable := false;
                    VarMemberNoEditable := false;
                    RemarkEditable := false;
                end;
    end;

    local procedure FnLimitNumberOfTransactions(): Boolean
    begin
        ObjSaccoTransfers.Reset;
        ObjSaccoTransfers.SetRange("Savings Account Type", 'NIS');
        ObjSaccoTransfers.SetRange("Source Account No.", Rec."Source Account No.");
        ObjSaccoTransfers.SetRange(Posted, true);
        ObjSaccoTransfers.SetCurrentkey(No);
        if ObjSaccoTransfers.FindLast then begin
            if (Rec."Transaction Date" - ObjSaccoTransfers."Transaction Date") > 30 then
                exit(true);
        end;
        exit(false);
    end;

    
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if rec."Status" = rec."Status"::Open then begin
            canSendApproval := True;
            EnablePost := false;
        end
        else if Rec."Status" = Rec."Status"::Approved then begin
            canSendApproval := false;
            EnablePost := true;
        end
        else begin
            canSendApproval := false;
            EnablePost := false
        end;
    end;
}






