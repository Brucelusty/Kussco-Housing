codeunit 50098 "SMS Reminders"
{
    trigger OnRun()
    var
    begin
        BSSDepositContributionReminder();
        MobileLoanRepaymentReminder();
    end;

    procedure BSSDepositContributionReminder()
    var
        cust: Record Customer;
        BSSMsg: Text[1500];
        smsManagement: Codeunit "Sms Management";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
        dateCalc: Codeunit "Dates Calculation";
        month: Integer;
        year: Integer;
        days: Integer;
        currentDate: Integer;
        EndMonth: Date;
    begin
        currentDate:= 0;
        days:= 0;
        month:= 0;
        year:= 0;
       // month:= Date2DMY(Today, 2);
        //year:= Date2DMY(Today, 3);
        //currentDate:= Date2DMY(Today, 1);

        //days:= dateCalc.DetermineDaysInMonth(month, year);
        EndMonth:=CalcDate('CM',Today);
        if EndMonth = Today then begin
            cust.Reset();
            cust.SetRange(cust."Employer Code", 'BUSINESS COMP');
            cust.SetFilter(cust.Status,'%1|%2',cust.Status::Active,cust.Status::Dormant);
            if cust.Find('-') then
            begin
                repeat
                    BSSMsg:= ('Dear '+ NameStyle(cust."No.") + ', it''s the end of the month, kindly remember to pay your Monthly Deposit, BBF and Loan(s) (if any) to our Paybill No.: 822221, Account No.: BD followed by your ID number;  IGNORE IF ALREADY PAID. "Save First, and Spend the Rest".');
                    smsManagement.SendSmsWithID(Source::CRM, cust."Mobile Phone No", BSSMsg, cust."No.", cust."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                until cust.Next() = 0;
            end;
        end;
    end;

    procedure MobileLoanRepaymentReminder()
    var
    dateCalc: Codeunit "Dates Calculation";
    smsManagement: Codeunit "Sms Management";
    myInt: Integer;
    days: Integer;
    overdueDays: Integer;
    loanBalance: Decimal;
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER;
    reminderMsg: Text[1500];
    loansReg: Record "Loans Register";
    loanProd: Record "Loan Products Setup";
    cust: Record Customer;

    begin
        loanBalance:= 0;
        days:= 0;
        overdueDays:= 0;

        loansReg.Reset();
        loansReg.SetRange("Loan Product Type", 'A03');
        loansReg.SetRange(Posted, True);
        loansReg.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty", "Total Outstanding Balance");
        loansReg.SetFilter("Total Outstanding Balance", '>%1', 0);
        if loansReg.FindSet() then begin
            repeat
            
                days:= Today - loansReg."Loan Disbursement Date";
                overdueDays:= Today - loansReg."Expected Date of Completion";
                loanBalance:= loansReg."Total Outstanding Balance";
                cust.Reset();
                if cust.Get(loansReg."Client Code") then begin
                    if CalcDate('<-1D>',loansReg."Expected Date of Completion") = Today then begin
                        reminderMsg:= 'Dear '+NameStyle(cust."No.")+'. Your '+loansReg."Loan Product Type Name"+', of Ksh '+Format(loanBalance)+' is due on - '+Format(loansReg."Expected Date of Completion")+'. Kindly pay on time to avoid penalties.';
                        smsManagement.SendSmsWithID(Source::LOAN_REMINDER, cust."Mobile Phone No", reminderMsg, cust."No.", cust."FOSA Account No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                    end;

                    if loansReg."Expected Date of Completion" = Today then begin
                        reminderMsg:= 'Dear '+NameStyle(cust."No.")+'. Your '+loansReg."Loan Product Type Name"+', of Ksh '+Format(loanBalance)+' is due today - '+Format(loansReg."Expected Date of Completion")+'. Kindly pay on time to avoid penalties.';
                        smsManagement.SendSmsWithID(Source::LOAN_REMINDER, cust."Mobile Phone No", reminderMsg, cust."No.", cust."FOSA Account No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                    end;
                    
                    if(overdueDays= 7) then begin
                        reminderMsg:= 'Dear '+NameStyle(cust."No.")+'. Your '+loansReg."Loan Product Type Name"+', of Ksh '+Format(loanBalance)+' was due on '+Format(loansReg."Expected Date of Completion")+'. Kindly pay to avoid penalties and maintain and grow your limit.';
                        smsManagement.SendSmsWithID(Source::LOAN_REMINDER, cust."Mobile Phone No", reminderMsg, cust."No.", cust."FOSA Account No.", true, 240, true, 'CBS', CreateGuid(), 'CBS');
                    end;
                   
                   if CalcDate('<15D>',loansReg."Repayment Start Date")=Today then begin 
                        reminderMsg:= 'Dear '+NameStyle(cust."No.")+'. Your '+loansReg."Loan Product Type Name"+', of Ksh '+Format(loanBalance)+' will be due due on '+Format(loansReg."Expected Date of Completion")+'. Kindly pay on time avoid penalties.';
                        smsManagement.SendSmsWithID(Source::LOAN_REMINDER, cust."Mobile Phone No", reminderMsg, cust."No.", cust."FOSA Account No.", true, 240, true, 'CBS', CreateGuid(),'CBS');
                   end;
                end;
            until loansReg.Next() = 0;
        end;
    end;

    procedure NameStyle(ClientCode:Code[40])Style:Text[50]
    var
    Customer: record Customer;
    FirstLetter: Text;
    OtherLetters: Text[40];
    begin
        Customer.Reset();
        Customer.SetRange(Customer."No.",ClientCode);
        if Customer.FindFirst() then begin
            Style:='';
            FirstLetter:='';
            OtherLetters:='';
            FirstLetter:=UpperCase(CopyStr(Customer."First Name",1,1));
            OtherLetters:=LowerCase(CopyStr(Customer."First Name",2,100));
            Style:=FirstLetter+OtherLetters;
            exit(Style);
        end;
    end;
    
}
