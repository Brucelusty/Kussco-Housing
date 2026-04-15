page 50032 "Sacco ATM Cards Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = Vendor;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("No.";Rec."No.")
                {
                    Editable = False;
                }
                field(Name;Rec.Name)
                {
                    Editable = False;
                }
                field("ATM No.";Rec."ATM No.")
                {
                    Editable = false;
                }
                field("Personal No.";Rec."Personal No.")
                {
                    Editable = False;
                    Caption = 'Payroll No.';
                }
                field("ID No.";Rec."ID No.")
                {
                    Editable = False;
                }
                field("ATM Enabled";Rec."ATM Enabled")
                {
                    Editable = False;
                }
                field("ATM Expiry Date";Rec."ATM Expiry Date")
                {
                    Editable = False;
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            
            group("ATM Re-linking")
            {
                action("Re-Link ATM Card")
                {
                    Caption = 'Re-Link ATM Card';
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SmsCodeunit: Codeunit "Sms Management";
                        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
                    begin
                        UserSetup.Get(UserId);
                        if UserSetup.Overdraft <> true then Error('You do not have permission to update ATM card information.');
                        if Rec."ATM No." <> '' then begin
                            if Confirm('Do you wish to proceed with re-linking this member''s ATM card?', true) = false then exit;
                            vend.Reset();
                            vend.SetRange("No.", rec."No.");
                            vend.SetRange("Account Type", '103');
                            if vend.Find('-') then begin
                                Report.Run(175074, true, false, vend);
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
    vend: Record Vendor;
    UserSetup: Record "User Setup";
}


