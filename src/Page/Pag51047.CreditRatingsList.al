page 51047 "Credit Ratings List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Credit Rating";
    DeleteAllowed = false;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Loan No.";Rec."Loan No.")
                {
                    Editable = false;
                }
                field("Document Date";Rec."Document Date")
                {
                    Editable = false;
                }
                field("Loan Amount";Rec."Loan Amount")
                {
                    Editable = false;
                }
                field("Loan Limit";Rec."Loan Limit")
                {
                    // Editable = creditRatingEditor;
                    Editable = false;
                }
                field("New Limit";Rec."New Limit")
                {
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Account No";Rec."Account No")
                {
                    Editable = false;
                }
                field("Member No";Rec."Member No")
                {
                    Editable = false;
                }
                field("Customer Name";Rec."Customer Name")
                {
                    Editable = false;
                }
                field("Staff No.";Rec."Staff No.")
                {
                    Editable = false;
                }
                field("Telephone No";Rec."Telephone No")
                {
                    Editable = false;
                }
                field("Date Entered";Rec."Date Entered")
                {
                    Editable = false;
                }
                field("Time Entered";Rec."Time Entered")
                {
                    Editable = false;
                }
                field("Entered By";Rec."Entered By")
                {
                    Editable = false;
                }
                field(Comments;Rec.Comments)
                {
                    Editable = false;
                }
                field("Entry No";Rec."Entry No")
                {
                    Editable = false;
                }
                field("Next Loan Application Date";Rec."Next Loan Application Date")
                {
                    Editable = false;
                }
                field(Penalized;Rec.Penalized)
                {
                    Editable = false;
                }
                field("Penalty Date";Rec."Penalty Date")
                {
                    Editable = false;
                }
                field("Last Notification";Rec."Last Notification")
                {
                    Editable = false;
                }
                field("Next Notification";Rec."Next Notification")
                {
                    Editable = false;
                }
                field("New Rate";Rec."New Rate")
                {
                    Editable = false;
                }
                field("Amount Recovered From BOSA";Rec."Amount Recovered From BOSA")
                {
                    Editable = false;
                }
                field("Amount  Recovered From FOSA";Rec."Amount  Recovered From FOSA")
                {
                    Editable = false;
                }
                field("Test Amount";Rec."Test Amount")
                {
                    Editable = false;
                }
                field("Deposits Recovered";Rec."Deposits Recovered")
                {
                    Editable = false;
                }
                field("Deposit Balance Cleared";Rec."Deposit Balance Cleared")
                {
                    Editable = false;
                }
                field("FOSA Balance";Rec."FOSA Balance")
                {
                    Editable = false;
                }
                field("Deposits Refunded";Rec."Deposits Refunded")
                {
                    Editable = false;
                }
                field("Dep. Refund. Updated By";Rec."Dep. Refund. Updated By")
                {
                    Editable = false;
                }
                field(Reversed;Rec.Reversed)
                {
                    Editable = false;
                }
                field(Installments;Rec.Installments)
                {
                    Editable = false;
                }
                field("End Date";Rec."End Date")
                {
                    Editable = false;
                }
                field(AmountRecoveredFromShares;Rec.AmountRecoveredFromShares)
                {
                    Editable = false;
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            
            action(SendApproval)
            {
                Caption = 'Send For Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                
                trigger OnAction()
                begin
                    Rec.TestField("New Limit");

                    workflowInt.CheckLoanLimitApprovalsWorkflowEnabled(Rec);
                    workflowInt.OnSendLoanLimitDocForApproval(Rec);
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                
                trigger OnAction()
                begin
                    workflowInt.CheckLoanLimitApprovalsWorkflowEnabled(Rec);
                    workflowInt.OnCancelLoanLimitApprovalRequest(Rec);
                end;
            }
            action(ApprovalEntries)
            {
                Caption = 'Approval Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                
                trigger OnAction()
                begin
                    approvalEntries.SetRecordFilters(Database::"Savings Variation", approvalDoc::CreditRating, Rec."Loan No.");
                    approvalEntries.Run();
                end;
            }
        }
    }

    
    var
        creditRatingEditor: Boolean;
        approvalDoc: Enum "Approval Document Type";
        approvalEntries: Page "Approval Entries";
        workflowInt: Codeunit WorkflowIntegration;
        user: Record "User Setup";
        register: Page "G/L Registers";

    trigger
    OnOpenPage()
    begin
        creditRatingEditor := false;
        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if user."Change Defaulter Status" = true
            then begin
                creditRatingEditor := true;
            end;
        end;
    end;
}


