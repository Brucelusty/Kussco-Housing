//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51055 "File Return Header"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "File Movement Header";
    PromotedActionCategories = 'New,Reports,Process,Return';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                }
                field("File Location";Rec."File Location")
                {
                    Caption = 'Destination File Location';
                }
                field(Status; Rec.Status)
                {
                }
                field("Returned By";Rec."Returned By")
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
            part("File Return Lines";"File Return Line")
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
                Caption = 'Return File(s)';
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
                    end else Error('Ensure you have selected the file(s) you wish to return');
                    
                    if workflowInt.CheckFileMovementApprovalsWorkflowEnabled(Rec) then workflowInt.OnSendFileMovementForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel File(s) Return';
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
        }
    }

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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."File Return" := true;
    end;

    var
    approvalDoc: Enum "Approval Document Type";
    ApprovalEntries: Page "Approval Entries";
    workflowInt: Codeunit WorkflowIntegration;
    files: Record "File Movement Line";
}






