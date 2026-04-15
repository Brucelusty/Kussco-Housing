//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50894 "File Movement Header"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "File Movement Header";
    PromotedActionCategories = 'New,Reports,Process,Requisition,Receive';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                }
                field("Issuing File Location";Rec."Issuing File Location")
                {
                }
                field("Date Requested";Rec."Date Requested")
                {
                }
                field("Duration Requested";Rec."Duration Requested")
                {
                }
                field("Expected Return Date";Rec."Expected Return Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Requested By";Rec."Requested By")
                {
                }
                field("Responsiblity Center";Rec."Responsiblity Center")
                {
                    Caption = 'Department';
                    ShowMandatory = true;
                }
                field("File Movement Status";Rec."File Movement Status")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                    Editable = false;
                }
                field("Reason For Rejection";Rec."Reason For Rejection")
                {
                    MultiLine = true;
                }
            }
            part("File Movement Lines";"File Movement Line")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval Request")
            {
                Caption = 'Request File(s)';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    files.Reset();
                    files.SetRange("Document No.", Rec."No.");
                    if files.FindSet() then begin
                        repeat
                        files.TestField("Account No.");
                        files.TestField("Purpose/Description");
                        until files.Next() = 0;
                    end else Error('Ensure you have selected the file(s) you wish to request');
                    
                    if workflowInt.CheckFileMovementApprovalsWorkflowEnabled(Rec) then workflowInt.OnSendFileMovementForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel File(s) Request';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    if workflowInt.CheckFileMovementApprovalsWorkflowEnabled(Rec) then workflowInt.OnCancelFileMovementApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    ApprovalEntries.SetRecordFilters(Database::"File Movement Header", approvalDoc::FileMovement, Rec."No.");
                    ApprovalEntries.Run;
                end;
            }
            action(Receive)
            {
                Caption = 'Receive File(s)';
                Image = ReceivableBill;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = canReceive;
                trigger OnAction()
                begin
                    files.Reset();
                    files.SetRange("Document No.", Rec."No.");
                    // files.SetRange("File Return Status", files."File Return Status"::Issued);
                    files.SetRange("Issued To", UserId);
                    if files.FindSet() then begin
                        repeat
                        files."File Return Status" := files."File Return Status"::Issued;
                        files."File Received" := true;
                        files."File Received On" := CurrentDateTime;
                        files.Modify;
                        until files.Next() = 0;
                        Message('You have successfully received all your issued files.');
                    end else Error('Ensure there are file(s) to receive');
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord() begin
        canReceive := false;

        if Rec.Status = Rec.Status::Approved then canReceive := true;
    end;

    trigger OnInit()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable := false;
    end;

    var
    canReceive: Boolean;
    approvalDoc: Enum "Approval Document Type";
    ApprovalEntries: Page "Approval Entries";
    workflowInt: Codeunit WorkflowIntegration;
    files: Record "File Movement Line";
    
}






