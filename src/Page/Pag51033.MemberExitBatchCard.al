//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings

Page 51033 "Member Exit Batch Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Member Exit Batch";
    SourceTableView = where(Posted = filter(false), "Mode Of Disbursement"= const("FOSA Account"));;

    layout
    {
        area(content)
        {
            field("Exit Batch No."; Rec."Exit Batch No.")
            {
                Editable = false;
            }
            field(Source; Rec.Source)
            {
            }
            field("Description/Remarks"; Rec."Description/Remarks")
            {
                Caption = 'Transaction Description';
            }
            field(Status; Rec.Status)
            {
                Editable = false;
                Caption = 'Approval Status';
            }
            field("Total to Disburse";Rec."Total to Disburse")
            {
                Editable = false;
            }
            field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
            {
                // Editable = SourceEditable;
                Visible = true;


                trigger OnValidate()
                begin
                    /*IF "Mode Of Disbursement"="Mode Of Disbursement"::EFT THEN
                    "Cheque No.":="Batch No.";
                    MODIFY;  */
                    if Rec."Mode Of Disbursement" <> Rec."mode of disbursement"::"FOSA Account" then
                        Rec."Document No." := Rec."Exit Batch No.";
                    rec.Modify;

                end;
            }
            field("Document No."; Rec."Document No.")
            {
                // Editable = DocumentNoEditable;
                Editable = SourceEditable;
                trigger OnValidate()
                begin
                    /*IF STRLEN("Document No.") > 6 THEN
                      ERROR('Document No. cannot contain More than 6 Characters.');
                      */

                end;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                // Editable = SourceEditable;
            }
          
            part(ExitSubForm; "Exit Sub-Page List")
            {
                SubPageLink = "Exit Batch No." = field("Exit Batch No."),
                              "System Created" = const(false);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Send Approval Request")
            {
                Caption = 'Send A&pproval Request';
                // Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = New;
                PromotedOnly = true;
                Enabled = canSendApproval;
                // Visible = false;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalsMgmt: Codeunit WorkflowIntegration;
                begin
                    //TESTFIELD("FOSA Account No.");
                    //IF Status<>Status::Open THEN
                    //ERROR(text001);

                    if ApprovalsMgmt.CheckMemberExitBatchApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendMemberExitBatchForApproval(Rec);

                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel A&pproval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = New;
                PromotedOnly = true;
                Enabled = CanCancelApprovalForRecord;
                // Visible = false;
                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit WorkflowIntegration;
                begin
                    if ApprovalMgt.CheckMemberExitBatchApprovalsWorkflowEnabled(Rec) then
                        ApprovalMgt.OnCancelMemberExitBatchApprovalRequest(Rec);
                end;
            }
        }
        area(Processing)
        {
            action("Post Withdrawal")
            {
                Promoted = true;
                Image = PostBatch;
                PromotedCategory = Process;
                Caption = 'Withdrawal Fee';
                Enabled = (rec.Status = rec.Status::Approved);

                trigger OnAction()
                var
                    ExitBatch: Record "Membership Exist";
                    exitRecov: Codeunit "Exit Recovery";
                begin
                    rec.CalcFields("Total Remainder");
                    if rec."Total Remainder" = 0 then begin
                        rec."Fully Paid" := true;
                        rec.modify;
                    end else begin
                        rec."Fully Paid" := false;
                        Rec.modify;
                    end;
                    if rec."Total Remainder" = 0 then begin
                        Error('This batch is already fully repaid.');
                    end;
                    ExitBatch.Reset();
                    ExitBatch.SetRange("Exit Batch No.", rec."Exit Batch No.");
                    ExitBatch.SetRange("Fully Paid", false);
                    if ExitBatch.Find('-') then begin
                        repeat
                            // if ExitBatch."Loans Cleared" = true then begin
                            //     Error('The withdrawal fee has already been paid.');
                            // end else begin
                                if ExitBatch."Closure Type" <> ExitBatch."Closure Type"::Death then begin
                                    exitRecov.PayWithdrawalFee(ExitBatch."Member No.");
                                end;
                            // end;
                        until ExitBatch.Next() = 0;
                    end;
                end;
            }
            action("WithdrawalSMS")
            {
                Promoted = true;
                Image = PostBatch;
                PromotedCategory = Process;
                Caption = 'Withdrawal SMS';
                Enabled = (rec.Status = rec.Status::Approved);
                // Visible = false;

                trigger OnAction()
                var
                    ExitBatch: Record "Membership Exist";
                    exitRecov: Codeunit "Exit Recovery";
                begin
                    ExitBatch.Reset();
                    ExitBatch.SetRange("Exit Batch No.", rec."Exit Batch No.");
                    ExitBatch.SetRange("Fully Paid", false);
                    ExitBatch.SetRange(Posted, false);
                    if ExitBatch.Find('-') then begin
                        repeat
                            if Cust.Get(ExitBatch."Member No.") then begin
                                exitRefund:= 'Dear ' +cust.Name+ '. Your exit deposit refund of Kshs.'+Format(ExitBatch."Amount To Disburse")+' has been posted to your FOSA A/C.';
                                smsManagement.SendSmsWithID(Source::MEMBER_EXIT, cust."Mobile Phone No", exitRefund, cust."No.", cust."FOSA Account No.", TRUE, 230, TRUE, 'CBS', CreateGuid(), 'CBS');
                                Cust.Modify();
                            end;
                        until ExitBatch.Next() = 0;
                    end;
                end;
            }
            action("Post Exit Batch")
            {
                Promoted = true;
                Image = PostBatch;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Post Batch';
                Visible = (rec.Status = rec.Status::Approved);
                Enabled = not rec.Posted;

                trigger OnAction()
                var
                    ExitBatch: Record "Membership Exist";
                    exitRecov: Codeunit "Exit Recovery";
                begin
                    rec.CalcFields("Total Remainder");
                    rec.Validate("Total Remainder");
                    if rec."Total Remainder" = 0 then begin
                        Error('This batch is already fully repaid.');
                    end;
                    ExitBatch.Reset();
                    ExitBatch.SetRange("Exit Batch No.", rec."Exit Batch No.");
                    ExitBatch.SetRange("Fully Paid", false);
                    if ExitBatch.Find('-') then begin
                        repeat
                            if ExitBatch."Closure Type" = ExitBatch."Closure Type"::Death then begin
                                ExitBatch."Deposits Paid":= exitRecov.PostDeathDepositstoFOSA(ExitBatch."Member No.", ExitBatch."Has BBF");
                                ExitBatch."Refunded On" := Today;
                                ExitBatch.Modify();
                            end else begin
                                ExitBatch.Remainder:= exitRecov.FullRePayRefunds(ExitBatch."Member No.", ExitBatch."Amount To Disburse");
                                ExitBatch.Validate(Remainder);
                                ExitBatch."Refunded On" := Today;
                                ExitBatch.Modify();
                            end;
                            
                        until ExitBatch.Next() = 0;
                    end;
                end;
            }
        }
        area(Reporting)
        {
            action("Exit Batch")
            {
                Promoted = true;
                Image = ExecuteBatch;
                PromotedCategory = Report;
                Caption = 'Exit Batch Slip';
                
                trigger OnAction()
                var
                    ExitBatch: Record "Membership Exist";
                begin
                    // Rec.TestField(Posted);
                    ExitBatch.Reset();
                    ExitBatch.SetRange(ExitBatch."Exit Batch No.",rec."Exit Batch No.");
                    if ExitBatch.Find('-') then
                        Report.run(173065,true,true,ExitBatch);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord() begin
        SetControlAppearance();
    end;
    trigger OnAfterGetRecord() begin
        SetControlAppearance();
    end;

    var
    SourceEditable: Boolean;
    DescriptionEditable: Boolean;
    OpenApprovalEntriesExist: Boolean;
    EnabledApprovalWorkflowsExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    OpenApprovalEntriesExistForCurrUser: Boolean;
    canSendApproval: Boolean;
    canCreate: Boolean;
    exitRefund: Text[1500];
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT;
    smsManagement: Codeunit "Sms Management";
    cust: Record Customer;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if rec."Status" = rec."Status"::Open then begin
            canSendApproval := True;
            canCreate := false;
        end
        else if Rec."Status" = Rec."Status"::Approved then begin
            canSendApproval := false;
            canCreate := true;
        end
        else begin
            canSendApproval := false;
            canCreate := false
        end;
    end;
}


