//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51159 "Coop Dividends Header"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Coop Dividends Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    Enabled = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                    Visible = false;

                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = true;
                    Caption = 'Transaction Description';
                    Visible = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ShowMandatory = true;
                  
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                }
                field("Total Scheduled"; Rec."Total Scheduled")
                {
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Total Count"; Rec."Total Count")
                {
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Group Destination Account"; Rec."Group Destination Account")
                {
                    Importance = Promoted;
                    Style = Favorable;
                    visible = false;
                    StyleExpr = true;
                }
                field("Checkoff Type"; Rec."Checkoff Type")
                {
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
            }
            part("Checkoff Lines-Distributed"; "Coop Dividends Lines")
            {
                Caption = 'Coop Dividend Lines';
                SubPageLink = "Checkoff No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Lines")
            {
                Enabled = ActionEnabled;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('This Action will clear all the Lines for the current Coop Dividends. Do you want to Continue', true) = false then exit;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", Rec.No);
                    ReceiptLine.DeleteAll;

                end;
            }

            action("Import Coop Dividends")
            {
                Caption = 'Import Coop Dividends';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Coop Dividends";
            }



            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff")
            {
                Caption = 'Validate Coop Dividends';
                Enabled = ActionEnabled;
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin


                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", Rec.No);
                    if ReceiptLine.FindSet() then begin
                        repeat
                            UpdateCheckofflines();
                        until ReceiptLine.Next = 0;


                    end;
                    Message('Validation was successfully completed');
                end;
            }

            group(ActionGroup1102755019)
            {
            }
            action("Process Coop Dividends")
            {
                Caption = 'Process Coop Dividends';
                Enabled = ActionEnabled;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    LoanProductCode: Code[100];
                    DetCust: Record "Detailed Cust. Ledg. Entry";
                    ESSAmount: Decimal;
                begin
                    IF CONFIRM('Are you sure you want to Processs Dividends to Journals ?') = TRUE THEN BEGIN

                        Rec.TestField(Rec.Description);
                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'DIVIDEND';
                        DOCUMENT_NO := Rec.No;
                        Counter := 0;
                        Percentage := 0;
                        TotalCount := 0;

                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DELETEALL;

                        LineNo := 0;


                        ReceiptLine.RESET;
                        ReceiptLine.SETRANGE("Checkoff No", Rec.No);
                        IF ReceiptLine.FIND('-') THEN BEGIN
                            TotalCount := ReceiptLine.COUNT;
                            REPEAT
                                IF ReceiptLine."Member No" <> '' THEN BEGIN
                                    FnPostCoopDividendsToFosa(ReceiptLine);
                                end;

                            UNTIL ReceiptLine.NEXT = 0;
                        END;

                        MESSAGE('Checkoff successfully Generated. Journal Batch is ready for posting');
                    END;


                end;
            }
            action("Process Checkoff Unallocated")
            {
                Visible = false;

                trigger OnAction()
                begin
                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", Rec.Remarks);
                    if MembLedg.Find('-') = false then begin
                        Error('You Can Only do this process on Already Posted Checkoffs')
                    end;
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //Report.run(172543,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Process Annual Charge")
            {
                Image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Document No");
                    Rec.TestField(Amount);
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //REPORT.RUN(172100,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Mark as Posted")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    salarybuffer: Record "Coop Dividends Lines";
                    MessageX: Text[1500];
                    smsManagement: Codeunit "Sms Management";
                    Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Checkoff No", Rec.No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.Setrange(Cust."No.", salarybuffer."Member No");
                                If Cust.Find('-') then begin

                                    if (Cust."Mobile Phone No" <> '') then begin
                                        MessageX := '';
                                        MessageX := 'Dear ' + Cust."First Name" + ', Your Coop Dividends  of Amount Ksh ' + Format(salarybuffer.Amount) + ' has been credited to your account, access through the ATM and M-Banking. Thank you for your patronage.';
                                        smsManagement.SendSmsWithID(Source::SALARY_PROCESSING, Cust."Mobile Phone No", MessageX, Cust."No.", Cust."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');

                                    end;
                                end;

                            until salarybuffer.Next() = 0;
                         end;
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec."Posting date" := Today;
                            Rec.Modify;
                            Message('Account Holders have received Salary Processing notifications via SMS.');
                        end;
                    end;
            }
            action(Journals)
            {
                Caption = 'General Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "General Journal";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActionEnabled := true;
        /*         MembLedg.Reset;
                MembLedg.SetRange(MembLedg."Document No.", Rec.Remarks);
                MembLedg.SetRange(MembLedg."Document No.", Rec."Document No");
                if MembLedg.Find('-') then begin
                    ActionEnabled := false;
                end; */
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting date" := Today;
        Rec."Date Entered" := Today;

    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        Schedule: record "Loan Repayment Schedule";
        TotalPaidSchedule: Decimal;

        TotalPaid: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed-NT";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        LoanArrears: Decimal;
        DBranchBOSA: Code[20];
        DepositsAmount: Decimal;

        BBFAmount: Decimal;
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        PrincipleLoan: Decimal;
        RcptBufLines: Record "Checkoff Lines-Distributed";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        Vendors: Record Vendor;
        LineN: Integer;
        //GenBatches: Record "Gen. Journal Batch";

        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        IntAmount: Decimal;
        LoanAmount: Decimal;
        ShRec: Decimal;
        CheckoffL: Record "Checkoff Loans";
        Members: Record Customer;
        CheckoffLAmount: Decimal;
        SHARESCAP: Decimal;
        LoansR: Record "Loans Register";
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Coop Dividends Lines";

        ReceiptLines: Record "Checkoff Lines-Distributed-NT";
        MembLedg: Record "Detailed Cust. Ledg. Entry";
        SFactory: Codeunit "Au Factory";
        TotalDistributed: Decimal;
        RunBalOne: Decimal;
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        XMLCheckOff: XmlPort "Import Checkoff Distributed";
        Window: Dialog;
        TotalCount: Integer;

        CheckoffLoans: Record "Checkoff Loans";

        EntriesNo: Integer;
        Counter: Integer;
        Percentage: Integer;
        Gensetup: Record "General Ledger Setup";
        MembersR: Record Customer;
        Savaccount: Code[20];

    local procedure FnGetLoanNumber(MemberNo: Code[40]; LoanProducttype: Code[100]): Code[100]
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.CalcFields("Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange("Client Code", MemberNo);
        ObjLoans.SetRange("Loan Product Type", LoanProducttype);
        ObjLoans.SetFilter(Posted, 'Yes');
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
        if ObjLoans.FindFirst then
            exit(ObjLoans."Loan  No.");
    end;

    local procedure FnPostCoopDividendsToFosa(ObjSalaryLines: Record "Coop Dividends Lines")
    var
        AmountToDeduct: Decimal;
        ObjGenSetup: Record "Sacco General Set-Up";
        ExciseDutyP: Decimal;
        ExpectedAmount: Decimal;
        AmountDeducted: Decimal;
        EXTERNAL_DOC_NO: code[40];
        WTax: Decimal;
    begin
        ObjGenSetup.Get();
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"Bank Account", 'BNK00002', Rec."Posting date", ObjSalaryLines.Amount, 'FOSA',
        EXTERNAL_DOC_NO, Rec.Description, '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."FOSA Account", Rec."Posting date", ObjSalaryLines.Amount * -1, 'FOSA',
        EXTERNAL_DOC_NO, Rec.Description, '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"1-Gross salary");

        WTax := 0;
        WTax := ObjSalaryLines.Amount * 10 / 100;
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."FOSA Account", Rec."Posting date", WTax, 'FOSA',
        EXTERNAL_DOC_NO, 'Withholding Tax ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::" ");
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", ObjGenSetup."WithHolding Tax Account", Rec."Posting date", -WTax, 'FOSA',
        EXTERNAL_DOC_NO, 'Withholding Tax ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::" ");



        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."FOSA Account", Rec."Posting date", 500, 'FOSA',
        EXTERNAL_DOC_NO, 'Processing fee ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Rec."Posting date", -500, 'FOSA',
        EXTERNAL_DOC_NO, 'Processing fee ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");




        ExciseDutyP := ROUND((500 * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."FOSA Account", Rec."Posting date", ExciseDutyP, 'FOSA',
        EXTERNAL_DOC_NO, 'Excise Duty on Dividends ', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", -ExciseDutyP, 'FOSA',
        EXTERNAL_DOC_NO, 'Excise Duty on Dividends', '', GenJournalLine."application source"::" ", ObjSalaryLines."Member No", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");


    end;

    local procedure FnGetFosaAccountNo(BosaAccountNo: Code[40]; LoanProducttype: Code[100]): Code[100]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange("BOSA Account No", BosaAccountNo);
        ObjVendor.SetRange("Account Type", LoanProducttype);
        if ObjVendor.Find('-') then
            exit(ObjVendor."No.");
    end;

    local procedure FnCheckLoanErrors(LoanProduct: Code[100]; Amount: Decimal; MemberNo: Code[40]) IsInvalidLoan: Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if Amount > 0 then begin
            IsInvalidLoan := true;
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetRange("Loan Product Type", LoanProduct);
            ObjLoans.SetRange(Posted, true);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
            if ObjLoans.FindFirst then begin
                IsInvalidLoan := false;
            end
        end;
        exit(IsInvalidLoan);
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Checkoff Lines-Distributed"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        LoanApp.CalcFields(LoanApp."Outstanding Balance");
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
            LoanApp.SetFilter(Posted, 'Yes');

            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            /*18/02/2020
                            varLRepayment:=0;
                            PRpayment:=0;
                            IF LoanApp."Loan Interest Repayment"> 0 THEN
                            varLRepayment:=ROUND(LoanApp."Loan Principle Repayment",1,'>')
                             ELSE varLRepayment:=ROUND(LoanApp."Loan Repayment",1,'>');
                             */
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := ROUND(LoanApp."Loan Principle Repayment", 1, '>');
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then
                                    AmountToDeduct := RunningBalance;

                                begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;

                                LineNo := LineNo + 10000;
                                //                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                                //                    GenJournalLine."Account Type"::Member,LoanApp."Client Code","Posting date",AmountToDeduct*-1,FORMAT(LoanApp.Source),"Document No",
                                //                    FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),LoanApp."Loan  No.",,'');
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;


                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;

    end;

    local procedure FnRunPrincipleExcessThirdParty(ObjRcptBuffer: Record "Checkoff Lines-Distributed"; RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        LoanApp.CalcFields(LoanApp."Outstanding Balance");
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.FindFirst then begin
                //IF LoanApp.FIND('-') THEN BEGIN
                //  SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                //    GenJournalLine."Account Type"::Member,LoanApp."Client Code","Posting date",RunningBalance*-1,FORMAT(LoanApp.Source),"Document No",
                //    FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),LoanApp."Loan  No.");


            end else begin
                //  SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
                //    GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",(ReceiptLine.THIRDPARTY)* -1,'BOSA',"Document No",
                //    FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution"),'');





                // // FRED start
                // IF FnCheckLoanErrors('GUR',ReceiptLine.THIRDPARTY,ReceiptLine."Member No") THEN BEGIN
                //        LineNo:=LineNo+10000;
                //        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
                //        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",(ReceiptLine.THIRDPARTY)*-1,'BOSA',"Document No",
                //        FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution"),'');
                //    END ELSE
                //    BEGIN
                //        LineNo:=LineNo+10000;
                //       SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                //       GenJournalLine."Account Type"::Member,LoanApp."Client Code","Posting date",RunningBalance*-1,FORMAT(LoanApp.Source),"Document No",
                //       FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),LoanApp."Loan  No.");
                //        //SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                //        //GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.THIRDPARTY*-1,'BOSA',"Document No",
                //        //FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'GUR'));
                //
                // END;
                //Fred end
            end;
        end;
    end;

    local procedure FnInitiateProgressBar()
    begin
    end;

    local procedure FnUpdateProgressBar()
    begin
        Percentage := (ROUND(Counter / TotalCount * 10000, 1));
        Counter := Counter + 1;
        Window.Update(1, Percentage);
    end;

    local procedure UpdateCheckofflines()
    begin
        //Message('home true %1-%2-%3', ReceiptLine."Member No", Memb."No.", ReceiptLine."Checkoff No");
        TotalDistributed := 0;

        Memb.Reset;
        Memb.SetRange(Memb."Payroll No", ReceiptLine."Payroll No");
        if Memb.Find('-') then begin
            ReceiptLine."Payroll No" := Memb."Payroll No";
            ReceiptLine."Employee Name" := Memb.Name;
            ReceiptLine."Member No" := Memb."No.";
            ReceiptLine."FOSA Account" := Memb."FOSA Account No.";

            ReceiptLine.Modify();
            ReceiptLine.TOTAL_DISTRIBUTED := ReceiptLine.Deposits +
            ReceiptLine.DL_P +
            ReceiptLine.DL_I +
            ReceiptLine.NL_P +
            ReceiptLine.NL_I +
            ReceiptLine.EMER_P +
            ReceiptLine.EMER_I +
            ReceiptLine.HouseHL_I +
            ReceiptLine.HouseHL_P +
            ReceiptLine.HarakaL_I +
            ReceiptLine.HarakaL_P +
            ReceiptLine."Dependand Savings 1" +
             ReceiptLine.BENEVOLENT +
            ReceiptLine.SAdvanceL_I +
            ReceiptLine.SAdvanceL_P +
            ReceiptLine.SchoolF_P +
            ReceiptLine.SchoolF_I +
            ReceiptLine.SuperSL_P +
            ReceiptLine.SuperSL_I +
            ReceiptLine.JumboL_P +
            ReceiptLine.JumboL_I +
            ReceiptLine.SpecialL_I + ReceiptLine.SpecialL_P + ReceiptLine."Dependand Savings 2" + ReceiptLine."Dependand Savings 3"
            + ReceiptLine.DeFL_I + ReceiptLine.DeFL_P + ReceiptLine."PremiumL-I" + ReceiptLine."PremiumL-P" + ReceiptLine."Holiday Savings" + ReceiptLine."Utafiti Housing" +
            ReceiptLine.DhamanaL_I + ReceiptLine.DhamanaL_P + ReceiptLine.Mavuna_I + ReceiptLine.Mavuno_L + ReceiptLine.REGFEE +

            ReceiptLine.SHARES;

            //ReceiptLine.TOTAL_DISTRIBUTED := TotalDistributed;
            //Message('receiptline total %1-%2-%3-%4', ReceiptLine.TOTAL_DISTRIBUTED, ReceiptLine."Member No", ReceiptLine."Employee Name", ReceiptLine."Payroll No");
            ReceiptLine.Modify();
            ;
        end;
    end;

    local procedure FnCheckLoanErrorsN(LoanProduct: Code[100]; Amount: Decimal; Amount_int: Decimal; MemberNo: Code[40]) IsInvalidLoan: Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if ((Amount > 0) or (Amount_int > 0)) then begin
            IsInvalidLoan := true;
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetFilter("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", Datefilter);
            ObjLoans.SetFilter(Posted, 'Yes');
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
            if ObjLoans.FindFirst then begin
                IsInvalidLoan := false;
            end
        end;
        exit(IsInvalidLoan);
    end;

    local procedure FnReturnNormaOrTopupCode(LoanProduct: Code[100]; Amount: Decimal; Amount_int: Decimal; MemberNo: Code[40]) LoanCode: Code[100]
    var
        ObjLoans: Record "Loans Register";
    begin
        if ((Amount > 0) or (Amount_int > 0)) then begin
            LoanCode := '';
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetFilter("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", Datefilter);
            ObjLoans.SetFilter(Posted, 'Yes');
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
            if ObjLoans.FindFirst then begin
                LoanCode := ObjLoans."Loan Product Type";
            end
        end;
        exit(LoanCode);
    end;

    local procedure FnCheckGoldSaveErrors(Amount: Decimal; MemberNo: Code[40]) IsInvalidAccount: Boolean
    var
        ObjVendor: Record Vendor;
    begin
        if Amount > 0 then begin
            IsInvalidAccount := true;
            ObjVendor.Reset;
            ObjVendor.SetRange("BOSA Account No", MemberNo);
            ObjVendor.SetRange("Account Type", 'GOLDSAVE');
            if ObjVendor.Find('-') then
                IsInvalidAccount := false;
            exit(IsInvalidAccount);
        end;
    end;

    local procedure FnCheckLoanErrorsGUR(LoanProduct: Code[100]; Amount: Decimal; MemberNo: Code[40]) IsInvalidLoan: Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if Amount > 0 then begin
            IsInvalidLoan := true;
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetRange("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", Datefilter);
            ObjLoans.SetFilter(Posted, 'Yes');
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
            //ObjLoans.SETFILTER(ObjLoans."Loan Product Type",'<>%1','GUR');
            //IF ObjLoans.FINDFIRST THEN BEGIN
            if ObjLoans.Find('-') then begin
                IsInvalidLoan := false;
            end
        end;
        exit(IsInvalidLoan);
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Checkoff Lines-Distributed"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        LoanApp.CalcFields(LoanApp."Outstanding Balance");
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
            LoanApp.SetFilter(Posted, 'Yes');

            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := ROUND(LoanApp."Loan Interest Repayment", 1, '>');
                            if varLRepayment > 0 then begin

                                if RunningBalance > 0 then
                                    AmountToDeduct := RunningBalance;

                                begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;

                                LineNo := LineNo + 10000;
                                //                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                                //                    GenJournalLine."Account Type"::Member,LoanApp."Client Code","Posting date",AmountToDeduct*-1,FORMAT(LoanApp.Source),"Document No",
                                //                    FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),LoanApp."Loan  No.");
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;


                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;
}






