//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50471 "HR Leave Carryover Request"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Leave Carry Allocation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application Code";Rec."Application Code")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Applicant Comments";Rec."Applicant Comments")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Job Tittle";Rec."Job Tittle")
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field("Employee No";Rec."Employee No")
                {
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                }
                field("Approved days";Rec."Approved days")
                {
                }
                field(Attachments; Rec.Attachments)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Outlook)
            {
            }
            systempart(Control17; Notes)
            {
            }
            systempart(Control18; MyNotes)
            {
            }
            systempart(Control19; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",Job;
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::Job;
                    ApprovalEntries.SetRecordFilters(Database::"HR Appraisal Header", DocumentType, Rec."Application Code");
                    ApprovalEntries.Run;
                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                        //ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    var
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}






