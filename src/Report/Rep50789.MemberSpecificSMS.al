report 50789 "Member Specific SMS"
{
    ApplicationArea = All;
    Caption = 'Member Bio Data Update SMS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = where(IsNormalMember = filter(true));
            RequestFilterFields = "No.", "Employer Code", "Date Of Birth", "Registration Date", "Membership Status";
            column(No_;"No.")
            {}
            // column()
            // {}

            trigger OnPreDataItem()
            begin
                if customLink = '' then Error('Kindly ensure the Google Form Link has been keyed in.');
            end;

            trigger OnAfterGetRecord() begin
                if Customer."Mobile Phone No" <> '' then begin
                    smsMessage := StrSubstNo(smsMessageTemplate, nameStyle.NameStyle(Customer."No."), Format(Customer."Date of Birth"), Customer."E-Mail", customLink);
                    smsManagement.SendSmsWithID(Source::CRM, Customer."Mobile Phone No", smsMessage, Customer."No.", Customer."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('The Message(s) were processed and sent successfully.');
            end;
        }
    }
    
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group("Custom Info")
                {
                    field(customLink;customLink)
                    {
                        Caption = 'Google Form Link';
                    ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }
        }
    }

    
    var
    myInt: Integer;
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY,MEMBER_ALLOWANCES,DIVIDEND_PROCESSING;
    customLink: Text[100];
    smsMessage: Text[1800];
    smsMessageTemplate: Label 'Dear %1, Greetings from TELEPOST SACCO. According to our records, your date of birth is %2, and your current e-mail is %3. Did we get it right? Click ''%4'' to update us. #Mbele Iko Sawa.';
    smsManagement: Codeunit "SMS Management";
    nameStyle: Codeunit "Send Birthday SMS";

}



