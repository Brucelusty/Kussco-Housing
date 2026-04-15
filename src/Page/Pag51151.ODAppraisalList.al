page 51151 "OD Appraisal List"
{
    ApplicationArea = All;
    CardPageID = "OD Appraisal Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = WHERE(Posted = FILTER(false),
                            Source = CONST(FOSA),
                            "Loan Status" = CONST(Appraisal),
                            "Approval Status" = CONST(Open),
                            "Loan Product Type" = CONST('M_OD'));

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field("Loan  No."; rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Staff No"; rec."Staff No")
                {
                }
                field("Old Account No."; rec."Old Account No.")
                {
                    Editable = false;
                }
                field("Loan Product Type"; rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Advice Type"; rec."Advice Type")
                {
                }
                field("Expected Date of Completion"; rec."Expected Date of Completion")
                {
                }
                field("Application Date"; rec."Application Date")
                {
                    Editable = false;
                }
                field("Loan Status"; rec."Loan Status")
                {
                }
                field("Approval Status"; rec."Approval Status")
                {
                }
                field("Client Code"; rec."Client Code")
                {
                    Editable = false;
                }
                field("BOSA No"; rec."BOSA No")
                {
                }
                field("Issued Date"; rec."Issued Date")
                {
                    Editable = false;
                }
                field("Client Name"; rec."Client Name")
                {
                    Editable = false;
                }
                field(Posted; rec.Posted)
                {
                    Editable = false;
                }
                field("Account No"; rec."Account No")
                {
                }
                field(Remarks; rec.Remarks)
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("Mark As Posted")
                {
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.Posted := TRUE;
                        rec.MODIFY;
                    end;
                }
                action("Loan Appraisal")
                {
                    Caption = 'Loan Appraisal';
                    Enabled = false;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = "Report";
                }
                separator(Sep06)
                {
                }
                action("View Schedule")
                {
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        //IF Posted=TRUE THEN
                        //ERROR('Loan has been posted, Can only preview schedule');

                        IF rec."Repayment Frequency" = rec."Repayment Frequency"::Daily THEN
                            EVALUATE(InPeriod, '1D')
                        ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Weekly THEN
                            EVALUATE(InPeriod, '1W')
                        ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Monthly THEN
                            EVALUATE(InPeriod, '1M')
                        ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Quaterly THEN
                            EVALUATE(InPeriod, '1Q');


                        QCounter := 0;
                        QCounter := 3;
                        //EVALUATE(InPeriod,'1D');
                        GrPrinciple := rec."Grace Period - Principle (M)";
                        GrInterest := rec."Grace Period - Interest (M)";
                        InitialGraceInt := rec."Grace Period - Interest (M)";

                        LoansR.RESET;
                        LoansR.SETRANGE(LoansR."Loan  No.", rec."Loan  No.");
                        IF LoansR.FIND('-') THEN BEGIN

                            rec.TESTFIELD("Loan Disbursement Date");
                            rec.TESTFIELD("Repayment Start Date");

                            RSchedule.RESET;
                            RSchedule.SETRANGE(RSchedule."Loan No.", rec."Loan  No.");
                            RSchedule.DELETEALL;

                            LoanAmount := LoansR."Approved Amount";
                            InterestRate := LoansR.Interest;
                            RepayPeriod := LoansR.Installments;
                            InitialInstal := LoansR.Installments + rec."Grace Period - Principle (M)";
                            LBalance := LoansR."Approved Amount";
                            RunDate := rec."Repayment Start Date";//"Loan Disbursement Date";
                                                                  //RunDate:=CALCDATE('-1W',RunDate);
                            InstalNo := 0;
                            //EVALUATE(RepayInterval,'1W');
                            //EVALUATE(RepayInterval,InPeriod);

                            //Repayment Frequency
                            IF rec."Repayment Frequency" = rec."Repayment Frequency"::Daily THEN
                                RunDate := CALCDATE('-1D', RunDate)
                            ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Weekly THEN
                                RunDate := CALCDATE('-1W', RunDate)
                            ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Monthly THEN
                                RunDate := CALCDATE('-1M', RunDate)
                            ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Quaterly THEN
                                RunDate := CALCDATE('-1Q', RunDate);
                            //Repayment Frequency


                            REPEAT
                                InstalNo := InstalNo + 1;
                                //RunDate:=CALCDATE("Instalment Period",RunDate);
                                //RunDate:=CALCDATE('1W',RunDate);


                                //Repayment Frequency
                                IF rec."Repayment Frequency" = rec."Repayment Frequency"::Daily THEN
                                    RunDate := CALCDATE('1D', RunDate)
                                ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Weekly THEN
                                    RunDate := CALCDATE('1W', RunDate)
                                ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Monthly THEN
                                    RunDate := CALCDATE('1M', RunDate)
                                ELSE IF rec."Repayment Frequency" = rec."Repayment Frequency"::Quaterly THEN
                                    RunDate := CALCDATE('1Q', RunDate);
                                //Repayment Frequency

                                //kma
                                IF rec."Repayment Method" = rec."Repayment Method"::Amortised THEN BEGIN
                                    rec.TESTFIELD(Interest);
                                    rec.TESTFIELD(Installments);
                                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - POWER((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                                    LPrincipal := TotalMRepay - LInterest;
                                END;

                                IF rec."Repayment Method" = rec."Repayment Method"::"Straight Line" THEN BEGIN
                                    rec.TESTFIELD(Interest);
                                    rec.TESTFIELD(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.05, '>');
                                    //Grace Period Interest
                                    LInterest := ROUND((LInterest * InitialInstal) / (InitialInstal - InitialGraceInt), 0.05, '>');
                                END;

                                IF rec."Repayment Method" = rec."Repayment Method"::"Reducing Balance" THEN BEGIN
                                    rec.TESTFIELD(Interest);
                                    rec.TESTFIELD(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                                END;

                                IF rec."Repayment Method" = rec."Repayment Method"::Constants THEN BEGIN
                                    rec.TESTFIELD(Repayment);
                                    IF LBalance < rec.Repayment THEN
                                        LPrincipal := LBalance
                                    ELSE
                                        LPrincipal := rec.Repayment;
                                    LInterest := rec.Interest;
                                END;
                                //kma



                                //Grace Period
                                IF GrPrinciple > 0 THEN BEGIN
                                    LPrincipal := 0
                                END ELSE BEGIN
                                    //IF "Instalment Period" <> InPeriod THEN
                                    LBalance := LBalance - LPrincipal;

                                END;

                                IF GrInterest > 0 THEN
                                    LInterest := 0;

                                GrPrinciple := GrPrinciple - 1;
                                GrInterest := GrInterest - 1;
                                //Grace Period
                                /*
                               //Q Principle
                               IF "Instalment Period" = InPeriod THEN BEGIN
                               //ADDED
                               IF GrPrinciple <> 0 THEN
                               GrPrinciple:=GrPrinciple-1;
                               IF QCounter = 1 THEN BEGIN
                               QCounter:=3;
                               LPrincipal:=QPrinciple+LPrincipal;
                               IF LPrincipal > LBalance THEN
                               LPrincipal:=LBalance;
                               LBalance:=LBalance-LPrincipal;
                               QPrinciple:=0;
                               END ELSE BEGIN
                               QCounter:=QCounter - 1;
                               QPrinciple:=QPrinciple+LPrincipal;
                               //IF QPrinciple > LBalance THEN
                               //QPrinciple:=LBalance;
                               LPrincipal:=0;
                               END

                               END;
                               //Q Principle
                                */

                                EVALUATE(RepayCode, FORMAT(InstalNo));
                                /*
                               WhichDay:=DATE2DWY(RunDate,1);
                               IF WhichDay=6 THEN
                                RunDate:=RunDate+2
                               ELSE IF WhichDay=7 THEN
                                RunDate:=RunDate+1;
                                    */
                                //MESSAGE('which day is %1',WhichDay);



                                RSchedule.INIT;
                                RSchedule."Repayment Code" := RepayCode;
                                RSchedule."Loan No." := rec."Loan  No.";
                                RSchedule."Loan Amount" := LoanAmount;
                                RSchedule."Instalment No" := InstalNo;
                                RSchedule."Repayment Date" := RunDate;
                                RSchedule."Member No." := rec."Client Code";
                                RSchedule."Loan Category" := rec."Loan Product Type";
                                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                                RSchedule."Monthly Interest" := LInterest;
                                RSchedule."Principal Repayment" := LPrincipal;
                                RSchedule.INSERT;
                                //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                                WhichDay := DATE2DWY(RSchedule."Repayment Date", 1);
                            //MESSAGE('which day is %1',WhichDay);
                            //BEEP(2,10000);
                            UNTIL LBalance < 1

                        END;

                        COMMIT;
                        /*
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        */

                    end;
                }
                separator(Sep01)
                {
                }
                action("Loans Top Up")
                {
                    Caption = 'Loans Top Up';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = FIELD("Loan  No."),
                                  "Client Code" = FIELD("Client Code");
                }
                separator(Sep02)
                {
                }
                separator(Sep03)
                {
                }
                action("Post Loan")
                {
                    Caption = 'Post Loan';
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF rec.Posted = TRUE THEN
                            ERROR('Loan already posted.');


                        rec."Loan Disbursement Date" := TODAY;
                        rec.TESTFIELD("Loan Disbursement Date");
                        rec."Posting Date" := rec."Loan Disbursement Date";


                        IF CONFIRM('Are you sure you want to post this loan?', TRUE) = FALSE THEN
                            EXIT;

                        /*//PRORATED DAYS
                        EndMonth:=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY("Posting Date",2),DATE2DMY("Posting Date",3))));
                        RemainingDays:=(EndMonth-"Posting Date")+1;
                        TMonthDays:=DATE2DMY(EndMonth,1);
                        //PRORATED DAYS
                        
                        */
                        IF rec."Mode of Disbursement" = rec."Mode of Disbursement"::"FOSA Account" THEN BEGIN

                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SETRANGE("Journal Batch Name", 'LOANS');
                            GenJournalLine.DELETEALL;


                            GenSetUp.GET();

                            DActivity := 'BOSA';
                            DBranch := '';//PKKS'NAIROBI';
                            LoanApps.RESET;
                            LoanApps.SETRANGE(LoanApps."Loan  No.", rec."Loan  No.");
                            LoanApps.SETRANGE(LoanApps."System Created", FALSE);
                            LoanApps.SETFILTER(LoanApps."Loan Status", '<>Rejected');
                            IF LoanApps.FIND('-') THEN BEGIN
                                REPEAT
                                    LoanApps.CALCFIELDS(LoanApps."Special Loan Amount");
                                    DActivity := '';
                                    DBranch := '';
                                    IF Vend.GET(LoanApps."Client Code") THEN BEGIN
                                        DActivity := Vend."Global Dimension 1 Code";
                                        DBranch := Vend."Global Dimension 2 Code";
                                    END;

                                    LoanDisbAmount := LoanApps."Approved Amount";

                                    IF (LoanApps."Special Loan Amount" > 0) AND (LoanApps."Bridging Loan Posted" = FALSE) THEN
                                        ERROR('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                                    TCharges := 0;
                                    TopUpComm := 0;
                                    TotalTopupComm := 0;


                                    IF LoanApps."Loan Status" <> LoanApps."Loan Status"::Approved THEN
                                        ERROR('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                                    IF LoanApps.Posted = TRUE THEN
                                        ERROR('Loan has already been posted. - ' + LoanApps."Loan  No.");


                                    LoanApps.CALCFIELDS(LoanApps."Top Up Amount");


                                    RunningDate := rec."Posting Date";


                                    //Generate and post Approved Loan Amount
                                    IF NOT GenBatch.GET('PAYMENTS', 'LOANS') THEN BEGIN
                                        GenBatch.INIT;
                                        GenBatch."Journal Template Name" := 'PAYMENTS';
                                        GenBatch.Name := 'LOANS';
                                        GenBatch.INSERT;
                                    END;

                                    PCharges.RESET;
                                    PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                                    IF PCharges.FIND('-') THEN BEGIN
                                        REPEAT
                                            PCharges.TESTFIELD(PCharges."G/L Account");

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.INIT;
                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                                            GenJournalLine."Account No." := PCharges."G/L Account";
                                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." := rec."Loan  No.";
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine."Posting Date" := rec."Posting Date";
                                            GenJournalLine.Description := PCharges.Description;
                                            IF PCharges."Use Perc" = TRUE THEN BEGIN
                                                GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1;
                                            END ELSE BEGIN
                                                GenJournalLine.Amount := PCharges.Amount * -1;

                                            END;


                                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                            //Don't top up charges on principle
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                                            GenJournalLine."Bal. Account No." := LoanApps."Account No";
                                            //Don't top up charges on principle
                                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            IF GenJournalLine.Amount <> 0 THEN
                                                GenJournalLine.INSERT;

                                            TCharges := TCharges + (GenJournalLine.Amount * -1);


                                        UNTIL PCharges.NEXT = 0;
                                    END;




                                    //Don't top up charges on principle
                                    TCharges := 0;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.INIT;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Member;
                                    GenJournalLine."Account No." := rec."Client Code";
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := rec."Loan  No.";
                                    GenJournalLine."External Document No." := rec."ID NO";
                                    GenJournalLine."Posting Date" := rec."Posting Date";
                                    GenJournalLine.Description := 'Principal Amount';
                                    GenJournalLine.Amount := LoanDisbAmount + TCharges;
                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Loan;
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    IF GenJournalLine.Amount <> 0 THEN
                                        GenJournalLine.INSERT;




                                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                        IF LoanApps."Top Up Amount" > 0 THEN BEGIN
                                            LoanTopUp.RESET;
                                            LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                            IF LoanTopUp.FIND('-') THEN BEGIN
                                                REPEAT
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.INIT;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := rec."Loan  No.";
                                                    GenJournalLine."Posting Date" := rec."Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Member;
                                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                    IF GenJournalLine.Amount <> 0 THEN
                                                        GenJournalLine.INSERT;
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.INIT;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := rec."Loan  No.";
                                                    GenJournalLine."Posting Date" := rec."Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                                                    GenJournalLine."Account No." := LoanApps."Account No";
                                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up";
                                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                    IF GenJournalLine.Amount <> 0 THEN
                                                        GenJournalLine.INSERT;


                                                    //Interest (Reversed if top up)
                                                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.INIT;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Member;
                                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." := rec."Loan  No.";
                                                        GenJournalLine."Posting Date" := rec."Posting Date";
                                                        GenJournalLine.Description := 'Interest paid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                        IF GenJournalLine.Amount <> 0 THEN
                                                            GenJournalLine.INSERT;


                                                    END;
                                                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.INIT;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." := rec."Loan  No.";
                                                        GenJournalLine."Posting Date" := rec."Posting Date";
                                                        GenJournalLine.Description := 'Interest paid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                                                        GenJournalLine."Account No." := LoanApps."Account No";
                                                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                        IF GenJournalLine.Amount <> 0 THEN
                                                            GenJournalLine.INSERT;


                                                    END;

                                                    //Commision
                                                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                                        IF LoanType."Top Up Commision" > 0 THEN BEGIN
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.INIT;
                                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                                                            GenJournalLine."Account No." := LoanApps."Account No";

                                                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                                            GenJournalLine."Bal. Account No." := LoanType."Top Up Commision Account";
                                                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                                            GenJournalLine."Document No." := rec."Loan  No.";
                                                            GenJournalLine."Posting Date" := rec."Posting Date";
                                                            GenJournalLine.Description := 'Commision on Loan Top Up';
                                                            TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                                                            TotalTopupComm := TotalTopupComm + TopUpComm;
                                                            GenJournalLine.Amount := TopUpComm * -1;
                                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;

                                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                            IF GenJournalLine.Amount <> 0 THEN
                                                                GenJournalLine.INSERT;

                                                        END;
                                                    END;
                                                UNTIL LoanTopUp.NEXT = 0;
                                            END;
                                        END;
                                    END;

                                    BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount";
                                    BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                                UNTIL LoanApps.NEXT = 0;
                            END;

                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := rec."Loan  No.";
                            GenJournalLine."External Document No." := rec."ID NO";
                            GenJournalLine."Posting Date" := rec."Posting Date";
                            GenJournalLine.Description := 'Principal Amount';
                            GenJournalLine.Amount := (LoanApps."Approved Amount") * -1;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;
                        END;



                        IF rec."Mode of Disbursement" = rec."Mode of Disbursement"::Cheque THEN BEGIN

                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SETRANGE("Journal Batch Name", 'LOANS');
                            GenJournalLine.DELETEALL;


                            GenSetUp.GET();

                            DActivity := 'BOSA';
                            DBranch := '';//PKKS'NAIROBI';
                            LoanApps.RESET;
                            LoanApps.SETRANGE(LoanApps."Loan  No.", rec."Loan  No.");
                            LoanApps.SETRANGE(LoanApps."System Created", FALSE);
                            LoanApps.SETFILTER(LoanApps."Loan Status", '<>Rejected');
                            IF LoanApps.FIND('-') THEN BEGIN
                                REPEAT
                                    LoanApps.CALCFIELDS(LoanApps."Special Loan Amount");



                                    DActivity := '';
                                    DBranch := '';
                                    IF Vend.GET(LoanApps."Client Code") THEN BEGIN
                                        DActivity := Vend."Global Dimension 1 Code";
                                        DBranch := Vend."Global Dimension 2 Code";
                                    END;



                                    LoanDisbAmount := LoanApps."Approved Amount";

                                    IF (LoanApps."Special Loan Amount" > 0) AND (LoanApps."Bridging Loan Posted" = FALSE) THEN
                                        ERROR('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                                    TCharges := 0;
                                    TopUpComm := 0;
                                    TotalTopupComm := 0;


                                    IF LoanApps."Loan Status" <> LoanApps."Loan Status"::Approved THEN
                                        ERROR('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                                    IF LoanApps.Posted = TRUE THEN
                                        ERROR('Loan has already been posted. - ' + LoanApps."Loan  No.");


                                    LoanApps.CALCFIELDS(LoanApps."Top Up Amount");


                                    RunningDate := rec."Posting Date";


                                    //Generate and post Approved Loan Amount
                                    IF NOT GenBatch.GET('PAYMENTS', 'LOANS') THEN BEGIN
                                        GenBatch.INIT;
                                        GenBatch."Journal Template Name" := 'PAYMENTS';
                                        GenBatch.Name := 'LOANS';
                                        GenBatch.INSERT;
                                    END;

                                    PCharges.RESET;
                                    PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                                    IF PCharges.FIND('-') THEN BEGIN
                                        REPEAT
                                            PCharges.TESTFIELD(PCharges."G/L Account");

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.INIT;
                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                                            GenJournalLine."Account No." := PCharges."G/L Account";
                                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." := rec."Loan  No.";
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine."Posting Date" := rec."Posting Date";
                                            GenJournalLine.Description := PCharges.Description;
                                            IF PCharges."Use Perc" = TRUE THEN BEGIN
                                                GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1;
                                            END ELSE BEGIN
                                                GenJournalLine.Amount := PCharges.Amount * -1;

                                            END;


                                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                            //Don't top up charges on principle
                                            //Don't top up charges on principle
                                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            IF GenJournalLine.Amount <> 0 THEN
                                                GenJournalLine.INSERT;

                                            TCharges := TCharges + (GenJournalLine.Amount * -1);


                                        UNTIL PCharges.NEXT = 0;
                                    END;




                                    //Don't top up charges on principle
                                    TCharges := 0;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.INIT;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Member;
                                    GenJournalLine."Account No." := rec."Client Code";
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := rec."Loan  No.";
                                    GenJournalLine."External Document No." := rec."ID NO";
                                    GenJournalLine."Posting Date" := rec."Posting Date";
                                    GenJournalLine.Description := 'Principal Amount';
                                    GenJournalLine.Amount := LoanDisbAmount + TCharges;
                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Loan;
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    IF GenJournalLine.Amount <> 0 THEN
                                        GenJournalLine.INSERT;




                                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                        IF LoanApps."Top Up Amount" > 0 THEN BEGIN
                                            LoanTopUp.RESET;
                                            LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                            IF LoanTopUp.FIND('-') THEN BEGIN
                                                REPEAT
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.INIT;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := rec."Loan  No.";
                                                    GenJournalLine."Posting Date" := rec."Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Member;
                                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                    IF GenJournalLine.Amount <> 0 THEN
                                                        GenJournalLine.INSERT;


                                                    //Interest (Reversed if top up)
                                                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.INIT;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Member;
                                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." := rec."Loan  No.";
                                                        GenJournalLine."Posting Date" := rec."Posting Date";
                                                        GenJournalLine.Description := 'Interestpaid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                                        //GenJournalLine."Bal. Account No.":=LoanType."Receivable Interest Account";
                                                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                        IF GenJournalLine.Amount <> 0 THEN
                                                            GenJournalLine.INSERT;


                                                    END;

                                                    //Commision
                                                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                                        IF LoanType."Top Up Commision" > 0 THEN BEGIN
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.INIT;
                                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                                                            GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                                            GenJournalLine."Document No." := rec."Loan  No.";
                                                            GenJournalLine."Posting Date" := rec."Posting Date";
                                                            GenJournalLine.Description := 'Commision on Loan Top Up';
                                                            TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                                                            TotalTopupComm := TotalTopupComm + TopUpComm;
                                                            GenJournalLine.Amount := TopUpComm * -1;
                                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";

                                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                            IF GenJournalLine.Amount <> 0 THEN
                                                                GenJournalLine.INSERT;

                                                        END;
                                                    END;
                                                UNTIL LoanTopUp.NEXT = 0;
                                            END;
                                        END;
                                    END;

                                    BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount";
                                    BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                                UNTIL LoanApps.NEXT = 0;
                            END;

                            LineNo := LineNo + 10000;
                            /*Disbursement.RESET;
                            Disbursement.SETRANGE(Disbursement."Loan Number","Loan  No.");
                            Disbursement.SETRANGE(Disbursement."Disbursement Date","Loan Disbursement Date");
                            IF Disbursement.FIND('-') THEN BEGIN
                            REPEAT
                            Disbursement.Posted:=TRUE;
                            Disbursement.MODIFY;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=Disbursement."Disbursement Account Type";
                            GenJournalLine."Account No.":=Disbursement."Disbursement Account No.";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."External Document No.":="ID NO";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Principal Amount';
                            GenJournalLine.Amount:=((LoanApps."Approved Amount")-(BatchTopUpAmount+BatchTopUpComm+TCharges))*-1;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                            UNTIL Disbursement.NEXT=0;
                            END;*/
                        END;



                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SETRANGE("Journal Batch Name", 'LOANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        END;

                        //Post New

                        rec.Posted := TRUE;
                        rec.MODIFY;



                        MESSAGE('Loan posted successfully.');

                        //Post

                        //LoanAppPermisions()
                        //CurrForm.EDITABLE:=TRUE;
                        //end;

                    end;
                }
                separator(Sep04)
                {
                }
                action("Loan Securities")
                {
                    Caption = 'Securities';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = FIELD("Loan  No.");
                    Visible = true;
                }
                action("Salary Details")
                {
                    Caption = 'Salary Details';
                    Enabled = true;
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page //51516246
                    "Loan Appraisal Salary Details";
                    RunPageLink = "Loan No" = FIELD("Loan  No."),
                                  "Client Code" = FIELD("Client Code");
                }
                action(Guarantors)
                {
                    Caption = 'Guarantors';
                    Image = Allocations;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page //51516247
                    "Loans Guarantee Details";
                    RunPageLink = "Loan No" = FIELD("Loan  No.");
                    Visible = true;
                }
                separator(Sep05)
                {
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    // trigger OnAction()
                    // var
                    //     ApprovalEntries: Page "658";
                    // begin
                    //     DocumentType:=DocumentType::Loan;
                    //     ApprovalEntries.Setfilters(DATABASE::"Absence Preferences",DocumentType,"Loan  No.");
                    //     ApprovalEntries.RUN;
                    // end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: Label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit 439;
                    begin
                        rec.OffsetCondition;

                        SalDetails.RESET;
                        SalDetails.SETRANGE(SalDetails."Client Code", rec."Client Code");
                        IF SalDetails.FIND('-') = FALSE THEN BEGIN
                            ERROR('Please Insert Loan Applicant Salary Information');
                        END;

                        LGuarantors.RESET;
                        LGuarantors.SETRANGE(LGuarantors."Loan No", rec."Loan  No.");
                        IF LGuarantors.FIND('-') = FALSE THEN BEGIN
                            ERROR('Please Insert Loan Applicant Guarantor Information');
                        END;

                        IF (rec."Mode of Disbursement" = rec."Mode of Disbursement"::Cheque) OR
                        (rec."Mode of Disbursement" = rec."Mode of Disbursement"::"FOSA Account") OR
                        (rec."Mode of Disbursement" = rec."Mode of Disbursement"::" ") THEN
                            ERROR('Mode of disbursment must be FOSA Loans');

                        rec.TESTFIELD("Approved Amount");
                        rec.TESTFIELD("Loan Product Type");


                        /*
                        LBatches.RESET;
                        LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
                        IF LBatches.FIND('-') THEN BEGIN
                           IF LBatches."Approval Status"<>LBatches."Approval Status"::Open THEN
                              ERROR(Text001);
                        END;
                        */
                        //End allocate batch number
                        //ApprovalMgt.SendLoanApprRequest(LBatches);
                        //ApprovalMgt.SendLoanApprRequest(Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        IF FormatField(Rec) THEN
            Overdue := Overdue::Yes;



    end;

    var
        LoanType: Record "Loan Products Setup";
        NoSeriesMgt: Codeunit "No. Series";
        LoanApp: Record "Loans Register";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        SpecialComm: Decimal;
        GenJournalLine: Record 81;
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Vend: Record 23;
        LineNo: Integer;
        DoubleComm: Boolean;
        AvailableBal: Decimal;
        Account: Record 23;
        RunBal: Decimal;
        TotalRecovered: Decimal;
        OInterest: Decimal;
        OBal: Decimal;
        ReffNo: Code[20];
        DiscountCommission: Decimal;
        BridgedLoans: Record "Loan Offset Details";
        LoanAdj: Decimal;
        LoanAdjInt: Decimal;
        AdjustRemarks: Text[30];
        Princip: Decimal;
        Overdue: Option Yes," ";
        i: Integer;
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record "Customer";
        Gnljnline: Record 81;
        Jnlinepost: Codeunit 12;
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record 232;
        GnljnlineCopy: Record 81;
        NewLNApplicNo: Code[10];
        Cust: Record "Customer";
        TestAmt: Decimal;
        CustRec: Record "Customer";
        CustPostingGroup: Record 92;
        GenSetUp: Record 311;
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Appraisal Salary Details";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit 12;
        LoanTopUp: Record "Loan Offset Details";
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        Notification: Codeunit 397;
        CustE: Record "Customer";
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        SMSMessage: Record "Customer";
        InstallNo2: Integer;
        currency: Record 330;
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;

    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := rec."Loan  No.";
        LoanProductType := rec."Loan Product Type";
    end;

    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        IF rec."Outstanding Balance" > 0 THEN BEGIN
            IF (Rec."Expected Date of Completion" < TODAY) THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END;
    end;

    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}




