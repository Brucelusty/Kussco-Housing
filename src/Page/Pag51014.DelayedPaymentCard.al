page 51014 "Delayed Payment Card"
{
    ApplicationArea = All;
    Caption = 'Delayed Payment Card';
    PageType = Card;
    SourceTable = "Delayed Payment";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                    TableRelation = "Salary Processing Headerr".No where(Posted = const(true));
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ToolTip = 'Specifies the value of the Transaction Description field.';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field("Account Type"; Rec."Account Type")

                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Doc Posting Date"; Rec."Doc Posting Date")
                {
                    //Editable = false;
                }
                field("Balancing Account Balance"; Rec."Balancing Account Balance")
                {
                    Editable = false;
                }

                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    Editable = false;
                }

                field("Scheduled Amount New Members"; Rec."Scheduled Amount New Members")
                {
                    Editable = false;
                }

                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Gra field.';
                }

                field("New Salary"; Rec."New Salary")
                {
                    ToolTip = 'Specifies the value of the Gra field.';
                }
            }

            part("172000"; "Delayed Payment  Lines")
            {
                Caption = 'Delayed Payment  Lines';
                // Enabled = false;
                SubPageLink = "Payment Header No." = field(No);
            }
        }

    }

    actions
    {
        area(Processing)
        {


            action("Load Lines")
            {
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    if Confirm('Load Payment?', true, false) = true then begin
                        Paymentlines.Reset();
                        Paymentlines.SetRange(Paymentlines."Payment Header No.", Rec.No);
                        if Paymentlines.FindSet() then begin
                            Paymentlines.DeleteAll();
                        end;
                        if Rec."Payment Type" = Rec."Payment Type"::all then begin
                            SalPayment.Reset();
                            SalPayment.SetRange(SalPayment."Document Number", Rec."Document No");
                            if SalPayment.FindFirst() then begin
                                repeat
                                    Paymentlines.Init();
                                    Paymentlines."Account No." := SalPayment."FOSA Account No";
                                    Paymentlines."Member No" := SalPayment."Member No";
                                    Paymentlines."Payment Header No." := Rec.No;
                                    Paymentlines."Document No." := SalPayment."Document Number";
                                    Paymentlines.Amount := Round((SalPayment."Net Salary"), 0.01, '=');
                                    Paymentlines."Staff No." := SalPayment."Payroll No";
                                    Paymentlines.Region := SalPayment.Region;
                                    Paymentlines.Grade := SalPayment.Grade;
                                    Paymentlines."Account Name" := SalPayment."Member Name";
                                    Paymentlines.Insert();
                                until SalPayment.Next() = 0;
                            end;
                        end;

                        if Rec."Payment Type" = Rec."Payment Type"::"Region Only" then begin
                            Rec.TestField(Region);
                            SalPayment.Reset();
                            SalPayment.SetRange(SalPayment."Document Number", Rec."Document No");
                            SalPayment.SetRange(SalPayment.Region, Rec.Region);
                            if SalPayment.FindFirst() then begin
                                repeat
                                    Paymentlines.Init();
                                    Paymentlines."Account No." := SalPayment."FOSA Account No";
                                    Paymentlines."Member No" := SalPayment."Member No";
                                    Paymentlines."Payment Header No." := Rec.No;
                                    Paymentlines."Document No." := SalPayment."Document Number";
                                    Paymentlines.Amount := Round((SalPayment."Net Salary"), 0.01, '=');
                                    Paymentlines."Staff No." := SalPayment."Payroll No";
                                    Paymentlines.Region := SalPayment.Region;
                                    Paymentlines.Grade := SalPayment.Grade;
                                    Paymentlines."Account Name" := SalPayment."Member Name";
                                    Paymentlines.Insert();
                                until SalPayment.Next() = 0;
                            end;
                        end;

                        if Rec."Payment Type" = Rec."Payment Type"::"Region & Grade" then begin
                            Rec.TestField(Region);
                            Rec.TestField(Grade);
                            SalPayment.Reset();
                            SalPayment.SetRange(SalPayment."Document Number", Rec."Document No");
                            SalPayment.SetRange(SalPayment.Region, Rec.Region);
                            SalPayment.SetRange(SalPayment.Grade, Rec.Grade);
                            if SalPayment.FindFirst() then begin
                                repeat
                                    Paymentlines.Init();
                                    Paymentlines."Account No." := SalPayment."FOSA Account No";
                                    Paymentlines."Member No" := SalPayment."Member No";
                                    Paymentlines."Payment Header No." := Rec.No;
                                    Paymentlines."Document No." := SalPayment."Document Number";
                                    Paymentlines.Amount := Round((SalPayment."Net Salary"), 0.01, '=');
                                    Paymentlines."Staff No." := SalPayment."Payroll No";
                                    Paymentlines.Region := SalPayment.Region;
                                    Paymentlines.Grade := SalPayment.Grade;
                                    Paymentlines."Account Name" := SalPayment."Member Name";
                                    Paymentlines.Insert();
                                until SalPayment.Next() = 0;
                            end;
                        end;
                        Message('Lines have been loaded');
                        //Post New
                    end;
                end;
            }

            action("Mark New Members")
            {
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Vend: Record Vendor;
                begin
                    if Confirm('Mark New Members?', true, false) = true then begin

                        if (Rec."Payment Type" = Rec."Payment Type"::all) and (Rec."New Salary" = true) then begin
                            Paymentlines.Reset();
                            Paymentlines.SetRange(Paymentlines."Payment Header No.", Rec.No);
                            if Paymentlines.FindFirst() then begin
                                repeat
                                    Vend.Reset();
                                    Vend.SetRange(Vend."BOSA Account No", Paymentlines."Member No");
                                    Vend.SetRange(Vend."Salary earner", false);
                                    Vend.SetRange(Vend."Account Type", '103');
                                    if Vend.FindFirst() then begin
                                        Paymentlines."New Salary" := true;
                                        Paymentlines.Modify();
                                    end;
                                until Paymentlines.Next() = 0;
                            end;
                        end;



                    end;
                end;
            }
            action("Post Payment")
            {
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Salaries: Record "Salary Details";
                    Cust: Record Customer;
                    MessageX: Text[1200];
                    MonthName: text[40];
                    smsManagement: Codeunit "Sms Management";
                    SalaryHeader: Record "Salary Processing Headerr";
                    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
                begin
                    if Confirm('Post Payment?', true, false) = true then begin
                        if Rec."New Salary" = false then begin
                            BATCH_TEMPLATE := 'GENERAL';
                            BATCH_NAME := 'SALARIES';
                            DOCUMENT_NO := Rec.No;
                            EXTERNAL_DOC_NO := Rec."Document No";

                            Rec.TestField("Transaction Description");

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;

                            Paymentlines.Reset();
                            Paymentlines.SetRange(Paymentlines."Payment Header No.", Rec.No);
                            Paymentlines.SetRange(Paymentlines."New Salary", false);
                            if Paymentlines.FindFirst() then begin
                                repeat
                                    LineNo := LineNo + 10000;
                                    FnPostNet(Paymentlines, Paymentlines.Amount, Rec);

                                    FnMarkPayment(Rec."Document No", Paymentlines."Member No");
                                until Paymentlines.Next() = 0;
                            end;
                            LineNo := LineNo + 10000;
                            Rec.CalcFields("Scheduled Amount");//

                            SaccoGeneral.Get();
                            SaccoGeneral.TestField("Delayed Net Account");
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                          Rec."Account Type", Rec."Account No", Rec."Doc Posting Date", Round((Rec."Scheduled Amount"), 0.01, '='), '', EXTERNAL_DOC_NO,
                           'Salary ', '', GenJournalLine."application source"::" ", '', GenJournalLine."Salary Receipt Type"::"Net Pay");

                            //Post New
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                            end;
                            //Post New
                            Salaries.Reset();
                            Salaries.SetRange(Salaries."Document Number", Rec."Document No");
                            Salaries.SetRange(Salaries.Region, Rec.Region);
                            Salaries.SetRange(Salaries.Grade, Rec.Grade);
                            if Salaries.FindSet() then begin
                                repeat
                                    Cust.Reset;
                                    Cust.Setrange(Cust."No.", Salaries."Member No");
                                    If Cust.Find('-') then begin
                                        if (Cust."Mobile Phone No" <> '') then begin
                                            SalaryHeader.Get(Salaries."Document Number");
                                            MessageX := '';
                                            MonthName := '';
                                            MonthName := FORMAT(SalaryHeader."Loan Cutoff", 0, '<Month Text>');
                                            MessageX := 'Dear ' + Cust."First Name" + ', Your ' + MonthName + ' Salary of Ksh ' + Format(Salaries."Gross Amount") + ' has been credited to your account,you can access through the ATM and M-Banking. Thank you for your patronage.';
                                            //smsManagement.SendSmsWithID(Source::SALARY_PROCESSING, Cust."Mobile Phone No", MessageX, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');

                                        end;
                                    end;

                                until Salaries.Next() = 0;

                            end;
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec."Posting date" := Today;
                            Message('Payment Posted Successfully.');
                            Rec.Modify();
                        end;

                        if Rec."New Salary" = true then begin
                            BATCH_TEMPLATE := 'GENERAL';
                            BATCH_NAME := 'SALARIES';
                            DOCUMENT_NO := Rec.No;
                            EXTERNAL_DOC_NO := Rec."Document No";

                            Rec.TestField("Transaction Description");

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;

                            Paymentlines.Reset();
                            Paymentlines.SetRange(Paymentlines."Payment Header No.", Rec.No);
                            Paymentlines.SetRange(Paymentlines."New Salary", true);
                            if Paymentlines.FindFirst() then begin
                                repeat
                                    LineNo := LineNo + 10000;
                                    FnPostNet(Paymentlines, Paymentlines.Amount, Rec);

                                    FnMarkPayment(Rec."Document No", Paymentlines."Member No");
                                until Paymentlines.Next() = 0;
                            end;
                            LineNo := LineNo + 10000;
                            Rec.CalcFields("Scheduled Amount New Members");//
                            SaccoGeneral.Get();
                            SaccoGeneral.TestField("Delayed Net Account");
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                          Rec."Account Type", Rec."Account No", Rec."Doc Posting Date", Round((Rec."Scheduled Amount New Members"), 0.01, '='), '', EXTERNAL_DOC_NO,
                           'Salary ', '', GenJournalLine."application source"::" ", '', GenJournalLine."Salary Receipt Type"::"Net Pay");

                            //Post New
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                            end;
                            //Post New
                            Paymentlines.Reset();
                            Paymentlines.SetRange(Paymentlines."Payment Header No.", Rec.No);
                            Paymentlines.SetRange(Paymentlines."New Salary", true);
                            if Paymentlines.FindSet() then begin
                                repeat
                                    Cust.Reset;
                                    Cust.Setrange(Cust."No.", Paymentlines."Member No");
                                    If Cust.Find('-') then begin
                                        if (Cust."Mobile Phone No" <> '') then begin
                                            SalaryHeader.Get(Paymentlines."Document No.");

                                            Salaries.Reset();
                                            Salaries.SetRange(Salaries."Document Number", Paymentlines."Document No.");
                                            Salaries.SetRange(Salaries."Member No", Paymentlines."Member No");
                                            if Salaries.FindFirst() then
                                                MessageX := '';
                                            MonthName := '';
                                            MonthName := FORMAT(SalaryHeader."Loan Cutoff", 0, '<Month Text>');
                                            MessageX := 'Dear ' + Cust."First Name" + ', Your ' + MonthName + ' Salary of Ksh ' + Format(Salaries."Gross Amount") + ' has been credited to your account,you can access through the ATM and M-Banking. Thank you for your patronage.';
                                            //smsManagement.SendSmsWithID(Source::SALARY_PROCESSING, Cust."Mobile Phone No", MessageX, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');

                                        end;
                                    end;

                                until Paymentlines.Next() = 0;

                            end;
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec."Posting date" := Today;
                            Message('Payment Posted Successfully.');
                            Rec.Modify();
                        end;
                    end;
                end;
            }
        }
    }

    var
        SalPayment: Record "Salary Details";
        LineNo: Integer;
        Paymentlines: Record "Delayed Payment Lines";
        SaccoGeneral: Record "Sacco General Set-Up";
        SFactory: Codeunit "Au Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";

        EXTERNAL_DOC_NO: Code[60];

    local procedure FnPostNet(ObjRcptBuffer: Record "Delayed Payment Lines"; RunningBalance: Decimal; ObjRcptRec: Record "Delayed Payment")
    var
        AmountToDeduct: Decimal;

    begin
        if RunningBalance > 0 then begin



            if RunningBalance > 0 then begin
                AmountToDeduct := 0;
                AmountToDeduct := RunningBalance;
                SaccoGeneral.Get();
                SaccoGeneral.TestField("Delayed Net Account");
                SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."Account Type"::Vendor, ObjRcptBuffer."Account No.", Rec."Doc Posting Date", AmountToDeduct * -1, '', EXTERNAL_DOC_NO,
               'Salary ', '', GenJournalLine."application source"::" ", ObjRcptBuffer."Member No", GenJournalLine."Salary Receipt Type"::"Net Pay");

            end;


        end;
    end;

    local procedure FnMarkPayment(SalNos: Code[40]; MemberNo: Code[40])
    var
    begin
        SalPayment.Reset();
        SalPayment.SetRange(SalPayment."Member No", MemberNo);
        SalPayment.SetRange(SalPayment."Document Number", SalNos);
        if SalPayment.FindFirst() then begin
            SalPayment.Posted := true;
            SalPayment."Posting Date" := Today;
            SalPayment.Validate("Posting Date");
            SalPayment.Modify();
        end;
    end;
}


