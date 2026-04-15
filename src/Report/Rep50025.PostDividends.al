report 50025 "Post Dividends"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Dividends Register"; Customer)
        {
            DataItemTableView = where("gross dividends" = filter(> 0));
            CalcFields = "Gross Dividends";
            column(Member_No; "Member No")
            {

            }

            trigger OnAfterGetRecord()
            begin


                Counter := Counter + 1;
                IF (Counter >= NoOfProgress) OR (Time - TimeProgress > 1000) THEN begin
                    NoOfProgressed := NoOfProgressed + Counter;
                    ProgreeCheck := Round(NoOfProgressed / NoOfRec * 10000, 1);

                    Progress.Update(1, "Dividends Register"."Member No" + '::' + "Dividends Register".Name);
                    //Progress.Update(1, ProgreeCheck);
                    Counter := 0;
                    TimeProgress := Time;
                end;
                "Dividends Register".CalcFields("Dividends Register"."Gross Dividends");
                /*                 if "Dividends Register"."Gross Dividends">0 then begin
                                    SendDividendSMS("Dividends Register"."No.");
                                end; */

                BATCH_TEMPLATE := 'General';
                BATCH_NAME := 'Dividend';

                "Dividends Register".CalcFields("Dividends Register"."Dividend Gross Interest Amount", "Dividends Register"."Dividend WHT Amount", "Dividends Register"."Deposits Gross Interest Amount", "Dividends Register"."Deposits WHT Amount", "Dividends Register"."Net Dividends Total");
                NetDiv := 0;
                NetDiv := "Dividends Register"."Net Dividends Total";
                NetDivBal := 0;
                NetDivBal := NetDiv;

                if "Dividends Register"."Dividend Gross Interest Amount" > 0 then begin

                    ObjGensetup.Get();
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, "Dividends Register"."Dividend Gross Interest Amount" * -1, 'FOSA', '',
                    'Gross Dividend- ' + Format(PostingDate), '', AppSource::" ");
                    //--------------------------------(CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits)---------------------------------------------															
                    //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C-----------------------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", '200-000-172', PostingDate, "Dividends Register"."Dividend Gross Interest Amount", 'FOSA', '',
                    'Gross Dividend- ' + Format(PostingDate), '', AppSource::" ");
                    //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------															
                    //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_GROSS WITHHOLDING TAX-------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, "Dividends Register"."Dividend WHT Amount", 'FOSA', '',
                    'Witholding Tax on Dividend- ' + Format(PostingDate), '', AppSource::" ");
                    //--------------------------------(Debit Member Dividend A/C_Gross Witholding Tax)-------------------------------------------------------------															
                    //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", '200-000-176', PostingDate, "Dividends Register"."Dividend WHT Amount" * -1, 'FOSA', '',
                    'Witholding Tax on Dividend- ' + Format(PostingDate), '', AppSource::" ");
                end;


                if "Dividends Register"."Deposits Gross Interest Amount" > 0 then begin
                    //IOD
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, "Dividends Register"."Deposits Gross Interest Amount" * -1, 'FOSA', '',
                    'Interest on Deposits- ' + Format(PostingDate), '', AppSource::" ");
                    //--------------------------------(CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits)---------------------------------------------															
                    //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C-----------------------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", '200-000-181', PostingDate, "Dividends Register"."Deposits Gross Interest Amount", 'FOSA', '',
                    'Interest on Deposits- ' + Format(PostingDate), '', AppSource::" ");
                    //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------															
                    //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_GROSS WITHHOLDING TAX-------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, "Dividends Register"."Deposits WHT Amount", 'FOSA', '',
                    'Witholding Tax on IOD- ' + Format(PostingDate), '', AppSource::" ");
                    //--------------------------------(Debit Member Dividend A/C_Gross Witholding Tax)-------------------------------------------------------------															
                    //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", '200-000-176', PostingDate, "Dividends Register"."Deposits WHT Amount" * -1, 'FOSA', '',
                    'Witholding Tax on IOD- ' + Format(PostingDate), '', AppSource::" ");
                end;

                IF (NetDivBal) >= 500 THEN BEGIN

                    Lineno := LineNo + 1000;

                    AuFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, 100, 'FOSA', '',
                    FORMAT(DATE2DMY(CALCDATE('-1Y', TODAY), 3)) + ' Interest on Deposits processing fee-' + "Dividends Register"."No.", '', AppSource::" ", GenJournalLine."Bal. Account Type"::"G/L Account", '300-000-066');


                    Lineno := LineNo + 1000;

                    AuFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, 20, 'FOSA', '',
                     FORMAT(DATE2DMY(CALCDATE('-1Y', TODAY), 3)) + ' Excise duty on processing fee -' + "Dividends Register"."No.", '', AppSource::" ", GenJournalLine."Bal. Account Type"::"G/L Account", '200-000-168');


                    Lineno := LineNo + 1000;
                    AuFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, 10, 'FOSA', '',
FORMAT(DATE2DMY(CALCDATE('-1Y', TODAY), 3)) + ' SMS Charges-' + "Dividends Register"."No.", '', AppSource::" ", GenJournalLine."Bal. Account Type"::"G/L Account", '300-000-055');


                    Lineno := LineNo + 1000;

                    AuFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, 2, 'FOSA', '',
                     FORMAT(DATE2DMY(CALCDATE('-1Y', TODAY), 3)) + ' Excise duty on SMS Charges -' + "Dividends Register"."No.", '', AppSource::" ", GenJournalLine."Bal. Account Type"::"G/L Account", '200-000-168');

                    NetDivBal := NetDivBal - 132;

                end;

                IF NetDivBal > 0 THEN
                    Loans.RESET;
                Loans.SETRANGE(Loans."Client Code", "Dividends Register"."No.");
                Loans.SETAUTOCALCFIELDS(Loans."Outstanding Balance", Loans."Outstanding Interest");
                Loans.SETFILTER(Loans."Loans Category", '%1|%2|%3', Loans."Loans Category"::Doubtful, Loans."Loans Category"::Loss, Loans."Loans Category"::Substandard);
                Loans.SETFILTER(Loans."Outstanding Balance", '>%1', 0);
                IF Loans.FIND('-') THEN BEGIN
                    REPEAT
                        Loans.CALCFIELDS(Loans."Outstanding Interest");
                        IF NetDivBal > 0 THEN
                            InterestDeduction := 0;
                        InterestDeduction := Loans."Outstanding Interest";
                        IF InterestDeduction > NetDivBal THEN
                            InterestDeduction := NetDivBal
                        ELSE
                            InterestDeduction := InterestDeduction;
                        //recover interest

                        LineNo := LineNo + 10000;
                        AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, InterestDeduction, 'FOSA', '',
                        'Interest Repayment For Loan-' + Loans."Loan  No.", '', AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Gross Witholding Tax)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Customer, "Dividends Register"."No.", PostingDate, InterestDeduction * -1, 'FOSA', '',
                        'Interest Repayment For Loan-' + Loans."Loan  No.", Loans."Loan  No.", AppSource::" ");

                        NetDivBal := NetDivBal - InterestDeduction;
                    UNTIL Loans.NEXT = 0;
                END;


                IF NetDivBal > 0 THEN BEGIN
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Client Code", "Dividends Register"."No.");
                    Loans.SETAUTOCALCFIELDS(Loans."Outstanding Balance", Loans."Outstanding Interest");
                    Loans.SETFILTER(Loans."Loans Category", '%1|%2|%3', Loans."Loans Category"::Doubtful, Loans."Loans Category"::Loss, Loans."Loans Category"::Substandard);
                    Loans.SETFILTER(Loans."Outstanding Balance", '>%1', 0);
                    IF Loans.FIND('-') THEN BEGIN
                        REPEAT
                            IF NetDivBal > 0 THEN
                                Larrears := 0;
                            LoanRepaymentSchedule.RESET;
                            LoanRepaymentSchedule.SETRANGE(LoanRepaymentSchedule."Loan No.", Loans."Loan  No.");
                            LoanRepaymentSchedule.SETFILTER(LoanRepaymentSchedule."Repayment Date", '<=%1', TODAY);
                            IF LoanRepaymentSchedule.FINDLAST THEN BEGIN
                                Larrears := Loans."Outstanding Balance" - LoanRepaymentSchedule."Loan Balance";
                            END;

                            IF NetDivBal > Larrears THEN
                                Larrears := Larrears
                            ELSE
                                Larrears := NetDivBal;

                            //recover loan
                            LineNo := LineNo + 1000;
                            LineNo := LineNo + 10000;
                            AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, "Dividends Register"."FOSA Account No.", PostingDate, Larrears, 'FOSA', '',
                            'Loan Repayment For Loan-' + Loans."Loan  No.", '', AppSource::" ");
                            //--------------------------------(Debit Member Dividend A/C_Gross Witholding Tax)-------------------------------------------------------------															
                            //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------															
                            LineNo := LineNo + 10000;
                            AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                            GenJournalLine."account type"::Customer, "Dividends Register"."No.", PostingDate, Larrears * -1, 'FOSA', '',
                            'Loan Repayment For Loan-' + Loans."Loan  No.", Loans."Loan  No.", AppSource::" ");
                            NetDivBal := NetDivBal - Larrears;
                        UNTIL Loans.NEXT = 0;
                    END;
                END;








            end;

            trigger OnPreDataItem()
            begin
                GetBatchs.Reset();
                GetBatchs.SetRange(GetBatchs."Journal Template Name", 'General');
                GetBatchs.SetRange(GetBatchs.Name, 'Dividend');
                if GetBatchs.Find('-') = false then begin
                    GetBatchs.Init();
                    GetBatchs."Journal Template Name" := 'General';
                    GetBatchs.Name := 'Dividend';
                    GetBatchs.Insert();
                end;
                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'General');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'Dividend');
                if GenJournalLine.Find('-') = true then begin
                    GenJournalLine.DeleteAll();
                end;
                Progress.Open(ProgressMsg);
                NoOfRec := "Dividends Register".Count;
                NoOfProgress := NoOfRec DIV 100;
                Counter := 0;
                NoOfProgressed := 0;
                TimeProgress := Time;
                DOCUMENT_NO := 'DIVIDENDS 2024';
            end;


            trigger OnPostDataItem()
            begin
                begin

                    // Do some processing
                    // for Counter := 1 to 100 do begin
                    //     Progress.Update(1, Counter);// Update the field in the dialog.
                    //     Sleep(50);
                    // end;
                    Progress.CLOSE();
                    Message(SuccessMessage, BATCH_TEMPLATE, BATCH_NAME);
                end;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Processing......@1######################\';
        SuccessMessage: Label 'Dividend has been successfully transferred to %1 Journal %2 Batch. ';
        GetBatchs: Record "Gen. Journal Batch";
        AuFactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[50];
        PostingDate: Date;
        LArrears: Decimal;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ObjGensetup: Record "Sacco General Set-Up";
        AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        NoOfRec: Integer;
        NoOfProgressed: Integer;
        NoOfProgress: Integer;
        TimeProgress: Time;
        NetDiv: Decimal;
        NetDivBal: Decimal;
        smsManagement: Codeunit "Sms Management";
        CreationMessage: Text[2500];
        ProgreeCheck: Decimal;
        Loans: Record "Loans Register";
        InterestDeduction: Decimal;
        NameStyle: Codeunit "Send Birthday SMS";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;

    procedure SendDividendSMS(CustID: Code[40])
    var
        Members: Record Customer;
    begin
        Members.Reset();
        Members.SetRange(Members."No.", CustID);
        Members.SetFilter(Members."Mobile Phone No", '<>%1', '');
        if Members.FindFirst() then begin
            Members.CalcFields(Members."Gross Dividends");
            CreationMessage := 'Dear ' + NameStyle.NameStyle(Members."No.") + ', Your ' + FORMAT(DATE2DMY(CALCDATE('-1Y', TODAY), 3)) + ' Dividends of  Ksh. ' + FORMAT(ABS(ROUND(Members."Gross Dividends", 0.01, '='))) + ' has been credited to your FOSA account .For enqueries call 0205029217';
            smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
        end;
    end;
}
