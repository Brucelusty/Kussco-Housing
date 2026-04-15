page 51155 "OD Approved Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    // InsertAllowed = false;
    PageType = Card;
    SourceTable = "Loans Register";
    SourceTableView = WHERE(Source = CONST(FOSA),
                            Posted = CONST(false),
                            "Loan Product Type" = const('M_OD'));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Loan  No."; rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Staff No"; rec."Staff No")
                {
                    Caption = 'Staff No';
                    Editable = false;
                }
                field("Account No"; rec."Account No")
                {
                    Caption = 'FOSA Account No';
                    Editable = MNoEditable;
                }
                field("Client Name"; rec."Client Name")
                {
                    Editable = false;
                }
                field("ID NO"; rec."ID NO")
                {
                    Editable = false;
                }
                field("Application Date"; rec."Application Date")
                {
                    // Editable = ApplcDateEditable;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        rec.TESTFIELD(Posted, FALSE);
                    end;
                }
                field("Loan Product Type"; rec."Loan Product Type")
                {
                    Editable = LProdTypeEditable;

                    trigger OnValidate()
                    begin
                        Register.RESET;
                        Register.SETRANGE(Register."Client Code", rec."Client Code");
                        Register.SETRANGE(Register."Loan Product Type", rec."Loan Product Type");
                        Register.SETFILTER(Register."Outstanding Balance", '>0');
                        IF Register.FIND('-') THEN BEGIN
                            ERROR('This member has an existing type of loan.');
                        END;
                    end;
                }
                field(Installments; rec.Installments)
                {
                    Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        rec.TESTFIELD(Posted, FALSE);
                    end;
                }
                field(Interest; rec.Interest)
                {
                    Editable = Interrest;
                }
                field("Product Currency Code"; rec."Product Currency Code")
                {
                    Editable = false;
                    Enabled = true;
                }
                field("Requested Amount"; rec."Requested Amount")
                {
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        rec.TESTFIELD(Posted, FALSE);
                    end;
                }
                field("Approved Amount"; rec."Approved Amount")
                {
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        rec.TESTFIELD(Posted, FALSE);
                    end;
                }
                field("Loan Purpose"; rec."Loan Purpose")
                {
                    Editable = true;
                    Visible = false;
                }
                field(Remarks; rec.Remarks)
                {
                    Editable = true;
                    Visible = true;
                }
                field("Repayment Method"; rec."Repayment Method")
                {
                    Editable = RepayMethodEditable;
                }
                field(Repayment; rec.Repayment)
                {
                    Editable = RepaymentEditable;
                }
                field("Loan Status"; rec."Loan Status")
                {
                    Editable = LoanStatusEditable;

                    trigger OnValidate()
                    begin
                        UpdateControl();

                        /*IF LoanType.GET('DISCOUNT') THEN BEGIN
                        IF (("Approved Amount")-("Special Loan Amount"+"Other Commitments Clearance"+SpecialComm))
                             < 0 THEN
                        ERROR('Bridging amount more than the loans applied/approved.');
                        
                        END;
                        
                        
                        IF "Loan Status" = "Loan Status"::Appraisal THEN BEGIN
                        StatusPermissions.RESET;
                        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Bosa Loan Appraisal");
                        IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to Appraise this Loan.');
                        
                        END ELSE BEGIN
                        
                        IF "Loan Status" = "Loan Status"::Approved THEN BEGIN
                        StatusPermissions.RESET;
                        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Bosa Loan Approval");
                        IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to Approve this Loan.');
                        
                        "Date Approved":=TODAY;
                        END;
                        END;
                        //END;
                        
                        
                        {
                        ccEmail:='';
                        
                        LoanG.RESET;
                        LoanG.SETRANGE(LoanG."Loan No","Loan  No.");
                        IF LoanG.FIND('-') THEN BEGIN
                        REPEAT
                        IF CustE.GET(LoanG."Member No") THEN BEGIN
                        IF CustE."E-Mail" <> '' THEN BEGIN
                        IF ccEmail = '' THEN
                        ccEmail:=CustE."E-Mail"
                        ELSE
                        ccEmail:=ccEmail + ';' + CustE."E-Mail";
                        END;
                        END;
                        UNTIL LoanG.NEXT = 0;
                        END;
                        
                        
                        
                        IF "Loan Status"="Loan Status"::Approved THEN BEGIN
                        CLEAR(Notification);
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'We are happy to inform you that your ' + "Loan Product Type" + ' loan application of ' + FORMAT("Requested Amount")
                         + ' has been approved.' + ' (Dynamics NAV ERP)','',FALSE);
                        END;
                        
                        
                        END ELSE IF "Loan Status"="Loan Status"::Appraisal THEN BEGIN
                        DocN:='';
                        DocM:='';
                        DocF:='';
                        DNar:='';
                        
                        IF "Copy of ID"= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:='Copy of ID.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        IF Contract= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:=DocM + ' Contract.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        IF Payslip= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:=DocM + ' Payslip.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        DNar:=DocN + DocM + DocF;
                        
                        
                        CLEAR(Notification);
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'Your ' + "Loan Product Type" + ' loan application of Ksh.' + FORMAT("Requested Amount")
                        + ' has been received and it is now at the appraisal stage. ' +
                         DNar + ' (Dynamics NAV ERP)'
                        ,'',FALSE);
                        END;
                        
                        
                        END ELSE BEGIN
                        CLEAR(Notification);
                        
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'We are sorry to inform you that your ' + "Loan Product Type" + ' loan application of ' + FORMAT("Requested Amount")
                        + ' has been rejected.' + ' (Dynamics NAV ERP)'
                        ,'',FALSE);
                        END;
                        
                        END;
                        
                        }
                          {
                        //SMS Notification
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","Client Code");
                        IF Cust.FIND('-') THEN BEGIN
                        Cust.TESTFIELD(Cust."Phone No.");
                        END;
                        
                        
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","Client Code");
                        IF Cust.FIND('-') THEN BEGIN
                        SMSMessage.INIT;
                        SMSMessage."SMS Message":=Cust."Phone No."+'*'+' Your loan app. of date ' + FORMAT("Application Date")
                        + ' of type ' + "Loan Product Type" +' of amount ' +FORMAT("Approved Amount")+' has been issued. Thank you.';
                        SMSMessage."Date Entered":=TODAY;
                        SMSMessage."Time Entered":=TIME;
                        SMSMessage."SMS Sent":=SMSMessage."SMS Sent"::No;
                        SMSMessage.INSERT;
                        END;
                        //SMS Notification
                        }   */

                    end;
                }
                field("Captured By"; rec."Captured By")
                {
                    Editable = false;
                }
                field("Top Up Amount"; rec."Top Up Amount")
                {
                }
                field("Total TopUp Commission"; rec."Total TopUp Commission")
                {
                }
                field("Other Commitments Clearance"; rec."Other Commitments Clearance")
                {
                    Editable = false;
                }
                field("Repayment Frequency"; rec."Repayment Frequency")
                {
                    Editable = RepayFrequencyEditable;
                }
                field("Recovery Mode"; rec."Recovery Mode")
                {
                }
                field("Mode of Disbursement"; rec."Mode of Disbursement")
                {
                    Editable = ModeofDisburesmentEdit;
                }
                field("Cheque No."; rec."Cheque No.")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        IF STRLEN(rec."Cheque No.") > 6 THEN
                            ERROR('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Repayment Start Date"; rec."Repayment Start Date")
                {
                    Editable = false;
                }
                field("Expected Date of Completion"; rec."Expected Date of Completion")
                {
                    Editable = false;
                }
                field("External EFT"; rec."External EFT")
                {
                    Visible = false;
                }
                field("Approval Status"; rec."Approval Status")
                {
                    Editable = false;
                }
                field("Transacting Branch"; rec."Transacting Branch")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Net Income"; rec."Net Income")
                {
                    Editable = NetIncome;
                    Visible = true;
                }
                field("Recommended Amount"; rec."Recommended Amount")
                {
                    Editable = false;
                }

                field("Emp Loan Codes"; rec."Emp Loan Codes")
                {
                }
            }
            group(Batching)
            {
                field("Loan Disbursement Date"; rec."Loan Disbursement Date")
                {
                    Editable = true;
                }
                field("Batch No."; rec."Batch No.")//
                {
                }
                field("Reason For Loan Rejection"; rec."Reason For Loan Rejection")
                {
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
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin


                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.", rec."Loan  No.");
                        IF LoanApp.FIND('-') THEN BEGIN

                            REPORT.RUN(51516263, TRUE, FALSE, LoanApp);
                        END;
                    end;
                }
                separator(Sep02)
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
                    var
                        SFactory: Codeunit "Au Factory";
                    begin
                        Rec.TestField(Rec."Loan Disbursement Date");
                        SFactory.FnGenerateLoanRepaymentSchedule(rec."Loan  No.");

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Commit;
                            Report.Run(80014, true, false, LoanApp);
                        end;
                    end;
                }
                separator(Sep04)
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
                separator(Sep05)
                {
                }
                separator(Sep06)
                {
                }
                action("Post Loan")
                {
                    Caption = 'Post Loan';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //SMS MESSAGE/// To Applicant
                        SMSMessage.RESET;
                        IF SMSMessage.FIND('+') THEN BEGIN
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        END
                        ELSE BEGIN
                            iEntryNo := 1;
                        END;

                        SMSMessage.RESET;
                        SMSMessage.INIT;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Account No" := rec."Account No";
                        SMSMessage."Date Entered" := TODAY;
                        SMSMessage."Time Entered" := TIME;
                        SMSMessage.Source := 'LOAN ISSUE';
                        SMSMessage."Entered By" := USERID;
                        SMSMessage."Sent To Server" := SMSMessage."Sent To Server"::No;
                        SMSMessage."SMS Message" := 'Your loan application of KSHs.' + FORMAT(rec."Approved Amount") +
                                                  ' has been issued. SHIRIKA SACCO LTD';
                        VEND1.RESET;
                        IF VEND1.GET(rec."Account No") THEN
                            SMSMessage."Telephone No" := VEND1."Phone No.";
                        SMSMessage.INSERT;

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
                separator(Sep07)
                {
                }
                action("Loan Securities")
                {
                    Caption = 'Securities';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = FIELD("Client Code");
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
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                    begin
                        /*
                        LBatches.RESET;
                        LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
                        IF LBatches.FIND('-') THEN BEGIN
                            ApprovalEntries.Setfilters(DATABASE::Loans,17,LBatches."Loan  No.");
                              ApprovalEntries.RUN;
                        END;
                        */

                        // DocumentType:=DocumentType::Loan;
                        // ApprovalEntries.Setfilters(DATABASE::"Absence Preferences",DocumentType,"Loan  No.");
                        // ApprovalEntries.RUN;

                    end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: Label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit 439;
                    begin
                        rec."Approval Status" := rec."Approval Status"::Approved;
                        rec."Loan Status" := rec."Loan Status"::Approval;
                        rec."approved By" := USERID;
                        rec."approved Time" := TIME;
                        rec.MODIFY;
                        /*
                     SalDetails.RESET;
                     SalDetails.SETRANGE(SalDetails."Loan No","Loan  No.");
                     IF SalDetails.FIND('-')=FALSE THEN BEGIN
                     ERROR('Please Insert Loan Applicant Salary Information');
                     END;
                       */

                        IF rec."Loan Product Type" <> 'L10' THEN BEGIN
                            LGuarantors.RESET;
                            LGuarantors.SETRANGE(LGuarantors."Loan No", rec."Loan  No.");
                            IF LGuarantors.FIND('-') = FALSE THEN BEGIN

                                /*Was an error*/
                                message('Please Insert Loan Applicant Guarantor Information');
                            END;
                        END;
                        rec.TESTFIELD("Approved Amount");
                        rec.TESTFIELD("Loan Product Type");

                        /*IF ("Mode of Disbursement"="Mode of Disbursement"::Cheque) OR
                        ("Mode of Disbursement"="Mode of Disbursement"::"Bank Transfer") OR
                        ("Mode of Disbursement"="Mode of Disbursement"::" ")THEN
                        ERROR('Mode of disbursment must be FOSA Loans'); */

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

                        IF rec."Loan Status" <> rec."Loan Status"::Application THEN
                            /*Was an error*/
                            message(Text001);

                        // IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                        //   ApprovalsMgmt.OnSendLoanAppDocForApproval(Rec);

                        /*"Loan Status":="Loan Status"::Approved;
                        "Approval Status":="Approval Status"::Approved;
                        MODIFY;
                        */

                        rec.TESTFIELD("Requested Amount");
                        //SMS MESSAGE

                        SMSMessages.RESET;
                        IF SMSMessages.FIND('+') THEN BEGIN
                            iEntryNo := SMSMessages."Entry No";
                            iEntryNo := iEntryNo + 1;
                        END
                        ELSE BEGIN
                            iEntryNo := 1;
                        END;

                        SMSMessages.RESET;
                        SMSMessages.INIT;
                        SMSMessages."Entry No" := iEntryNo;
                        SMSMessages."Account No" := rec."Client Code";
                        SMSMessages."Date Entered" := TODAY;
                        SMSMessages."Time Entered" := TIME;
                        SMSMessages.Source := 'LOAN APPL';
                        SMSMessages."Entered By" := USERID;
                        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                        SMSMessages."SMS Message" := 'Your loan application of KSHs.' + FORMAT(rec."Requested Amount") +
                                                  ' has been received. TELEPOST SACCO.';
                        Cust.RESET;
                        IF Cust.GET(rec."Client Code") THEN
                            SMSMessages."Telephone No" := Cust."Phone No.";
                        SMSMessages.INSERT;

                        // SMS Message to Guarantors
                        LoanGuar.RESET;
                        LoanGuar.SETRANGE(LoanGuar."Loan No", rec."Loan  No.");
                        IF LoanGuar.FIND('-') THEN BEGIN
                            REPEAT

                                Vend.RESET;
                                Vend.SETRANGE(Vend."No.", LoanGuar."Account No.");
                                //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                                IF Cust.FIND('-') THEN BEGIN

                                    //SMS MESSAGE

                                    SMSMessages.RESET;
                                    IF SMSMessages.FIND('+') THEN BEGIN
                                        iEntryNo := SMSMessages."Entry No";
                                        iEntryNo := iEntryNo + 1;
                                    END
                                    ELSE BEGIN
                                        iEntryNo := 1;
                                    END;

                                    SMSMessages.INIT;
                                    SMSMessages."Entry No" := iEntryNo;
                                    SMSMessages."Account No" := LoanGuar."Account No.";
                                    SMSMessages."Date Entered" := TODAY;
                                    SMSMessages."Time Entered" := TIME;
                                    SMSMessages.Source := 'LOAN GUARANTORS';
                                    SMSMessages."Entered By" := USERID;
                                    SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                                    //IF LoanApp.GET(LoanGuar."Loan No") THEN
                                    SMSMessages."SMS Message" := 'You have guaranteed an amount of ' + FORMAT(LoanGuar."Amont Guaranteed")
                                    + ' to ' + rec."Client Name" + ' ' + 'Staff No:-' + rec."Staff No" + ' ' +
                                    'Loan Type ' + rec."Loan Product Type" + ' ' + 'of ' + FORMAT(rec."Approved Amount") + ' at TELEPOST SACCO.'
                                    + ' ' + 'Please call if in dispute.';
                                    SMSMessages."Telephone No" := Vend."Phone No.";
                                    SMSMessages.INSERT;
                                    //MESSAGE('%1',Cust."Phone No.");
                                END;
                            UNTIL LoanGuar.NEXT = 0;
                        END;

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        // IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                        //   ApprovalsMgmt.OnCancelLoanAppApprovalRequest(Rec);
                    end;
                }
                action(Reopen)
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec."Loan Status" := rec."Loan Status"::Application;
                        rec."Approval Status" := rec."Approval Status"::Open;
                        rec.MODIFY
                        //ApprovalsMgmt.OnCancelLoanAppApprovalRequest(Rec);
                    end;
                }
                action("Return To Appraisal")
                {
                    Image = Confirm;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec."Loan Status" := rec."Loan Status"::Appraisal;
                        rec."Approval Status" := rec."Approval Status"::Open;
                        rec."Appraised By" := '';
                        rec.MODIFY

                        /*IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnCancelLoanAppApprovalRequest(Rec);
                        */

                    end;
                }
                action("Reject Loan")
                {
                    Image = Reject;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.TESTFIELD("Reason For Loan Rejection");
                        rec."Loan Status" := rec."Loan Status"::Rejected;
                        rec."Approval Status" := rec."Approval Status"::Rejected;
                        rec.MODIFY

                        /*IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnCancelLoanAppApprovalRequest(Rec);
                        */

                    end;
                }
                action("Mark As Express Loan")
                {
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.MarkLoanAsExpress;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Source := rec.Source::FOSA;
        rec."Mode of Disbursement" := rec."Mode of Disbursement"::"FOSA Account";
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        IF rec."Loan Status" = rec."Loan Status"::Approved THEN
            CurrPage.EDITABLE := FALSE;
    end;

    trigger OnOpenPage()
    begin
        rec.SETRANGE(Posted, FALSE);
        //CurrPage.EDITABLE := FALSE;

        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if user.Overdraft = true then begin
                pageEditor := true;
            end
            else begin
                Error('This user, %1 is not authorized to view this card.', UserId);
            end;
        end;
    end;

    var
        pageEditor: Boolean;
        user: Record "User Setup";
        iEntryNo: Integer;
        VEND1: Record 23;
        LoanGuar: Record "Loans Guarantee Details";
        SMSMessage: Record "SMS Messages";
        SMSMessages: Record "SMS Messages";
        i: Integer;
        LoanType: Record "Loan Products Setup";
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
        LineNo: Integer;
        GnljnlineCopy: Record 81;
        NewLNApplicNo: Code[10];
        Cust: Record "Customer";
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record "Customer";
        CustPostingGroup: Record 92;
        GenSetUp: Record 311;
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
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
        GenJournalLine: Record 81;
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit 12;
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record 23;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        Notification: Codeunit 397;
        CustE: Record "Customer";
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Register";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Offset Details";
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
        LBatches: Record "Loan Disburesment-Batching";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        Text001: Label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        Interrest: Boolean;
        InterestSal: Decimal;
        NetIncome: Boolean;
        ApprovalsMgmt: Codeunit 1535;
        Register: Record "Loans Register";

    procedure UpdateControl()
    begin
        IF rec."Loan Status" = rec."Loan Status"::Application THEN BEGIN
            MNoEditable := TRUE;
            ApplcDateEditable := TRUE;
            LoanStatusEditable := FALSE;
            LProdTypeEditable := TRUE;
            InstallmentEditable := TRUE;
            NetIncome := TRUE;
            Interrest := FALSE;
            AppliedAmountEditable := TRUE;
            ApprovedAmountEditable := TRUE;
            RepayMethodEditable := TRUE;
            RepaymentEditable := TRUE;
            BatchNoEditable := FALSE;
            RepayFrequencyEditable := TRUE;
            ModeofDisburesmentEdit := TRUE;
            DisbursementDateEditable := TRUE;
        END;

        IF rec."Loan Status" = rec."Loan Status"::Appraisal THEN BEGIN
            MNoEditable := FALSE;
            ApplcDateEditable := TRUE;
            LoanStatusEditable := FALSE;
            LProdTypeEditable := FALSE;
            Interrest := FALSE;
            NetIncome := TRUE;
            InstallmentEditable := FALSE;
            AppliedAmountEditable := FALSE;
            ApprovedAmountEditable := TRUE;
            RepayMethodEditable := TRUE;
            RepaymentEditable := TRUE;
            BatchNoEditable := FALSE;
            RepayFrequencyEditable := FALSE;
            ModeofDisburesmentEdit := TRUE;
            DisbursementDateEditable := FALSE;
        END;

        IF rec."Loan Status" = rec."Loan Status"::Rejected THEN BEGIN
            MNoEditable := FALSE;
            ApplcDateEditable := FALSE;
            LoanStatusEditable := FALSE;
            LProdTypeEditable := FALSE;
            InstallmentEditable := FALSE;
            AppliedAmountEditable := FALSE;
            NetIncome := FALSE;
            Interrest := FALSE;
            ApprovedAmountEditable := FALSE;
            RepayMethodEditable := FALSE;
            RepaymentEditable := FALSE;
            BatchNoEditable := FALSE;
            RepayFrequencyEditable := FALSE;
            ModeofDisburesmentEdit := FALSE;
            DisbursementDateEditable := FALSE;
        END;

        IF rec."Loan Status" = rec."Loan Status"::Approved THEN BEGIN
            MNoEditable := FALSE;
            LoanStatusEditable := FALSE;
            ApplcDateEditable := FALSE;
            Interrest := FALSE;
            LProdTypeEditable := FALSE;
            NetIncome := FALSE;
            InstallmentEditable := FALSE;
            AppliedAmountEditable := FALSE;
            ApprovedAmountEditable := FALSE;
            RepayMethodEditable := FALSE;
            RepaymentEditable := FALSE;
            BatchNoEditable := TRUE;
            RepayFrequencyEditable := FALSE;
            ModeofDisburesmentEdit := TRUE;
            DisbursementDateEditable := TRUE;
        END;
    end;

    procedure LoanAppPermisions()
    begin
    end;
}




