//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50744 "Bulk SMS Header"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = Card;
    SourceTable = "Bulk SMS Header";

    layout
    {
        area(content)
        {
            field(No; Rec.No)
            {
                Editable = false;
            }
            field("Date Entered"; Rec."Date Entered")
            {
                Editable = false;
            }
            field("Time Entered"; Rec."Time Entered")
            {
                Editable = false;
            }
            field("Entered By"; Rec."Entered By")
            {
                Editable = false;
            }
            field("SMS Type"; Rec."SMS Type")
            {
                trigger
                OnValidate()
                begin
                    
                end;
            }
            field("Employer Code"; Rec."Employer Code")
            {
                Editable = employer;
            }
            field("Activity Status";Rec."Activity Status")
            {
                Editable = active;
            }
            field("SMS Status"; Rec."SMS Status")
            {
                Editable = false;
            }
            field("Status Date"; Rec."Status Date")
            {
                Editable = false;
            }
            field("Status Time"; Rec."Status Time")
            {
                Editable = false;
            }
            field("Status By"; Rec."Status By")
            {
                Editable = false;
            }
            field(Message; Rec.Message)
            {
                // Editable = message;
                MultiLine = true;
            }
            group(Additional)
            {
                field("Second Message"; Rec.MessageII)
                {
                    // Editable = message;
                    Importance = Additional;
                    MultiLine = true;
                }
            }
            part(Control1000000012; "Bulk SMS Lines Part")
            {
                Caption = '<Bulk SMS Lines>';
                Editable = true;
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Mobile Phone Nos")
            {
                Image = Import;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = rec."SMS Type" = rec."SMS Type"::Telephone;
                RunObject = xmlport "Import Bulk SMS Mobile Nos";
            }
            action("Validate Mobile Phone Nos")
            {
                Image = Confirm;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = rec."SMS Type" = rec."SMS Type"::Telephone;

                trigger OnAction()
                begin
                    BulkLines.Reset();
                    BulkLines.SetRange(No, Rec.No);
                    if BulkLines.Find('-') then
                    begin
                        repeat
                            if BulkLines.Code = '' then
                            begin
                                Error('Empty Mobile Phone No.');
                            end else 
                            begin
                                Cust.SetRange("Mobile Phone No", BulkLines.Code);
                                if Cust.find('-') then begin
                                    BulkLines."Member No":= Cust."No.";
                                    BulkLines.Modify;
                                end
                                else begin
                                    BulkLines."Member No":= '';
                                    BulkLines.Modify;
                                end;
                            end;
                        until BulkLines.Next() = 0;
                    end;
                end;
            }
            action(Send)
            {
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Blines: Codeunit "Send Birthday SMS";
                    UserSetup: Record "User Setup";
                begin

                    UserSetup.Get(UserId);
                    if UserSetup."Bulk SMS" <> true then Error('You have no permissions to send bulk SMS.');
                    if Confirm('Are you sure you want to send this SMS?', true, false) = true then begin
                        if (Rec."SMS Type" = Rec."SMS Type"::Everyone) and (Rec.Message <> '') then begin
                            Cust.Reset();
                            //Cust.Setfilter(Cust."No.",'00493');
                            Cust.SetRange(Cust.Status, Rec."Activity Status");
                            Cust.SetFilter(Cust."Mobile Phone No", '<>%1', '');
                            if Cust.Find('-') then begin
                                repeat
                                    Prefix := 'Dear ' + Blines.NameStyle(Cust."No.") + ', ' + Rec.Message + Rec.MessageII;
                                    //smsManagement.SendSmsResponse(Cust."Mobile Phone No", Prefix);
                                    smsManagement.SendSmsWithID(Source::CRM, Cust."Mobile Phone No", Prefix, Cust."No.", Cust."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                                // end;
                                until Cust.Next() = 0;
                            end;
                        end;

                        if (Rec."SMS Type" = Rec."SMS Type"::Employees) and (Rec.Message <> '') then begin
                            Cust.Reset();
                            Cust.SetRange(Cust."Employer Code", Rec."Employer Code");
                            Cust.SetRange(Cust.Status, Rec."Activity Status");
                            Cust.SetFilter(Cust."Mobile Phone No", '<>%1', '');
                            if Cust.Find('-') then begin
                                repeat
                                    Prefix := 'Dear ' + Blines.NameStyle(Cust."No.") + ', ' + Rec.Message + Rec.MessageII;
                                    //smsManagement.SendSmsResponse(Cust."Mobile Phone No", Prefix);
                                    smsManagement.SendSmsWithID(Source::CRM, Cust."Mobile Phone No", Prefix, Cust."No.", Cust."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                                // end;
                                until Cust.Next() = 0;
                            end;
                        end;

                        if Rec."SMS Type" = Rec."SMS Type"::Telephone then begin
                            BulkLines.Reset();
                            BulkLines.SetRange(BulkLines.No, rec.No);
                            BulkLines.SetFilter(Code, '<>%1','');
                            if BulkLines.Find('-') then begin
                                repeat
                                    // Message('Here');
                                    Cust.Reset();
                                    Cust.SetRange(Cust."No.", BulkLines."Member No");
                                    Cust.SetFilter(Cust."Mobile Phone No", '<>%1', '');
                                    if Cust.Find('-') then begin
                                        if BulkLines.Description <> '' then begin
                                            Prefix := 'Dear ' + Blines.NameStyle(Cust."No.") + ', ' + BulkLines.Description;
                                            smsManagement.SendSmsWithID(Source::CRM, Cust."Mobile Phone No", Prefix, Cust."No.", Cust."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                                        end else begin
                                            Prefix := 'Dear ' + Blines.NameStyle(Cust."No.") + ', ' + rec.Message + rec.MessageII;
                                            smsManagement.SendSmsWithID(Source::CRM, Cust."Mobile Phone No", Prefix, Cust."No.", Cust."FOSA Account No.", false, 200, false, 'CBS', CreateGuid(), 'CBS');
                                        end;
                                    end
                                    else
                                    begin
                                        if BulkLines.Description <> '' then begin
                                            Prefix := BulkLines.Description;
                                            smsManagement.SendSmsWithID(Source::CRM, BulkLines.Code, Prefix, '', '', false, 200, false, 'CBS', CreateGuid(), 'CBS');
                                        end else begin
                                            Prefix := rec.Message + rec.MessageII;
                                            smsManagement.SendSmsWithID(Source::CRM, BulkLines.Code, Prefix, '', '', false, 200, false, 'CBS', CreateGuid(), 'CBS');
                                        end;
                                    end;
                                until BulkLines.Next() = 0;
                            end;
                        end;
                        Rec.Posted := true;
                        Rec."Sent By" := UserId;
                        Rec.Modify();
                        Message('SMS successfully sent.');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        employer := false;
        active := false;
        message := false;
        if rec."SMS Type" = rec."SMS Type"::Everyone then begin
            employer := false;
            active := true;
            message := true;
        end;
        if rec."SMS Type" = rec."SMS Type"::Employees then begin
            employer := true;
            active := true;
            message := true;
        end;
        if rec."SMS Type" = rec."SMS Type"::Telephone then begin
            active := false;
            message := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        employer := false;
        active := false;
        message := false;
        if rec."SMS Type" = rec."SMS Type"::Everyone then begin
            employer := false;
            active := true;
            message := true;
        end;
        if rec."SMS Type" = rec."SMS Type"::Employees then begin
            employer := true;
            active := true;
            message := true;
        end;
        if rec."SMS Type" = rec."SMS Type"::Telephone then begin
            active := false;
            message := false;
        end;
    end;
    var
        Cust: Record Customer;
        smsManagement: Codeunit "Sms Management";
        BulkLines: Record "Bulk SMS Lines";
        Prefix: Text[1800];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
        employer: Boolean;
        active: Boolean;
        message: Boolean;
}


