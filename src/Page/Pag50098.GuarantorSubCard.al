#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50098 "Guarantor Sub Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Guarantorship Substitution H";
    PromotedActionCategories = 'New,Report,Process,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Loanee Member No"; Rec."Loanee Member No")
                {
                    Editable = LoaneeNoEditable;
                }
                field("Loanee Name"; Rec."Loanee Name")
                {
                    Editable = false;
                }
                field("Loan Guaranteed"; Rec."Loan Guaranteed")
                {
                    Editable = LoanGuaranteedEditable;
                }
                field("Substituting Member"; Rec."Substituting Member")
                {
                    Caption = 'Member to be substituted';
                    Editable = SubMemberEditable;
                }
                field("Substituting Member Name"; Rec."Substituting Member Name")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Style = Strong;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field(Substituted; Rec.Substituted)
                {
                    Editable = false;
                }
                field("Date Substituted"; Rec."Date Substituted")
                {
                    Editable = false;
                }
                field("Substituted By"; Rec."Substituted By")
                {
                    Editable = false;
                }
            }
            part(Control1000000014; "Guarantor Sub Subform")
            {
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Substituting Member"),
                              "Loan No." = field("Loan Guaranteed");
            }
            part(Control1000000015; "Loans Guarantee Details")
            {
                SubPageLink ="Member No" = field("Substituting Member"),
                              "Outstanding Balance" = filter(> 0);
                Enabled = false;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    GuarantorshipSubstitutionL: Record "Guarantorship Substitution L";
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Error('Status must be open.');

                    Rec.TestField(Rec."Loanee Member No");
                    Rec.TestField(Rec."Loan Guaranteed");

                    GuarantorshipSubstitutionL.Reset;
                    GuarantorshipSubstitutionL.SetRange("Document No", Rec."Document No");
                    GuarantorshipSubstitutionL.FindFirst;


                    LGuarantor.Reset;
                    LGuarantor.SetRange(LGuarantor."Loan No", Rec."Loan Guaranteed");
                    LGuarantor.SetRange(LGuarantor."Member No", Rec."Substituting Member");
                    if LGuarantor.FindSet then begin
                        //Add All Replaced Amounts
                        TotalReplaced := 0;
                        GSubLine.Reset;
                        GSubLine.SetRange(GSubLine."Document No", Rec."Document No");
                        GSubLine.SetRange(GSubLine."Member No", Rec."Substituting Member");
                        if GSubLine.FindSet then begin
                            repeat
                                TotalReplaced := TotalReplaced + GSubLine."Sub Amount Guaranteed";
                            until GSubLine.Next = 0;
                        end;

                    end;

                    if WorkflowIntegration.CheckGuarantorSubstitutionApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendGuarantorSubstitutionForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel A&pproval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                // ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if Rec.Status <> Rec.Status::Pending then
                        Error(text001);

                    if WorkflowIntegration.CheckGuarantorSubstitutionApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnCancelGuarantorSubstitutionApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                ApprovalEntries: Page "Approval Entries";
                approvalDoc: Enum "Approval Document Type";
                begin
                    ApprovalEntries.SetRecordFilters(Database::"Guarantorship Substitution H", approvalDoc::GuarantorSub, rec."Document No");
                    ApprovalEntries.Run();
                end;
            }
            action("Process Substitution")
            {
                Image = Post;
                Enabled = (Rec.Status = Rec.Status::Approved);
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                oldSubGuar: Code[200];
                begin
                    oldSubGuar := '';
                    Rec.TestField(Status, Rec.Status::Approved);

                    LGuarantor.Reset;
                    LGuarantor.SetRange(LGuarantor."Loan No", Rec."Loan Guaranteed");
                    LGuarantor.SetRange(LGuarantor."Member No", Rec."Substituting Member");
                    if LGuarantor.Find('-') then begin
                        GSubLine.Reset();
                        GSubLine.SetRange("Document No", Rec."Document No");
                        GSubLine.SetRange("Member No", Rec."Substituting Member");
                        if GSubLine.FindSet() then begin
                            GSubLine.CalcSums("Sub Amount Guaranteed");
                            if GSubLine."Amount Guaranteed" > GSubLine."Sub Amount Guaranteed" then begin
                                LGuarantor."Amont Guaranteed" := (GSubLine."Amount Guaranteed" - GSubLine."Sub Amount Guaranteed");
                                LGuarantor.Modify;
                            end else if GSubLine."Amount Guaranteed" = GSubLine."Sub Amount Guaranteed" then begin
                                LGuarantor.Substituted := true;
                                LGuarantor.Modify;
                            end;
                        end;
                    end;
                    
                    GSubLine.Reset;
                    GSubLine.SetRange(GSubLine."Document No", Rec."Document No");
                    GSubLine.SetRange(GSubLine."Member No", Rec."Substituting Member");
                    if GSubLine.FindSet then begin
                        repeat
                        NewLGuar.Reset();
                        NewLGuar.SetRange("Loan No", Rec."Loan Guaranteed");
                        NewLGuar.SetRange("Member No", GSubLine."Substitute Member");
                        if NewLGuar.Find('-') then begin
                            NewLGuar."Amont Guaranteed" += GSubLine."Sub Amount Guaranteed";
                            oldSubGuar := NewLGuar."Substituted Guarantor";
                            NewLGuar."Substituted Guarantor" := oldSubGuar +'|'+ GSubLine."Member No";
                            NewLGuar."Acceptance Status" := NewLGuar."Acceptance Status"::Accepted;
                            NewLGuar.Modify;
                        end else begin
                            NewLGuar.Init;
                            NewLGuar."Loan No" := Rec."Loan Guaranteed";
                            NewLGuar."Member No" := GSubLine."Substitute Member";
                            NewLGuar.Validate(NewLGuar."Member No");
                            NewLGuar.Name := GSubLine."Substitute Member Name";
                            NewLGuar."Amont Guaranteed" := GSubLine."Sub Amount Guaranteed";
                            NewLGuar."Substituted Guarantor" := GSubLine."Member No";
                            NewLGuar."Acceptance Status" := NewLGuar."Acceptance Status"::Accepted;
                            NewLGuar.Insert;
                        end;
                        until GSubLine.Next = 0;
                    end;

                    if cust.Get(GSubLine."Substitute Member") then begin
                        subMsg:= 'Dear '+ GSubLine."Substitute Member Name" +'. You have guaranteed '+rec."Loanee Name"+' an amount of ' + Format(GSubLine."Sub Amount Guaranteed") + ' for a '+rec."Loan Type"+'.';
                        smsManagement.SendSmsWithID(Source::LOAN_GUARANTORS, cust."Mobile Phone No", subMsg, GSubLine."Substitute Member", cust."FOSA Account No.", true, 240, true, 'CBS', CreateGuid(),'CBS');
                    end;
                    
                    Rec.Substituted := true;
                    Rec."Date Substituted" := Today;
                    Rec."Substituted By" := UserId;
                    Rec.Modify;
                    Message('Guarantor Substituted Succesfully');
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FNAddRecordRestriction();
    end;

    trigger OnAfterGetRecord()
    begin
        FNAddRecordRestriction();
    end;

    trigger OnOpenPage()
    begin
        Rec."Application Date" := Today;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,GuarantorSubstitution;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        LGuarantor: Record "Loans Guarantee Details";
        GSubLine: Record "Guarantorship Substitution L";
        LoaneeNoEditable: Boolean;
        LoanGuaranteedEditable: Boolean;
        SubMemberEditable: Boolean;
        TotalReplaced: Decimal;
        Commited: Decimal;
        NewLGuar: Record "Loans Guarantee Details";
        WorkflowIntegration: codeunit WorkflowIntegration;
        cust: Record Customer;
        subMsg: Text[1500];
        smsManagement: Codeunit "Sms Management";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
        

    local procedure FNAddRecordRestriction()
    begin
        if Rec.Status = Rec.Status::Open then begin
            LoaneeNoEditable := true;
            LoanGuaranteedEditable := true;
            SubMemberEditable := true

        end else
            if Rec.Status = Rec.Status::Pending then begin
                LoaneeNoEditable := false;
                LoanGuaranteedEditable := false;
                SubMemberEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    LoaneeNoEditable := false;
                    LoanGuaranteedEditable := false;
                    SubMemberEditable := false;
                end;
    end;

    local procedure CalculateAmountGuaranteed(AmountReplaced: Decimal; TotalAmount: Decimal; AmountGuaranteed: Decimal) AmtGuar: Decimal
    begin
        AmtGuar := ((AmountReplaced / TotalAmount) * AmountGuaranteed);

        exit(AmtGuar);
    end;
}



