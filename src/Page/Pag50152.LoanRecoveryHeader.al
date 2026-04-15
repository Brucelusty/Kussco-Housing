//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50152 "Loan Recovery Header"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Recovery Header";
    PromotedActionCategories = 'New,Process,Report,Recover,Approvals';

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
                field("Member No"; Rec."Member No")
                {
                    Editable = (rec.Status = rec.Status::Open);
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    Caption = 'Member Deposits';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Total Outstanding Loans"; Rec."Total Outstanding Loans")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    Caption = 'Transaction Date';
                    Editable = false;
                }
                field("Recover Single Loan"; Rec."Recover Single Loan")
                {
                    Editable = true;
                }
                field("Loan to Attach"; Rec."Loan to Attach")
                {
                    Editable = rec."Recover Single Loan";
                    Enabled = (rec.Status = rec.Status::Open);
                }
                field("Loan Liabilities"; Rec."Loan Liabilities")
                {
                    Caption = 'Principal Balance';
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Interest Repayment"; Rec."Interest Repayment")
                {
                    Caption = 'Interest Repayment';
                    Editable = false;
                    Enabled = false;
                    HideValue = true;
                    Visible = false;
                }
                field("Principal Repayment"; Rec."Principal Repayment")
                {
                    Caption = 'Principal Repayment';
                    Editable = false;
                    Enabled = false;
                    HideValue = true;
                    Visible = false;
                }
                field("Total Interest Due Recovered"; Rec."Total Interest Due Recovered")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Total Thirdparty Loans"; Rec."Total Thirdparty Loans")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Mobile Loan"; Rec."Mobile Loan")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Deposits Aportioned"; Rec."Deposits Aportioned")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                    ToolTip = '(Outstanding Balance/Total Loans Outstanding Balance)*(Deposits-(Total Accrued Interest+Thirdparty Loans+Mobile Loan))';
                }
                field("Total Guaranteed"; Rec."Total Guaranteed")
                {
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field("Loan Distributed to Guarantors"; Rec."Loan Distributed to Guarantors")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(Guarantors; Rec.Guarantors)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("FOSA Account No"; Rec."FOSA Account No")
                {
                    Editable = false;
                }
                field("Recovery Difference"; Rec."Recovery Difference")
                {
                    Caption = 'Recovery Difference';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    Editable = (rec.Status = rec.Status::Open);
                }
                field("Attach Closure Fee"; Rec."Attach Closure Fee")
                {
                    Editable = (rec.Status = rec.Status::Open);
                    Enabled = (rec."Recovery Type" = rec."Recovery Type"::"Recover From Loanee Deposits");
                }
                field("Guarantor Allocation Type"; Rec."Guarantor Allocation Type")
                {
                    Caption = 'Liability Allocation Type';
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                    Editable = (rec.Status = rec.Status::Open);
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 1 Code")
                {
                    //Editable = Global1Editable;
                    //  OptionCaption = 'Activity';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Date Created';
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field("Loans Generated"; Rec."Loans Generated")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                }
            }
            part("<c>"; "Loan Recovery Details")
            {
                // Editable = GuarantorLoansDetailsEdit;
                Editable = (rec.Status = rec.Status::Open);
                Enabled = GuarantorLoansDetailsEdit;
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Member No");
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Transaction")
            {
                Enabled = (not Rec.Posted);
                Visible = rec.Status = rec.Status::Approved;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LineNo: Integer;
                    TotalLoanRecovered: Decimal;
                    AuFactory: Codeunit "Au Factory";
                    passed: Boolean;
                begin
                    if (Rec.Status <> Rec.Status::Approved) then Error('You cannot post a document which is not approved');

                    BATCH_TEMPLATE := 'PAYMENTS';
                    BATCH_NAME := 'DF_RECOVER';
                    DOCUMENT_NO := Rec."Document No";
                    EXTERNAL_DOC_NO := Rec."Loan to Attach";
                    Datefilter := '..' + Format(Rec."Loan Disbursement Date");

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    GenBatch.Reset;
                    GenBatch.SetRange(GenBatch."Journal Template Name", BATCH_TEMPLATE);
                    GenBatch.SetRange(GenBatch.Name, BATCH_NAME);
                    if GenBatch.Find('-') = false then begin
                        GenBatch.Init;
                        GenBatch."Journal Template Name" := BATCH_TEMPLATE;
                        GenBatch.Name := BATCH_NAME;
                        GenBatch.Description := 'Loan Recovery Journal';
                        GenBatch.Insert;
                    end;


                    if Rec."Recovery Type" = Rec."recovery type"::"Recover From Loanee Deposits" then begin
                        LineNo := 0;
                        //  FnRunPostMemberDepositstoLSA("Document No",WORKDATE,"Loan to Attach");
                        RunBal := Rec."Current Shares";
                        if RunBal > 0 then
                            FnRunRecoverFromLoaneesDeposits(RunBal, rec."Attach Closure Fee");
                    end;

                    if Rec."Recovery Type" = Rec."recovery type"::"Recover From Loanee FOSA" then begin
                        LineNo := 0;
                        Vend.Reset();
                        Vend.SetRange("No.", Rec."FOSA Account No");
                        if Vend.Find('-') then begin
                            RunBal := Vend.GetAvailableBalance();
                        end;
                        if RunBal > 0 then
                            FnRunRecoverFromLoaneesFOSA(RunBal, rec."Attach Closure Fee");
                    end;


                    if Rec."Recovery Type" = Rec."recovery type"::"Attach Defaulted Loans to Guarantors" then begin
                        LineNo := 0;
                        FnGenerateDefaulterLoans();
                    end;


                    if Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits" then begin

                        if Confirm('Kindly ensure you have apportioned the guarantors and verified their apportioned liability', true) = false then exit;
                        LoanDetails.Reset();
                        LoanDetails.SetRange("Document No", Rec."Document No");
                        LoanDetails.SetFilter("Guarantor Amount Apportioned", '<%1', 0);
                        if LoanDetails.Find('-') then begin
                            Error('Kindly confirm the apportioned liability of guarantor %1.', LoanDetails."Guarantor Number");
                        end;

                        LoanDetails.Reset();
                        LoanDetails.SetRange("Document No", Rec."Document No");
                        LoanDetails.SetFilter("Guarantor Amount Apportioned", '>%1', 0);
                        LoanDetails.SetFilter("Guarantors Current Shares", '<=%1', 0);
                        if LoanDetails.Find('-') then begin
                            Error('Kindly confirm the apportioned liability of guarantor %1.', LoanDetails."Guarantor Number");
                        end;

                        passed := FnRunRecoverFromGuarantorsDeposits(Rec."Document No", Rec."Loan to Attach", Rec."Member No", Today);
                        Message('Success: %1', passed);
                    end;


                    // Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;

                    ObjGuarantorRec.Reset;
                    ObjGuarantorRec.SetRange("Loan No", Rec."Loan No");
                    if ObjGuarantorRec.Find('-') then begin
                        Rec.Posted := true;
                        Rec."Loans Generated" := true;
                        Rec."Posting Date" := Today;
                        Rec."Posted By" := UserId;
                        Rec.Modify;
                    end;

                    if Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits" then begin
                        LoanDetails.Reset();
                        LoanDetails.SetRange("Document No", rec."Document No");
                        if LoanDetails.FindSet() then begin
                            repeat
                                if Cust.Get(LoanDetails."Guarantor Number") then begin
                                    smsGuar := 'Dear ' + namesStyles.NameStyle(Cust."No.") + '. Kshs.' + Format(LoanDetails."Guarantor Amount Apportioned") + ' was recovered from your deposits to repay ' + namesStyles.NameStyle(rec."Member No") + '''s defaulted ' + LoanDetails."Loan Type" + ' which you had guaranteed.';
                                    smsManagement.SendSmsWithID(smsOptions::LOAN_RECOVERY, Cust."Mobile Phone No", smsGuar, Cust."FOSA Account No.", Cust."FOSA Account No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                                end;
                            until LoanDetails.Next() = 0;
                        end;
                    end;
                    if Rec."Recovery Type" = Rec."recovery type"::"Recover From Loanee Deposits" then begin
                        if Cust.Get(Rec."Member No") then begin
                            smsLoanee := 'Dear ' + namesStyles.NameStyle(Cust."No.") + '. Kshs.' + Format(Rec."Loan Distributed to Guarantors") + ' was recovered from your deposits to repay your defaulted ' + LoanDetails."Loan Type" + '.';
                            smsManagement.SendSmsWithID(smsOptions::LOAN_RECOVERY, Cust."Mobile Phone No", smsGuar, Cust."FOSA Account No.", Cust."FOSA Account No.", false, 240, false, 'CBS', CreateGuid(), 'CBS');
                        end;
                    end;
                    if Rec."Recovery Type" = Rec."recovery type"::"Recover From Loanee FOSA" then begin
                        if Cust.Get(Rec."Member No") then begin
                            smsLoanee := 'Dear ' + namesStyles.NameStyle(Cust."No.") + '. Kshs.' + Format(Rec."Loan Distributed to Guarantors") + ' was recovered from your FOSA Savings to repay your defaulted ' + LoanDetails."Loan Type" + '.';
                            smsManagement.SendSmsWithID(smsOptions::LOAN_RECOVERY, Cust."Mobile Phone No", smsGuar, Cust."FOSA Account No.", Cust."FOSA Account No.", false, 240, false, 'CBS', CreateGuid(), 'CBS');
                        end;
                    end;
                    // Message('', passed);
                    CurrPage.Close;
                end;
            }
            action("Load Guarantors")
            {
                Image = WorkCenterLoad;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = (rec."Recovery Type" <> rec."Recovery Type"::"Recover From Loanee Deposits");

                trigger OnAction()
                var
                    LoanDetails: Record "Loan Member Loans";
                    GCount: Integer;
                    loansReg: Record "Loans Register";
                    totalLoan: Decimal;
                    approvedAmount: Decimal;
                    refLiability: Decimal;
                    currLiability: Decimal;
                    princLiability: Decimal;
                    intLiability: Decimal;
                begin
                    Rec.TESTFIELD(Rec."Recovery Type");

                    totalLoan := 0;
                    approvedAmount := 0;
                    refLiability := 0;
                    currLiability := 0;
                    princLiability := 0;
                    intLiability := 0;

                    rec.CalcFields(Guarantors);
                    refLiability := Rec."Loan Distributed to Guarantors";
                    if (Rec."Recovery Type" = Rec."recovery type"::"Attach Defaulted Loans to Guarantors") or (Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits") then begin
                        LoanDetails.Reset;
                        LoanDetails.SetRange(LoanDetails."Loan No.", Rec."Loan to Attach");
                        if LoanDetails.Find('-') then begin
                            LoanDetails.DeleteAll;
                        end;

                        LoanGuarantors.Reset;
                        LoanGuarantors.SetRange(LoanGuarantors."Loan No", Rec."Loan to Attach");
                        LoanGuarantors.SetRange(Substituted, false);
                        LoanGuarantors.SetCurrentKey("Amont Guaranteed");
                        LoanGuarantors.SetAscending("Amont Guaranteed", false);
                        if LoanGuarantors.FindSet then begin
                            repeat
                                GCount += 1;
                                currLiability := Round(((Rec."Loan Distributed to Guarantors" / Rec."Total Guaranteed") * LoanGuarantors."Amont Guaranteed"), 0.01, '=');
                                refLiability := refLiability - currLiability;
                                if (refLiability <> 0) and (GCount = rec.Guarantors) then begin
                                    currLiability := currLiability + refLiability;
                                end;
                                LoanGuarantors.calcfields("Total Loans Guaranteed", "Total Committed Shares", "Total Amount Guaranteed");
                                LoanDetails.Init;
                                LoanDetails."Document No" := Rec."Document No";
                                LoanDetails."Member No" := Rec."Member No";
                                LoanDetails."Member Name" := LoanGuarantors.Name;
                                LoanDetails."Guarantor Number" := LoanGuarantors."Member No";
                                LoanDetails."Loan No." := LoanGuarantors."Loan No";
                                LoanDetails.Validate("Loan No.");
                                LoanDetails."Amont Guaranteed" := LoanGuarantors."Amont Guaranteed";
                                if ObjCust.Get(LoanGuarantors."Member No") then begin
                                    ObjCust.CalcFields(ObjCust."Current Shares");
                                    LoanDetails."Guarantors Current Shares" := ObjCust."Current Shares";
                                    LoanDetails."Guarantor Amount Apportioned" := currLiability;
                                    LoanDetails.Validate("Guarantor Amount Apportioned");
                                    if ObjCust."Current Shares" < currLiability then begin
                                        LoanDetails.Difference := currLiability - ObjCust."Current Shares";
                                    end else
                                        LoanDetails.Difference := 0;
                                end;
                                if not LoanDetails.Insert then LoanDetails.Modify;
                            until LoanGuarantors.Next = 0;
                        end;
                    end;
                    Message('Loan Guarantors loaded successfully. Kindly apportion the guarantors''');
                end;
            }
            action("Apportion Liability")
            {
                Image = CalculateDiscount;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = (rec."Recovery Type" <> rec."Recovery Type"::"Recover From Loanee Deposits");

                trigger OnAction()
                var
                    activeGuar: Integer;
                    currLiability: Decimal;
                    princLiability: Decimal;
                    intLiability: Decimal;
                    maxDiff: Decimal;
                begin
                    maxDiff := 0;
                    VarGuarantorCount := 0;
                    VarTotalGuarantorAmount := 0;
                    //===============Load Guarantors Check=====================================
                    ObjLoanGuarantors.Reset;
                    ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                    if ObjLoanGuarantors.Find('-') = false then begin
                        Error('Ensure you Load Loan Guarantors');
                    end;
                    //===============End Load Guarantors Check====================================

                    //==============Get Total Deficit Guarantor Amount=====================================
                    ObjLoanGuarantors.Reset;
                    ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                    ObjLoanGuarantors.SetFilter(ObjLoanGuarantors.Difference, '>%1', 0);
                    ObjLoanGuarantors.SetCurrentKey("Amont Guaranteed");
                    ObjLoanGuarantors.SetAscending("Amont Guaranteed", false);
                    if ObjLoanGuarantors.FindSet then begin
                        repeat
                            VarGuarantorCount := ObjLoanGuarantors.Count;
                            VarTotalGuarantorAmount := VarTotalGuarantorAmount + ObjLoanGuarantors.Difference;
                            ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Guarantor Amount Apportioned" - ObjLoanGuarantors.Difference;
                            ObjLoanGuarantors.Validate("Guarantor Amount Apportioned");
                            ObjLoanGuarantors.modify;
                        until ObjLoanGuarantors.Next = 0;
                    end;
                    //=============End Get Total Deficit Guarantor Amount==================================


                    //============= Trickle Down The Total Deficit Guarantor Amount Dividing Among The Current Guarantors==================================
                    ObjLoanGuarantors.Reset;
                    ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                    ObjLoanGuarantors.SetRange(ObjLoanGuarantors.Difference, 0);
                    ObjLoanGuarantors.SetCurrentKey("Amont Guaranteed");
                    ObjLoanGuarantors.SetAscending("Amont Guaranteed", false);
                    if ObjLoanGuarantors.Find('-') then begin
                        repeat
                            if VarTotalGuarantorAmount > 0 then begin
                                maxDiff := (ObjLoanGuarantors."Amont Guaranteed" - ObjLoanGuarantors."Guarantor Amount Apportioned");
                                if maxDiff >= VarTotalGuarantorAmount then begin
                                    ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Guarantor Amount Apportioned" + VarTotalGuarantorAmount;
                                    ObjLoanGuarantors.Validate("Guarantor Amount Apportioned");
                                    VarTotalGuarantorAmount := VarTotalGuarantorAmount - VarTotalGuarantorAmount;
                                    ObjLoanGuarantors.modify;
                                end else begin
                                    ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Guarantor Amount Apportioned" + maxDiff;
                                    ObjLoanGuarantors.Validate("Guarantor Amount Apportioned");
                                    VarTotalGuarantorAmount := VarTotalGuarantorAmount - maxDiff;
                                    ObjLoanGuarantors.modify;
                                end;
                            end;
                        until ObjLoanGuarantors.Next = 0;
                    end;
                    Message('Guarantors Apportioned Successfully.');
                end;
            }
        }
        area(creation)
        {
            action("Send Approval Request")
            {
                Caption = 'Send A&pproval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                begin
                    rec.TestField("Member No");
                    rec.TestField("Recovery Type");
                    if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then
                        Error(text001);

                    if rec."Recovery Type" = rec."Recovery Type"::"Recover From Guarantors Deposits" then begin
                        rec.CalcFields("Amount to be Recovered");
                        if rec."Loan Distributed to Guarantors" <> rec."Amount to be Recovered" then Error('Ensure that the amount approtioned among the guarantors adds up to the total loan balance.');
                        if Confirm('Kindly ensure you have apportioned the guarantors', true) = false then exit;
                    end;
                    if rec."Recovery Type" = rec."Recovery Type"::"Recover From Loanee Deposits" then begin

                    end;


                    if WKFLWIntegr.CheckGuarantorRecoveryApprovalsWorkflowEnabled(Rec) then
                        WKFLWIntegr.OnSendGuarantorRecoveryForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel A&pproval Request';
                // Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                //ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Approved) then
                        Error(text001);

                    // if WKFLWIntegr.CheckGuarantorRecoveryApprovalsWorkflowEnabled(Rec) then
                    //     WKFLWIntegr.OnCancelGuarantorRecoveryApprovalRequest(Rec);
                    ReC.Status := Rec.Status::Open;
                    Rec.Modify(true);
                    Commit();
                    Message('Rcord opened.');
                    CurrPage.Close();
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Enabled = OpenApprovalEntriesExist;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    approvalDoc: Enum "Approval Document Type";
                begin
                    ApprovalEntries.SetRecordFilters(Database::"Loan Recovery Header", approvalDoc::GuarantorRecovery, Rec."Document No");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        UpdateControls();
        EnableCreateMember := false;
        //OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        //CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (rec.Posted) then
            EnableCreateMember := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := UserId;
        Rec."Application Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        //UpdateControls();
    end;

    var
        ObjGLEntry: Record "G/L Entry";
        Attached: Boolean;
        LoanBalanceAfterDeposit: Decimal;
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        // temp: Record "Temp. Blob";
        LoansRec: Record "Loans Register";
        TotalRecovered: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        GLoanDetails: Record "Loan Member Loans";
        TotalOustanding: Decimal;
        ClosingDepositBalance: Decimal;
        RemainingAmount: Decimal;
        AMOUNTTOBERECOVERED: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        intRecoverNw: Decimal;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        WKFLWIntegr: Codeunit WorkflowIntegration;
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Lbal: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        "Loan&int": Decimal;
        TotDed: Decimal;
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[10];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        MemberNoEditable: Boolean;
        RecoveryTypeEditable: Boolean;
        Global1Editable: Boolean;
        Global2Editable: Boolean;
        LoantoAttachEditable: Boolean;
        GuarantorLoansDetailsEdit: Boolean;
        TotalRecoverable: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        AmounttoRecover: Decimal;
        BaltoRecover: Decimal;
        InstRecoveredAmount: Decimal;
        X: Decimal;
        ObjGuarantorML: Record "Loan Member Loans";
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RunBal: Decimal;
        TotalSharesUsed: Decimal;
        i: Integer;
        GenJnlBatch: Record "Gen. Journal Batch";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        LoanGuar: Record "Loans Guarantee Details";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        loanReg: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        GrossPay: Decimal;
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        TAXABLEPAY: Record "PAYE Brackets Credit";
        PAYE: Decimal;
        PAYESUM: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        Taxrelief: Decimal;
        OTrelief: Decimal;
        Chargeable: Decimal;
        PartPay: Record "Loan Partial Disburesments";
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        RepaySched: Record "Loan Repayment Schedule";
        LoanReferee1NameEditable: Boolean;
        LoanReferee2NameEditable: Boolean;
        LoanReferee1MobileEditable: Boolean;
        LoanReferee2MobileEditable: Boolean;
        LoanReferee1AddressEditable: Boolean;
        LoanReferee2AddressEditable: Boolean;
        LoanReferee1PhyAddressEditable: Boolean;
        LoanReferee2PhyAddressEditable: Boolean;
        LoanReferee1RelationEditable: Boolean;
        LoanReferee2RelationEditable: Boolean;
        LoanPurposeEditable: Boolean;
        WitnessEditable: Boolean;
        compinfo: Record "Company Information";
        LoanRepa: Record "Loan Repayment Schedule";
        ObjGuarantorRec: Record "Loan Recovery Header";
        Text0001: label 'Please consider recovering from the Loanee Shares Before Attaching to Guarantors';
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "Au Factory";
        DLoan: Code[20];
        Datefilter: Text;
        LoanDetails: Record "Loan Member Loans";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        smsGuar: Text[1800];
        smsLoanee: Text[1800];
        RecoveryTransType: Option Normal,"Guarantor Recoverd","Guarantor Paid";
        smsOptions: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY;
        smsManagement: Codeunit "Sms Management";
        namesStyles: Codeunit "SMS Reminders";
        ObjLoansRec: Record "Loans Register";
        ObjNoSeries: Record "No. Series Line";
        ObjSaccoNoSeries: Record "Sacco No. Series";
        LastNoUsed: Code[20];
        ObjLoanType: Record "Loan Products Setup";
        VarAmounttoDeduct: Integer;
        ObjCust: Record Customer;
        ObjLoanGuarantors: Record "Loan Member Loans";
        VarTotalGuarantorAmount: Decimal;
        VarGuarantorCount: Integer;
        VarTotalApprotionLess: Decimal;
        VarTotalApprotionGreater: Decimal;
        VarTotalApprotionLessCount: Integer;
        intRecover: Decimal;
        penRecover: Decimal;
        LONS: Decimal;


    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            RecoveryTypeEditable := true;
            LoantoAttachEditable := true;
            Global1Editable := true;
            Global2Editable := true;
            GuarantorLoansDetailsEdit := true;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := true;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := false;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := true;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := false;
        end
    end;

    local procedure FnGetDefaultorLoanAmount(OutstandingBalance: Decimal; GuaranteedAmount: Decimal; TotalGuaranteedAmount: Decimal; GuarantorCount: Integer): Decimal
    begin
        if Rec."Guarantor Allocation Type" = Rec."guarantor allocation type"::"Equally Liable" then begin

            exit(ROUND(OutstandingBalance / (GuarantorCount), 0.05, '>'));
            // MESSAGE('guar %1',GuarantorCount);
        end else
            exit(ROUND(GuaranteedAmount / TotalGuaranteedAmount * (Rec."Loan Liabilities"), 0.05, '>'));
    end;


    procedure FnPostRepaymentJournal(TDefaulterLoan: Decimal)
    var
        ObjLoanDetails: Record "Loan Member Loans";
    begin
        if LoansRec.Get(Rec."Loan to Attach") then begin
            LineNo := LineNo + 10000;

            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
            GenJournalLine."Account Type"::Customer, LoansRec."Client Code", Rec."Loan Disbursement Date", TDefaulterLoan * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
            'Defaulted Loan Recovered-' + Rec."Loan to Attach", LoanApp."Loan  No.", 0);//Maximum No of Parameters(13) Exceeded

        end;
    end;

    local procedure FnGetInterestForLoanToAttach(): Decimal
    var
        ObjLoansRegisterLocal: Record "Loans Register";
    begin
        ObjLoansRegisterLocal.Reset;
        ObjLoansRegisterLocal.SetRange(ObjLoansRegisterLocal."Loan  No.", Rec."Loan to Attach");
        if ObjLoansRegisterLocal.Find('-') then begin
            ObjLoansRegisterLocal.CalcFields(ObjLoansRegisterLocal."Outstanding Interest");
            exit(ObjLoansRegisterLocal."Outstanding Interest");
        end;
    end;

    local procedure FnRunInterest(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange("BOSA No", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;
                        AmountToDeduct := FnCalculateTotalInterestDue(LoanApp);
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", 0);
                        RunningBalance := RunningBalance - AmountToDeduct;
                    end;
                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Total Interest Due Recovered", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);
            end;
        end;
    end;

    local procedure FnRunPrinciple(RunningBalance: Decimal)
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
    begin
        // BEGIN
        //    IF LoansRec.GET("Loan to Attach") THEN BEGIN
        //      //---------------------PAY-------------------------------
        //      LONS:=0;
        //      LineNo:=LineNo+10000;
        //      ObjCust.CALCFIELDS(ObjCust."Current Shares");
        //     //"Deposits Aportioned":=("Current Shares"-"Total Interest Due Recovered" );
        //       //"Deposits Aportioned":="Current Shares"-"Total Outstanding Loans";
        //       //IF LONS<0 THEN
        //    //"Deposits Aportioned":=("Current Shares"-"Total Interest Due Recovered");
        //          // IF "Deposits Aportioned"<=0 THEN
        //           //"Deposits Aportioned":=0;
        //          // MESSAGE('aprtioned %1',"Deposits Aportioned");
        //             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::Repayment,
        //      GenJournalLine."Account Type"::Member,LoansRec."Client Code","Loan Disbursement Date","Deposits Aportioned"*-1,FORMAT(LoansRec.Source),EXTERNAL_DOC_NO,
        //      FORMAT(GenJournalLine."Transaction Type"::Repayment),"Loan to Attach");
        //      //--------------------RECOVER-----------------------------
        //      LineNo:=LineNo+10000;
        //      SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
        //      GenJournalLine."Account Type"::Member,"Member No","Loan Disbursement Date","Deposits Aportioned",FORMAT(LoansRec.Source),EXTERNAL_DOC_NO,
        //      FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution")+'-'+LoansRec."Loan Product Type",'');
        //      END;
        //    END;

        begin
            if LoanApp."Outstanding Balance" > Rec."Current Shares" then begin
                Rec."Deposits Aportioned" := Rec."Current Shares";
            end;
            if LoansRec.Get(Rec."Loan to Attach") then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                GenJournalLine."Account Type"::Customer, LoansRec."Client Code", Rec."Loan Disbursement Date", Rec."Deposits Aportioned" * -1, Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::Repayment), LoanApp."Loan  No.", 0);
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Deposits Aportioned", Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoansRec."Loan Product Type", LoanApps."Loan  No.", 0);
            end;
        end;
    end;

    local procedure FnDefaulterLoansDisbursement(ObjLoanDetails: Record "Loan Member Loans"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CU: Codeunit "No. Series";
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, '16');
        if loanTypes.Find('-') then begin
            DocNumber := CU.GetNextNo('LBATCH', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Guarantor Number";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := '16';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails."Interest Rate";
                LoansRec."Loan Status" := LoansRec."loan status"::Disbursed;
                LoansRec."Application Date" := Rec."Loan Disbursement Date";
                LoansRec."Issued Date" := Rec."Loan Disbursement Date";
                LoansRec."Loan Disbursement Date" := Rec."Loan Disbursement Date";
                LoansRec."Expected Date of Completion" := Rec."Expected Date of Completion";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::EFT;
                LoansRec."Repayment Start Date" := Rec."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := Format(LoanApps.Source);
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := LoansRec.Source::BOSA;
                LoansRec."Approval Status" := LoansRec."approval status"::Approved;
                LoansRec.Repayment := ObjLoanDetails."Approved Loan Amount";
                LoansRec."Requested Amount" := 0;
                LoansRec."Approved Amount" := ObjLoanDetails."Approved Loan Amount";
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::EFT;
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", LoansRec."Loan  No.");
        LoansR.SetFilter(LoansR."Approved Amount", '>%1', 0);
        LoansR.SetFilter(LoansR.Posted, '=%1', true);
        if LoansR.Find('-') then begin
            if ((LoansR."Loan Product Type" = '16') and (LoansR."Issued Date" <> 0D) and (LoansR."Repayment Start Date" <> 0D)) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansR."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansR."Approved Amount";
                InterestRate := LoansR.Interest;
                RepayPeriod := LoansR.Installments;
                InitialInstal := LoansR.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansR."Approved Amount";
                RunDate := Rec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        //LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;

    local procedure FnRecoverMobileLoanPrincipal(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."BOSA No", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", Rec."Mobile Loan" * -1, 'FOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::Repayment), LoanApp."Loan  No.", 0);
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Mobile Loan", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);
            end;
        end;
    end;

    local procedure FnRunPrincipleThirdparty(RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
    // ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := LoanApp."Outstanding Balance";
                            if varLRepayment > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                Message('bal %1', AmountToDeduct);
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                Format(GenJournalLine."transaction type"::Repayment), LoanApp."Loan  No.", 0);
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;

                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Total Thirdparty Loans", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnGenerateDefaulterLoans()
    var
        DLoanAmount: Decimal;
        LoansRegister: record "Loans Register";
        TotAmtG: decimal;
        Gur: record "Loans Guarantee Details";
        LoansG: record "Loans Guarantee Details";
        TotalToPostToLoan: decimal;
        AmountToPostAsGuarantorLoan: decimal;
        AmountAll: decimal;
        NewLoanNo: code[500];
        PostedOn: date;
        AuFactory: Codeunit "Au Factory";
        RemPeriod: Integer;
        TheDateToday: date;
        ObjLoansGuarantor: record "Loans Guarantee Details";
        CU: codeunit "No. Series";
        LoanProductSetup: Record "Loan Products Setup";
        Interest2: decimal;
    begin
        PostedOn := today;
        LoansRegister.RESET;
        LoansRegister.SETRANGE("Client Code", Rec."Member No");
        LoansRegister.SETFILTER("Outstanding Balance", '>0');
        LoansRegister.SetRange("Loan  No.", Rec."Loan to Attach");
        //LoansRegister.SETFILTER("Loan Product Type",'<>%1','D306');
        LoansRegister.SETAUTOCALCFIELDS("Outstanding Interest", "Outstanding Balance");
        IF LoansRegister.FINDSET THEN BEGIN
            REPEAT
                WITH LoansRegister DO BEGIN

                    IF "Outstanding Interest" < 0 THEN "Outstanding Interest" := 0;
                    IF "Outstanding Balance" > "Outstanding Interest" THEN BEGIN

                        "Outstanding Interest" := 0;
                        "Outstanding Balance" := "Outstanding Balance";//- ("Total Allocated To Loan"-"Outstanding Interest");
                    END ELSE
                        "Outstanding Interest" := "Outstanding Interest";//- "Total Allocated To Loan";
                                                                         // MESSAGE('%1|%2, %3',"Outstanding Interest","Outstanding Balance","Total Allocated To Loan");


                    //  LoanRemainingPeriod.RESET;
                    //  LoanRemainingPeriod.SETRANGE("Loan No","Loan  No.");
                    //  LoanRemainingPeriod.SETRANGE("Header No",Rec."Document No");
                    //  LoanRemainingPeriod.SETRANGE("Member No",Rec."Member No");
                    //  IF LoanRemainingPeriod.FINDFIRST THEN
                    //     RemPeriod:=LoanRemainingPeriod."Remaining Period";

                    //  IF RemPeriod<=0 THEN BEGIN
                    //      RemPeriod:=1;
                    //      RSchedule.RESET;
                    //      RSchedule.SETRANGE("Loan No.","Loan  No.");
                    //      RSchedule.SETRANGE("Closed Schedule",FALSE);
                    //      RSchedule.SETFILTER("Repayment Date",'>=%1',TODAY);
                    //      IF RSchedule.FINDFIRST THEN

                    //         RemPeriod:=RSchedule.COUNT;
                    //  END;

                    //  MESSAGE(FORMAT(Rec."Loan to Attach"));

                    if LoanProductSetup.Get('DEFAULT') then begin
                        RemPeriod := LoanProductSetup."No of Installment";
                        Interest2 := LoanProductSetup."Interest rate";
                    end;

                    Gur.RESET;
                    Gur.SETRANGE("Loan No", "Loan  No.");
                    Gur.SETRANGE(Substituted, FALSE);
                    Gur.SETRANGE("Self Guarantee", FALSE);
                    Gur.SETFILTER("Amont Guaranteed", '>0');
                    IF Gur.FINDFIRST THEN BEGIN
                        Gur.CALCSUMS("Amont Guaranteed");
                        TotAmtG := Gur."Amont Guaranteed";
                    END;

                    TotalToPostToLoan := 0;
                    LoansG.RESET;
                    LoansG.SETRANGE("Loan No", "Loan  No.");
                    LoansG.SETRANGE(Substituted, FALSE);
                    LoansG.SETRANGE("Self Guarantee", FALSE);
                    LoansG.SETFILTER("Amont Guaranteed", '>0');
                    IF LoansG.FINDSET THEN
                        REPEAT

                            AmountToPostAsGuarantorLoan := ROUND((LoansG."Amont Guaranteed" / TotAmtG) * (("Outstanding Balance")), 0.01, '=');
                            //Interest2:=FnGetInterestRate(Rec."Member No",LoansG."Loan No");//interest new
                            // MESSAGE('%1|%2',"Outstanding Interest","Outstanding Balance");
                            AmountAll += AmountToPostAsGuarantorLoan;
                            //MESSAGE('%1|%2',AmountToPostAsGuarantorLoan,AmountAll);
                            NewLoanNo := CU.GetNextNo('DLN', 0D, TRUE);
                            LoansRec.INIT;
                            LoansRec."Loan  No." := NewLoanNo;//loan no
                            LoansRec."Client Code" := LoansG."Member No";
                            LoansRec."Loan Product Type" := 'DEFAULT';
                            LoansRec."Loan Product Type Name" := 'Defaulted Loan';
                            LoansRec."Loan Status" := LoansRec."Loan Status"::Disbursed;
                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.", LoansG."Member No");
                            IF Cust.FIND('-') THEN BEGIN
                                LoansRec."Client Name" := Cust.Name;
                                LoansRec."Employer Code" := Cust."Employer Code";
                                LoansRec."Employer Name" := Cust."Employer Name";
                                LoansRec."Staff No" := Cust."Payroll No";
                            END;
                            LoansRec."Application Date" := PostedOn;
                            LoansRec."Issued Date" := TODAY;
                            LoansRec."Loan Disbursement Date" := TODAY;
                            TheDateToday := CALCDATE('-CM', TODAY);
                            GenSetUp.GET;
                            IF (TODAY < CALCDATE(GenSetUp."Days for Checkoff", TheDateToday)) THEN BEGIN
                                LoansRec."Repayment Start Date" := CALCDATE('CM', TODAY);
                            END ELSE BEGIN
                                LoansRec."Repayment Start Date" := CALCDATE('CM', CALCDATE('CM+1M', TODAY));
                            END;
                            LoansRec."Expected Date of Completion" := CALCDATE('CM', CALCDATE('CM+' + FORMAT(RemPeriod) + 'M', TODAY));
                            // LoansRec."Repayment Start Date":="Repayment Start Date";
                            LoansRec.Installments := RemPeriod;
                            // LoansRec.Interest:=KentoursFactory.knGetInterestRate(KentoursFactory.KnGetLoanProductType("Loan  No."),RemPeriod);
                            LoansRec.Interest := Interest2;
                            // LoansRec.Repayment:=ObjLoanDetails."Defaulter Loan"/"Remaining Loan Period"; //Corrected for final use
                            LoansRec."Requested Amount" := AmountToPostAsGuarantorLoan;
                            LoansRec."Approved Amount" := AmountToPostAsGuarantorLoan;
                            LoansRec."Mode of Disbursement" := LoansRec."Mode of Disbursement"::" ";
                            LoansRec.Posted := TRUE;
                            LoansRec."Advice Date" := TODAY;
                            LoansRec.Source := LoansRec.Source::BOSA;
                            LoansRec."Branch Code" := 'NAIROBI';
                            LoansRec."Recovery Mode" := LoansRec."Recovery Mode"::Checkoff;
                            LoansRec."Repayment Method" := LoansRec."Repayment Method"::"Reducing Balance";
                            LoansRec."Repayment Frequency" := LoansRec."Repayment Frequency"::Monthly;
                            LoansRec."Approval Status" := LoansRec."Approval Status"::Approved;
                            LoansRec."Original Loanee" := Rec."Member No";
                            LoansRec."Disbursed By" := UserId;
                            LoansRec."Original Loan" := LoansG."Loan No";
                            LoansRec."Interest Due" := FnGetInterestForLoanToAttach();
                            LoansRec."Defaulter Loan" := TRUE;
                            LoansRec.INSERT;

                            //============================================================Insert Guarantor
                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.", LoansRec."Client Code");
                            IF Cust.FIND('-') THEN BEGIN
                                ObjLoansGuarantor.INIT;
                                ObjLoansGuarantor."Loan No" := LoansRec."Loan  No.";
                                ;
                                ObjLoansGuarantor."Member No" := Cust."No.";
                                ObjLoansGuarantor.Name := Cust.Name;
                                ObjLoansGuarantor."Amont Guaranteed" := LoansRec."Approved Amount";
                                ObjLoansGuarantor."Employer Code" := Cust."Employer Code";
                                ObjLoansGuarantor."Employer Name" := Cust."Employer Name";
                                ObjLoansGuarantor."Loanees  No" := Cust."No.";
                                ObjLoansGuarantor."Loanees  Name" := Cust.Name;
                                ObjLoansGuarantor."Self Guarantee" := TRUE;
                                ObjLoansGuarantor."Staff/Payroll No." := Cust."Payroll No";
                                ObjLoansGuarantor.INSERT;
                            END;
                            //============================================================End Insert Guarantor
                            AuFactory.FnGenerateLoanRepaymentSchedule(LoansRec."Loan  No.");
                            //FnGenerateRepaymentSchedule(LoansRec."Loan  No.");
                            IF LoansRec.GET(LoansRec."Loan  No.") THEN
                                LoansRec.VALIDATE(LoansRec."Approved Amount");
                            LineN := LineN + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Line No." := LineN;
                            GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                            GenJournalLine."Journal Batch Name" := BATCH_NAME;
                            GenJournalLine."Document No." := DOCUMENT_NO;
                            GenJournalLine."External Document No." := LoansG."Loan No";
                            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Loan;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                            GenJournalLine."Account No." := LoansG."Member No";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := PostedOn;
                            GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                            GenJournalLine.Description := 'Defaulted Loan' + ' ' + Rec."Member Name" + ' ' + LoansG."Loan No";
                            GenJournalLine.Amount := LoansRec."Approved Amount";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Loan No" := LoansRec."Loan  No.";
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;
                            TotalToPostToLoan += GenJournalLine.Amount;
                        UNTIL LoansG.NEXT = 0;

                    LineN := LineN + 10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Line No." := LineN;
                    GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                    GenJournalLine."Journal Batch Name" := BATCH_NAME;
                    GenJournalLine."Document No." := DOCUMENT_NO;
                    GenJournalLine."External Document No." := "Loan  No.";
                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                    GenJournalLine."Account No." := "Client Code";
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := PostedOn;
                    GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                    GenJournalLine.Description := 'Defaulted Loan Attached';
                    GenJournalLine.Amount := -ROUND(TotalToPostToLoan, 0.01, '>');
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Loan No" := "Loan  No.";
                    IF GenJournalLine.Amount <> 0 THEN
                        GenJournalLine.INSERT;

                    // repay loan if guarantor has retained deposits;
                    //RepayLoanIfGuarantorHasRetainedDeposits(LoansG."Member No",LoansRec."Loan  No.",LoansRec."Approved Amount",LoansG);


                end;
            until LoansRegister.next = 0;
        end;
        // LoanDetails.Reset;
        // LoanDetails.SetRange(LoanDetails."Document No", "Document No");
        // LoanDetails.SetRange(LoanDetails."Loan No.", "Loan to Attach");
        // LoanDetails.SetRange(LoanDetails."Member No", "Member No");
        // if LoanDetails.FindSet then begin
        //     repeat
        //         LineNo := LineNo + 1000;
        //         DLoan := FnDefaulterLoansDisbursement(LoanDetails, LineNo);
        //         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
        //         GenJournalLine."Account Type"::Customer, LoanDetails."Guarantor Number", "Loan Disbursement Date", LoanDetails."Defaulter Loan", Format(LoansRec.Source::BOSA), "Loan to Attach",
        //         'Defaulter Recovery-' + "Loan to Attach", LoanDetails."Defaulter Loan No", 0);//DLoan
        //         DLoanAmount := DLoanAmount + LoanDetails."Defaulter Loan";
        //     until LoanDetails.Next = 0;
        // end;

        // if LoansRec.Get("Loan to Attach") then begin
        //     LineNo := LineNo + 10000;
        //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
        //     GenJournalLine."Account Type"::Customer, LoansRec."Client Code", "Loan Disbursement Date", DLoanAmount * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
        //     'Defaulted Loan Recovered-' + LoansRec."Loan Product Type", LoanApp."Loan  No.", 0);//Maximum no of Parameters Exceeded

        //     GenJournalLine.Init;
        //     GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
        //     GenJournalLine."Journal Batch Name" := BATCH_NAME;
        //     GenJournalLine."Document No." := DOCUMENT_NO;
        //     GenJournalLine."Line No." := LineNo;
        //     GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        //     GenJournalLine."Account No." := LoansRec."Client Code";
        //     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
        //     GenJournalLine."Loan No" := "Loan to Attach";
        //     GenJournalLine.Validate(GenJournalLine."Account No.");
        //     GenJournalLine."Posting Date" := "Loan Disbursement Date";
        //     GenJournalLine.Description := 'Defaulted Loan Recovered-' + "Loan to Attach";
        //     GenJournalLine.Validate(GenJournalLine."Currency Code");
        //     GenJournalLine.Amount := DLoanAmount * -1;
        //     GenJournalLine."External Document No." := "Loan to Attach";
        //     GenJournalLine.Validate(GenJournalLine.Amount);
        //     GenJournalLine."Recovery Transaction Type" := GenJournalLine."recovery transaction type"::"Guarantor Recoverd";
        //     GenJournalLine."Recoverd Loan" := "Loan to Attach";
        //     GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
        //     GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
        //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        //     if GenJournalLine.Amount <> 0 then
        //         GenJournalLine.Insert;
        // end;
    end;

    local procedure FnCalculateTotalInterestDue(Loans: Record "Loans Register") InterestDue: Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
    begin
        ObjRepaymentSchedule.Reset;
        ObjRepaymentSchedule.SetRange("Loan No.", Loans."Loan  No.");
        ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Rec."Loan Disbursement Date");
        if ObjRepaymentSchedule.Find('-') then
            "Loan Age" := ObjRepaymentSchedule.Count;
        Loans.CalcFields("Outstanding Balance", "Interest Paid");

        // InterestDue:=((0.01*Loans."Approved Amount"+0.01*Loans."Outstanding Balance")*Loans.Interest/12*("Loan Age"))/2-ABS(Loans."Interest Paid");
        // IF (DATE2DMY("Loan Disbursement Date",1) >15) THEN BEGIN
        // InterestDue:=((0.01*Loans."Approved Amount"+0.01*Loans."Outstanding Balance")*Loans.Interest/12*("Loan Age"+1))/2-ABS(Loans."Interest Paid");
        // END;
        InterestDue := (Loans."Outstanding Balance") * (Loans.Interest / 1200);
        InterestDue := InterestDue * 3;
        if InterestDue <= 0 then
            exit(0);
        //MESSAGE('Approved=%1 Loan Age=%2 OBalance=%3 InterestPaid=%4 InterestDue=%5',Loans."Approved Amount","Loan Age",Loans."Outstanding Balance",Loans."Interest Paid",InterestDue);
        exit(InterestDue);
    end;

    local procedure FnRunRecoverFromLoaneesFOSA(RunningBalance: Decimal; attachClosure: Boolean)
    var
        AmountToDeduct: Decimal;
        exitFee: Decimal;
        exitFeeAcc: Code[20];
        totalInterest: Decimal;
        mobileLoans: Decimal;
        totalPrincipal: Decimal;
        totalLoans: Decimal;
        Vendors: Record Vendor;
        FOSAAccount: Code[40];
        AuFactory: Codeunit "Au Factory";
        saccoGenSetup: Record "Sacco General Set-Up";
    begin
        if rec."Recover Single Loan" = true then begin

            FOSAAccount := AuFactory.FnGetAccountNumber('103', Rec."Member No");
            Vendors.Reset();
            Vendors.SetRange("No.", FOSAAccount);
            Vendors.SetRange("Account Type", '103');
            if Vendors.Find('-') then begin
                RunningBalance := Vendors.GetAvailableBalance();

                if attachClosure then begin
                    saccoGenSetup.Get();
                    exitFee := saccoGenSetup."Withdrawal Fee";
                    exitFeeAcc := saccoGenSetup."Withdrawal Fee Account";

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, FOSAAccount, Today, exitFee, 'BOSA', EXTERNAL_DOC_NO,
                    'Closure Fee Attached to ' + LoanApp."Loan Product Type" + ' Recovery', LoanApp."Loan  No.", 0);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", exitFeeAcc, Today, exitFee * -1, 'BOSA', EXTERNAL_DOC_NO,
                    'Closure Fee Attached to ' + LoanApp."Loan Product Type" + ' Recovery', LoanApp."Loan  No.", 0);

                    RunningBalance := RunningBalance - exitFee;

                    Vendors.Status := Vendors.Status::Closed;
                    Vendors."Membership Status" := Vendors."Membership Status"::Exited;
                    Vendors.Validate("Membership Status");
                    Vendors.Modify();
                end;
            end;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
            LoanApp.SetRange("Client Code", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Penalty");
                if RunningBalance > 0 then begin
                    LoanBalanceAfterDeposit := 0;
                    AmountToDeduct := 0;
                    intRecover := 0;
                    penRecover := 0;

                    if LoanApp."Outstanding Penalty" > 0 then begin
                        penRecover := LoanApp."Outstanding Penalty";
                        if penRecover > RunningBalance then begin
                            intRecover := RunningBalance;
                        end else begin
                            intRecover := penRecover;
                        end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, FOSAAccount, Today, penRecover, 'BOSA', EXTERNAL_DOC_NO,
                        LoanApp."Loan Product Type Name" + ' Penalty Recovered From FOSA' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, penRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        LoanApp."Loan Product Type Name" + ' Penalty  Recovered From FOSA', LoanApp."Loan  No.", 0);

                        RunningBalance := RunningBalance - penRecover;
                    end;

                    if LoanApp."Outstanding Interest" > 0 then begin
                        intRecover := LoanApp."Outstanding Interest";
                        if intRecover > RunningBalance then begin
                            intRecover := RunningBalance;
                        end else begin
                            intRecover := intRecover;
                        end;
                        //interest
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, FOSAAccount, Today, intRecover, 'BOSA', EXTERNAL_DOC_NO,
                        LoanApp."Loan Product Type Name" + ' Interest Recovered From FOSA' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, intRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        LoanApp."Loan Product Type Name" + ' Interest  Recovered From FOSA', LoanApp."Loan  No.", 0);

                        RunningBalance := RunningBalance - intRecover;
                    end;

                    if RunningBalance > 0 then begin
                        if LoanApp."Outstanding Balance" > 0 then begin
                            AmountToDeduct := LoanApp."Outstanding Balance";
                            if AmountToDeduct > RunningBalance then
                                AmountToDeduct := RunningBalance
                            else
                                AmountToDeduct := AmountToDeduct;

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."Account Type"::Vendor, FOSAAccount, Today, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                            'Repayment Recovered From FOSA' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                            GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                            'Repayment Recovered From FOSA', LoanApp."Loan  No.", 0);
                        end;
                    end;
                end;
            end;
        end else if rec."Recover Single Loan" = false then begin
            loanReg.Reset();
            loanReg.SetRange("Client Code", rec."Member No");
            loanReg.SetFilter(loanReg."Loans Category", '=%1|%2|%3', loanReg."Loans Category"::Substandard, loanReg."Loans Category"::Doubtful, loanReg."Loans Category"::Loss);
            loanReg.SetAutoCalcFields("Total Outstanding Balance");
            loanReg.SetFilter("Total Outstanding Balance", '>%1', 0);
            if loanReg.FindSet() then begin
                repeat
                    loanReg.CalcFields("Outstanding Balance", "Outstanding Interest", "Total Outstanding Balance");
                    totalLoans := totalLoans + loanReg."Total Outstanding Balance";
                // totalInterest:= totalInterest + loanReg."Outstanding Interest";
                // totalPrincipal:= totalPrincipal + loanReg."Outstanding Balance";
                until loanReg.Next() = 0;
            end;

            FOSAAccount := AuFactory.FnGetAccountNumber('103', Rec."Member No");
            Vendors.Reset();
            Vendors.SetRange("No.", FOSAAccount);
            Vendors.SetRange("Account Type", '103');
            if Vendors.Find('-') then begin
                RunningBalance := Vendors.GetAvailableBalance();
            end;

            if totalLoans > RunningBalance then Error('The member''s FOSA savings cannot fully recover all of their defaulted loans.');
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange("Client Code", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Loans Category", '=%1|%2|%3', LoanApp."Loans Category"::Substandard, LoanApp."Loans Category"::Doubtful, LoanApp."Loans Category"::Loss);
            LoanApp.SetAutoCalcFields("Total Outstanding Balance");
            LoanApp.SetFilter("Total Outstanding Balance", '>%1', 0);
            if LoanApp.FindSet() then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Penalty");
                    if RunningBalance > 0 then begin
                        LoanBalanceAfterDeposit := 0;
                        AmountToDeduct := 0;
                        intRecover := 0;
                        penRecover := 0;

                        if LoanApp."Outstanding Penalty" > 0 then begin
                            penRecover := LoanApp."Outstanding Penalty";
                            if penRecover > RunningBalance then begin
                                intRecover := RunningBalance;
                            end else begin
                                intRecover := penRecover;
                            end;
                            //interest
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, FOSAAccount, Today, penRecover, 'BOSA', EXTERNAL_DOC_NO,
                            LoanApp."Loan Product Type Name" + 'Penalty Recovered From FOSA' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                            GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, penRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                            LoanApp."Loan Product Type Name" + 'Penalty  Recovered From FOSA', LoanApp."Loan  No.", 0);

                            RunningBalance := RunningBalance - penRecover;
                        end;

                        if LoanApp."Outstanding Interest" > 0 then begin
                            intRecover := LoanApp."Outstanding Interest";
                            if intRecover > RunningBalance then begin
                                intRecover := RunningBalance;
                            end else begin
                                intRecover := intRecover;
                            end;
                            //interest
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, FOSAAccount, Today, intRecover, 'BOSA', EXTERNAL_DOC_NO,
                            LoanApp."Loan Product Type Name" + 'Interest Recovered From FOSA' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, intRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                            LoanApp."Loan Product Type Name" + 'Interest  Recovered From FOSA', LoanApp."Loan  No.", 0);

                            RunningBalance := RunningBalance - intRecover;
                        end;

                        if RunningBalance > 0 then begin
                            if LoanApp."Outstanding Balance" > 0 then begin
                                AmountToDeduct := LoanApp."Outstanding Balance";
                                if AmountToDeduct > RunningBalance then
                                    AmountToDeduct := RunningBalance
                                else
                                    AmountToDeduct := AmountToDeduct;

                                //"Principal Repayment"
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."Account Type"::Vendor, FOSAAccount, Today, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                                'Repayment Recovered From FOSA' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                'Repayment Recovered From FOSA', LoanApp."Loan  No.", 0);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
        end;
        Message('Transaction Posted Successfully');
    end;

    local procedure FnRunRecoverFromLoaneesDeposits(RunningBalance: Decimal; attachClosure: Boolean)
    var
        AmountToDeduct: Decimal;
        exitFee: Decimal;
        exitFeeAcc: Code[20];
        totalInterest: Decimal;
        mobileLoans: Decimal;
        totalPrincipal: Decimal;
        totalLoans: Decimal;
        Vendors: Record Vendor;
        FOSAAccount: Code[40];
        AuFactory: Codeunit "Au Factory";
        saccoGenSetup: Record "Sacco General Set-Up";
    begin
        if rec."Recover Single Loan" = true then begin

            FOSAAccount := AuFactory.FnGetAccountNumber('102', Rec."Member No");
            Vendors.Reset();
            Vendors.SetRange("No.", FOSAAccount);
            Vendors.SetRange("Account Type", '102');
            if Vendors.Find('-') then begin
                Vendors.CalcFields(Balance);
                RunningBalance := Vendors.Balance;

                if attachClosure then begin
                    saccoGenSetup.Get();
                    exitFee := saccoGenSetup."Withdrawal Fee";
                    exitFeeAcc := saccoGenSetup."Withdrawal Fee Account";

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, FOSAAccount, Today, exitFee, 'BOSA', EXTERNAL_DOC_NO,
                    'Closure Fee Attached to ' + LoanApp."Loan Product Type" + ' Recovery', LoanApp."Loan  No.", 0);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", exitFeeAcc, Today, exitFee * -1, 'BOSA', EXTERNAL_DOC_NO,
                    'Closure Fee Attached to ' + LoanApp."Loan Product Type" + ' Recovery', LoanApp."Loan  No.", 0);

                    RunningBalance := RunningBalance - exitFee;

                    Vendors.Status := Vendors.Status::Closed;
                    Vendors."Membership Status" := Vendors."Membership Status"::Exited;
                    Vendors.Validate("Membership Status");
                    Vendors.Modify();
                end;
            end;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
            LoanApp.SetRange("Client Code", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Penalty");
                if RunningBalance > 0 then begin
                    LoanBalanceAfterDeposit := 0;
                    AmountToDeduct := 0;
                    intRecover := 0;
                    penRecover := 0;

                    if LoanApp."Outstanding Penalty" > 0 then begin
                        penRecover := LoanApp."Outstanding Penalty";
                        if penRecover > RunningBalance then begin
                            intRecover := RunningBalance;
                        end else begin
                            intRecover := penRecover;
                        end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, FOSAAccount, Today, penRecover, 'BOSA', EXTERNAL_DOC_NO,
                        LoanApp."Loan Product Type Name" + ' Penalty Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, penRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        LoanApp."Loan Product Type Name" + ' Penalty  Recovered From Deposits', LoanApp."Loan  No.", 0);

                        RunningBalance := RunningBalance - penRecover;
                    end;

                    if LoanApp."Outstanding Interest" > 0 then begin
                        intRecover := LoanApp."Outstanding Interest";
                        if intRecover > RunningBalance then begin
                            intRecover := RunningBalance;
                        end else begin
                            intRecover := intRecover;
                        end;
                        //interest
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, FOSAAccount, Today, intRecover, 'BOSA', EXTERNAL_DOC_NO,
                        LoanApp."Loan Product Type Name" + ' Interest Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, intRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        LoanApp."Loan Product Type Name" + ' Interest  Recovered From Deposits', LoanApp."Loan  No.", 0);

                        RunningBalance := RunningBalance - intRecover;
                    end;

                    if RunningBalance > 0 then begin
                        if LoanApp."Outstanding Balance" > 0 then begin
                            AmountToDeduct := LoanApp."Outstanding Balance";
                            if AmountToDeduct > RunningBalance then
                                AmountToDeduct := RunningBalance
                            else
                                AmountToDeduct := AmountToDeduct;

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."Account Type"::Vendor, FOSAAccount, Today, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                            'Repayment Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                            GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                            'Repayment Recovered From Deposits', LoanApp."Loan  No.", 0);
                        end;
                    end;
                end;
            end;
        end else if rec."Recover Single Loan" = false then begin
            loanReg.Reset();
            loanReg.SetRange("Client Code", rec."Member No");
            loanReg.SetFilter(loanReg."Loans Category", '=%1|%2|%3', loanReg."Loans Category"::Substandard, loanReg."Loans Category"::Doubtful, loanReg."Loans Category"::Loss);
            loanReg.SetAutoCalcFields("Total Outstanding Balance");
            loanReg.SetFilter("Total Outstanding Balance", '>%1', 0);
            if loanReg.FindSet() then begin
                repeat
                    loanReg.CalcFields("Outstanding Balance", "Outstanding Interest", "Total Outstanding Balance");
                    totalLoans := totalLoans + loanReg."Total Outstanding Balance";
                // totalInterest:= totalInterest + loanReg."Outstanding Interest";
                // totalPrincipal:= totalPrincipal + loanReg."Outstanding Balance";
                until loanReg.Next() = 0;
            end;

            FOSAAccount := AuFactory.FnGetAccountNumber('102', Rec."Member No");
            Vendors.Reset();
            Vendors.SetRange("No.", FOSAAccount);
            Vendors.SetRange("Account Type", '102');
            if Vendors.Find('-') then begin
                Vendors.CalcFields(Balance);
                RunningBalance := Vendors.Balance;
            end;

            if totalLoans > RunningBalance then Error('The member''s deposits cannot fully recover all of their defaulted loans.');
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange("Client Code", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Loans Category", '=%1|%2|%3', LoanApp."Loans Category"::Substandard, LoanApp."Loans Category"::Doubtful, LoanApp."Loans Category"::Loss);
            LoanApp.SetAutoCalcFields("Total Outstanding Balance");
            LoanApp.SetFilter("Total Outstanding Balance", '>%1', 0);
            if LoanApp.FindSet() then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Penalty");
                    if RunningBalance > 0 then begin
                        LoanBalanceAfterDeposit := 0;
                        AmountToDeduct := 0;
                        intRecover := 0;
                        penRecover := 0;

                        if LoanApp."Outstanding Penalty" > 0 then begin
                            penRecover := LoanApp."Outstanding Penalty";
                            if penRecover > RunningBalance then begin
                                intRecover := RunningBalance;
                            end else begin
                                intRecover := penRecover;
                            end;
                            //interest
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, FOSAAccount, Today, penRecover, 'BOSA', EXTERNAL_DOC_NO,
                            LoanApp."Loan Product Type Name" + 'Penalty Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                            GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, penRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                            LoanApp."Loan Product Type Name" + 'Penalty  Recovered From Deposits', LoanApp."Loan  No.", 0);

                            RunningBalance := RunningBalance - penRecover;
                        end;

                        if LoanApp."Outstanding Interest" > 0 then begin
                            intRecover := LoanApp."Outstanding Interest";
                            if intRecover > RunningBalance then begin
                                intRecover := RunningBalance;
                            end else begin
                                intRecover := intRecover;
                            end;
                            //interest
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, FOSAAccount, Today, intRecover, 'BOSA', EXTERNAL_DOC_NO,
                            LoanApp."Loan Product Type Name" + 'Interest Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, intRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                            LoanApp."Loan Product Type Name" + 'Interest  Recovered From Deposits', LoanApp."Loan  No.", 0);

                            RunningBalance := RunningBalance - intRecover;
                        end;

                        if RunningBalance > 0 then begin
                            if LoanApp."Outstanding Balance" > 0 then begin
                                AmountToDeduct := LoanApp."Outstanding Balance";
                                if AmountToDeduct > RunningBalance then
                                    AmountToDeduct := RunningBalance
                                else
                                    AmountToDeduct := AmountToDeduct;

                                //"Principal Repayment"
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."Account Type"::Vendor, FOSAAccount, Today, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                                'Repayment Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Today, AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                'Repayment Recovered From Deposits', LoanApp."Loan  No.", 0);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
        end;
        Message('Transaction Posted Successfully');
    end;

    local procedure FnRunRecoverFromGuarantorsDeposits(VarDocumentNo: Code[20]; VarLoanNo: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date) Success: Boolean
    var
        FOSAAccount: Code[40];
        AuFactory: Codeunit "Au Factory";
        depositsDeducted: Decimal;
        intPaid: Decimal;
        princPaid: Decimal;
        totalDepPaid: Decimal;
        loans: Record "Loans Register";
        loanGuar: Record "Loans Guarantee Details";
    begin
        totalDepPaid := 0;
        // Message('Here');
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange("Document No", VarDocumentNo);
        ObjLoanGuarantors.SetFilter("Guarantor Amount Apportioned", '>%1', 0);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                // Error('%1');
                depositsDeducted := 0;
                intPaid := 0;
                princPaid := 0;
                FOSAAccount := AuFactory.FnGetAccountNumber('102', ObjLoanGuarantors."Guarantor Number");
                vend.Reset();
                Vend.SetRange("No.", FOSAAccount);
                if vend.Find('-') then begin
                    vend.CalcFields(Balance);
                    if ObjLoanGuarantors."Guarantor Amount Apportioned" > vend.Balance then begin
                        depositsDeducted := vend.Balance;
                    end else
                        depositsDeducted := ObjLoanGuarantors."Guarantor Amount Apportioned";

                    if loans.Get(VarLoanNo) then begin
                        loans.CalcFields("Outstanding Interest", "Outstanding Balance", "Outstanding Penalty");
                        // if loans."Outstanding Interest" > 0 then begin
                        //     intPaid := loans."Outstanding Interest";
                        //     if intPaid > depositsDeducted then begin
                        //         intPaid := intPaid;
                        //     end else intPaid := depositsDeducted;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."Account Type"::Vendor, FOSAAccount, VarPostingDate, ObjLoanGuarantors."Interest Liability", 'BOSA', EXTERNAL_DOC_NO,
                        'Defaulted Guaranteed ' + ObjLoanGuarantors."Loan Type" + ' Recovery' + '-' + VarMemberNo + '(Interest)', EXTERNAL_DOC_NO, GenJournalLine."Application Source"::" ");

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, VarMemberNo, VarPostingDate, ObjLoanGuarantors."Interest Liability" * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Interest Recovered From Guarantor Deposits_' + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                        // end;
                        // if loans."Outstanding Balance" > 0 then begin
                        //     princPaid := loans."Outstanding Balance";
                        //     if princPaid > (depositsDeducted-intPaid) then begin
                        //         princPaid := princPaid;
                        //     end else princPaid := (depositsDeducted-intPaid);

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."Account Type"::Vendor, FOSAAccount, VarPostingDate, ObjLoanGuarantors."Principal Liability", 'BOSA', EXTERNAL_DOC_NO,
                        'Defaulted Guaranteed ' + ObjLoanGuarantors."Loan Type" + ' Recovery' + '-' + VarMemberNo, EXTERNAL_DOC_NO, GenJournalLine."Application Source"::" ");

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                        GenJournalLine."Account Type"::Customer, VarMemberNo, VarPostingDate, ObjLoanGuarantors."Principal Liability" * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Repayment Recovered From Guarantor Deposits_' + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                        // end;
                    end
                end;

                loanGuar.Reset();
                loanGuar.SetRange("Loan No", VarLoanNo);
                loanGuar.SetRange("Member No", ObjLoanGuarantors."Guarantor Number");
                if loanGuar.Find('-') then begin
                    if ObjLoanGuarantors.Difference > 0 then begin
                        loanGuar."Fully Recovered" := false;
                        loanGuar."Amount Recovered" := LoanDetails."Guarantor Amount Apportioned";
                        loanGuar.Modify();
                    end else begin
                        loanGuar."Fully Recovered" := true;
                        loanGuar."Amount Recovered" := LoanDetails."Guarantor Amount Apportioned";
                        loanGuar.Modify();
                    end;

                end;

                totalDepPaid := totalDepPaid + depositsDeducted;
            until ObjLoanGuarantors.Next = 0;

            if loans.Get(VarLoanNo) then begin
                loans."Recovered From Guarantor" := true;
                loans."Recovered Guarantor Amount" := totalDepPaid;
                loans.Modify;
            end;
            Success := true;
        end else
            Success := false;
    end;

    local procedure FnRunPostMemberDepositstoLSA(VarDocumentNo: Code[30]; VarPostingDate: Date; VarLoanNo: Code[30])
    var
        GuarantorName: Text[100];
        VarAmounttoRecover: Decimal;
    begin
        if ObjCust.Get(Rec."Member No") then begin
            ObjCust.CalcFields(ObjCust."Current Shares");
            if ObjCust."Current Shares" < LoanApp."Outstanding Balance" then
                Error('The Deposits Recovered Amount specified is more than the Available Member Deposits');

            //--------------------------------(Credit LSA Account)-------------------------------------------------------------------------------
            /* LineNo:=LineNo+10000;
             SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
             GenJournalLine."Account Type"::Vendor,"Settlement Account",VarPostingDate, LoanApp."Outstanding Balance"*-1,'BOSA',EXTERNAL_DOC_NO,
             'Loan Recovered: '+"Member Name"+' - '+VarLoanNo,VarLoanNo,GenJournalLine."Recovery Transaction Type"::"Guarantor Recoverd",VarLoanNo);*/

            //--------------------------------(Debit Guarantor Account)-------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Vendor, ObjCust."Deposits Account No", VarPostingDate, LoanApp."Outstanding Balance", 'BOSA', EXTERNAL_DOC_NO,
            'Loan Recovered: ' + Rec."Member Name" + ' - ' + VarLoanNo, VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);


            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
            end;
        end;

    end;

    local procedure FnAttachToGuarantorLoans()
    var
        DLoanAmount: Decimal;
    begin
        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Loan No", LoanApp."Loan  No.");
        if LoanGuar.Find('-') then begin
            LoanGuar.Reset;
            LoanGuar.SetRange(LoanGuar."Loan No", LoanApp."Loan  No.");
            repeat
                TGrAmount := TGrAmount + GrAmount;
                GrAmount := LoanGuar."Amont Guaranteed";
                FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
            until LoanGuar.Next = 0;
        end;

        //Defaulter loan clear
        LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Interest Due");
        Lbal := ROUND(LoanApp."Outstanding Balance", 1, '=');
        if LoanApp."Interest Due" > 0 then begin
            INTBAL := ROUND(LoanApp."Interest Due", 1, '=');
            COMM := ROUND((LoanApp."Interest Due" * 0.5), 1, '=');
            LoanApp."Attached Amount" := Lbal;
            LoanApp.PenaltyAttached := COMM;
            LoanApp.InDueAttached := INTBAL;
            Rec.Modify;
        end;

        Attached := true;
        //MESSAGE('BALANCE %1',Lbal);
        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'general';
        GenJournalLine."Journal Batch Name" := 'LNAttach';
        GenJournalLine."Document No." := LoanApp."Loan  No.";
        GenJournalLine."External Document No." := LoanApp."Loan  No.";
        GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := Rec."FOSA Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine.Description := 'Def Loan' + Rec."FOSA Account No";
        GenJournalLine.Amount := -Lbal;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Loan No" := LoanApp."Loan  No.";
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        "LN Doc" := LoanApp."Loan  No.";
        // int due
        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'general';
        GenJournalLine."Journal Batch Name" := 'LNAttach';
        GenJournalLine."Document No." := LoanApp."Loan  No.";
        GenJournalLine."External Document No." := LoanApp."Loan  No.";
        GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Insurance Paid";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := Rec."FOSA Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Description := 'Defaulted Loan int' + ' ';
        GenJournalLine.Amount := -INTBAL;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Loan No" := LoanApp."Loan  No.";
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //commisision

        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'general';
        GenJournalLine."Journal Batch Name" := 'LNAttach';
        GenJournalLine."Document No." := LoanApp."Loan  No.";
        GenJournalLine."External Document No." := LoanApp."Loan  No.";
        GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
        GenJournalLine."Account No." := '100002';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine.Description := 'Penalty' + ' ';
        GenJournalLine.Amount := -COMM;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Loan No" := LoanApp."Loan  No.";
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;




        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Loan No", LoanApp."Loan  No.");
        if LoanGuar.Find('-') then begin
            LoanGuar.Reset;
            LoanGuar.SetRange(LoanGuar."Loan No", LoanApp."Loan  No.");
            DLN := 'DLN';
            repeat
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Client Code", LoanGuar."Member No");
                LoanApp.SetRange(LoanApp."Loan Product Type", '16');
                if LoanApp.Find('-') then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    if LoanApp."Outstanding Balance" = 0 then
                        LoanApp.DeleteAll;
                end;

                GenSetUp.Get();
                GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                GenSetUp.Modify;
                DLN := 'DLN' + Format(GenSetUp."Defaulter LN");
                TGrAmount := TGrAmount + GrAmount;
                GrAmount := LoanGuar."Amont Guaranteed";
                //MESSAGE('guarnteed Amount %1',FGrAmount);

                ////Insert Journal Lines
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'general';
                GenJournalLine."Journal Batch Name" := 'LNAttach';
                GenJournalLine."Document No." := "LN Doc";
                GenJournalLine."External Document No." := "LN Doc";
                GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                GenJournalLine."Account No." := LoanGuar."Member No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine.Description := 'Defaulted Loan' + ' ';
                GenJournalLine.Amount := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Loan No" := DLN;
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                if loanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanApp.Init;
                    LoanApp."Loan  No." := DLN;
                    LoanApp."Client Code" := LoanGuar."Member No";
                    LoanApp."Loan Product Type" := '16';
                    LoanApp."Loan Status" := LoanApp."loan status"::Disbursed;
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", LoanGuar."Member No");
                    if Cust.Find('-') then begin
                        LoanApp."Client Name" := Cust.Name;
                    end;
                    LoanApp."Application Date" := Today;
                    LoanApp."Issued Date" := Today;
                    LoanApp.Installments := loanTypes."No of Installment";
                    LoanApp.Repayment := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM)) / loanTypes."No of Installment";
                    LoanApp."Requested Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                    LoanApp."Approved Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                    LoanApp.Posted := true;
                    LoanApp."Advice Date" := Today;
                    LoanApp.Insert;
                    //MESSAGE('guarnteed Amount %1',"Loans Register"."Requested Amount");
                end;
            until LoanGuar.Next = 0;
        end;
        LoanApp.Posted := true;
        LoanApp."Attachement Date" := Today;
        Rec.Modify;
    end;

    local procedure FnAdjustDeficitLiability()
    var
        myInt: Integer;
        totalDiff: Decimal;
        apportionedDiff: Decimal;
        runningDiff: Decimal;
        loanGuarMembers: Record "Loan Member Loans";
    begin
        totalDiff := 0;
        apportionedDiff := 0;
        runningDiff := 0;
        ObjLoanGuarantors.Reset();
        ObjLoanGuarantors.SetRange("Document No", Rec."Document No");
        if ObjLoanGuarantors.FindSet() then begin
            ObjLoanGuarantors.CalcSums(Difference);
            totalDiff := ObjLoanGuarantors.Difference;
            runningDiff := ObjLoanGuarantors.Difference;
        end;

        if totalDiff > 0 then begin
            ObjLoanGuarantors.Reset();
            ObjLoanGuarantors.SetRange("Document No", Rec."Document No");
            if ObjLoanGuarantors.findSet() then begin
                repeat
                    if (ObjLoanGuarantors.Difference = 0) and (runningDiff > 0) then begin
                        apportionedDiff := ObjLoanGuarantors."Amont Guaranteed" - ObjLoanGuarantors."Guarantor Amount Apportioned";
                        if apportionedDiff >= totalDiff then begin
                            apportionedDiff := totalDiff;
                            ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Guarantor Amount Apportioned" + apportionedDiff;
                            ObjLoanGuarantors.modify;
                        end else begin
                            apportionedDiff := apportionedDiff;
                            ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Guarantor Amount Apportioned" + apportionedDiff;
                            ObjLoanGuarantors.modify;
                        end;
                        runningDiff := runningDiff - apportionedDiff;
                    end;
                until ObjLoanGuarantors.Next() = 0;
            end;
        end;
    end;
}


