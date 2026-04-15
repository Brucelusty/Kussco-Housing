report 50782 "Generate Dividend SMS"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Dividends Register"; Customer)
        {
            DataItemTableView = where("gross dividends" = filter(> 0));
            RequestFilterFields = "No.";
            CalcFields = "Gross Dividends";
            column(Member_No; "Member No")
            {

            }

            trigger OnAfterGetRecord()
            begin
                "Dividends Register".CalcFields("Dividends Register"."Gross Dividends");
                if "Dividends Register"."Gross Dividends" > 0 then begin
                    SendDividendSMS("Dividends Register"."No.");
                end;
            end;

            trigger OnPreDataItem()
            begin

            end;


            trigger OnPostDataItem()
            begin
                begin
                    Message(SuccessMessage, BATCH_TEMPLATE, BATCH_NAME);
                end;
            end;

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
        SuccessMessage: Label 'SMS messages has been successfully sent. ';
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
            CreationMessage := 'Dear ' + NameStyle.NameStyle(Members."No.") + ', Your ' + FORMAT(DATE2DMY(CALCDATE('-1Y', TODAY), 3)) + ' Dividends of  Ksh. ' + FORMAT(ABS(ROUND(Members."Gross Dividends", 0.01, '='))) + ' has been credited to your FOSA account .For enquiries call 0205029217';
            smsManagement.SendSmsWithID(Source::DEPOSIT_CONFIRMATION, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
        end;
    end;
}
