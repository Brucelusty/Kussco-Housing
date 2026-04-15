Page 50125 "Membership Exit Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exist";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Notice No"; Rec."Notice No")
                {
                    // Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    //Editable = MNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Interview Done?"; Rec."Interview Done?") { }
                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Application Date';
                    //Editable = ClosingDateEditable;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    Caption = 'Maturity Date';
                }

                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    Caption = 'Reason For Exit';
                    // Editable = ClosureTypeEditable;
                }
                field("Total Loan"; Rec."Total Loan")
                {
                    //Caption = 'Total Loan BOSA';
                    Editable = false;
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    // Caption = 'Total Interest Due BOSA';
                    Editable = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    Editable = false;
                }
                field(SchoolFeesShares;Rec.SchoolFeesShares)
                {
                    Editable = false;
                }
                field("Total FOSA Account"; Rec."Total FOSA Account")
                {
                    Editable = false;
                    Caption = 'FOSA Account Balance';
                }

                field("Total Account Amount"; Rec."Total Account Amount")
                {
                    Editable = false;
                }
                field("Exit Batch No."; Rec."Exit Batch No.")
                {
                    Editable = (((rec."Loans Cleared") and (rec."Guarantorship Cleared")) or (rec."Deposits Paid"));
                    // and (rec.Status <> rec.Status::Approved);
                }
                field("Exit Notice Date";Rec."Exit Notice Date")
                {
                    Editable = false;
                }
                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                    Editable = false;
                }
                field("Amount To Disburse"; Rec."Amount To Disburse")
                {
                }
                field("Paying Bank"; Rec."Paying Bank")
                {
                    Visible = true;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Visible = false;
                }
                field(Payee; rec.Payee)
                {
                    Visible = false;
                }

                field("Member Savings"; Rec."Member Savings")
                {
                    Visible = false;
                }

            }
            group("Share Capital Transfer Details")
            {
                Caption = 'Share Capital Transfer Details';
                //Visible = ShareCapitalTransferVisible;
                field("Share Capital Transfer Fee"; Rec."Share Capital Transfer Fee")
                {
                    Editable = false;
                }
            }
            part("Share Capital Sell"; "Share Capital Sell")
            {
                SubPageLink = "Document No" = field("No."),
                              "Selling Member No" = field("Member No."),
                              "Selling Member Name" = field("Member Name");
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(PostLoan)
                {
                    Caption = 'Loan Recovery';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = not rec."Loans Cleared";
                    Visible = not (rec."Closure Type" = rec."Closure Type"::Death);

                    trigger OnAction()
                    var
                        Notice: Record "Withdrawal Notice";
                        exitRecov: Codeunit "Exit Recovery";
                    begin
                        rec.TestField(Posted, false);
                        
                        //TestField(Status, Status::Approved);
                        if Confirm('Are you absolutely sure you want to recover the loans from member deposit.', true) = false then exit;

                        if rec."Closure Type" <> rec."Closure Type"::Death then begin
                            rec."Loans Cleared" := exitRecov.RecoverLoans(rec."Member No.", rec."Loan Balance");
                            rec.modify;
                        end;

                        // WithdrawalFee := 0;
                        // TransferFee := 0;
                        // RunningBal := 0;
                        // PayableAmount := 0;
                        // WithdrawableCharge := 0;
                        // WatotoCharge := 0;
                        // TotalChequeCharge := 0;
                        // if cust.Get(rec."Member No.") then begin
                        //     if rec."Net Payable to the Member" < 0 then
                        //         // ERROR('The Member Does have enough Deposits to Clear Loans');

                        //         //-----------------------------------------Assign Standard variables-------------------------------------------------------------
                        //         DActivity := cust."Global Dimension 1 Code";
                        //     DBranch := cust."Global Dimension 2 Code";


                        //     if (rec."Total Loan" + Rec."Total Interest") > Rec."Total Account Amount" then
                        //         Error('Account amounts must not be less than liabilities.');
                        //     Generalsetup.Get();
                        //     ChequeCharge := Generalsetup."Loan Trasfer Fee-Cheque";
                        //     ChequeChargeGL := Generalsetup."Loan Trasfer Fee A/C-Cheque";
                        //     //TotalChequeCharge:=ChequeCharge*"No of Cheques";
                        //     WithdrawalFee := Generalsetup."Withdrawal Fee";
                        //     WithFeeGL := Generalsetup."Withdrawal Fee Account";
                        //     //ExciseGL:=Generalsetup."Excise Duty Account";

                        //     if rec."Sell Share Capital" then begin
                        //         TransferFee := Generalsetup."Share Capital Transfer Fee";
                        //         TransferGL := Generalsetup."Share Capital Transfer Fee Acc";
                        //     end;


                        //     //------------------------------------------Assign Standard variables-----------------------------------------------------------------

                        //     //------------------------------------------Delete Journal Lines----------------------------------------------------------------------

                        //     BATCH_TEMPLATE := 'GENERAL';
                        //     BATCH_NAME := 'CLOSURE';
                        //     DOCUMENT_NO := Rec."No.";
                        //     Gnljnline.Reset;
                        //     Gnljnline.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        //     Gnljnline.SetRange("Journal Batch Name", BATCH_NAME);
                        //     Gnljnline.DeleteAll;
                        //     //------------------------------------------Post Transaction---------------------------------------------------------------------------
                        //     if (rec."Closure Type" <> rec."closure type"::Voluntary) then //OR ("Closure Type"="Closure Type"::"Withdrawal - Death") THEN
                        //       begin
                        //         FnPostAmountsToFOSA(Rec."Member No.");
                        //         RunningBal := Rec."Total Account Amount";
                        //         FnPostSavingsCharge(Rec."Member No.");
                        //         FnRecoverBOSAInterest(Rec."Member No.");
                        //         FnRecoverBOSALoanPrinciple(Rec."Member No.");
                        //         // PayableAmount := rec."Member Deposits" + rec.Dependand1 + rec.dependand2 + rec.dependand3 + rec.PrdOverdeduction + rec.utafitihousing + rec.holidaysaving - (rec."Total Loan" + rec."Total Interest" + TotalChequeCharge + WithdrawableCharge);



                        //         //----------------------------------------Post Transaction----------------------------------------------------------------------------
                        //     end else
                        //         if (rec."Closure Type" = rec."closure type"::Death) then begin
                        //             FnPostAmountsToFOSA(Rec."Member No.");
                        //             FnPostAmountsToFOSADeath(Rec."Member No.");
                        //             FnRecoverBOSAInterestDeath();
                        //             FnRecoverBOSALoanPrincipleDeath();
                        //         end;
                        // end;


                        // //FNPostShareCapTransfer();


                        // // //Post New
                        // GenJournalLine.Reset;
                        // GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        // GenJournalLine.SetRange("Journal Batch Name", 'CLOSURE');
                        // if GenJournalLine.Find('-') then begin
                        //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        // end;


                        // rec."Application Date" := Today;
                        // rec.Posted := true;
                        // Message('Closure posted successfully.');


                        // //CHANGE ACCOUNT STATUS

                        // if (rec."Closure Type" = rec."closure type"::Death) then begin
                        //     cust.Reset;
                        //     cust.SetRange(cust."No.", rec."Member No.");
                        //     if cust.Find('-') then begin
                        //         cust."Membership Status" := cust."Membership Status"::Deceased;
                        //         cust."Closing Date" := Today;
                        //         //cust.Blocked := cust.Blocked::All;
                        //         cust.Modify;
                        //     end;
                        // end else
                        //     cust.Reset;
                        // cust.SetRange(cust."No.", rec."Member No.");
                        // if cust.Find('-') then begin
                        //     cust."Membership Status" := cust."Membership Status"::Exited;
                        //     cust."Closing Date" := Today;
                        //     cust."Withdrawal Date" := Today;
                        //     //cust.Blocked := cust.Blocked::All;
                        //     cust.Modify;
                        // end;
                        // Notice.Reset();
                        // Notice.SetRange(Notice."No.", Rec."Notice No");
                        // if Notice.FindFirst() then begin
                        //     Notice.Converted := true;
                        //     Notice.Modify();
                        // end;

                        // CurrPage.Close();
                    end;
                }
                action(PostGuar)
                {
                    Caption = 'Guarantorship';
                    Image = CheckLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = (not Rec."Guarantorship Cleared") and (rec."Loans Cleared");
                    Visible = not (rec."Closure Type" = rec."Closure Type"::Death);

                    trigger OnAction()
                    var
                        Notice: Record "Withdrawal Notice";
                        exitRecov: Codeunit "Exit Recovery";
                    begin
                        rec.TestField(Posted, false);

                        if rec."Closure Type" <> rec."Closure Type"::Death then begin
                            rec."Guarantorship Cleared":= exitRecov.checkGuarantorship(Rec."Member No.");
                            rec.modify;
                        end;
                    end;
                }
                action(DeptoFOSA)
                {
                    Caption = 'Capture Death';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = rec."Closure Type" = rec."Closure Type"::Death;
                    Visible = (rec."Closure Type" = rec."Closure Type"::Death);

                    trigger OnAction()
                    var
                        Notice: Record "Withdrawal Notice";
                        exitRecov: Codeunit "Exit Recovery";
                    begin
                        rec.TestField(Posted, false);
                        
                        rec."Deposits Paid":= true;
                        rec.modify;

                        if cust.Get(rec."Member No.") then begin
                            cust."Membership Status":= cust."Membership Status"::Deceased;
                            cust.Status:= cust.Status::Deceased;
                            cust.modify;
                            vend.Reset();
                            vend.SetRange("BOSA Account No", rec."Member No.");
                            if vend.Find('-') then begin
                                repeat
                                    vend.Status:= vend.Status::Deceased;
                                    vend."Membership Status":= vend."Membership Status"::Deceased;
                                    vend.modify;
                                until vend.Next() = 0;
                            end;
                        end;
                    end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    // Visible=false;

                    trigger OnAction()
                    var
                        text001: label 'This exit is not open';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        rec.TestField("Notice No");
                        rec.TestField("Interview Done?");
                        rec.TestField("Amount To Disburse");
                        IF Rec.Status <> Rec.Status::Open THEN ERROR(text001);

                        if ApprovalsMgmt.CheckMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMWithdrawalForApproval(Rec);

                        //Change Status To Awaiting Withdrawing
                        GenSetUp.Get();

                        // if Generalsetup."Send Membership Withdrawal SMS" = true then begin
                        //     FnSendWithdrawalApplicationSMS();
                        // end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel A&pproval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    // Visible = false;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        if ApprovalMgt.IsMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            ApprovalMgt.OnCancelMWithdrawalApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approval Entry';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    // Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalDoc: Enum "Approval Document Type";
                    begin
                        //  ApprovalsMgmt.OpenApprovalEntriesPage(RecordId);
                        ApprovalEntries.SetRecordFilters(Database::"Membership Exist", approvalDoc::MembershipWithdrawal, Rec."No.");
                    end;
                }
                action("Account closure Slip")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible=false;

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", rec."Member No.");
                        if cust.Find('-') then
                            Report.Run(172474, true, false, cust);
                    end;
                }
                action("Print Cheque")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        ClosureR.RESET;
                        ClosureR.SETRANGE(ClosureR."Member No.","Member No.");
                        IF ClosureR.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,ClosureR);
                        */

                    end;
                }
                action("Exit Slip")
                {
                    Promoted = true;
                    Image = DepositSlip;
                    PromotedCategory = Report;
                    Caption = 'ExitSlip';
                    trigger OnAction()
                    var
                       withdrawal: Record "Membership Exist";
                    begin
                        // Rec.TestField(Posted);
                        withdrawal.Reset();
                        withdrawal.SetRange("No.", rec."No.");
                        withdrawal.SetRange("Member No.", rec."Member No.");
                        if withdrawal.Find('-') then begin
                            Report.run(173053,true,true,withdrawal);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        //OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
    end;

    trigger OnAfterGetRecord()
    var
    Vend: Record Vendor;

    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        if rec."Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        //"Mode Of Disbursement":="Mode Of Disbursement"::Vendor;
        //MODIFY;
        UpdateControl();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnOpenPage()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        PostingDateEditable := false;
        if rec."Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        rec."Mode Of Disbursement" := rec."mode of disbursement"::"FOSA Account";
        UpdateControl();
    end;

    var
        Closure: Integer;
        Text001: label 'Not Approved';
        cust: Record Customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        PostingDateEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];

        Guarantor: Record "Loans Guarantee Details";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exist";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        PTEN: Text;
        //DataSheet: Record "Checkoff Advice Register";
        Customer: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ShareCapitalTransferVisible: Boolean;
        ShareCapSellPageVisible: Boolean;
        ObjShareCapSell: Record "Share Capital Sell";
        SurestepFactory: Codeunit "Au Factory";
        JVTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        JVAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        TemplateName: Code[20];
        BatchName: Code[20];
        JVBalAccounttype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JVBalAccountNo: Code[20];
        TransferFee: Decimal;
        WithdrawalFee: Decimal;
        TransferGL: Code[20];
        WithFeeGL: Code[20];
        ExciseGL: Code[20];
        RunningBal: Decimal;
        EnabledApprovalWorkflowsExist: Boolean;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        SFactory: Codeunit "SURESTEP FactoryMobile";

        BATCH_TEMPLATE: Code[60];
        BATCH_NAME: Code[80];
        DOCUMENT_NO: Code[40];
        EventFilter: Text;
        OpenApprovalEntriesExist: Boolean;
        // MWithdrawalGraduatedCharges: Record "MWithdrawal Graduated Charges";
        MemberRegister: Record Customer;
        ChequeCharge: Decimal;
        ChequeChargeGL: Code[10];
        PayableAmount: Decimal;
        WatotoCharge: Decimal;
        WithdrawableCharge: Decimal;
        PayWatoto: Decimal;
        PayHSS: Decimal;
        TotalChequeCharge: Decimal;


    procedure UpdateControl()
    begin
        if rec.Status = rec.Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            ClosureTypeEditable := true;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            ClosureTypeEditable := false;
            PostingDateEditable := true;
        end;
    end;


    procedure FnSendWithdrawalApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := rec."No.";
        SMSMessage."Document No" := rec."No.";
        SMSMessage."Account No" := rec."Member No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBERSHIPWITH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Membership Withdrawal Application has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        cust.Reset;
        cust.SetRange(cust."No.", rec."Member No.");
        if cust.Find('-') then begin
            SMSMessage."Telephone No" := cust."Mobile Phone No";
        end;
        if cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FNPostShareCapTransfer()
    begin

        JVTransactionType := Jvtransactiontype::"Share Capital";
        JVAccountType := Jvaccounttype::Member;
        TemplateName := 'GENERAL';
        BatchName := 'CLOSURE';

        //Credit Buyer Account
        ObjShareCapSell.Reset;
        ObjShareCapSell.SetRange(ObjShareCapSell."Document No", rec."No.");
        if ObjShareCapSell.FindSet then begin
            repeat
                LineNo := LineNo + 10000;
                SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::"Share Capital",
                GenJournalLine."account type"::Vendor, ObjShareCapSell."Buyer Share Capital Account", WorkDate,
                (ObjShareCapSell.Amount * -1), 'BOSA', rec."No.", 'Share Capital Purchase From ' + Format(ObjShareCapSell."Selling Member No"), '', GenJournalLine."application source"::" ");
            // VarBuyerMemberNos := VarBuyerMemberNos + ObjShareCapSell."Buyer Member No" + ', ';
            until ObjShareCapSell.Next = 0;
        end;

        LineNo := LineNo + 10000;
        //=========================================================================================================Debit Seller Account
        rec.CalcFields("Share Capital to Sell");
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::"Share Capital",
        GenJournalLine."account type"::Vendor, rec."Seller Share Capital Account", WorkDate,
            (rec."Share Capital to Sell"), 'BOSA', rec."No.", 'Share Capital Sell to ' + ObjShareCapSell."Buyer Share Capital Account", '', GenJournalLine."application source"::" ");


        LineNo := LineNo + 10000;
        //Post Transfer Fee
        Generalsetup.Get();
        JVBalAccounttype := Jvbalaccounttype::"G/L Account";
        JVBalAccountNo := Generalsetup."Share Capital Transfer Fee Acc";
        JVTransactionType := Jvtransactiontype::"Deposit Contribution";

        SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, rec."No.", LineNo, JVTransactionType, JVAccountType, rec."Member No.", rec."Application Date"
        , 'Transfer Fee_' + Format(rec."No."), JVBalAccounttype, JVBalAccountNo, (rec."Share Capital Transfer Fee"), 'BOSA', '');
        //Post JV

        LineNo := LineNo + 10000;
        //Post Transfer Fee Excise Duty
        Generalsetup.Get();
        JVBalAccounttype := Jvbalaccounttype::"G/L Account";
        JVBalAccountNo := Generalsetup."Excise Duty Account";
        JVTransactionType := Jvtransactiontype::"Deposit Contribution";

        SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, rec."No.", LineNo, JVTransactionType, JVAccountType, rec."Member No.", rec."Application Date"
        , 'Transfer Fee Excise_' + Format(rec."No."), JVBalAccounttype, JVBalAccountNo, (rec."Share Capital Transfer Fee" * (Generalsetup."Excise Duty(%)" / 100)), 'BOSA', '');
        //Post Transfer Fee Excise Duty

        //SurestepFactory.FnPostGnlJournalLine(TemplateName,BatchName);
    end;

    local procedure FnPostChequeCharge(Bal: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin

        /*IF( (Bal>0) AND ("Maturity Date"<"Expected Posting Date")) THEN
          BEGIN
           IF("Maturity Date"<"Expected Posting Date") THEN
              AmountToDeduct:=Bal*0.1+500;
              MWithdrawalGraduatedCharges.RESET;
              MWithdrawalGraduatedCharges.SETRANGE(MWithdrawalGraduatedCharges."Notice Status",MWithdrawalGraduatedCharges."Notice Status"::Notified);
              IF MWithdrawalGraduatedCharges.FIND('-') THEN BEGIN
              REPEAT
              IF (Bal>=MWithdrawalGraduatedCharges."Minimum Amount") AND (Bal<=MWithdrawalGraduatedCharges."Maximum Amount") THEN BEGIN
              IF MWithdrawalGraduatedCharges."Use Percentage"=TRUE  THEN BEGIN
              AmountToDeduct:=Bal*(MWithdrawalGraduatedCharges."Percentage of Amount"/100)
              END ELSE
              AmountToDeduct:=MWithdrawalGraduatedCharges.Amount;
              END;
              UNTIL MWithdrawalGraduatedCharges.NEXT=0;
              END;*/

        if (Bal > 0) then begin
            if rec."Member Deposits" > 300 then
                AmountToDeduct := TotalChequeCharge;


            LineNo := LineNo + 10000;
            SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Maturity Date", 'Cheque Fee: ' + rec."Member No.",
            GenJournalLine."bal. account type"::"G/L Account", ChequeChargeGL, AmountToDeduct, DActivity, '');

            /*LineNo:=LineNo+10000;
            SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName,BatchName,Doc_No,LineNo,GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor,"FOSA Account No.","Maturity Date",'Excise(20%): '+"Member No.",
            GenJournalLine."Bal. Account Type"::"G/L Account",Generalsetup."Excise Duty Account",AmountToDeduct*0.2,DActivity,'');*/
            //------------------------------------End--------------------------------------------------
        end;
        exit(Bal);

    end;

    local procedure FnRecoverBOSAInterest(ClientCode: Code[80])
    var
        ObjLoans: Record "Loans Register";
        interestBuffer: Record "Interest Buffer Table";
        IterestFromBuffer: Decimal;
        AmountToDeduct: Decimal;
    begin

        IterestFromBuffer := 0;


        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", ClientCode);
        //ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::BOSA);
        if ObjLoans.Find('-') then begin
            repeat
                interestBuffer.Reset();
                interestBuffer.SetRange("Loan No", ObjLoans."Loan  No.");
                if interestBuffer.Find('-') then begin
                    interestBuffer.CalcSums("Interest Amount");
                    IterestFromBuffer := IterestFromBuffer + interestBuffer."Interest Amount";
                end;
                //Message('%1', interestBuffer);
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Outstanding Interest");
                if ObjLoans."Outstanding Interest" > 0 then begin
                    AmountToDeduct := ObjLoans."Outstanding Interest";// + IterestFromBuffer;
                                                                      // if AmountToDeduct > Bal then
                                                                      //     AmountToDeduct := Bal
                                                                      // else
                                                                      //     AmountToDeduct := AmountToDeduct;

                    //-------------------------------Credit Loan Interest-----------------------------
                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                              GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", Today, AmountToDeduct * -1, DActivity,
                                              ObjLoans."Loan  No.", 'Interest Recovered(With): ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");

                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                              GenJournalLine."Account Type"::Vendor, rec."Paying Bank", Today, AmountToDeduct, DActivity,
                                              ObjLoans."Loan  No.", 'Interest Recovered(With): ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");
                    //--------------------------------End------------------------------------

                end;


            until ObjLoans.Next = 0;
        end;



    end;

    local procedure FnRecoverBOSAInterestDeath()
    var
        ObjLoans: Record "Loans Register";
        interestBuffer: Record "Interest Buffer Table";
        IterestFromBuffer: Decimal;
        AmountToDeduct: Decimal;
    begin
        //if Bal > 0 then begin
        IterestFromBuffer := 0;


        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", rec."Member No.");
        //ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::BOSA);
        if ObjLoans.Find('-') then begin
            repeat
                interestBuffer.Reset();
                interestBuffer.SetRange("Loan No", ObjLoans."Loan  No.");
                if interestBuffer.Find('-') then begin
                    interestBuffer.CalcSums("Interest Amount");
                    IterestFromBuffer := IterestFromBuffer + interestBuffer."Interest Amount";
                end;
                //Message('%1', interestBuffer);
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Outstanding Interest");
                if ObjLoans."Outstanding Interest" > 0 then begin
                    AmountToDeduct := ObjLoans."Outstanding Interest";// + IterestFromBuffer;
                                                                      //if AmountToDeduct > Bal then
                                                                      //   AmountToDeduct := Bal
                                                                      //else
                                                                      // AmountToDeduct := AmountToDeduct;

                    //-------------------------------Credit Loan Interest-----------------------------
                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                              GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", rec."Maturity Date", AmountToDeduct * -1, DActivity,
                                              ObjLoans."Loan  No.", 'Interest Recovered(With): ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");

                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                              GenJournalLine."Account Type"::"G/L Account", '21608', rec."Maturity Date", AmountToDeduct, DActivity,
                                              ObjLoans."Loan  No.", 'Interest Recovered(With): ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");
                    //--------------------------------End------------------------------------
                    // Bal := Bal - AmountToDeduct;
                end;


            until ObjLoans.Next = 0;
        end;
        //end;

        //exit(Bal);
    end;

    local procedure FnRecoverFOSAInterest(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", rec."FOSA Account No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::FOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Outstanding Interest");
                    if ObjLoans."Outstanding Interest" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Interest";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //----------------------------------Debit FOSA-------------------------------------------
                        // LineNo := LineNo + 10000;
                        // SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                        // GenJournalLine."account type"::Vendor, "FOSA Account No.", "Maturity Date", AmountToDeduct, DActivity,
                        // ObjLoans."Loan  No.", 'Repay Interest(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        // //------------------------------------End--------------------------------------------------
                        // //----------------------------------Credit Loan--------------------------------------------
                        // LineNo := LineNo + 10000;
                        // SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        // GenJournalLine."account type"::Investor, ObjLoans."Client Code", "Maturity Date", AmountToDeduct * -1, DActivity,
                        // ObjLoans."Loan  No.", 'Interest Recovered(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        // //------------------------------------End--------------------------------------------------
                        // Bal := Bal - AmountToDeduct;
                    end;

                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnRecoverBOSALoanPrinciple(ClientCode: Code[60])
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", ClientCode);
        if ObjLoans.Find('-') then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                if ObjLoans."Outstanding Balance" > 0 then begin
                    AmountToDeduct := ObjLoans."Outstanding Balance";
                    // if AmountToDeduct > Bal then
                    //     AmountToDeduct := Bal
                    // else
                    //     AmountToDeduct := AmountToDeduct;
                    //-----------------------------------------Debit FOSA-----------------------------------------------------------------------------
                    // LineNo := LineNo + 10000;
                    // SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    //                           GenJournalLine."Account Type"::Customer, "Member No.", "Maturity Date", AmountToDeduct, DActivity,
                    //                           ObjLoans."Loan  No.", 'Repay Loan(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Application Source"::" ");
                    //----------------------------------------------End---------------------------------------------------------------------------------
                    //-----------------------------------------Credit Loans-----------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                              GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", Today, AmountToDeduct * -1, DActivity,
                                              ObjLoans."Loan  No.", 'Offset by Transferred(With): ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Application Source"::" ");
                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                              GenJournalLine."Account Type"::Vendor, rec."Paying Bank", Today, AmountToDeduct, DActivity,
                                              ObjLoans."Loan  No.", 'Offset by Transferred(With: ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");
                    //------------------------------------------End--------------------------------------------------------------------------------------

                    //FnUpdateDatasheetMain(ObjLoans."Loan  No.");
                end;
            until ObjLoans.Next = 0;
        end;



    end;

    local procedure FnRecoverBOSALoanPrincipleDeath()
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        // if Bal > 0 then begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", rec."Member No.");
        if ObjLoans.Find('-') then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                if ObjLoans."Outstanding Balance" > 0 then begin
                    AmountToDeduct := ObjLoans."Outstanding Balance";
                    // if AmountToDeduct > Bal then
                    // AmountToDeduct := Bal
                    //  else
                    // AmountToDeduct := AmountToDeduct;
                    //-----------------------------------------Debit FOSA-----------------------------------------------------------------------------
                    // LineNo := LineNo + 10000;
                    // SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    //                           GenJournalLine."Account Type"::Customer, "Member No.", "Maturity Date", AmountToDeduct, DActivity,
                    //                           ObjLoans."Loan  No.", 'Repay Loan(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Application Source"::" ");
                    //----------------------------------------------End---------------------------------------------------------------------------------
                    //-----------------------------------------Credit Loans-----------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                              GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", rec."Maturity Date", AmountToDeduct * -1, DActivity,
                                              ObjLoans."Loan  No.", 'Offset by Transferred(With): ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Application Source"::" ");
                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                              GenJournalLine."Account Type"::Vendor, rec."Paying Bank", rec."Maturity Date", AmountToDeduct, DActivity,
                                              ObjLoans."Loan  No.", 'Offset by Transferred(With: ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");
                    //------------------------------------------End--------------------------------------------------------------------------------------
                    //Bal := Bal - AmountToDeduct;
                    //FnUpdateDatasheetMain(ObjLoans."Loan  No.");
                end;
            until ObjLoans.Next = 0;
        end;
    end;

    //exit(Bal);
    // end;

    local procedure FnRecoverFOSALoanPrinciple(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", rec."Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::FOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Balance";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //-------------------------------------Debit FOSA---------------------------------------------------------------------------------
                        // LineNo := LineNo + 10000;
                        // SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                        //                           GenJournalLine."account type"::Vendor, "FOSA Account No.", "Maturity Date", AmountToDeduct, DActivity,
                        //                           ObjLoans."Loan  No.", 'Repay Loan(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        // //-----------------------------------------End---------------------------------------------------------------------------------------
                        // //---------------------------------------Credit Loan----------------------------------------------------------------------------------
                        // LineNo := LineNo + 10000;
                        // SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::Repayment,
                        //                           GenJournalLine."account type"::Investor, ObjLoans."Client Code", "Maturity Date", AmountToDeduct * -1, DActivity,
                        //                           ObjLoans."Loan  No.", 'Offset by Transferred(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        // //----------------------------------------End----------------------------------------------------------------------------------------
                        // Bal := Bal - AmountToDeduct;
                    end;
                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnDebitMemberDepositsAndShareCapital(DepositContributions: Decimal; RefundableShareCapital: Decimal)
    var
        AmountToTransfer: Decimal;
        AccountNo: Code[20];
        TotalAmount: Decimal;
    begin
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                   GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Maturity Date", rec."Member Deposits", DActivity, rec."No.", 'Account Closure(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");
        TotalAmount := TotalAmount + rec."Member Deposits";

        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Maturity Date", rec.Dependand1, DActivity, rec."No.", 'Account Closure dependand 1(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");
        //*-----------------Credit Deposits----------------------------
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Maturity Date", rec.dependand2, DActivity, rec."No.", 'Account Closure dependand 2(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");

        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Maturity Date", rec.dependand3, DActivity, rec."No.", 'Account Closure dependand 3(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");
        //*-----------------Credit Deposits----------------------------
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Maturity Date", rec.holidaysaving, DActivity, rec."No.", 'Account Closure holiday(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");
        //unallocated
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Maturity Date", rec.PrdOverdeduction, DActivity, rec."No.", 'Account Closure prd(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");

        //Vendor
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."Account Type"::Vendor, rec."FOSA Account No.", rec."Maturity Date", -TotalAmount, DActivity, rec."No.", 'Account Closure prd(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");
    end;

    local procedure FnUpdateDatasheetMain(LoanNum: Code[20])
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNum);
        if ObjLoans.Find('-') then begin
            PTEN := '';

            if StrLen(ObjLoans."Staff No") = 10 then begin
                PTEN := CopyStr(ObjLoans."Staff No", 10);
            end else
                if StrLen(ObjLoans."Staff No") = 9 then begin
                    PTEN := CopyStr(ObjLoans."Staff No", 9);
                end else
                    if StrLen(ObjLoans."Staff No") = 8 then begin
                        PTEN := CopyStr(ObjLoans."Staff No", 8);
                    end else
                        if StrLen(ObjLoans."Staff No") = 7 then begin
                            PTEN := CopyStr(ObjLoans."Staff No", 7);
                        end else
                            if StrLen(ObjLoans."Staff No") = 6 then begin
                                PTEN := CopyStr(ObjLoans."Staff No", 6);
                            end else
                                if StrLen(ObjLoans."Staff No") = 5 then begin
                                    PTEN := CopyStr(ObjLoans."Staff No", 5);
                                end else
                                    if StrLen(ObjLoans."Staff No") = 4 then begin
                                        PTEN := CopyStr(ObjLoans."Staff No", 4);
                                    end else
                                        if StrLen(ObjLoans."Staff No") = 3 then begin
                                            PTEN := CopyStr(ObjLoans."Staff No", 3);
                                        end else
                                            if StrLen(ObjLoans."Staff No") = 2 then begin
                                                PTEN := CopyStr(ObjLoans."Staff No", 2);
                                            end else
                                                if StrLen(ObjLoans."Staff No") = 1 then begin
                                                    PTEN := CopyStr(ObjLoans."Staff No", 1);
                                                end;

            //IF LoanTypes.GET(ObjLoans."Loan Product Type") THEN BEGIN
            //IF Customer.GET(ObjLoans."Client Code") THEN BEGIN
            //Loans."Staff No":=customer."Payroll/Staff No";
            /* DataSheet.INIT;
             DataSheet."Entry No":=ObjLoans."Staff No";
             DataSheet."Payroll No":=ObjLoans."Loan Product Type";
             DataSheet."Amount Off":=ObjLoans."Loan  No.";
             DataSheet."Member No":=ObjLoans."Client Name";
             DataSheet."Member Name":=ObjLoans."ID NO";
             DataSheet."Principal Amount":=ObjLoans."Loan Principle Repayment";
             DataSheet."Interest Amount":=ObjLoans."Loan Interest Repayment";
             DataSheet."Employer Name":=ROUND(ObjLoans.Repayment,5,'>');
             DataSheet."Amount On":='2026';
             DataSheet."Batch No.":="No.";
             DataSheet."Checkoff Advice Type":=0;
             DataSheet."Repayment Method":=ObjLoans."Repayment Method";
             DataSheet.Reference:=DataSheet.Reference::"1";
             DataSheet.Balance:="Application Date";
             IF Customer.GET(ObjLoans."Client Code") THEN BEGIN
             DataSheet."Loan No":=Customer."Employer Code";
             END;
             DataSheet."Advice Date":=PTEN;
             DataSheet.INSERT;
             */
        end;


    end;

    local procedure FnTransferToCurrentAccount(TotalTransferredAmount: Decimal)
    begin
        //Message('%1', TotalTransferredAmount);
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."account type"::Vendor, rec."Paying Bank", rec."Maturity Date", TotalTransferredAmount * -1, DActivity, rec."No.", 'Account Closure(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");
    end;

    local procedure FnPostExciseDuty(Bal: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        // if ("Maturity Date" < "Expected Posting Date") then
        //     AmountToDeduct := "Ten WIthdrawal";
        // LineNo := LineNo + 10000;
        // SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
        // GenJournalLine."account type"::Vendor, "FOSA Account No.", "Maturity Date", 'Early withdrawal Charge' + "Member No.",
        // GenJournalLine."bal. account type"::"G/L Account", WithFeeGL, AmountToDeduct, DActivity, '');

        // LineNo := LineNo + 10000;
        // SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
        // GenJournalLine."account type"::Vendor, "FOSA Account No.", "Maturity Date", 'Excise(20%): ' + "Member No.",
        // GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Excise Duty Account", AmountToDeduct * 0.2, DActivity, '');
        //------------------------------------End--------------------------------------------------

        //  exit(Bal);
    end;

    local procedure FnPostSavingsCharge(ClientCode: Code[60])
    var
        AmountToDeduct: Decimal;
        Vends: Record Vendor;
        FOSAAccount: Code[60];
    begin



        WithdrawableCharge := Generalsetup."Withdrawal Fee";
        Vend.Reset();
        Vend.SetRange(Vend."BOSA Account No", ClientCode);
        Vend.SetFilter(Vend."Account Type", '103');
        if Vend.FindFirst() then begin
            FOSAAccount := Vend."No.";
        end;

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        GenJournalLine."Account Type"::Vendor, FOSAAccount, Today, WithdrawableCharge, '', DOCUMENT_NO,
         'Withdrawal Fee: ' + ' ' + ClientCode, '');

        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                  GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Withdrawal Fee Account", Today, WithdrawableCharge * -1, DActivity, rec."No.", 'Withdrawal Fee: ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");





    end;


    local procedure FnPostAmountsToFOSA(ClientCode: Code[60])
    var
        Vends: Record Vendor;
        Vend: Record Vendor;
        FOSAAmount: decimal;
        FOSAAccount: Code[60];
    begin

        Vend.Reset();
        Vend.SetRange(Vend."BOSA Account No", ClientCode);
        Vend.SetFilter(Vend."Account Type", '103');
        if Vend.FindFirst() then begin
            FOSAAccount := Vend."No.";
        end;
        Vends.Reset();
        Vends.SetRange(Vends."BOSA Account No", ClientCode);
        Vends.SetFilter(Vends."Account Type", '%1|%2', '102', '104');
        Vends.SetAutoCalcFields(Vends.Balance);
        Vends.SetFilter(Vends.Balance, '>%1', 0);
        if Vends.FindFirst() then begin
            repeat
                Vends.CalcFields(Balance);
                FOSAAmount := 0;
                FOSAAmount := VendS.Balance;
                //Message('hERE%1%1cODE%2', FOSAAmount, ClientCode);
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, FOSAAccount, Today, FOSAAmount * -1, '', DOCUMENT_NO,
                 'Membership Exit' + ' ' + ClientCode, '');


                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, Vends."No.", Today, FOSAAmount, '', DOCUMENT_NO,
                 'Membership Exit' + ' ' + ClientCode, '');
            until Vends.Next() = 0;
        end;
    end;



    local procedure FnPostAmountsToFOSADeath(ClientCode: Code[60])
    var
        Vends: Record Vendor;
        Vend: Record Vendor;
        FOSAAmount: decimal;
        FOSAAccount: Code[60];
    begin

        Vend.Reset();
        Vend.SetRange(Vend."BOSA Account No", ClientCode);
        Vend.SetFilter(Vend."Account Type", '103');
        if Vend.FindFirst() then begin
            FOSAAccount := Vend."No.";
        end;
        Vends.Reset();
        Vends.SetRange(Vends."BOSA Account No", ClientCode);
        Vends.SetFilter(Vends."Account Type", '%1', '102');
        Vends.SetAutoCalcFields(Vends.Balance);
        Vends.SetFilter(Vends.Balance, '>%1', 0);
        if Vends.FindFirst() then begin
            Vends.CalcFields(Balance);
            FOSAAmount := 0;
            FOSAAmount := VendS.Balance;
            //Message('hERE%1%1cODE%2', FOSAAmount, ClientCode);
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor, FOSAAccount, Today, FOSAAmount * -1, '', DOCUMENT_NO,
             'Membership Exit*2' + ' ' + ClientCode, '');


            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::"G/L Account", '21608', Today, FOSAAmount, '', DOCUMENT_NO,
             'Membership Exit*2' + ' ' + ClientCode, '');
        end;
    end;
}

