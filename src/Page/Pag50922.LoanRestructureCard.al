//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50922 "Loan Restructure Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Loan Rescheduling";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("Loan No"; Rec."Loan No")
                {
                }
                field("Issue Date"; Rec."Issue Date")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Rescheduled; Rec.Rescheduled)
                {
                }
                field("Rescheduled By"; Rec."Rescheduled By")
                {
                }
                field("Rescheduled Date"; Rec."Rescheduled Date")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                }
                field("Outstanding Loan Amount"; Rec."Outstanding Loan Amount")
                {
                }
                field("New Installments"; Rec."New Installments")
                {
                }
                field("Original Installments"; Rec."Original Installments")
                {
                }
                field("Loan Insurance"; Rec."Loan Insurance")
                {
                }
                field("Active Schedule"; Rec."Active Schedule")
                {
                }
                field("Repayment Amount"; Rec."Repayment Amount")
                {
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Members Statistics")
            {
                Caption = 'New Repayment Schedule';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    LoanRegister.Reset;
                    LoanRegister.SetRange(LoanRegister."Loan  No.", Rec."Loan No");
                    if LoanRegister.Find('-') then begin
                        Report.Run(172477, true, false, LoanRegister);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableEffectRetructure := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Rec.Status::Approved) and (Rec."Rescheduled Date" = 0D)) then
            EnableEffectRetructure := true;
        //FnRecordRestriction;
    end;

    trigger OnOpenPage()
    begin
        EnableEffectRetructure := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Rec.Status::Approved) and (Rec."Rescheduled Date" = 0D)) then
            EnableEffectRetructure := true;
        //FnRecordRestriction;
    end;

    var
        EnableEffectRetructure: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure;
        MemberNoEditable: Boolean;
        LoantoRestructureEditable: Boolean;
        NewPeriodEditable: Boolean;
        SFactory: Codeunit "Au Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        ObjAccount: Record Vendor;
        VarLSAAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoans: Record "Loans Register";
        ObjLoansII: Record "Loans Register";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        VarNewLoanNo: Code[30];
        ObjAccounts: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarInterestRateMin: Decimal;
        VarInterestRateMax: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit "No. Series";
        LoanRegister: Record "Loans Register";
}




