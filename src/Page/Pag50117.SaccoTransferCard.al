//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50117 "Sacco Transfer Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Transfers";
    PromotedActionCategories = 'New,Process,Report,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = not (Rec.Posted);
                field(No; rec.No)
                {
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    //Editable = TransactionDateEditable;
                }
                field("Member No"; Rec."Member No")
                {
                    //Editable = VarMemberNoEditable;
                    Visible = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    // Editable = RemarkEditable;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    // Editable = SourceAccountTypeEditable;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                }
                field("Source Transaction Type"; Rec."Source Transaction Type")
                {
                    //Editable = SourceAccountTypeEditable;

                    trigger OnValidate()
                    var
                        SourceLoanVisible: Boolean;
                    begin
                        SourceLoanVisible := false;
                        if (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Charged") or
                            (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Paid") or
                            (rec."Source Transaction Type" = rec."source transaction type"::Repayment) or
                            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Due") or
                            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid")
                          then begin
                            SourceLoanVisible := true;
                        end;
                    end;
                }
                group(DepositDebitType)
                {
                    Caption = 'Deposit Debit Type';
                    //Visible = DepositDebitTypeVisible;
                }
                field("Source Loan No"; Rec."Source Loan No")
                {
                    //Editable = SourceLoanNoEditable;
                    //Visible = SourceLoanVisible;
                }
                field("Header Amount"; Rec."Header Amount")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Charge Transfer Fee"; Rec."Charge Transfer Fee")
                {
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    Editable = false;
                }
                field("Transfer Fee"; rec.GetTransferFee)
                {
                    Editable = false;
                }
                field(NetTransferable; rec.NetTransferable)
                {
                    Editable = false;
                    Caption = 'Total';
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field(Posted; rec.Posted)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Approved; rec.Approved)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Editable = false;
                    Visible = false;
                }
            }
            part(Control1102760014; "Sacco Transfer Schedule")
            {
                SubPageLink = "No." = field(No);
                Editable = not (Rec.Posted);
            }
        }
        area(factboxes)
        {
            part(Control2; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Source Account No.");
                Visible = false;
            }
            part(Control1; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Source Account No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    // Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowExist;
                    // Enabled = 
                    Enabled = (Rec.Status = Rec.Status::Open);
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        vend: Record Vendor;
                    begin
                        rec.TestField("Transaction Description");
                        rec.CalcFields("Schedule Total");
                        if Rec."Schedule Total" <= 0 then Error('There should be a destination account.');

                        if Rec."Source Account Type" = Rec."Source Account Type"::"FOSA Account" then begin
                            if vend.Get(Rec."Source Account No.") then begin
                                vend.CalcFields(Balance);
                                if vend."Account Type" = '103' then begin
                                    if vend.GetAvailableBalance() < rec."Schedule Total" then Error('The scheduled amount is greater than the source account balance.');
                                end else begin
                                    if vend.Balance < rec."Schedule Total" then Error('The scheduled amount is greater than the source account balance.');
                                end;
                            end;
                        end;
                        if ((rec."Schedule Total" > rec."Header Amount") and (rec.Refund)) then Error('Scheduled Amount must be less or equal to Header Amount!');

                        if ((rec."Schedule Total" > rec."Header Amount") and (not ((rec."Source Transaction Type" = rec."source transaction type"::Repayment)
                          or (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid") 
                          or (rec."Source Transaction Type" = rec."source transaction type"::"Loan Penalty Charged")))) then Error('Scheduled Amount must be less or equal to Header Amount!');
                        
                        if FnLimitNumberOfTransactions() then Error(Txt0001);

                        if ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendSaccoTransferForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Enabled = (Rec.Status = Rec.Status::"Pending Approval");
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //canSendApproval
                        //CanCancelApprovalFOrRecord
                        if CanCancelApprovalFOrRecord then begin
                            if ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) then
                                ApprovalsMgmt.OnCancelSaccoTransferApprovalRequest(Rec);
                        end else begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
                action(Approvals)
                {
                    Enabled = OpenApprovalEntriesExist;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    // ApprovalEntries: Page "Approval Entries";
                    begin
                        // DocumentType := Documenttype::SaccoTransfers;
                        ApprovalEntries.SetRecordFilters(Database::"Sacco Transfers", DoctypeEnum::SaccoTransfers,  rec.No);
                        ApprovalEntries.Run;
                    end;
                }
                action(Post)
                {
                    Caption = 'Post & Print';
                    Enabled = EnablePost;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        SaccoGeneralSetUp: Record "Sacco General Set-Up";
                        TransferFee: Decimal;
                        CalculatedTransferFee: Decimal;
                        ScheduleAmt: Decimal;
                        SaccoTransfers: Record "Sacco Transfers";
                        LineNo: Integer;
                    begin
                        ScheduleAmt := 0;
                        SaccoTransfers.Reset();
                        SaccoTransfers.SetRange(SaccoTransfers.No, Rec.No);
                        if SaccoTransfers.FindFirst() then begin
                            SaccoTransfers.CalcFields(SaccoTransfers."Schedule Total");
                            ScheduleAmt := SaccoTransfers."Schedule Total";
                            //Message('ScheduleAmt %1', ScheduleAmt);
                            //   Error('Test %1',ScheduleAmt);
                        end;
                        /*if FundsUSer.Get(UserId) then begin
                            Jtemplate := FundsUSer."Payment Journal Template";
                            Jbatch := FundsUSer."Payment Journal Batch";
                            Message('JtemplateJbatch %1%2', Jtemplate, Jbatch);
                            Error('stop');
                        end;*/
                        JTemplate := 'GENERAL';//Temp."Payment Journal Template";
                        JBatch := 'FTRANS';//Temp."Payment Journal Batch";
                        if rec.Posted = true then Error('This Schedule is already posted');

                        if Confirm('Are you sure you want to transfer schedule?', false) = true then begin

                            /*IF "Source Transaction Type"="Source Transaction Type"::"Share Capital" THEN BEGIN
                              //IF "Receipt No"='' THEN
                              //  ERROR('Please enter receipt Number to confirm transfer');
                              //TESTFIELD("Receipt No");
                              END;
                              */


                            // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                            if GenJournalLine.FindSet() then begin
                                GenJournalLine.DeleteAll;
                            end;
                            //Transfer Charge
                            if rec."Charge Transfer Fee" = true then begin
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Document No." := rec.No;
                                GenJournalLine."Line No." := LineNo;
                                if Rec."Source Account Type" = Rec."Source Account Type"::"BOSA Account" then
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer
                                else if Rec."Source Account Type" = Rec."Source Account Type"::"FOSA Account" then
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor
                                else if Rec."Source Account Type" = Rec."Source Account Type"::"GL Account" then
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := rec."Source Account No.";
                                GenJournalLine."Loan No" := rec."Source Loan No";
                                GenJournalLine."Posting Date" := rec."Transaction Date";
                                TransferFee := 0;
                                SaccoGeneralSetUp.Get;
                                SaccoGeneralSetUp.TestField("Internal Transfer Fee");
                                SaccoGeneralSetUp.TestField("Internal Transfer Fee Account");
                                TransferFee := rec.GetTransferFee;//ROUND(rec.TransferCharges, 0.05, '=');
                                Message('TRANS %1', TransferFee);
                                GenJournalLine.Amount := TransferFee;
                                //MESSAGE(FORMAT(TransferFee));
                                //GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := SaccoGeneralSetUp."Internal Transfer Fee Account";
                                GenJournalLine.Description := 'Transfer Charges' + rec."Transaction Description";//+' '+"Source Account No.";
                                GenJournalLine."Transaction Type" := rec."Source Transaction Type";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                GenJournalLine.Insert;
                            end;


                            // UPDATE Source Account
                            //Message('Line%1', LineNo);
                            LineNo := LineNo + 100000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Document No." := rec.No;
                            GenJournalLine.Description := rec."Transaction Description" + ' ' + rec."Source Account No.";

                            GenJournalLine."Line No." := LineNo;
                            if rec."Source Account Type" = rec."source account type"::"BOSA Account" then begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                GenJournalLine."Transaction Type" := rec."Source Transaction Type";
                                GenJournalLine."Account No." := rec."Source Account No.";
                                Rec.CalcFields("Schedule Total");
                                GenJournalLine.Amount := rec."Schedule Total";
                                Rec.CalcFields("Schedule Total");
                                //  Message('Header Amount', GenJournalLine.Amount);

                                GenJournalLine."Loan No" := rec."Source Loan No";
                            end else
                                if rec."Source Account Type" = rec."source account type"::"FOSA Account" then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := rec."Source Account No.";
                                    Rec.CalcFields("Schedule Total");
                                    GenJournalLine.Amount := rec."Schedule Total";
                                    /// Message('Header Amount', GenJournalLine.Amount);

                                end else
                                    if rec."Source Account Type" = rec."source account type"::"BOSA Account" then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Transaction Type" := rec."Source Transaction Type";
                                        GenJournalLine.Description := rec."Transaction Description" + ' ' + rec."Source Account No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                        GenJournalLine."Account No." := rec."Source Account No.";
                                        GenJournalLine."Loan No" := rec."Source Loan No";
                                    end else


                                        if rec."Source Account Type" = rec."source account type"::"GL Account" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Transaction Type" := rec."Source Transaction Type";
                                            GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                            GenJournalLine."Account No." := rec."Source Account No.";
                                            Rec.CalcFields("Schedule Total");
                                            GenJournalLine.Amount := rec."Schedule Total";
                                            //  Message('Header Amount', GenJournalLine.Amount);
                                        end;
                            GenJournalLine."Posting Date" := rec."Transaction Date";
                            GenJournalLine.Description := rec."Transaction Description";//+' '+"Source Account No.";
                            Rec.CalcFields("Schedule Total");
                            //ScheduleAmt :=  rec."Schedule Total";
                            //IF "Charge Transfer Fee" THEN ScheduleAmt:=NetTransferable;
                            GenJournalLine.Amount := rec."Schedule Total";
                            //Message('GenJournalLine.Amount', GenJournalLine.Amount);

                            GenJournalLine."Amount (LCY)" := ScheduleAmt;
                            //Message('GenJournalLine.Amount', GenJournalLine.Amount);

                            GenJournalLine.Insert;

                            BSched.Reset;
                            BSched.SetRange(BSched."No.", rec.No);
                            if BSched.Find('-') then begin
                                repeat
                                    //Message('Bsched%1', BSched."destination account type");
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;

                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := rec.No;
                                    GenJournalLine."Line No." := LineNo;

                                    if BSched."Destination Account Type" = BSched."destination account type"::CUSTOMER then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Transaction Type" := BSched."Destination Type";
                                        GenJournalLine."Account No." := BSched."Destination Account No.";
                                        GenJournalLine.Description := BSched."Transaction Description" + ' ' + rec."Source Account No.";
                                        GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                    end else
                                        if BSched."Destination Account Type" = BSched."destination account type"::MEMBER then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                            GenJournalLine."Transaction Type" := BSched."Destination Type";
                                            GenJournalLine."Account No." := BSched."Destination Account No.";
                                            GenJournalLine.Description := BSched."Transaction Description" + ' ' + rec."Source Account No.";
                                            GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                        end else
                                            if BSched."Destination Account Type" = BSched."destination account type"::VENDOR then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                if ObjVendors.Get(rec."Source Account No.") then begin
                                                    ObjVendors.CalcFields(Balance);
                                                    if ObjVendors.Balance < 0 then
                                                        Error('Account has insufficient Balance');
                                                end;
                                                GenJournalLine."Transaction Type" := BSched."Destination Type";
                                                GenJournalLine."Account No." := BSched."Destination Account No.";
                                                GenJournalLine.Description := BSched."Transaction Description" + ' ' + rec."Source Account No.";
                                                GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                            end else
                                                if BSched."Destination Account Type" = BSched."destination account type"::"G/L ACCOUNT" then begin
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                    GenJournalLine."Account No." := BSched."Destination Account No.";
                                                    GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                                    GenJournalLine.Description := BSched."Transaction Description" + ' ' + rec."Source Account No.";

                                                end else
                                                    if BSched."Destination Account Type" = BSched."destination account type"::BANK then begin
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                        GenJournalLine."Account No." := BSched."Destination Account No.";
                                                        GenJournalLine.Description := BSched."Transaction Description" + ' ' + rec."Source Account No.";
                                                        GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                                    end;
                                    GenJournalLine."Loan No" := BSched."Destination Loan";
                                    GenJournalLine.Validate(GenJournalLine."Loan No");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := rec."Transaction Date";
                                    //GenJournalLine.Description := rec."Transaction Description" + ' ' + rec."Source Account No.";
                                    GenJournalLine.Amount := -BSched.Amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine.Insert;
                                until BSched.Next = 0;
                            end;



                            //Post
                            //Post New
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;


                            rec.Posted := true;
                            rec.Modify;
                            MESSAGE('Transaction posted succesfully');

                        end;


                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        BTRANS.Reset;
                        BTRANS.SetRange(BTRANS.No, rec.No);
                        if BTRANS.Find('-') then begin
                            Report.run(172902, true, true, BTRANS);
                        end;
                    end;
                }
            }
            action("Members Statistics")
            {
                Caption = 'Member Details';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Source Account No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    //  ApprovalsmgtBase: Codeunit "Approvals Mgmt.";
    begin
        AddRecordRestriction();
        SetControlAppearance();
        approvals.Reset();
        approvals.SetRange("Document No.", Rec.No);
        approvals.SetRange(Status, approvals.Status::Approved);
        if approvals.Find('-') then begin
            Rec.Status := Rec.Status::Approved;
            Rec.Modify;
        end;
        Commit();
        // EnablePost := false;
        //OpenApprovalEntriesExist := ApprovalsmgtBase.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalFOrRecord := ApprovalsmgtBase.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowExist := true;
        if Rec.Status = rec.Status::Approved then begin
            // OpenApprovalEntriesExist := false;
            // CanCancelApprovalFOrRecord := false;
            EnabledApprovalWorkflowExist := false;
        end;
        if Rec.Status = rec.Status::Approved then
            // EnablePost := true;
        SourceLoanVisible := false;
        if (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Charged") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Paid") or
            (rec."Source Transaction Type" = rec."source transaction type"::Repayment) or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Due") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
        DepositDebitTypeVisible := false;
        if rec."Source Transaction Type" = rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        //"Transaction Date":=TODAY;
        //MODIFY;
    end;

    trigger OnAfterGetRecord()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if rec."Source Transaction Type" = rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        SourceLoanVisible := false;
        if (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Charged") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Paid") or
            (rec."Source Transaction Type" = rec."source transaction type"::Repayment) or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Due") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    trigger OnOpenPage()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if rec."Source Transaction Type" = rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        SourceLoanVisible := false;
        if (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Charged") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Loan Insurance Paid") or
            (rec."Source Transaction Type" = rec."source transaction type"::Repayment) or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Due") or
            (rec."Source Transaction Type" = rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "Sacco Transfers Schedule";
        BTRANS: Record "Sacco Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        DoctypeEnum: Enum "Approval Document Type";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers;
        SourceAccountNoEditbale: Boolean;
        SourceAccountNameEditable: Boolean;
        SourceAccountTypeEditable: Boolean;
        SourceTransactionType: Boolean;
        SourceLoanNoEditable: Boolean;
        RemarkEditable: Boolean;
        TransactionDateEditable: Boolean;
        approvalEntries: Page "Approval Entries";
        approvals: Record "Approval Entry";
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        ObjSaccoTransfers: Record "Sacco Transfers";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowExist: Boolean;
        CanCancelApprovalFOrRecord: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        canSendApproval: Boolean;
        EnablePost: Boolean;
        Txt0001: label 'You cannot transfer another amount before three months elapse. ';
        DepositDebitTypeVisible: Boolean;
        ObjGensetup: Record "Sacco General Set-Up";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        VarExciseDuty: Decimal;
        VarExciseDutyAccount: Code[30];
        VarDepositDebitTypeEditable: Boolean;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjMember: Record Customer;
        VarMemberNoEditable: Boolean;
        ObjLoans: Record "Loans Register";
        window: Dialog;
        SourceLoanVisible: Boolean;
        cust: Record Customer;

    local procedure AddRecordRestriction()
    begin
        if rec.Status = rec.Status::Open then begin
            SourceAccountNoEditbale := true;
            SourceAccountNameEditable := true;
            SourceAccountTypeEditable := true;
            SourceLoanNoEditable := true;
            SourceTransactionType := true;
            TransactionDateEditable := true;
            VarDepositDebitTypeEditable := true;
            VarMemberNoEditable := true;
            RemarkEditable := true
        end else
            if rec.Status = rec.Status::"Pending Approval" then begin
                SourceAccountNoEditbale := false;
                SourceAccountNameEditable := false;
                SourceAccountTypeEditable := false;
                SourceLoanNoEditable := false;
                SourceTransactionType := false;
                TransactionDateEditable := false;
                VarDepositDebitTypeEditable := false;
                VarMemberNoEditable := false;
                RemarkEditable := false
            end else
                if rec.Status = rec.Status::Approved then begin
                    SourceAccountNoEditbale := false;
                    SourceAccountNameEditable := false;
                    SourceAccountTypeEditable := false;
                    SourceLoanNoEditable := false;
                    SourceTransactionType := false;
                    TransactionDateEditable := false;
                    VarDepositDebitTypeEditable := false;
                    VarMemberNoEditable := false;
                    RemarkEditable := false;
                end;
    end;

    local procedure FnLimitNumberOfTransactions(): Boolean
    begin
        ObjSaccoTransfers.Reset;
        ObjSaccoTransfers.SetRange("Savings Account Type", 'NIS');
        ObjSaccoTransfers.SetRange("Source Account No.", Rec."Source Account No.");
        ObjSaccoTransfers.SetRange(Posted, true);
        ObjSaccoTransfers.SetCurrentkey(No);
        if ObjSaccoTransfers.FindLast then begin
            if (Rec."Transaction Date" - ObjSaccoTransfers."Transaction Date") > 30 then
                exit(true);
        end;
        exit(false);
    end;

    
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if rec."Status" = rec."Status"::Open then begin
            canSendApproval := True;
            EnablePost := false;
        end
        else if Rec."Status" = Rec."Status"::Approved then begin
            canSendApproval := false;
            EnablePost := true;
        end
        else begin
            canSendApproval := false;
            EnablePost := false
        end;
    end;
}




