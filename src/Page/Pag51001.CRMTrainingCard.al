//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51001 "CRM Training Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "CRM Trainings";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Duration Units"; Rec."Duration Units")
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Re-Assessment Date"; Rec."Re-Assessment Date")
                {
                }
                field("Need Source"; Rec."Need Source")
                {
                }
                field(Provider; Rec.Provider)
                {
                }
                field("Provider Name"; Rec."Provider Name")
                {
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                }
                field("Training Scope"; Rec."Training Scope")
                {
                    MultiLine = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Approval Status';
                    Editable = false;
                    Importance = Additional;
                }
                field("Training Status"; Rec."Training Status")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Total Attendees"; Rec."Total Attendees")
                {
                    Editable = false;
                }
            }
            part(Control19; "CRM Trainees")
            {
                SubPageLink = "Training Code" = field(Code);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ImportTrainees)
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = XMLport "Import BD Trainees";
            }
            action("Close Training")
            {
                Enabled = EnableActivateTraining;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this training?', false) = true then begin
                        Rec."Training Status" := Rec."training status"::Closed;
                        Rec.Closed := true;
                        Rec.Modify;
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
          
                begin

                    if WorkflowIntegration.CheckCRMTrainingApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendCRMTrainingForApproval(Rec);
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
                        WorkflowIntegration.OnCancelCRMTrainingApprovalRequest(Rec);

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
                  //  ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining;
                begin
                    DocumentType := Documenttype::CRMTraining;
                    //ApprovalEntries.Setfilters(Database::"CRM Trainings", DocumentType, Code);
                    //ApprovalEntries.Run;
                end;
            }
            action("Training Cost/Suppliers")
            {
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "CRM Training Suppliers";
                RunPageLink = "CRM Training No" = field(Code);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableActivateTraining := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableActivateTraining := true;
    end;

    trigger OnOpenPage()
    begin
        EnableActivateTraining := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableActivateTraining := true;
    end;

    var
        EnableActivateTraining: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
  
        EnabledApprovalWorkflowsExist: Boolean;
        WorkflowIntegration: Codeunit WorkflowIntegration;
}






