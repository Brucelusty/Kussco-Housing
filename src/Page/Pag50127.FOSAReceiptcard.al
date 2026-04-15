//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50127 "FOSA Receipt Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                field("Transaction No."; Rec."Transaction No.")
                {
                    Editable = false;
                }
                field(Source; Rec.Source)
                {
                    Editable = false;

                }
                field("Account Type"; Rec."Account Type")
                {

                }

                field("Account No."; Rec."Account No.")
                {

                }
                field(Name; rec.Name)
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    visible = False;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    visible = false;
                }
                field(Amount; rec.Amount)
                {
                    trigger OnValidate()
                    var
                        TellerTill: Record "Bank Account";
                    begin
                        TellerTill.Reset;
                        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
                        TellerTill.SetRange(TellerTill.CashierID, UserId);
                        if TellerTill.Find('-') then begin
                            TellerTill.CalcFields(TellerTill."Balance (LCY)");
                            Rec."Employer No." := TellerTill."No.";
                            rec."Bank Name" := TellerTill.name;
                            rec."Till/Bank Name" := TellerTill.name;

                            rec."Teller/Bank Balance" := TellerTill."Balance (LCY)";
                        end;
                    end;
                }
                field("Receipt Mode"; Rec."Receipt Mode")
                {
                    Editable = false;
                }
                field("Excess Transaction Type"; Rec."Excess Transaction Type")
                {
                    Visible = false;
                }
                field(Remarks; rec.Remarks)
                {
                    ShowMandatory = true;
                    Caption = 'Transaction Description';
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                }
                field("Un allocated Amount"; Rec."Un allocated Amount")
                {
                    Editable = false;
                }
                field("Employer No."; Rec."Employer No.")
                {
                    Caption = 'Teller Till ';
                    Editable = false;
                }
                field("Till/Bank Name"; Rec."Till/Bank Name") { }
                field("Teller/Bank Balance"; Rec."Teller/Bank Balance") { }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Caption = 'Cheque / Slip  No.';
                    Visible = false;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Caption = 'Posting Date';
                    Visible = FALSE;
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Editable = false;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    Editable = false;
                }
                field(Posted; rec.Posted)
                {
                    Editable = false;
                }
            }
            part("Receipt Allocation"; "Receipt Allocation-BOSA")
            {
                SubPageLink = "Document No" = field("Transaction No.");

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suggest)
            {
                Caption = 'Suggest';
                action("Cash/Cheque Clearance")
                {
                    Caption = 'Cash/Cheque Clearance';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cheque := false;
                        //SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Suggest Payments")
                {
                    Caption = 'Suggest Monthy Repayments';
                    Image = Suggest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ObjTransactions: Record "Receipt Allocation";
                        RunBal: Decimal;
                        Datefilter: Text;
                    begin

                        rec.TestField(Posted, false);
                        rec.TestField("Account No.");
                        rec.TestField(Amount);
                        // ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account

                        ObjTransactions.Reset;
                        ObjTransactions.SetRange(ObjTransactions."Document No", Rec."Transaction No.");
                        if ObjTransactions.Find('-') then
                            ObjTransactions.DeleteAll;

                        Datefilter := '..' + Format(rec."Transaction Date");
                        RunBal := 0;
                        RunBal := rec.Amount;
                        RunBal := FnRunEntranceFee(Rec, RunBal);
                        RunBal := FnRunShareCapital(Rec, RunBal);
                        RunBal := FnRunInterest(Rec, RunBal);
                        RunBal := FnRunPrinciple(Rec, RunBal);
                        RunBal := FnRunDepositContribution(Rec, RunBal);
                        RunBal := FnRunInsuranceContribution(Rec, RunBal);
                        RunBal := FnRunBenevolentFund(Rec, RunBal);

                        if RunBal > 0 then begin
                            if Confirm('Excess Money will allocated to ' + Format(rec."Excess Transaction Type") + '.Do you want to Continue?', true) = false then
                                exit;
                            case rec."Excess Transaction Type" of
                                rec."excess transaction type"::"Deposit Contribution":
                                    FnRunDepositContributionFromExcess(Rec, RunBal);
                                rec."excess transaction type"::"Safari Saving":
                                    FnRunSavingsProductExcess(Rec, RunBal, 'SAVINGS');
                                rec."excess transaction type"::"Silver Savings":
                                    FnRunSavingsProductExcess(Rec, RunBal, 'GOLDSAVE');
                                rec."excess transaction type"::"Junior Savings":
                                    FnRunSavingsProductExcess(Rec, RunBal, 'NFK-JUNIOR');
                            end;
                            //RunBal:=FnRunUnallocatedAmount(Rec,RunBal);
                        end;

                        rec.CalcFields("Allocated Amount");
                        rec."Un allocated Amount" := (rec.Amount - rec."Allocated Amount");
                        rec.Modify;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post (F11)';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    // if ("Receipt Mode" = "receipt mode"::Cash) and ("Transaction Date" <> Today) then
                    //     Error('You cannot post cash transactions with a date not today');

                    if rec.Posted then
                        Error('This receipt is already posted');

                    rec.TestField("Account No.");
                    rec.TestField(Amount);

                    if (rec."Account Type" = rec."account type"::"G/L Account") or
                       (rec."Account Type" = rec."account type"::Debtor) then
                        TransType := 'Withdrawal'
                    else
                        TransType := 'Deposit';

                    BOSABank := rec."Employer No.";
                    if (rec."Account Type" = rec."account type"::Customer)  then begin

                        if rec.Amount <> rec."Allocated Amount" then
                            Error('Receipt amount must be equal to the allocated amount.');
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    GenJournalLine.DeleteAll;


                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := rec."Transaction No.";
                    GenJournalLine."External Document No." := rec."Cheque No.";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := rec."Employer No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Today;
                    //GenJournalLine."Posting Date":="Transaction Date";
                    GenJournalLine.Description := 'BT-' + rec."Account No." + '-' + rec.Name;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    ReceiptAllocations."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
                    ReceiptAllocations."Global Dimension 2 Code" := rec."Global Dimension 2 Code";
                    if TransType = 'Withdrawal' then
                        GenJournalLine.Amount := -rec.Amount
                    else
                        GenJournalLine.Amount := rec.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    if rec."Allocated Amount" > 0 then begin
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := rec."Transaction No.";
                        GenJournalLine."External Document No." := rec."Cheque No.";
                        GenJournalLine."Line No." := LineNo;
                        if rec."Account Type" = rec."account type"::"G/L Account" then
                            GenJournalLine."Account Type" := rec."Account Type"
                        else
                            if rec."Account Type" = rec."account type"::Debtor then
                                GenJournalLine."Account Type" := rec."Account Type"
                            else
                                if rec."Account Type" = rec."account type"::Vendor then
                                    GenJournalLine."Account Type" := rec."Account Type"
                                else
                                    if rec."Account Type" = rec."account type"::"Bank Account" then
                                        GenJournalLine."Account Type" := rec."Account Type"
                                    else
                                        if rec."Account Type" = rec."account type"::Customer then
                                            GenJournalLine."Account Type" := rec."Account Type";
                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        //GenJournalLine."Posting Date":="Transaction Date";
                        GenJournalLine.Description := 'BT-' + rec.Name + '-' + rec."Account No." + '-' + rec.Name;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if TransType = 'Withdrawal' then
                            GenJournalLine.Amount := rec.Amount
                        else
                            GenJournalLine.Amount := -rec.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        ReceiptAllocations."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
                        ReceiptAllocations."Global Dimension 2 Code" := rec."Global Dimension 2 Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    GenSetup.Get();

                    if (rec."Account Type" = rec."account type"::Customer) or (rec."Account Type" = rec."account type"::"bank account") or (rec."Account Type" = rec."account type"::Vendor) or
                      (rec."Account Type" = rec."account type"::"G/L Account") then begin
                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", rec."Transaction No.");
                        if ReceiptAllocations.Find('-') then begin
                            repeat
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := rec."Transaction No.";
                                GenJournalLine."External Document No." := rec."Cheque No.";
                                GenJournalLine."Posting Date" := Today;
                                //GenJournalLine."Posting Date":="Transaction Date";

                                if ReceiptAllocations."Account Type" = ReceiptAllocations."Account Type"::"G/L Account" Then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");

                                end else
                                    if ReceiptAllocations."Account Type" = ReceiptAllocations."Account Type"::Vendor Then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");

                                    end else
                                        if ReceiptAllocations."Account Type" = ReceiptAllocations."Account Type"::Customer Then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                            GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");

                                        end else
                                            if ReceiptAllocations."Account Type" = ReceiptAllocations."Account Type"::"Bank Account" Then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                                GenJournalLine.Validate(GenJournalLine."Account No.");

                                            end;
                                // end;
                                Message('GenJournalLine."Account Type" %1', GenJournalLine."Account Type");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'BT-' + '-' + rec."Account No." + '-' + rec.Name;
                                ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                ReceiptAllocations."Global Dimension 2 Code" := SURESTEPFactory.FnGetUserBranch();
                                GenJournalLine.Amount := -ReceiptAllocations.Amount;
                                GenJournalLine."Shortcut Dimension 1 Code" := ReceiptAllocations."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := ReceiptAllocations."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine.Description := CopyStr(
                                Format(ReceiptAllocations."Transaction Type") + '-' + rec.Name + '-' + Format(rec."Receipt Mode") + '-' + rec."Cheque No."
                                , 1, 50);
                                GenJournalLine."Transaction Type" := ReceiptAllocations."Transaction Type";
                                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            until ReceiptAllocations.Next = 0;
                        end;


                    end;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin


                        //Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                    //Post New
                    Message('Transaction posted successfully');
                    //rec.Posted := true;
                    //rec.Modify;
                    Commit;

                    /*BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", rec."Transaction No.");
                    if BOSARcpt.Find('-') then
                        BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", rec."Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.Run(172486, true, false, BOSARcpt);

                    //END;*/

                    CurrPage.Close;
                end;
            }
            action("Reprint Frecipt")
            {
                Caption = 'Reprint Receipt';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    rec.TestField(Posted);

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", rec."Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.Run(172486, true, true, BOSARcpt)
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        rec.CalcFields("Allocated Amount");
        rec."Un allocated Amount" := rec.Amount - rec."Allocated Amount";
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        Cheque: Boolean;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        Cust: Record Customer;
        BOSABank: Code[20];
        LineNo: Integer;
        BOSARcpt: Record "Receipts & Payments";
        TellerTill: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        TransType: Text[30];
        RCPintdue: Decimal;
        Text001: label 'This member has reached a maximum share contribution of Kshs. 5,000/=. Do you want to post this transaction as shares contribution?';
        BosaSetUp: Record "Sacco General Set-Up";
        MpesaCharge: Decimal;
        CustPostingGrp: Record "Customer Posting Group";
        MpesaAc: Code[30];
        GenSetup: Record "Sacco General Set-Up";
        ShareCapDefecit: Decimal;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        SURESTEPFactory: Codeunit "Au Factory";

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Source := rec.Source::FOSA;
    end;


    local procedure FnRunInterest(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                    if LoanApp."Outstanding Interest" > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := ROUND(LoanApp."Outstanding Interest", 0.05, '>');
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Interest Paid";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        loanrepaymentSch: Record "Loan Repayment Schedule";
        ENTRYNO: Integer;
        AmountToPay: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);

            if LoanApp.Find('-') then begin
                repeat

                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", "Oustanding Interest to Date");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            loanrepaymentSch.Reset();
                            loanrepaymentSch.SetRange("Loan No.", LoanApp."Loan  No.");
                            loanrepaymentSch.SetFilter("Repayment Date", '%1..%2', CalcDate('-CM', Today), CalcDate('CM', Today));
                            IF loanrepaymentSch.FindLast() THEN begin
                                PRpayment := loanrepaymentSch."Principal Repayment";
                            end;

                            varLRepayment := LoanApp."Loan Principle Repayment";
                            if LoanApp."Loan Product Type" = 'GUR' then
                                varLRepayment := LoanApp."Loan Principle Repayment";
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToPay := varLRepayment;
                                    end
                                    else
                                        AmountToPay := RunningBalance;
                                end;

                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::Repayment;
                                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                                ObjReceiptTransactions.Amount := AmountToPay;
                                ObjReceiptTransactions.Description := 'Loan No' + LoanApp."Loan  No.";

                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);

                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunEntranceFee(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetFilter(ObjMember."Registration Date", '>%1', 20171017D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                if Abs(ObjMember."Registration Fee Paid") > 0 then begin
                    if ObjMember."Registration Date" <> 0D then begin

                        AmountToDeduct := 0;
                        AmountToDeduct := GenSetup."BOSA Registration Fee Amount" - Abs(ObjMember."Registration Fee Paid");
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                        ObjReceiptTransactions."Account No" := '';
                        ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                        ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Registration Fee";
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                        ObjReceiptTransactions.Amount := AmountToDeduct;
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunShareCapital(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetRange(ObjMember.ISNormalMember, true);
            if ObjMember.Find('-') then begin
                //REPEAT Deducted once unless otherwise advised
                ObjMember.CalcFields(ObjMember."Shares Retained");
                if ObjMember."Shares Retained" < GenSetup."Retained Shares" then begin
                    SharesCap := GenSetup."Retained Shares";
                    DIFF := SharesCap - ObjMember."Shares Retained";

                    if DIFF > 1 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := DIFF;
                            /*IF DIFF > 10000 THEN
                              AmountToDeduct:=10000;*/
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;

                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                            ObjReceiptTransactions."Account No" := ObjMember."Share Capital No";
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Share Capital";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount <> 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                end;
                //UNTIL RcptBufLines.NEXT=0;
            end;

            exit(RunningBalance);
        end;

    end;

    local procedure FnRunDepositContribution(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetRange(ObjMember.ISNormalMember, true);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := ROUND(ObjMember."Monthly Contribution", 0.05, '>');
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                ObjReceiptTransactions."Account No" := ObjMember."Deposits Account No";
                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInsuranceContribution(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        GenSetup.Get();
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin
                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Benevolent Fund Contribution";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Insurance Paid";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunBenevolentFund(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin

                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Risk Fund Amount";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                    ObjReceiptTransactions."Account No" := ObjMember."Benevolent Fund No";
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                   // ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Benevolent Fund";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunUnallocatedAmount(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        if ObjMember.Find('-') then begin
            begin
                AmountToDeduct := 0;
                AmountToDeduct := RunningBalance;
                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                //ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Coop Shares";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
            end;
        end;
    end;

    local procedure FnRunDepositContributionFromExcess(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        ObjMember.SetRange(ObjMember.ISNormalMember, true);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"Deposit Contribution");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
            ObjReceiptTransactions."Account No" := ObjMember."Deposits Account No";
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;

    local procedure FnReturnAmountToClear(TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account") AmountReturned: Decimal
    var
        ObjReceiptAllocation: Record "Receipt Allocation";
    begin
        ObjReceiptAllocation.Reset;
        ObjReceiptAllocation.SetRange("Document No", Rec."Transaction No.");
        ObjReceiptAllocation.SetRange("Transaction Type", TransType);
        if ObjReceiptAllocation.Find('-') then begin
            AmountReturned := ObjReceiptAllocation.Amount;
            ObjReceiptAllocation.Delete;
        end;
        exit;
    end;

    local procedure FnRunSavingsProductExcess(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal; SavingsProduct: Code[100]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        ObjMember.SetRange(ObjMember.ISNormalMember, true);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"FOSA Account");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
            ObjReceiptTransactions."Member No" := ObjMember."No.";
            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
            ObjReceiptTransactions."Account No" := ObjReceiptTransactions."Member No";
            // if "Excess Transaction Type" = "excess transaction type"::"Junior Savings" then
            //     ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Junior Savings";
            // if "Excess Transaction Type" = "excess transaction type"::"Silver Savings" then
            //     ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Silver Savings";
            // if "Excess Transaction Type" = "excess transaction type"::"Safari Saving" then
            //     ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Safari Savings";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;
}




