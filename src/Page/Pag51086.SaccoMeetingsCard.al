page 51086 "Sacco Meetings Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Payment,Approvals,Attachments';
    SourceTable = "Sacco Meetings";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Meeting No";Rec."Meeting No")
                {
                    Editable = false;
                }
                field("Meeting Type";Rec."Meeting Type")
                {
                    Editable = not (complete);
                }
                field("Committee No";Rec."Committee No")
                {
                    Editable = rec."Meeting Type" = rec."Meeting Type"::"Board Meeting";
                }
                field("Committee Name";Rec."Committee Name")
                {
                    Editable = false;
                }
                field("Meeting Description";Rec."Meeting Description")
                {
                    Editable = not (complete);
                }
                field("Meeting Date";Rec."Meeting Date")
                {
                    // Editable = not (complete);
                }
                field("Allowance Expected";Rec."Allowance Expected")
                {
                    Editable = not (complete);
                    // Enabled = (Rec.Uploaded);
                }
                field(Month;Rec.Month)
                {
                    Editable = false;
                    Style = StrongAccent;
                    // Enabled = (Rec.Uploaded);
                }
                field(Posted;Rec.Posted)
                {
                    // Editable = false;
                    Style = StrongAccent;
                    // Enabled = (Rec.Uploaded);
                }
                
                // field("Total Allowance";Rec."Total Allowance")
                // {
                //     Editable = rec."Allowance Expected";
                //     Enabled = (Rec.Uploaded);
                // }
                // field("Total Actual Allowance";Rec."Total Actual Allowance")
                // {
                //     Editable = false;
                //     Enabled = (Rec.Uploaded);
                // }

            }
            part(attendees; "Sacco Meetings Lines")
            {
                Caption = 'Meeting Attendees';
                SubPageLink = "Doc No." = field("Meeting No");
                // Editable = not (complete);
            }
        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Sacco Meetings"), "No." = field("Meeting No");
                Enabled = not (complete);
            }
        }
    }
    
    actions
    {
        area(Reporting)
        {
            action(Attachment)
            {
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
        area(Navigation)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::New);
                Visible = (Rec.Uploaded);
                trigger OnAction()
                var
                begin
                    Rec.CalcFields("Total Actual Allowance");
                    if Rec."Total Actual Allowance" = 0 then Error('The meeting members should have an allowance.');

                    
                    docFactbox.Reset();
                    docFactbox.SetRange("Table ID", Database::"Sacco Meetings");
                    docFactbox.SetRange("No.", Rec."Meeting No");
                    if docFactbox.FindSet() then begin
                        noOfRecords:= docFactbox.Count;
                    end;
                    if noOfRecords <= 0 then Error('Ensure that a document is attached to this meeting.');

                    workflowInt.CheckMemberAllowanceWorkflowEnabled(Rec);
                    workflowInt.OnSendMemberAllowanceForApproval(Rec);
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::"Pending Approval");
                Visible = (Rec.Uploaded);

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    workflowInt.CheckMemberAllowanceWorkflowEnabled(Rec);
                    workflowInt.OnCancelMemberAllowanceRequest(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approval Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::"Pending Approval");
                Visible = (Rec.Uploaded);

                trigger OnAction()
                var
                begin
                    approvalEntries.SetRecordFilters(Database::"Sacco Meetings", approvalDoc::MemberAllowance, Rec."Meeting No");
                    approvalEntries.RunModal;
                end;
            }
        }
        area(Processing)
        {
            action(Upload)
            {
                Ellipsis = True;
                Caption = 'Upload Meeting';
                Image = PostDocument;
                ToolTip = 'Upload meeting details.';
                Promoted = true;
                PromotedCategory = Process;
                Enabled = not(Rec.Uploaded);

                trigger OnAction() begin
                    if Rec.Month = '' then begin
                        Error('Kindly ensure that the date of the meeting has been placed accurately and the month of the meeting has been populated.');
                    end;

                    Rec.CalcFields("Total Actual Allowance");
                    if Rec."Total Actual Allowance" <> Rec."Total Allowance" then Error('Ensure that the allocated allowances for each attendee sums up to the total allowances inputted in the header.');
                    
                    docFactbox.Reset();
                    docFactbox.SetRange("Table ID", Database::"Sacco Meetings");
                    docFactbox.SetRange("No.", Rec."Meeting No");
                    if docFactbox.FindSet() then begin
                        noOfRecords:= docFactbox.Count;
                    end;
                    if noOfRecords <= 0 then Error('Ensure that a document is attached to this meeting.');

                    if Confirm('Do you wish to upload this meeting?', true) = false then exit;
                    rec.Uploaded:= true;
                    rec."Uploaded By":= UserId;
                    rec."Uploaded On":= Today;
                    rec.modify;
                end;
            }

            action(PaymentSlip)
            {
                Caption = 'Payment Slip';
                Image = DepositSlip;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                // Enabled = ((Rec."Meeting Type" = Rec."Meeting Type"::"Board Meeting") or (Rec."Meeting Type" = Rec."Meeting Type"::Delegates));
                Enabled = (canProcessAllow);
                Visible = (Rec.Uploaded = true);

                trigger OnAction()
                var
                begin
                    if Rec.Month = '' then begin
                        Error('Kindly ensure that the date of the meeting has been placed accurately and the month of the meeting has been populated.');
                    end;
                    
                    meetings.Reset();
                    meetings.SetRange("Meeting No", Rec."Meeting No");
                    if meetings.Find('-') then begin
                        Report.Run(Report::"Board Payment Slip", true, false, meetings);
                    end;
                end;
            }
            
            action(Payment)
            {
                Caption = 'Process Payment';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                // Enabled = ((Rec."Meeting Type" = Rec."Meeting Type"::"Board Meeting") or (Rec."Meeting Type" = Rec."Meeting Type"::Delegates));
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::Approved) and (canProcessAllow);
                Visible = (Rec.Uploaded = true);

                trigger OnAction()
                var
                begin
                    if Rec.Month = '' then begin
                        Error('Kindly ensure that the date of the meeting has been placed accurately and the month of the meeting has been populated.');
                    end;
                    
                    if Rec.Posted = true then Message('This allowance payment has already been posted');
                    
                    if Confirm('Do you wish to proceed with the payment of these members'' allowances?', true) = false then exit;
                    if Rec."Meeting Type" = Rec."Meeting Type"::"Board Meeting" then begin
                        if processAllowances.FnProcessBoardMemberAllowances(Rec."Meeting No") then begin
                            Rec.Posted := true;
                            // Rec.Test := true;
                            Rec."Posted By" := UserId;
                            Rec."Posted On" := Today;
                            Rec.Modify;
                            Message('Journal lines processed and populated successfully.');
                            Message('Proceed to mark this payment as posted to notify the members.');
                        end else Message('Failed to populate journal lines');
                    end else if Rec."Meeting Type" = Rec."Meeting Type"::Delegates then begin
                        if processAllowances.FnProcessDelegateMemberAllowances(Rec."Meeting No") then begin
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec."Posted On" := Today;
                            Rec.Modify;
                            Message('Journal lines processed and populated successfully.');
                            Message('Proceed to mark this payment as posted to notify the members.');
                        end else Message('Failed to populate journal lines');
                    end;
                end;
            }
            action(Post)
            {
                Caption = 'Mark as Posted';
                Image = CarryOutActionMessage;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                // Enabled = ((Rec."Meeting Type" = Rec."Meeting Type"::"Board Meeting") or (Rec."Meeting Type" = Rec."Meeting Type"::Delegates));
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::Approved) and (canProcessAllow);
                Visible = (Rec.Uploaded = true) and (Rec.Posted);

                trigger OnAction()
                var
                begin
                    if Rec.Completed = true then Error('This allowance payment has already been marked as completed and members notified via SMS.');
                    
                    if Confirm('Do you wish to nofity these members'' of their allowances.', true) = false then exit;
                    
                    meetingMembers.Reset();
                    meetingMembers.SetRange("Doc No.", Rec."Meeting No");
                    meetingMembers.SetRange("Member Present", true);
                    meetingMembers.SetRange(Dormant, false);
                    meetingMembers.SetRange(Defaulter, false);
                    meetingMembers.SetRange("Already Paid", false);
                    meetingMembers.SetFilter(Allowance, '>%1', 0);
                    if meetingMembers.FindSet() then begin
                        repeat
                        if cust.Get(meetingMembers."Member No") then begin
                            allowMessage := 'Dear '+namesStyle.NameStyle(cust."No.")+', your '+Rec.Month+', '+Rec."Meeting Description"+' allowance has been posted to your FOSA A/C.';
                            smsManagement.SendSmsWithID(Source::MEMBER_ALLOWANCES, cust."Mobile Phone No", allowMessage, cust."FOSA Account No.", cust."FOSA Account No.", true, 245, true, 'CBS', CreateGUID(), 'CBS');
                        end;
                        until meetingMembers.Next() = 0;
                    end;

                    Rec.Completed := true;
                    Rec.Modify;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord() begin
        canProcessAllow := false;
        complete := false;
        users.Reset();
        users.SetRange("User ID", UserId);
        if users.Find('-') then begin
            if users."Can Process Allowances" = true then begin
                canProcessAllow := true;
            end;
            //   else Error('The user %1 cannot process member allowances.', UserId);
        end;

        if Rec."Approval Status" <> Rec."Approval Status"::New then begin
            complete := true;
        end;
    end;
    var

    noOfRecords: Integer;
    canProcessAllow: Boolean;
    complete: Boolean;
    allowMessage: Text[2048];
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY,MEMBER_ALLOWANCES;
    approvalDoc: Enum "Approval Document Type";
    approvalEntries: Page "Approval Entries";
    processAllowances: Codeunit "Process Allowances";
    smsManagement: Codeunit "Sms Management";
    namesStyle: Codeunit "SMS Reminders";
    workflowInt: Codeunit WorkflowIntegration;
    docFactbox: Record "Document Attachment";
    cust: Record Customer;
    allowance: Record "Meeting Allowances";
    meetings: Record "Sacco Meetings";
    meetingMembers: Record "Meeting Lines";
    users: Record "User Setup";

}


