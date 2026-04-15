//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51009 "House Group Registration Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "House Groups Registration";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("House Group Code"; Rec."House Group Code")
                {
                    Editable = false;
                }
                field("House Group Name"; Rec."House Group Name")
                {
                }
                field("Date Formed"; Rec."Date Formed")
                {
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                }
                group(Control27)
                {
                    Visible = false;
                    field("Group Leader"; Rec."Group Leader")
                    {
                    }
                    field("Group Leader Name"; Rec."Group Leader Name")
                    {
                        Editable = false;
                    }
                    field("Group Leader Email"; Rec."Group Leader Email")
                    {
                        Editable = false;
                    }
                    field("Group Leader Phone No"; Rec."Group Leader Phone No")
                    {
                        Editable = false;
                    }
                    field("Assistant group Leader"; Rec."Assistant group Leader")
                    {
                    }
                    field("Assistant Group Name"; Rec."Assistant Group Name")
                    {
                        Editable = false;
                    }
                    field("Assistant Group Leader Email"; Rec."Assistant Group Leader Email")
                    {
                        Editable = false;
                    }
                    field("Assistant Group Leader Phone N"; Rec."Assistant Group Leader Phone N")
                    {
                        Editable = false;
                    }
                }
                field("Credit Officer"; Rec."Credit Officer")
                {
                }
                field("Field Officer"; Rec."Field Officer")
                {
                }
                field("Meeting Place"; Rec."Meeting Place")
                {
                }
                field("No of Members"; Rec."No of Members")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                }
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

                trigger OnAction()
                begin
                    if Rec."Created On" <> 0D then
                        Error('Group Already Created');

                    if Confirm('Are you sure you want to Create this House Group?', false) = true then begin
                        if ObjSaccoNos.Get then begin
                            ObjSaccoNos.TestField(ObjSaccoNos."House Group Nos");
                            VarHouseNo := NoSeriesMgt.GetNextNo(ObjSaccoNos."House Group Nos", 0D, true);

                            ObjHouseG.Init;
                            ObjHouseG."Cell Group Code" := VarHouseNo;
                            ObjHouseG."Cell Group Name" := Rec."House Group Name";
                            ObjHouseG."Group Leader" := Rec."Group Leader";
                            ObjHouseG."Group Leader Name" := Rec."Group Leader Name";
                            ObjHouseG."Group Leader Email" := Rec."Group Leader Email";
                            ObjHouseG."Group Leader Phone No" := Rec."Group Leader Phone No";
                            ObjHouseG."Assistant group Leader" := Rec."Assistant group Leader";
                            ObjHouseG."Assistant Group Name" := Rec."Assistant Group Name";
                            ObjHouseG."Assistant Group Leader Email" := Rec."Assistant Group Leader Email";
                            ObjHouseG."Assistant Group Leader Phone N" := Rec."Assistant Group Leader Phone N";
                            ObjHouseG."Meeting Place" := Rec."Meeting Place";
                            ObjHouseG.Insert;

                        end;
                    end;

                    Rec."Created By" := UserId;
                    Rec."Created On" := WorkDate;
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

                begin

                    if WorkflowIntegration.CheckHouseRegistrationApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendHouseRegistrationForApproval(Rec);
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

                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        WorkflowIntegration.OnCancelHouseRegistrationApprovalRequest(Rec);

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
                //ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::HouseRegistration;
                    //ApprovalEntries.Setfilters(Database::"House Groups Registration", DocumentType, Rec."House Group Code");
                    //ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableCreateHouse := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateHouse := true;
    end;

    trigger OnOpenPage()
    begin
        EnableCreateHouse := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
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
        WorkflowIntegration: Codeunit WorkflowIntegration;
}






