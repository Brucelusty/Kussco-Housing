//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50030 "Approved MOBILE Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "MOBILE Applications";
    Caption = 'Mobile Banking Application Card';
    Editable = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Date Applied"; Rec."Date Applied")
                {
                }
                field("Time Applied"; Rec."Time Applied")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Approvals")
            {
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = false;
                    //      PromotedCategory=
                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status = Rec.Status::Approved then
                            Error('The record is already approved.');
                        if Rec.Status = Rec.Status::"Pending Approval" then
                            Error('The record is already Pending Approval.');
                        Codeunit.RUN(CODEUNIT::"Custom Workflow Events");

                        if WorkflowManagement.CheckMobileApplicationApprovalsWorkflowEnabled(Rec) then
                            WorkflowManagement.OnSendMobileApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status = Rec.Status::Application then
                            Error('The record is already open.');
                        Rec.Status := Rec.Status::Application;
                        Rec.Modify;

                    end;
                }

                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MobileApplication;
                        ApprovalEntries.SetRecordFilters(Database::"MOBILE Applications", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }
    var
        WorkflowManagement: Codeunit WorkflowIntegration;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,MobileApplication;
}






