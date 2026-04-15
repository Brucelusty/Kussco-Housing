//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50838 "MOBILE Application Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "MOBILE Applications";
    Caption = 'Mobile Banking Application Card';
    PromotedActionCategories = 'New,Report,Process,Approvals';

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
                field("Member Banking";Rec."Member Banking")
                {
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    Editable = false;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Create)
            {
                Caption = 'Onboard Member';
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = enable;

                trigger OnAction() begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    
                    if cust.Get(Rec."Account No") then begin
                        if Rec."Member Banking" = Rec."Member Banking"::Mobile then begin
                            cust."Mobile Banking" := true;
                            cust.Modify;
                            Message('The member has successfully been registered for Mobile Banking.');
                        end else if Rec."Member Banking" = Rec."Member Banking"::Internet then begin
                            cust."Internet Banking" := true;
                            cust.Modify;
                            Message('The member has successfully been registered for Internet Banking.');
                        end else if Rec."Member Banking" = Rec."Member Banking"::Both then begin
                            cust."Mobile Banking" := true;
                            cust."Internet Banking" := true;
                            cust.Modify;
                            Message('The member has successfully been registered for Mobile & Internet Banking.');
                        end;
                    end;
                end;
            }
        }
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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("ID No");
                        Rec.TestField("Account No");

                        if Rec.Status = Rec.Status::Approved then
                            Error('The record is already approved.');
                        if Rec.Status = Rec.Status::"Pending Approval" then
                            Error('The record is already Pending Approval.');

                        if WorkflowManagement.CheckMobileApplicationApprovalsWorkflowEnabled(Rec) then WorkflowManagement.OnSendMobileApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status = Rec.Status::Application then Error('The record is already open.');
                        
                        if WorkflowManagement.CheckMobileApplicationApprovalsWorkflowEnabled(Rec) then WorkflowManagement.OnCancelMobileApplicationApprovalRequest(Rec);
                    end;
                }

                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalDoc: Enum "Approval Document Type";
                    begin
                        ApprovalEntries.SetRecordFilters(Database::"MOBILE Applications", approvalDoc::MobileApplication , Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }
    var
    enable: Boolean;
    WorkflowManagement: Codeunit WorkflowIntegration;
    cust: Record Customer;

    trigger OnAfterGetCurrRecord() begin
        enable := false;
        if Rec.Status = Rec.Status::Approved then enable := true;
    end;
}






