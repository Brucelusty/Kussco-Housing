//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50157 "Checkoff Processing Header-D"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Checkoff Header-Distributed";
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

                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = true;
                    Caption = 'Transaction Description';
                }
                field("Posted By"; Rec."Posted By")
                {
                    Visible = false;
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
                    Enabled = false;
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
                field("Document No"; Rec."Document No")
                {
                    Caption = 'Document No./ Cheque No.';
                    ShowMandatory = true;
                    // Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Total Scheduled"; Rec."Total Scheduled")
                {
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Count"; Rec."Total Count")
                {
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
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
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D")
            {
                Caption = 'Checkoff Lines-Distributed';
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
                    if Confirm('This Action will clear all the Lines for the current Check off. Do you want to Continue', true) = false then exit;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", Rec.No);
                    ReceiptLine.DeleteAll;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", '');
                    ReceiptLine.DeleteAll;

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Rec.Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;
                end;
            }
            action("Clear Loans Buffer Lines")
            {
                Enabled = ActionEnabled;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                begin
                    if Confirm('This Action will clear all the Lines for the loans buffer. Do you want to Continue') = false then
                        exit;
                    CheckoffLoans.DeleteAll;

                end;
            }
            action("Import Checkoff Distributed")
            {
                Caption = 'Import Checkoff';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed";
            }


            action("Import Checkoff Loans")
            {
                Caption = 'Import Checkoff Loans';
                Enabled = ActionEnabled;
                Image = Import;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Loans";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff")
            {
                Caption = 'Validate Checkoff';
                Enabled = ActionEnabled;
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    Rec.TestField("Document No");
                    //Rec.TestField(Amount);

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Rec.Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;



                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", Rec."Document No");
                    if MembLedg.Find('-') = true then begin
                        Error('Sorry,You have already posted this Document. Validation not Allowed.');
                    end;
                    if rec."Checkoff Type" = rec."Checkoff Type"::Loans then begin
                        EntriesNo := 0;
                        MembersR.Reset();
                        MembersR.SetAutoCalcFields(MembersR."Checkoff Loans");
                        MembersR.SetFilter(MembersR."Checkoff Loans", '>%1', 0);
                        if MembersR.FindFirst() then begin
                            repeat

                                EntriesNo := EntriesNo + 1;
                                ReceiptLine.Init();
                                ReceiptLine."Member No" := MembersR."No.";
                                ReceiptLine."Payroll No" := MembersR."Payroll No";
                                ReceiptLine."Checkoff No" := Rec.No;
                                ReceiptLine.Amount := MembersR."Checkoff Loans";
                                ReceiptLine."Entry No" := EntriesNo;
                                ReceiptLine.insert(TRUE);

                            until MembersR.NEXT = 0;
                        end;
                    end;
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", Rec.No);
                    if ReceiptLine.FindSet(true, true) then begin
                        repeat
                            //ReceiptLine."Payroll No" := '';
                            //ReceiptLine."Employee Name" := '';
                            ReceiptLine.TOTAL_DISTRIBUTED := 0;
                            ReceiptLine.Modify(true);
                        until ReceiptLine.Next = 0;
                    end;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", Rec.No);
                    if ReceiptLine.FindSet(true, true) then begin
                        repeat

                            UpdateCheckofflines();
                        // end;
                        until ReceiptLine.Next = 0;


                    end;
                    Message('Validation was successfully completed');
                end;
            }
            action("Unallocated Funds")
            {
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    ReptProcHeader.Reset;
                    ReptProcHeader.SetRange(ReptProcHeader.No, Rec.No);
                    if ReptProcHeader.Find('-') then
                        Report.run(172542, true, false, ReptProcHeader);
                end;
            }
            action("Variance Report")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ReceiptsProcessingLines.Reset;
                    ReceiptsProcessingLines.SetRange(ReceiptsProcessingLines."Checkoff No", Rec.No);
                    if ReceiptsProcessingLines.Find('-') then begin
                        Report.run(175100, true, false, ReceiptsProcessingLines);
                    end;
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Process Checkoff Distributed")
            {
                Caption = 'Process Checkoff';
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
                    IF CONFIRM('Are you sure you want to Transfer this Checkoff to Journals ?') = TRUE THEN BEGIN
                        Rec.TESTFIELD("Document No");
                        Rec.TESTFIELD(Amount);
                        IF Rec.Amount <> Rec."Total Scheduled" THEN
                            ERROR('Scheduled Amount must be equal to the Cheque Amount');

                        Datefilter := '..' + FORMAT(Rec."Posting date");

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'CHECKOFF';
                        DOCUMENT_NO := Rec.No;
                        Counter := 0;
                        Percentage := 0;
                        TotalCount := 0;

                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DELETEALL;

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                        GenBatches.SetRange(GenBatches.Name, 'CHECKOFF');
                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name" := 'GENERAL';
                            GenBatches.Name := 'CHECKOFF';
                            GenBatches.Description := 'CHECKOFF';
                            GenBatches.Insert;
                        end;
                        LineNo := 0;
                        if Rec.Type = Rec.Type::Member then begin

                            ReceiptLine.RESET;
                            ReceiptLine.SETRANGE("Checkoff No", Rec.No);
                            //ReceiptLine.SETRANGE("Member No",'01845');

                            IF ReceiptLine.FIND('-') THEN BEGIN
                                Window.OPEN('@1@');
                                TotalCount := ReceiptLine.COUNT;
                                REPEAT
                                    IF ReceiptLine."Member No" <> '' THEN BEGIN
                                    //////Get Savings Account
                                        MembersR.RESET;
                                        MembersR.SETRANGE("No.", ReceiptLine."Member No");
                                        IF MembersR.FIND('-') THEN begin
                                            Vendors.Reset();
                                            Vendors.SetRange("BOSA Account No", MembersR."No.");
                                            Vendors.SetRange("Account Type", '103');
                                            if Vendors.Find('-') then begin
                                                Savaccount := Vendors."No.";
                                            end;
                                            //MESSAGE('Savings Account %1',Savaccount);
                                            //////End Get Savings Account
                                            FnUpdateProgressBar();

                                            RunBal := ReceiptLine.Amount;

                                            FnCheckLoanErrors(ReceiptLine."Loan Product", ReceiptLine.Amount, ReceiptLine."Member No");

                                            //BOSA Deposit Contribution
                                            Vendors.Reset();
                                            Vendors.SetRange("BOSA Account No", MembersR."No.");
                                            Vendors.SetRange("Account Type", '102');
                                            if Vendors.Find('-') then begin
                                                if RunBal > 0 then begin
                                                    DepositsAmount := 0;
                                                    if RunBal > MembersR."Monthly Contribution" then
                                                        DepositsAmount := MembersR."Monthly Contribution"
                                                    else DepositsAmount := RunBal;

                                                    //----------------------------1. DEPOSITS----------------------------------------------------------------
                                                    LineNo := LineNo + 10000;
                                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                    GenJournalLine."Account Type"::Vendor, Vendors."No.", Rec."Posting date", DepositsAmount * -1, 'BOSA', Rec."Document No",
                                                    Rec.Remarks, '', GenJournalLine."Application Source"::" ");
                                                    RunBal := RunBal - DepositsAmount;
                                                end;
                                            end;

                                            if RunBal > 0 then begin
                                                BBFAmount := 0;
                                                BBFAmount := 300;
                                                if RunBal > BBFAmount then
                                                    BBFAmount := BBFAmount
                                                else
                                                    BBFAmount := RunBal;

                                                LineNo := LineNo + 10000;
                                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                GenJournalLine."Account Type"::Customer, ReceiptLine."Member No", Rec."Posting date", BBFAmount * -1, 'BOSA', Rec."Document No",
                                                Rec.Remarks, '', GenJournalLine."Application Source"::" ");
                                                RunBal := RunBal - BBFAmount;
                                            end;


                                            if RunBal > 0 then begin
                                                if MembersR."ESS Contribution" > 0 then begin
                                                    Vendors.Reset();
                                                    Vendors.SetRange(Vendors."BOSA Account No", MembersR."No.");
                                                    Vendors.SetRange(Vendors."Account Type", '104');
                                                    if Vendors.FindFirst() then begin
                                                        ESSAmount := 0;
                                                        ESSAmount := MembersR."ESS Contribution";
                                                        if RunBal > ESSAmount then
                                                            ESSAmount := ESSAmount
                                                        else
                                                            ESSAmount := RunBal;

                                                        LineNo := LineNo + 10000;
                                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                        GenJournalLine."Account Type"::Vendor, Vendors."No.", Rec."Posting date", ESSAmount * -1, 'BOSA', Rec."Document No",
                                                        Rec.Remarks, '', GenJournalLine."Application Source"::" ");
                                                        RunBal := RunBal - ESSAmount;
                                                    end;
                                                end;
                                            end;
                                            if RunBal > 0 then begin
                                                if MembersR."Jibambe Savings Contribution"> 0 then begin
                                                    Vendors.Reset();
                                                    Vendors.SetRange(Vendors."BOSA Account No", MembersR."No.");
                                                    Vendors.SetRange(Vendors."Account Type", '106');
                                                    if Vendors.FindFirst() then begin
                                                        ESSAmount := 0;
                                                        ESSAmount := MembersR."Jibambe Savings Contribution";
                                                        if RunBal > ESSAmount then
                                                            ESSAmount := ESSAmount
                                                        else
                                                            ESSAmount := RunBal;

                                                        LineNo := LineNo + 10000;
                                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                        GenJournalLine."Account Type"::Vendor, Vendors."No.", Rec."Posting date", ESSAmount * -1, 'BOSA', Rec."Document No",
                                                        Rec.Remarks, '', GenJournalLine."Application Source"::" ");
                                                        RunBal := RunBal - ESSAmount;
                                                    end;
                                                end;
                                            end;
                                            if RunBal > 0 then begin
                                                if MembersR."Wezesha Savings Contribution"> 0 then begin
                                                    Vendors.Reset();
                                                    Vendors.SetRange(Vendors."BOSA Account No", MembersR."No.");
                                                    Vendors.SetRange(Vendors."Account Type", '107');
                                                    if Vendors.FindFirst() then begin
                                                        ESSAmount := 0;
                                                        ESSAmount := MembersR."Wezesha Savings Contribution";
                                                        if RunBal > ESSAmount then
                                                            ESSAmount := ESSAmount
                                                        else
                                                            ESSAmount := RunBal;

                                                        LineNo := LineNo + 10000;
                                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                        GenJournalLine."Account Type"::Vendor, Vendors."No.", Rec."Posting date", ESSAmount * -1, 'BOSA', Rec."Document No",
                                                        Rec.Remarks, '', GenJournalLine."Application Source"::" ");
                                                        RunBal := RunBal - ESSAmount;
                                                    end;
                                                end;
                                            end;
                                            if RunBal > 0 then begin
                                                if MembersR."Mdosi Jr Contribution" > 0 then begin
                                                    Vendors.Reset();
                                                    Vendors.SetRange(Vendors."BOSA Account No", MembersR."No.");
                                                    Vendors.SetRange(Vendors."Account Type", '109');
                                                    if Vendors.FindFirst() then begin
                                                        ESSAmount := 0;
                                                        ESSAmount := MembersR."Mdosi Jr Contribution";
                                                        if RunBal > ESSAmount then
                                                            ESSAmount := ESSAmount
                                                        else
                                                            ESSAmount := RunBal;

                                                        LineNo := LineNo + 10000;
                                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                        GenJournalLine."Account Type"::Vendor, Vendors."No.", Rec."Posting date", ESSAmount * -1, 'BOSA', Rec."Document No",
                                                        Rec.Remarks, '', GenJournalLine."Application Source"::" ");
                                                        RunBal := RunBal - ESSAmount;
                                                    end;
                                                end;
                                            end;
                                            if RunBal > 0 then begin
                                                if MembersR."Pension Akiba Contribution" > 0 then begin
                                                    Vendors.Reset();
                                                    Vendors.SetRange(Vendors."BOSA Account No", MembersR."No.");
                                                    Vendors.SetRange(Vendors."Account Type", '110');
                                                    if Vendors.FindFirst() then begin
                                                        ESSAmount := 0;
                                                        ESSAmount := MembersR."Pension Akiba Contribution";
                                                        if RunBal > ESSAmount then
                                                            ESSAmount := ESSAmount
                                                        else
                                                            ESSAmount := RunBal;

                                                        LineNo := LineNo + 10000;
                                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                        GenJournalLine."Account Type"::Vendor, Vendors."No.", Rec."Posting date", ESSAmount * -1, 'BOSA', Rec."Document No",
                                                        Rec.Remarks, '', GenJournalLine."Application Source"::" ");
                                                        RunBal := RunBal - ESSAmount;
                                                    end;
                                                end;
                                            end;

                                            LoansR.reset;
                                            LoansR.setrange(LoansR."Client Code", ReceiptLine."Member No");
                                            LoansR.SetAutoCalcFields(LoansR."Total Outstanding Balance");
                                            LoansR.SETFILTER(LoansR."Total Outstanding Balance", '>%1', 0);
                                            LoansR.SetRange(LoansR."Recovery Mode", LoansR."Recovery Mode"::Checkoff);
                                            if LoansR.FindSet() then begin
                                                repeat
                                                    LoansR.CalcFields("Outstanding Interest", "Outstanding Balance");
                                                    IntAmount := 0;
                                                    LoanAmount := 0;

                                                    IntAmount := LoansR."Outstanding Interest";
                                                    LoanAmount:= LoansR."Outstanding Balance";
                                                    if RunBal > 0 then begin
                                                        if IntAmount > 0 then begin
                                                            if RunBal > IntAmount then
                                                                IntAmount := IntAmount
                                                            else
                                                                IntAmount := RunBal;
                                                            LineNo := LineNo + 10000;
                                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                                            GenJournalLine."Account Type"::Customer, ReceiptLine."Member No", Rec."Posting date", IntAmount * -1, 'BOSA', Rec."Document No",
                                                            Rec.Remarks + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.", GenJournalLine."Application Source"::" ");
                                                            RunBal := RunBal - IntAmount;
                                                        end;
                                                    end;
                                                    if RunBal > 0 then begin
                                                        PrincipleLoan := 0;
                                                        // TotalPaid := 0;
                                                        // TotalPaidSchedule := 0;
                                                        // TotalPaid := LoansR."Approved Amount" - LoansR."Outstanding Balance";

                                                        // Schedule.reset;
                                                        // Schedule.SetRange(Schedule."Loan No.", LoansR."Loan  No.");
                                                        // Schedule.SetFilter(Schedule."Repayment Date", '..%1', Calcdate('-1M', Calcdate('CM', Rec."Loan CutOff Date")));
                                                        // if Schedule.find('-') then begin
                                                        //     Schedule.calcsums(schedule."Principal Repayment");
                                                        //     TotalPaidSchedule := schedule."Principal Repayment";
                                                        // end;
                                                        // LoanArrears := 0;
                                                        // LoanArrears := TotalPaidSchedule - TotalPaid;
                                                        // if LoanArrears < 0 then LoanArrears := 0;

                                                        Schedule.reset;
                                                        Schedule.SetRange(Schedule."Loan No.", LoansR."Loan  No.");
                                                        Schedule.SetFilter(Schedule."Repayment Date", '%1..%2', Calcdate('-CM', Rec."Loan CutOff Date"), Calcdate('CM', Rec."Loan CutOff Date"));
                                                        if Schedule.find('-') then begin
                                                            PrincipleLoan := 0;
                                                            // Schedule.calcsums("Principal Repayment");
                                                            PrincipleLoan := schedule."Principal Repayment";
                                                        end;
                                                        //Message('Arrears%1Principle%2Loan%3',loanArrears,PrincipleLoan,LoansR."Loan  No.");
                                                        //loanArrears := LoanArrears + PrincipleLoan;
                                                        // LoanArrears := schedule."Principal Repayment" - IntAmount;
                                                        // if LoanArrears < 0 then
                                                        //     LoanArrears := 0
                                                        // else if LoanArrears > LoanAmount then begin
                                                        //     LoanArrears := LoanAmount
                                                        // end else LoanArrears := LoanArrears;

                                                        if PrincipleLoan > 0 then begin
                                                            if LoanAmount > PrincipleLoan then begin
                                                                if RunBal > PrincipleLoan then
                                                                    PrincipleLoan := PrincipleLoan
                                                                else
                                                                    PrincipleLoan := RunBal;
                                                                LineNo := LineNo + 10000;
                                                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                                                GenJournalLine."Account Type"::Customer, ReceiptLine."Member No", Rec."Posting date", PrincipleLoan * -1, 'BOSA', Rec."Document No",
                                                                Rec.Remarks + ' Principle Payment', loansR."Loan  No.", GenJournalLine."Application Source"::" ");
                                                                RunBal := RunBal - PrincipleLoan;
                                                            end else begin
                                                                if RunBal > LoanAmount then
                                                                    LoanAmount := LoanAmount
                                                                else
                                                                    LoanAmount := RunBal;
                                                                LineNo := LineNo + 10000;
                                                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                                                GenJournalLine."Account Type"::Customer, ReceiptLine."Member No", Rec."Posting date", LoanAmount * -1, 'BOSA', Rec."Document No",
                                                                Rec.Remarks + ' Principle Payment', loansR."Loan  No.", GenJournalLine."Application Source"::" ");
                                                                RunBal := RunBal - LoanAmount;
                                                            end;
                                                        end;
                                                    end;
                                                until LoansR.Next = 0;
                                            end;

                                            Vendors.Reset();
                                            Vendors.SetRange("BOSA Account No", MembersR."No.");
                                            Vendors.SetRange("Account Type", '102');
                                            if Vendors.Find('-') then begin
                                                if RunBal > 0 then begin
                                                    //----------------------------1. DEPOSITS----------------------------------------------------------------
                                                    LineNo := LineNo + 10000;
                                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                    GenJournalLine."Account Type"::Vendor, Vendors."No.", Rec."Posting date", RunBal * -1, 'BOSA', Rec."Document No",
                                                    Rec.Remarks+' Excess to Deposits',' ' ,GenJournalLine."Application Source"::" ");
                                                    RunBal := RunBal - RunBal;
                                                end;
                                            end;
                                        END;

                                        if ReceiptLine."Member No" = '' then begin
                                            LineNo := LineNo + 10000;
                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                            GenJournalLine."Account Type"::"G/L Account", '21628', Rec."Posting date", ReceiptLine.Amount * -1, 'BOSA', Rec."Document No",
                                            Rec.Remarks + ' ' + ReceiptLine."Payroll No", '', GenJournalLine."Application Source"::" ")
                                        end;
                                    end;
                                UNTIL ReceiptLine.NEXT = 0;
                            END;
                        end;

                                //Kit

                                if Rec.Type = Rec.Type::Groups then begin

                                    ReceiptLine.RESET;
                                    ReceiptLine.SETRANGE("Checkoff No", Rec.No);
                                    //ReceiptLine.SETRANGE("Member No",'01845');

                                    IF ReceiptLine.FIND('-') THEN BEGIN
                                        Window.OPEN('@1@');
                                        TotalCount := ReceiptLine.COUNT;
                                        REPEAT

                                            FnUpdateProgressBar();





                                            if rec."Checkoff Type" = rec."Checkoff Type"::"FOSA Saving" then begin
                                                LineNo := LineNo + 10000;
                                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                                GenJournalLine."Account Type"::Vendor, ReceiptLine."FOSA Account", Rec."Posting date", ReceiptLine.Amount * -1, 'BOSA', Rec."Document No",
                                                ReceiptLine."Employee Name" + ' ' + Rec.No, '', GenJournalLine."Application Source"::" ");
                                            end;

                                        UNTIL ReceiptLine.NEXT = 0;
                                    END;
                                end;


                                //Balancing Journal Entry
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                Rec."Account Type", Rec."Account No", Rec."Posting date", Rec.Amount, 'BOSA', Rec."Document No",
                                Rec.Remarks, '', GenJournalLine."Application Source"::" ");

                                Window.CLOSE;
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
                //Enabled = not ActionEnabled;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin

                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec."Posting date" := Today;
                        Rec.Modify;
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
        ReceiptLine: Record "Checkoff Lines-Distributed-NT";

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
        if Rec.Type = Rec.Type::Member then begin
            Memb.Reset;
            Memb.SetRange(Memb."Payroll No", ReceiptLine."Payroll No");
            //Memb.SetFilter(Status, '<>%1', Memb.Status::Dormant);
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

        if Rec.Type = Rec.Type::Groups then begin
            Memb.Reset;
            Memb.SetRange(Memb."Payroll No", ReceiptLine."Payroll No");
            //Memb.SetFilter(Status, '<>%1', Memb.Status::Dormant);
            if Memb.Find('-') then begin
                //ReceiptLine."FOSA Account" := Rec."Group Destination Account";
                ReceiptLine."Employee Name" := Memb.Name;
                ReceiptLine."Member No" := Memb."No.";

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
            end;
            ;
        end
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






