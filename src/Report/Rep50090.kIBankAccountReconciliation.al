report 50090 "kIBank Account Reconciliation"
{
    ApplicationArea = All;
    // version Payment ProcessesV1.0(Surestep Systems)

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/KIBankrec.rdlc';
    Caption = 'KI Bank Reconciliation Custom';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            RequestFilterFields = "Statement No.";

            column(BankCode; BankCode)
            {
            }
            column(Cleared_Cheques_and_Payments; "Cleared Cheques and Payments") { }
            column(Cleared_Deposit_and_Credits; "Cleared Deposit and Credits") { }
            column(UnCleared_Cheques_and_Payments; "UnCleared Cheques and Payments") { }
            column(UnCleared_Deposit_and_Credits; "UnCleared Deposit and Credits") { }
            column(BankAccountNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Bank Account No.")
            {
            }

            column(Balance_Last_Statement; "Balance Last Statement") { }
            column(Statement_Ending_Balance; "Statement Ending Balance") { }
            column(StatementNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(TotalBalanceonBankAccount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Balance on Bank Account")
            {
            }
            column(TotalAppliedAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Applied Amount")
            {
            }
            column(TotalTransactionAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Transaction Amount")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(BankName; BankName)
            {
            }
            column(DoneByname; DoneByname) { }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(CompanyInformation_Pic; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_homepage; CompanyInformation."Home Page") { }
            column(CompanyInformation_Email; CompanyInformation."E-Mail") { }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Debit Amount" = FILTER(> 0), Reconciled = filter(false), Reversed = filter(false));
                column(CheckNo_BankAccReconciliationLine; "Bank Account Ledger Entry"."External Document No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Bank Account Ledger Entry"."Statement Line No.")
                {
                }
                column(Description_BankAccReconciliationLine; "Bank Account Ledger Entry".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Bank Account Ledger Entry".Amount)
                {
                }
                column(Empty14; Empty1) { }
                // column(OpenType_BankAccReconciliationLine;"Bank Acc. Reconciliation Line"."Open Type")
                // {
                // }
            }
            dataitem("<Bank Acc. Reconciliation Ln1>"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Credit Amount" = FILTER(> 0), Reconciled = filter(false), Reversed = filter(false));
                column(CheckNo_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."External Document No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationLn1; "<Bank Acc. Reconciliation Ln1>"."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Posting Date")
                {
                }
                column(Description_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>".Amount)
                {
                }
                column(Empty15; Empty1) { }
                // column(OpenType_BankAccReconciliationLine1;"<Bank Acc. Reconciliation Ln1>"."Open Type")
                // {
                // }

            }

            //payment cleared start
            dataitem("<Bank Acc. Reconciliation pc>"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled = filter(true), Amount = filter(< 0), Reversed = filter(false));

                column(CheckNo_BankAccReconciliationpc; "<Bank Acc. Reconciliation pc>"."External Document No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationpc; "<Bank Acc. Reconciliation pc>"."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationpc; "<Bank Acc. Reconciliation pc>"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationpc; "<Bank Acc. Reconciliation pc>"."Posting Date")
                {
                }
                column(Description_BankAccReconciliationpc; "<Bank Acc. Reconciliation pc>".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationpc; "<Bank Acc. Reconciliation pc>".Amount)
                {
                }
                column(Empty13; Empty1) { }
                // column(OpenType_BankAccReconciliationLine1;"<Bank Acc. Reconciliation Ln1>"."Open Type")
                // {
                // }

            }

            //payment cleared end


            //Receipt cleared start
            dataitem("<Bank Acc. Reconciliation rc>"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled = filter(true), Reversed = filter(false), Amount = filter(> 0));

                column(CheckNo_BankAccReconciliationrc; "<Bank Acc. Reconciliation rc>"."External Document No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationrc; "<Bank Acc. Reconciliation rc>"."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationrc; "<Bank Acc. Reconciliation rc>"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationrc; "<Bank Acc. Reconciliation rc>"."Posting Date")
                {
                }
                column(Description_BankAccReconciliationrc; "<Bank Acc. Reconciliation rc>".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationrc; "<Bank Acc. Reconciliation rc>".Amount)
                {
                }
                column(Empty1; Empty1)
                { }
                // column(OpenType_BankAccReconciliationLine1;"<Bank Acc. Reconciliation Ln1>"."Open Type")
                // {
                // }

            }

            //Receipt cleared end

            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                DoneByname := '';
                Empty1 := 0;
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;
                HRemployee.Reset();
                HRemployee.SetRange(HRemployee."Employee UserID", UserId);
                if HRemployee.FindFirst() then begin
                    DoneByname := HRemployee."First Name" + ' ' + HRemployee."Middle Name" + ' ' + HRemployee."Last Name";
                end;



                TotalDiffFunc();

                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SetRange(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CalcFields(Bank."Net Change");


                    BankStatBalance := "Bank Acc. Reconciliation"."Statement Ending Balance";
                    BankAccountBalanceasperCashBook := "Statement Ending Balance" + UncreditedBanking;
                    HRemployee.Reset();
                    HRemployee.SetRange(HRemployee."Employee UserID", UserId);
                    if HRemployee.FindFirst() then begin
                        DoneByname := HRemployee."First Name" + ' ' + HRemployee."Middle Name" + ' ' + HRemployee."Last Name";
                    end;

                    // added code
                    BankStatementLine2.RESET;
                    BankStatementLine2.SETRANGE(BankStatementLine2."Bank Account No.", Bank."No.");
                    BankStatementLine2.SETRANGE(BankStatementLine2."Statement No.", "Statement No.");
                    BankStatementLine2.SETRANGE(BankStatementLine2.Reconciled, FALSE);
                    BankStatementLine2.SETRANGE(BankStatementLine2.Reversed, FALSE);
                    IF BankStatementLine2.FIND('-') THEN begin
                        REPEAT
                            IF BankStatementLine2.Amount < 0 THEN
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine2.Amount
                            ELSE
                                IF BankStatementLine2.Amount > 0 THEN
                                    UncreditedBanking := UncreditedBanking + BankStatementLine2.Amount;
                        UNTIL BankStatementLine2.NEXT = 0;

                        UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    end;
                    //end code 


                    Clear(RecAmt);
                    BankAccReconLine.Reset;
                    BankAccReconLine.SetRange(BankAccReconLine."Bank Account No.", "Bank Account No.");
                    BankAccReconLine.SetRange(BankAccReconLine."Statement No.", "Statement No.");
                    if BankAccReconLine.Find('-') then begin
                        repeat
                            if BankAccReconLine."Applied Entries" = '1' then
                                RecAmt := RecAmt + BankAccReconLine."Applied Amount"
                        until BankAccReconLine.Next = 0;
                    end;

                    BankDiff := 0;
                    "Bank Acc. Reconciliation".CalcFields("Reconciled Amount");
                    //BankDiff := ("Statement Ending Balance" - "Balance Last Statement");
                    BankDiff := (("Balance Last Statement" + "Reconciled Amount") - "Statement Ending Balance");
                    Difference := BankDiff;
                    "Test Report Generated" := true;
                    "Bank Acc. Reconciliation".Modify(true);
                    //Message('Difference %1',Difference);

                    if BankDiff = RecAmt then
                        ReconciliationStatement := 'The bank reconciliation is complete!'
                    else
                        ReconciliationStatement := ' The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts';
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);

                ReconciliationStatement := 'Reconciliation is incomplete please go through it again';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Bank: Record "Bank Account";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        DoneByname: Text;
        HRemployee: Record "HR Employees";
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Bank Acc. Reconciliation Line";
        BankStatementLine1: Record "Bank Account Ledger Entry";
        CompanyInfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankStatementLine2: Record "Bank Account Ledger Entry";
        BankRecPresented: Record "Bank Account Ledger Entry";
        BankRecUnPresented: Record "Bank Acc. Reconciliation Line";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        Empty1: Decimal;
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";

    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset;
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Amount;
            //MESSAGE('%1',TotalDifference);
            until BankRecPresented.Next = 0;
        end;
    end;
}



