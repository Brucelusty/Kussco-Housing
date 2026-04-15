page 51039 "ATM Pin Replacement Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "ATM Card Applications";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("No.";Rec."No.")
                {
                    Editable = false;
                }
                field("Request Type";Rec."Request Type")
                {
                    Editable = canSendApproval;
                }
                field("Reason for Reissue";Rec."Reason for Reissue")
                {
                    Editable = canSendApproval;
                }
                field("Account No";Rec."Account No")
                {
                    Editable = canSendApproval;
                }
                field("Account Type";Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    Editable = false;
                }
                field("ID No";Rec."ID No")
                {
                    Editable = false;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    Editable = false;
                }
                field("ATM Card No";Rec."Previous Card No")
                {
                    Caption = 'ATM Card No.';
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    Editable = false;
                }
                field(Status;Rec.Status)
                {
                    Editable = false;
                }
                field("Terms Read and Understood";Rec."Terms Read and Understood")
                {
                    Editable = canSendApproval;
                }
                field("Captured By";Rec."Captured By")
                {
                    Editable = false;
                }
            }
            group("Issue Details")
            {
                Visible = canIssue;

                field("Issued to"; Rec."Issued to")
                {
                    Editable = cannotIssue;
                }
                field("Card Issued to Customer"; Rec."Card Issued to Customer")
                {
                    Caption = 'Pin Issued';
                    Editable = cannotIssue;
                }

                field("Issued to Phone Number"; Rec."Issued to Phone Number")
                {
                    Editable = cannotIssue;
                }
                field("Issued To ID No"; Rec."Issued To ID No")
                {
                    Editable = cannotIssue;
                }
                field("Mode Of Dispatch"; Rec."Mode Of Dispatch")
                {
                    Editable = cannotIssue;
                }
                field(Location; Rec.Location)
                {
                    Editable = cannotIssue;
                }
                field(Address; Rec.Address)
                {
                    Editable = cannotIssue;
                }
                field("Tracking Code"; Rec."Tracking Code")
                {
                    Editable = cannotIssue;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            group(Processes)
            {
                action("Receive Replacement")
                {
                    Caption = 'Receive Pin Replacement';
                    Enabled = not canIssue;
                    Image = GetOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = canCreate;

                    trigger OnAction()
                    begin
                        if Rec."Pin Received" = true then begin
                            Error('The pin replacement has already been received.');
                        end;
                        if Confirm('Do you wish to proceed with receiving this ATM Pin Replacement?', true) = false then exit
                        else begin
                            rec."Pin Received":= true;
                            rec."Pin Received On":= Today;
                            rec."Pin Received By":= UserId;
                            canIssue:= true;
                            cannotIssue:= true;
                            Message('The ATM Pin replacement has been received. The member will be notified.');

                            Vend.Get(Rec."Account No");
                            if Vend.Get(Rec."Account No") then begin
                                SmsCodeunit.SendSmsWithID(Source::ATM_COLLECTION, Vend."Mobile Phone No",'Dear '+vend.name+', Your ATM pin replacement is ready for collection. Visit the Sacco head office or share your postal address for issuing.',Vend."No.", Vend."No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                            end;
                        end;
                    end;
                }
                action("Issue Replacement")
                {
                    Caption = 'Issue Pin Replacement';
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = cannotIssue;

                    trigger OnAction()
                    begin
                        if Rec."Pin Replacement Issued"=true then begin
                            Error('Pin already issued.');
                        end;
                        
                        if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Card Sent" then begin
                            if (rec."Issued to" = '') or (rec."Issued to Phone Number" = '') or (rec."Issued To ID No" = '') or (rec."Issued to" = '') or (rec.Location = '') or (rec.Address = '') or (rec."Tracking Code" = '') then begin
                                Error('The details of where the card is to be issued must be clearly stated before issuing it.');
                            end;
                        end else if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Card Issued to" then begin
                            if (rec."Issued to" = '') or (rec."Issued to Phone Number" = '') or (rec."Issued To ID No" = '') or (rec."Issued to" = '') or (rec.Location = '') then begin
                                Error('The details of where the card is to be issued must be clearly stated before issuing it.');
                            end;
                        end else if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Owner Collected" then begin
                            if (rec."Issued to" = '') or (rec."Issued to Phone Number" = '') or (rec."Issued To ID No" = '') or (rec."Issued to" = '') then begin
                                Error('The details of where the card is to be issued must be clearly stated before issuing it.');
                            end;
                        end;

                        if Confirm('Do you wish to proceed with issuing this ATM Pin Replacement?', true) = false then exit
                        else begin
                            rec."Pin Replacement Issued":= true;
                            rec."Pin Replacement Issued On":= Today;
                            rec."Pin Replacement Issued By":= UserId;
                            rec.Posted := true;
                            cannotIssue := false;
                            Message('The ATM Pin replacement has been issued. The member will be notified.');

                            Vend.Get(Rec."Account No");
                            if Vend.Get(Rec."Account No") then begin
                                if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Card Sent" then begin
                                    SmsCodeunit.SendSmsWithID(Source::ATM_COLLECTION, Vend."Mobile Phone No",'Dear '+vend."first name"+', Your ATM pin replacement has been issued via parcel '+rec."Tracking Code"+' to your postal address '+rec.Address+', '+Rec.Location+'.',Vend."No.", Vend."No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                end else if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Card Issued to" then begin
                                    SmsCodeunit.SendSmsWithID(Source::ATM_COLLECTION, Vend."Mobile Phone No",'Dear '+vend."first name"+', Your ATM pin replacement has been issued to '+rec."Issued to"+' ID No. '+rec."Issued To ID No"+'.',Vend."No.", Vend."No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                end else if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Owner Collected" then begin
                                    SmsCodeunit.SendSmsWithID(Source::ATM_COLLECTION, Vend."Mobile Phone No",'Dear '+vend."first name"+', You have collected your ATM pin replacement.',Vend."No.", Vend."No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                end;
                            end;
                        end;
                    end;
                }
            }
            // group(Approvals)
            // {
            //     action(Approval)
            //     {
            //         Caption = 'Approvals';
            //         Enabled = OpenApprovalEntriesExist;
            //         Image = Approval;
            //         Promoted = true;
            //         PromotedCategory = Category4;

            //         trigger OnAction()
            //         var
            //             ApprovalEntries: Page "Approval Entries";
            //             approvalDoc: Enum "Approval Document Type";
            //         begin
            //             ApprovalEntries.SetRecordFilters(Database::"ATM Card Applications", approvalDoc::"ATMCard", Rec."No.");
            //             ApprovalEntries.Run;
            //         end;
            //     }
            //     action("Send Approval Request")
            //     {
            //         Caption = 'Send Approval Request';
            //         //Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
            //         Enabled = canSendApproval;
            //         Image = SendApprovalRequest;
            //         Promoted = true;
            //         PromotedCategory = Category4;

            //         trigger OnAction()
            //         var
            //             Text001: label 'This request is already pending approval';
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //             WorkflowIntegration: Codeunit WorkflowIntegration;
            //         begin

            //             if Rec.Status = Rec.Status::Pending then
            //                 Error('This record is already pending approval.');

            //             if rec."Terms Read and Understood" = false then
            //             begin
            //                 Error('The member should have agreed to the terms and conditions.');
            //             end;
            //             if rec."Reason for Reissue" = '' then
            //             begin
            //                 Error('The member should state the reason for reissuing the ATM Pin.');
            //             end;
                        
            //             ObjGensetup.Get;

            //             if WorkflowIntegration.CheckATMCardApprovalsWorkflowEnabled(Rec) then
            //                 WorkflowIntegration.OnSendATMCardForApproval(Rec);

            //             Vend.Get(Rec."Account No");
            //             if Vend.Get(Rec."Account No") then begin
            //               ///  SmsCodeunit.SendSmsResponse(Vend."Mobile Phone No", 'Dear Member, your Atm card application has been received and is under processing.');
            //               SmsCodeunit.SendSmsWithID(Source::ATM_COLLECTION, Vend."Mobile Phone No",'Dear Member, your ATM Pin replacement application has been received and is under processing.',Vend."No.", Vend."No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
            //             end;
            //         end;
            //     }
            //     action("Cancel Approval Request")
            //     {
            //         Caption = 'Cancel Approval Request';
            //         Enabled = CanCancelApprovalForRecord;
            //         Image = Cancel;
            //         Promoted = true;
            //         PromotedCategory = Category4;

            //         trigger OnAction()
            //         var
            //             Approvalmgt: Codeunit "Approvals Mgmt.";
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //             WorkflowIntegration: Codeunit WorkflowIntegration;
            //         begin

            //             if WorkflowIntegration.CheckATMCardApprovalsWorkflowEnabled(Rec) then
            //                 WorkflowIntegration.OnCancelATMCardApprovalRequest(Rec);
            //         end;
            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    var
    vend: Record Vendor;
    cust: Record Customer;
    ATMCardApplication: Record "ATM Card Applications";
    ObjGensetup: Record "Sacco General Set-Up";
    SmsCodeunit: Codeunit "Sms Management";
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    EnabledApprovalWorkflowsExist: Boolean;
    EnableCreateMember: Boolean;
    OpenApprovalEntriesExistForCurrUser: Boolean;
    canSendApproval: Boolean;
    canCreate: Boolean;
    canIssue: Boolean;
    cannotIssue: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if rec.Status = rec.Status::Open then begin
            canSendApproval := True;
            canCreate := false;
        end
        else if Rec.Status = Rec.Status::Approved then begin
            canSendApproval := false;
            canCreate := true;
        end
        else begin
            canSendApproval := false;
            canCreate := false
        end;
        if rec."Pin Received" = true then begin
            canIssue := true;
            cannotIssue := true;
        end;
        if rec."Pin Replacement Issued" = true then begin
            cannotIssue := false;
        end;
    end;
    trigger OnOpenPage() begin
        if rec."Pin Received" = true then begin
            canIssue := true;
            cannotIssue := true;
        end;
        if rec."Pin Replacement Issued" = true then begin
            cannotIssue := false;
        end;
    end;
}


