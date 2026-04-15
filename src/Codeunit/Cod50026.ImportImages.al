// //************************************************************************
// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// Codeunit 50025 "Import Images"
// {

//     trigger OnRun()
//     begin
//         GetImages();
//     end;

//     var
//         objMembers: Record Vendor;
//         InStream1: InStream;
//         InputFile: File;
//         OutStream1: OutStream;


//     procedure GetImages()
//     var
//         filename: Text[100];
//         InStream1: InStream;
//         OutStream1: OutStream;
//     //objMembers: Record "Members Register";
//     begin
//         objMembers.Reset;
//         if objMembers.FindSet(true, false) then begin
//             repeat
//                 filename := 'C:\Downloads\' + objMembers."Sacco No" + '.gif';
//                 if objMembers.Signature.count > 0 then
//                     Clear(objMembers.Signature);
//                 //  if FILE.Exists(filename) then begin
//                 //    InputFile.Open(filename);
//                 //    InputFile.CreateInstream(InStream1);
//                 //objMembers.Signature.ExportFile()
//                 objMembers.Signature.ImportStream(InStream1, 'signature', 'jpg');
//                 CopyStream(OutStream1, InStream1);
//                 objMembers.Modify;
//             // InputFile.Close;

//             //  end;
//             until objMembers.Next = 0;
//             Message('Imported successfully');
//         end;
//     end;
// }

codeunit 50026 "Mdosi Jnr Piggy Bank Reminders"
{
    trigger OnRun()
    begin
        FnSendReminder();
    end;
    
    local procedure FnCheckPiggyBankEligibility(MdosiJnrAcc: Code[20]) : Boolean
    var
        myInt: Integer;
    begin
        piggyBank.Reset();
        piggyBank.SetRange("Piggy Bank Account", MdosiJnrAcc);
        if piggyBank.Find('-') = false then begin

            reffCredits := 0;
            accCredits := 0;

            accTypes.Reset();
            if accTypes.Get('109') then begin
                reffCredits := accTypes."Interest Calc Min Balance";
            end;

            detVend.Reset();
            detVend.SetRange("Vendor No.", MdosiJnrAcc);
            detVend.SetRange(Reversed, false);
            detVend.SetFilter("Credit Amount", '>%1', 0);
            if detVend.FindSet() then begin
                detVend.CalcSums("Credit Amount");
                accCredits := detVend."Credit Amount";
            end;

            if accCredits >= reffCredits then begin
                exit(true);
            end else exit(false);

        end else exit(false);

    end;

    local procedure FnSendReminder()
    var
        myInt: Integer;
    begin
        vend.Reset();
        vend.SetRange("Account Type", '109');
        if vend.FindSet() then begin
            repeat
            cust.Reset();
            if cust.Get(vend."BOSA Account No") then begin
                if FnCheckPiggyBankEligibility(vend."No.") then begin
                    smsMessage := StrSubstNo(smsMessageTemplate, NameStyle.NameStyle(cust."No."), vend."Child Name");
                   // smsManagement.SendSmsWithID(Source::PIGGY_BANK, cust."Mobile Phone No", smsMessage, cust."No.", cust."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                end;
            end;
            until vend.Next() = 0;
        end;
    end;
    var
        myInt: Integer;
        accCredits: Decimal;
        reffCredits: Decimal;
        smsMessage: Text[1800];
        smsMessageTemplate: Label 'Dear %1, Your Mdosi Junior account for %2 is eligible for a Piggy Bank issuance. Kindly visit the Sacco to receive it. Thank you for banking with us.';
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY,MEMBER_ALLOWANCES,DIVIDEND_PROCESSING;
        smsManagement: Codeunit "Sms Management";
        NameStyle: Codeunit "Send Birthday SMS";
        vend: Record Vendor;
        cust: Record Customer;
        piggyBank: Record "Piggy Bank Issuance";
        detVend: Record "Detailed Vendor Ledg. Entry";
        accTypes: Record "Account Types-Saving Products";
}
