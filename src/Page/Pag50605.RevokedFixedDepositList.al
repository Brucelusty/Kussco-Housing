page 50605 "Revoked Fixed deposit list"
{
    ApplicationArea = All;
    CardPageID = "Fixed deposit card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Fixed Deposit";
    SourceTableView = WHERE(Revoked = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FD No"; rec."FD No")
                {
                    Editable = false;
                }
                field("Account No"; rec."Account No")
                {
                    Editable = false;
                }
                field("Account Name"; rec."Account Name")
                {
                    Editable = false;
                }
                field("Fd Duration"; rec."Fd Duration")
                {
                    Editable = false;
                }
                field(Amount; rec.Amount)
                {
                    Editable = false;
                }
                field("Interest Rate"; rec."Interest Rate")
                {
                    Editable = false;
                }
                field("ID NO"; rec."ID NO")
                {
                    Editable = false;
                }
                field("Creted by"; rec."Created by")
                {
                    Editable = false;
                }
                field("Amount After maturity"; rec."Amount After maturity")
                {
                    Editable = false;
                }
                field(Date; rec.Date)
                {
                    Editable = false;
                }
                field(MaturityDate; rec.MaturityDate)
                {
                    Editable = false;
                }
                field(matured; rec.matured)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action("Transfer Fixed To FOSA")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //credit savings
                    IF rec.Credited = TRUE THEN
                        ERROR('This account has already been credited');
                    IF TODAY < rec.MaturityDate THEN
                        ERROR('This fixed deposit has not matured yet.');
                    IF CONFIRM('Are you sure you want to transfer this fixed deposit?', TRUE, FALSE) = TRUE THEN BEGIN
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                        GenJournalLine.DELETEALL;

                        //MESSAGE('amount is %1',Amount);
                        AccP.RESET;
                        AccP.SETRANGE(AccP."ID No.", rec."ID NO");
                        AccP.SETFILTER(AccP."Account Type", 'FIXED');
                        IF AccP.FIND('-') THEN BEGIN
                            fixedno := AccP."No.";




                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FXDEP';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := fixedno;
                            GenJournalLine."Document No." := rec."FD No";
                            GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine.Description := 'Matured Fixed deposit';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := rec.Amount;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;

                            //END credit fixed deposit


                            //Debit ordinary
                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FXDEP';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := rec."Account No";
                            GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine."Document No." := rec."FD No";
                            GenJournalLine.Description := 'Matured Fixed deposit ';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -rec.Amount;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;

                            //Interest Earned
                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FXDEP';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                            GenJournalLine."Account No." := '400-000-205';
                            GenJournalLine."Document No." := rec."FD No";
                            GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine.Description := 'Fixed deposit Interest Earned';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := rec."Interest Earned";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;




                            //Credit
                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FXDEP';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := rec."Account No";
                            GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine."Document No." := rec."FD No";
                            GenJournalLine.Description := 'Witholding Tax On Interest Earned';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -rec."Interest Earned";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;

                            //Witholding Tax
                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FXDEP';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                            GenJournalLine."Account No." := '200-000-176';
                            GenJournalLine."Document No." := rec."FD No";
                            GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine.Description := 'Witholding Tax On Interest Earned';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -(rec."Interest Earned" * 15 / 100);
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;




                            //Credit
                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FXDEP';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := rec."Account No";
                            GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine."Document No." := rec."FD No";
                            GenJournalLine.Description := 'Fixed deposit Interest Earned';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := (rec."Interest Earned" * 15 / 100);
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;
                            //end debit ordinary savings

                            //Post New
                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                            GenJournalLine.SETRANGE("Journal Batch Name", 'FXDEP');
                            IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            END;
                            rec.Credited := TRUE;
                            rec."Posted Date" := TODAY;
                            rec."Posted By" := USERID;
                            rec.Posted := TRUE;
                            rec.MODIFY;
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // Rec.SETFILTER(MaturityDate, '<=%1', TODAY);
    end;

    var
        LoanBalance: Decimal;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record 81;
        DefaultBatch: Record 232;
        GLPosting: Codeunit 12;
        window: Dialog;
        Account: Record 23;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record 98;
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record 270;
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record "Charges";
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record "Members Register";
        AccountHolders: Record 23;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        chqtransactions: Record "Transactions";
        Trans: Record "Transactions";
        TotalUnprocessed: Decimal;
        CustAcc: Record "Members Register";
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record "Transactions";
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record "Denominations";
        TillNo: Code[20];
        FOSASetup: Record 312;
        Acc: Record 23;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record 2000000120;
        ChBank: Code[20];
        DValue: Record 349;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        Cheque: Boolean;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        BOSABank: Code[20];
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        genSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        AccP: Record 23;
        LoansR: Record "Loans Register";
        ClearingCharge: Decimal;
        ClearingRate: Decimal;
        [InDataSet]
        FChequeVisible: Boolean;
        [InDataSet]
        BChequeVisible: Boolean;
        [InDataSet]
        BReceiptVisible: Boolean;
        [InDataSet]
        BOSAReceiptChequeVisible: Boolean;
        [InDataSet]
        "Branch RefferenceVisible": Boolean;
        [InDataSet]
        LRefVisible: Boolean;
        [InDataSet]
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record 271;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Vend1: Record 23;
        TransDesc: Text;
        TransTypes: Record "Transaction Types";
        ObjTransactionCharges: Record "Transaction Charges";
        AccountBalance: Decimal;
        MinimumBalance: Decimal;
        TransactionAmount: Decimal;
        WithCharges: Decimal;
        fixedno: Code[30];
        fixeddeposit: Record "Fixed Deposit";
        CreditEnabled: Boolean;
}




