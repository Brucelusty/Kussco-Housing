codeunit 50103 "Send Birthday SMS"
{


    trigger OnRun()
    begin
        membersBirthdaySMS();
        childBirthdaySMS();
    end;
    
    procedure membersBirthdaySMS()
    var
        Members: Record Customer;
        BirthMonth: Integer;
        BirthDate: integer;
        CurrMonth: Integer;
        CurrDate: integer;
        ageDec: Decimal;
        ProgressWindow: Dialog;
        smsManagement: Codeunit "Sms Management";
        dateCalc: Codeunit "Dates Calculation";
        CreationMessage: Text[2500];
        ageCust: Text[450];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    begin
        Members.RESET;
        Members.SetFilter(Members."Mobile Phone No", '<>%1', '');
        IF Members.FINDFIRST THEN BEGIN
            REPEAT

                IF Members."Date of Birth" <> 0D THEN BEGIN
                    BirthMonth := DATE2DMY(Members."Date of Birth", 2);
                    BirthDate := DATE2DMY(Members."Date of Birth", 1);
                    CurrDate := DATE2DMY(TODAY, 1);
                    CurrMonth := DATE2DMY(TODAY, 2);
                    IF ((CurrDate = BirthDate) AND (CurrMonth = BirthMonth)) THEN BEGIN
                        CreationMessage:='Happy Birthday '+NameStyle(Members."No.")+'! May this New Year bring along many Opportunities, Love, Joy & Happiness. Thank you for Banking with us.';
                        smsManagement.SendSmsWithID(Source::CRM, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                        
                        ageCust:= dateCalc.DetermineAge(Members."Date Of Birth", Today);
                        ageDec:= Round((Today - Members."Date Of Birth")/365.25, 1, '=');

                        Members.Age := ageCust;
                        Members.Agee := ageDec;
                        Members.Modify;
                    end;
                end;
            until Members.next = 0;
        end;
    end;

    procedure childBirthdaySMS()
    var
        cust: Record Customer;
        vend: Record Vendor;
        childBirthMonth: Integer;
        childBirthDate: integer;
        childCurrMonth: Integer;
        childCurrDate: integer;
        ProgressWindow: Dialog;
        smsManagement: Codeunit "Sms Management";//
        childBday: Text[2500];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    begin
        vend.Reset();
        vend.SetRange("Account Type", '109');
        vend.SetFilter("Mobile Phone No", '<>%1','');
        if vend.Find('-') then begin
            repeat
                if vend."Child DOB" <> 0D then begin
                    childBirthMonth := Date2DMY(vend."Child DOB", 2);
                    childBirthDate := Date2DMY(vend."Child DOB", 1);
                    childCurrMonth := Date2DMY(Today, 2);
                    childCurrDate := Date2DMY(Today, 1);
                    if (childBirthDate = childCurrDate) and (childBirthMonth = childCurrMonth) then begin
                        cust.Get(vend."BOSA Account No");
                        childBday:= 'Happy Birthday '+vend."Child Name"+'! May this new year bring along many Opportunities, Love, Joy & Happiness. Thank you for Banking with us.';
                        smsManagement.SendSmsWithID(Source::CRM, cust."Mobile Phone No", childBday, cust."No.", cust."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                    end
                end;
            until vend.Next()=0
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
    
    procedure PhoneNo(ClientCode:Code[40])mobile: code[50]
    var
       Customer: record Customer;
       FirstLetter: Text;
       OtherLetters: Text[40];
    begin
        Customer.Reset();
        Customer.SetRange(Customer."No.",ClientCode);
        if Customer.FindFirst() then begin
            mobile := customer."Mobile Phone No";
            exit(mobile);
        end;
    end;
}
