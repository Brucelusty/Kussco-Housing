//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50915 "Posted OverDraft Applic Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "OverDraft Application";

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
                    Editable = false;
                }
                field("Over Draft Account"; Rec."Over Draft Account")
                {
                    Editable = false;
                }
                field("Over Draft Account Name"; Rec."Over Draft Account Name")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Security Type"; Rec."Security Type")
                {
                    Editable = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Member Guarantee Liability"; Rec."Member Guarantee Liability")
                {
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Members Unsecured Loans"; Rec."Total Members Unsecured Loans")
                {
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("OD Qualifying Amount:Deposits"; Rec."OD Qualifying Amount:Deposits")
                {
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("OD Qualifying Amount:Collatera"; Rec."OD Qualifying Amount:Collatera")
                {
                    Caption = 'OD Qualifying Amount:Collateral';
                }
                field("Qualifying Overdraft Amount"; Rec."Qualifying Overdraft Amount")
                {
                    Editable = false;
                }
                field("Overdraft Duration"; Rec."Overdraft Duration")
                {
                    Editable = false;
                }
                field("OverDraft Expiry Date"; Rec."OverDraft Expiry Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("OverDraft Application Type"; Rec."OverDraft Application Type")
                {
                    Editable = false;
                }
                field("OverDraft Application Status"; Rec."OverDraft Application Status")
                {
                    Editable = false;
                }
                field("Date Terminated"; Rec."Date Terminated")
                {
                    Editable = false;
                }
                field("Terminated By"; Rec."Terminated By")
                {
                    Editable = false;
                }
                field("Reason For Termination"; Rec."Reason For Termination")
                {
                    MultiLine = true;
                }
            }
            part("Collateral Security"; "OverDraft Collateral Register")
            {
                Caption = 'Collateral Security';
                Editable = false;
                SubPageLink = "OD No" = field("Document No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(EnableCreateHouse)
            {
                Caption = 'Create Group';
                Enabled = EnableCreateHouse;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
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
                    /*
                    IF ApprovalsMgmt.CheckHouseRegistrationApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendHouseRegistrationForApproval(Rec);
                    */

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
                    /*IF CONFIRM('Are you sure you want to cancel this approval request',FALSE)=TRUE THEN
                     ApprovalsMgmt.OnCancelHouseRegistrationApprovalRequest(Rec);
                      Status:=Status::Open;
                      MODIFY;
                    */

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
                    /*DocumentType:=DocumentType::HouseRegistration;
                    ApprovalEntries.Setfilters(DATABASE::"House Groups Registration",DocumentType,"Cell Group Code");
                    ApprovalEntries.RUN;*/

                end;
            }
            action(EndOverDraft)
            {
                Caption = 'Terminate OverDraft';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Rec."OverDraft Application Status" = Rec."overdraft application status"::Terminated then
                        Error('Application Terminated');

                    if Rec."Reason For Termination" = '' then
                        Error('Specify termination Reasons');

                    if Confirm('Confirm Overdraft Termination?', false) = true then begin
                        Rec."Terminated By" := UserId;
                        Rec."OverDraft Application Status" := Rec."overdraft application status"::Terminated;
                        Rec."Date Terminated" := WorkDate;

                        if ObjAccount.Get(Rec."Over Draft Account") then begin
                            ObjAccount."Over Draft Limit Expiry Date" := 0D;
                            ObjAccount."Over Draft Limit Amount" := 0;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableCreateHouse := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateHouse := true;
    end;

    trigger OnOpenPage()
    begin
        EnableCreateHouse := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateHouse := true;
    end;

    var
        ObjCellGroups: Record "Member House Groups";
        ObjCust: Record "Members Register";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff;
        EnableCreateHouse: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        MemberNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChangeTypeEditable: Boolean;
        AccountTypeEditable: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        ObjSaccoNos: Record "Sacco No. Series";
        VarHouseNo: Code[30];
        ObjHouseG: Record "Member House Groups";
        NoSeriesMgt: Codeunit "No. Series";
        ObjAccount: Record Vendor;
}






