//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50448 "Piggy Bank Issuance Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Piggy Bank Issuance";
    DeleteAllowed = false;
    

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                    Editable = false;
                }
                field("Member Account No";Rec."Member No")
                {
                    Editable = not Issued;
                }
                field("Member Name";Rec."Member Name")
                {
                    Editable = false;
                }
                field("Piggy Bank Account";Rec."Piggy Bank Account")
                {
                    ShowMandatory = true;
                    Editable = not Issued;

                    trigger OnValidate()
                    begin
                        // PiggyBankIssuance.Reset;
                        // PiggyBankIssuance.SetRange(PiggyBankIssuance."Piggy Bank Account", Rec."Piggy Bank Account");
                        // PiggyBankIssuance.SetRange(PiggyBankIssuance.Issued, true);
                        // if PiggyBankIssuance.FindSet then
                        //     Rec."Exisiting piggy Bank" := true;
                    end;
                }
                field("Piggy Bank Account Name";Rec."Piggy Bank Account Name")
                {
                    Editable = false;
                }
                field("Piggy Bank No";Rec."Piggy Bank No")
                {
                    ShowMandatory = true;
                    Editable = not Issued;
                }
                field("Exisiting piggy Bank";Rec."Exisiting piggy Bank")
                {
                    Caption = 'Has Existing Piggy Bank';
                    Editable = false;
                }
                field("Issued By";Rec."Issued By")
                {
                    Editable = false;
                }
                field("Issued On";Rec."Issued On")
                {
                    Editable = false;
                }
                field(Issued;Rec.Issued)
                {
                    Editable = false;
                }
            }
            group("Issuing Details")
            {
                field("Card Issued to Customer";Rec."Card Issued to Customer")
                {
                    Editable = not Issued;
                }
                field("Issued To";Rec."Issued To")
                {
                    Editable = not Issued;
                }
                field("Issued To ID No";Rec."Issued To ID No")
                {
                    Editable = not Issued;
                }
                field("Issued to Phone Number";Rec."Issued to Phone Number")
                {
                    Editable = not Issued;
                }
                field("Mode Of Dispatch";Rec."Mode Of Dispatch")
                {
                    Editable = not Issued;
                }
                field(Address;Rec.Address)
                {
                    Editable = not Issued;
                }
                field(Location;Rec.Location)
                {
                    Editable = not Issued;
                }
                field("Tracking Code";Rec."Tracking Code")
                {
                    Editable = not Issued;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Issue Piggy Bank")
            {
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = not Issued;

                trigger OnAction()
                begin
                    // if Confirm('Confirm Piggy Bank Charge?', false) = true then begin
                    //     GenJournalLine.Reset;
                    //     GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    //     GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    //     GenJournalLine.DeleteAll;

                    //     SFactory.FnRunPostPiggyBankCharges(Rec."Piggy Bank Account", Rec."Exisiting piggy Bank");
                    // end;
                    if rec."Piggy Bank Account" = '' then Error('You must input a FOSA Account to link the piggy bank.');
                    if rec."Piggy Bank No" = '' then Error('You must input the piggy bank number.');

                    if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Card Sent" then begin
                        if (rec."Issued to" = '') or (rec."Issued to Phone Number" = '') or (rec."Issued To ID No" = '') or (rec."Issued to" = '') or (rec.Location = '') or (rec.Address = '') or (rec."Tracking Code" = '') then begin
                            Error('The details of where the card is to be issued must be clearly stated before issuing it.');
                        end;
                    end else if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Card Issued to" then begin
                        if (rec."Issued to" = '') or (rec."Issued to Phone Number" = '') or (rec."Issued To ID No" = '') or (rec."Issued to" = '') or (rec.Location = '') then begin
                            Error('The details of where the card is to be issued must be clearly stated before issuing it.');
                        end;
                    end else if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Owner Collected" then begin
                        if (rec."Issued to" = '') or (rec."Issued to Phone Number" = '') or (rec."Issued To ID No" = '') or (rec."Issued to" = '') then begin
                            Error('The details of where the card is to be issued must be clearly stated before issuing it.');
                        end;
                    end;
                    
                    if Confirm('Do you wish to proceed with issuing this piggy bank?', true) = false then exit;

                    Vend.Get(Rec."Piggy Bank Account");
                    if Vend.Get(Rec."Piggy Bank Account") then begin
                        if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Card Sent" then begin
                            SmsCodeunit.SendSmsWithID(Source::PIGGY_BANK, Vend."Mobile Phone No",'Dear '+vend.Name+', Your Piggy Bank for account '+rec."Piggy Bank Account"+' has been issued via parcel '+rec."Tracking Code"+' to your postal address '+rec.Address+', '+Rec.Location+'.',Vend."No.", Vend."No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                        end else if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Card Issued to" then begin
                            SmsCodeunit.SendSmsWithID(Source::PIGGY_BANK, Vend."Mobile Phone No",'Dear '+vend.Name+', Your Piggy Bank for account '+rec."Piggy Bank Account"+' has been issued to '+rec."Issued to"+' ID No. '+rec."Issued To ID No"+'.',Vend."No.", Vend."No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                        end else if rec."Card Issued to Customer" = rec."Card Issued to Customer"::"Owner Collected" then begin
                            SmsCodeunit.SendSmsWithID(Source::PIGGY_BANK, Vend."Mobile Phone No",'Dear '+vend.Name+', You have collected your Piggy Bank for account '+rec."Piggy Bank Account"+'.',Vend."No.", Vend."No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                        end;
                    end;

                    Rec."Issued On" := WorkDate;
                    Rec."Issued By" := UserId;
                    Rec.Issued := true;
                    Issued:= true;
                    
                    Message('Piggy bank issued successfully. The member will be notified via SMS.');
                end;
            }
        }
    }
    trigger OnOpenPage() begin
        Issued:= false;
        if rec.Issued = true then begin
            Issued := true;
        end else begin
            Issued := false;
        end;
    end;
    trigger OnAfterGetRecord() begin
        Issued:= false;
        if rec.Issued = true then begin
            Issued := true;
        end else begin
            Issued := false;
        end;
    end;

    var
    GenJournalLine: Record "Gen. Journal Line";
    LineNo: Integer;
    SFactory: Codeunit "Au Factory";
    VarPiggyBankFee: Decimal;
    ObjAccountType: Record "Account Types-Saving Products";
    vend: Record Vendor;
    ObjGensetup: Record "Sacco General Set-Up";
    VarTaxAmount: Decimal;
    VarAccountAvailableBal: Decimal;
    PiggyBankIssuance: Record "Piggy Bank Issuance";
    VarTransactionNarrationDebit: Text;
    VarTransactionNarrationCredit: Text;
    SmsCodeunit: Codeunit "Sms Management";
    Issued: Boolean;
    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK;

}






