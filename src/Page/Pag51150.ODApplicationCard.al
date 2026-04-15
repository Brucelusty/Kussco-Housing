page 51150 "OD Application Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = WHERE(Source = CONST(FOSA), Posted = CONST(false),
                            "Loan Status" = CONST(Application), "Loan Product Type" = const('M_OD'));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Source"; Rec."Source")
                {
                    Caption = 'FOSA/BOSA/Micro';
                    Editable = false;
                }
                field("Source."; Rec."Source.")
                {
                    Caption = 'Source';
                    Editable = false;
                }
                field("Loan Product Type"; rec."Loan Product Type")
                {
                    Editable = LProdTypeEditable;
                    Lookup = true;
                    LookupPageId = "Overdraft Loan Product Setup";

                    trigger OnValidate()
                    begin
                        Register.RESET;
                        Register.SETRANGE(Register."Client Code", rec."Client Code");
                        Register.SETRANGE(Register."Loan Product Type", rec."Loan Product Type");
                        Register.SETFILTER(Register."Outstanding Balance", '>0');
                        IF Register.FIND('-') THEN BEGIN
                            MESSAGE('This member has an existing %1 .', rec."Loan Product Type Name");
                        END;
                    end;
                }
                field("Loan Product Type Name"; rec."Loan Product Type Name")
                {
                    Editable = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member No.';
                }
                field("Account No"; rec."Account No")
                {
                    Caption = 'FOSA Account No';
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        // VEND6.GET("Account No");
                        // CustS.RESET;
                        // CustS.SETRANGE(CustS."No.",VEND6."BOSA Account No");
                        // CustS.SETFILTER(CustS."Loan Defaulter",'%1',TRUE);
                        // IF CustS.FINDFIRST THEN
                        // BEGIN
                        // ERROR('Member is A Defaulter.');
                        // END;

                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Client Code", VEND6."BOSA Account No");
                        LoanApp.SETFILTER(LoanApp."Loans Category", 'Loss');
                        IF (LoanApp.FIND('-')) THEN
                            REPEAT
                                IF LoanApp."Loans Category" = LoanApp."Loans Category"::Loss THEN
                                    ERROR('Member has Aloan which is in Loss- %1', LoanApp."Loan  No.");
                            //currentShares:=currentShares+Cust2.Amount;
                            UNTIL LoanApp.NEXT = 0;
                        //LoanApp.INIT;
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Client Code", VEND6."BOSA Account No");
                        LoanApp.SETFILTER(LoanApp."Loans Category", 'Substandard');
                        IF (LoanApp.FIND('-')) THEN
                            REPEAT
                                IF LoanApp."Loans Category" = LoanApp."Loans Category"::Substandard THEN
                                    ERROR('Member has Aloan which is substandard- %1', LoanApp."Loan  No.");
                            //currentShares:=currentShares+Cust2.Amount;
                            UNTIL LoanApp.NEXT = 0;
                        //LoanApp.INIT;
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Client Code", VEND6."BOSA Account No");
                        LoanApp.SETFILTER(LoanApp."Loans Category", 'Doubtful');
                        IF (LoanApp.FIND('-')) THEN
                            REPEAT
                                IF LoanApp."Loans Category" = LoanApp."Loans Category"::Doubtful THEN
                                    ERROR('Member has Aloan which is doubtfull- %1', LoanApp."Loan  No.");
                            //currentShares:=currentShares+Cust2.Amount;
                            UNTIL LoanApp.NEXT = 0;

                    end;
                }
                field("Client Name"; rec."Client Name")
                {
                    Editable = false;
                }
                field("Staff No"; rec."Staff No")
                {
                    Caption = 'Staff No';
                    Editable = false;
                }
                field("ID NO"; rec."ID NO")
                {
                    Editable = false;
                }
                field(Workstation; rec.Workstation)
                {
                    Editable = false;
                }
                field(Designation; rec.Designation)
                {
                    Editable = false;
                }
                field("Terms of Service"; rec."Terms of Service")
                {

                }
                field("Gross monthly Income"; rec."Gross monthly Income")
                {
                    Visible = false;
                }
                field("Estimated Monthly Expense"; rec."Estimated Monthly Expense")
                {
                    Visible = false;

                    trigger
                    OnValidate()
                    begin
                        rec."Estimated Net Monthly Income" := rec."Gross monthly Income" - rec."Estimated Monthly Expense";
                        rec."Net Income" := rec."Estimated Net Monthly Income";
                    end;
                }
                field("Estimated Net Monthly Income"; rec."Estimated Net Monthly Income")
                {
                    Visible = false;
                    Editable = false;
                }
                field("Application Date"; rec."Application Date")
                {
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        rec.TESTFIELD(Posted, FALSE);
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
                    // Editable = AppliedAmountEditable;
                    Editable = RequestedAmountEditable;

                    trigger OnValidate()
                    begin
                        rec.TESTFIELD(Posted, FALSE);
                        rec.Repayment := (rec."Requested Amount" * (rec.Interest / 100)) + rec."Requested Amount";
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
                field("Main Sector"; Rec."Main Sector")
                {

                }
                field("Manin Sector Name"; Rec."Manin Sector Name")
                {
                    Editable = false;
                    Caption = 'Main sector Name';
                }

                field("Sub Sector"; Rec."Sub Sector")
                {

                }
                field("SubSector Name"; Rec."SubSector Name") { Editable = false; }


                field("Sector Specific"; Rec."Sector Specific")
                {
                    caption = 'Specific Sector';
                    trigger OnValidate()
                    var
                        SpecificSector: Record "Specific Sector";
                    begin
                        /*                         SpecificSector.Reset();
                                                SpecificSector.SetRange(SpecificSector.Code, Rec."Sector Specific");
                                                if SpecificSector.FindFirst() then begin
                                                    Rec."Sector Specific Name" := SpecificSector.Description;
                                                    Rec."Main Sector" := SpecificSector."Main Sector";
                                                    Rec."Sub Sector" := SpecificSector."Sub-Sector";
                                                end; */
                    end;
                }
                field("Sector Specific Name"; Rec."Sector Specific Name") { Editable = false; Caption = 'Specific Sector Name'; }
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
                field("Batch No."; rec."Batch No.")
                {
                    Editable = BatchNoEditable;
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
                field("Offset Loan"; rec."Offset Loan")
                {
                }
                field("Mode of Disbursement"; rec."Mode of Disbursement")
                {
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Disbursement Date"; rec."Loan Disbursement Date")
                {
                    Editable = DisbursementDateEditable;
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
                field("Bridge Amount Release"; rec."Bridge Amount Release")
                {
                    Enabled = false;
                }
                field("Reason for rejection"; rec."Reason for rejection")
                {
                }
            }
            group(Earnings)
            {
                Caption = 'Earnings';
                field("Basic Pay H"; rec."Basic Pay H")
                {
                    Caption = 'Basic Pay';
                }
                field("Other Income."; rec."Other Income.")
                {
                }
                field("Total Earnings(Salary)"; rec."Total Earnings(Salary)")
                {
                }
                field("Total Deductions(Salary)"; rec."Total Deductions(Salary)")
                {
                }
                field("Third basic"; rec."Third basic")
                {
                }
                field("Two Thirds Basic"; rec."Two Thirds Basic")
                {
                }
                field("Net take Home"; rec."Net take Home")
                {
                }
            }
            part("Guarantors  Detail"; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = FIELD("Loan  No.");
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
                action("Move to Appraisal")
                {
                    Image = Recalculate;
                    Enabled = pageEditor;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    //SFac: Codeunit "51516007";

                    begin
                        rec.TESTFIELD("Main Sector");
                        rec.TESTFIELD("Sub Sector");
                        rec.TESTFIELD("Sector Specific");
                        rec.TESTFIELD("Loan Product Type");
                        rec.TESTFIELD("Application Date");
                        rec.TestField("Basic Pay H");
                        //TESTFIELD("Client Code");
                        rec.TESTFIELD("Account No");
                        rec.TESTFIELD("BOSA No");
                        rec.TESTFIELD("Requested Amount");
                        rec.TestField("Application Date", Today);
                        // //TESTFIELD("Gross monthly Income");
                        // TESTFIELD("Estimated Monthly Expense");
                        // TESTFIELD("Estimated Net Monthly Income");

                        if Rec."Overdrawn Reconciliation" = false then begin
                            LoanApp.RESET;
                            LoanApp.SETRANGE(LoanApp."Client Code", rec."Client Code");
                            LoanApp.SETRANGE(LoanApp.Posted, TRUE);
                            IF LoanApp.FIND('-') THEN BEGIN
                                REPEAT
                                    LoanApp.CALCFIELDS(LoanApp."Outstanding Balance");
                                    rec.CALCFIELDS("Top Up Amount");
                                    IF LoanApp."Outstanding Balance" > 0 THEN BEGIN
                                        IF (LoanApp."Loans Category" = LoanApp."Loans Category"::Substandard) OR
                                        (LoanApp."Loans Category" = LoanApp."Loans Category"::Doubtful) OR (LoanApp."Loans Category" = LoanApp."Loans Category"::Loss)
                                        THEN BEGIN
                                            IF rec."Top Up Amount" = 0 THEN BEGIN
                                                IF NOT (USERID = 'TELEPOST\GOMINDE') OR (USERID = 'TELEPOST\MNDEKEI') OR (USERID = 'TELEPOST\Administrator') THEN
                                                    ERROR('The member is a defaulter' + '. ' + 'Loan No' + ' ' + LoanApp."Loan  No." + ' ' + 'is in loan category' + ' ' +
                                                    FORMAT(LoanApp."Loans Category"));
                                            END;
                                        END;
                                    END;
                                UNTIL LoanApp.NEXT = 0;
                            END;
                        end;

                        IF rec."Staff Loan" = FALSE THEN BEGIN
                            //IF LoanProducts.GET("Loan Product Type") THEN BEGIN
                            //IF LoanProducts."No Qlf  Per Deposits"<>TRUE THEN BEGIN
                            LoanGr.RESET;
                            LoanGr.SETRANGE(LoanGr."Loan No", rec."Loan  No.");
                            IF LoanGr.FINDSET THEN BEGIN
                                LoanGr.CALCSUMS(LoanGr."Amont Guaranteed");
                                TotalGuaranteed := LoanGr."Amont Guaranteed";
                            END;

                            LoanType.GET(rec."Loan Product Type");
                            /*IF LoanType."Appraise Guarantors"=TRUE THEN BEGIN
                            IF "Requested Amount">TotalGuaranteed THEN
                            ERROR('Guaranteed Amount Must Be Equal To The Requested Amount.');
                            //END;
                            //END;
                            END;
                            IF "Requested Amount">TotalGuaranteed THEN
                            IF CONFIRM('Guaranteed Amount is less than Requested Amount.,Are you sure you want to continue ?',TRUE) = FALSE THEN
                            EXIT;*/
                        END;

                        IF CONFIRM('Are you sure you want to move this Loan to Appraisal Stage ?', TRUE) = FALSE THEN
                            EXIT;
                        if rec."Basic Pay H" > 4000000 then
                            Error('Basic pay is above maximum expected');
                        if rec."Basic Pay H" < 100 then
                            Error('Basic pay is Less than minimum');

                        rec."Loan Status" := rec."Loan Status"::Appraisal;
                        rec."Captured By" := USERID;
                        rec.MODIFY;

                        //SMS MESSAGE

                        /*
                        SMSMessages.RESET;
                        IF SMSMessages.FIND('+') THEN BEGIN
                        iEntryNo:=SMSMessages."Entry No";
                        iEntryNo:=iEntryNo+1;
                        END
                        ELSE BEGIN
                        iEntryNo:=1;
                        END;

                        SMSMessages.RESET;
                        SMSMessages.INIT;
                        SMSMessages."Entry No":=iEntryNo;
                        SMSMessages."Account No":="Account No";
                        SMSMessages."Date Entered":=TODAY;
                        SMSMessages."Time Entered":=TIME;
                        SMSMessages.Source:='LOAN APPL';
                        SMSMessages."Entered By":=USERID;
                        SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
                        SMSMessages."SMS Message":='Dear '+"Client Name"+', your '+"Loan Product Type Name"+ ' application of KSHs.'+FORMAT("Requested Amount")+
                                                  ' has been received and is being worked on. TELEPOST SACCO.';
                        Cust.RESET;
                        IF Cust.GET("Client Code") THEN
                        SMSMessages."Telephone No":=Cust."Phone No.";
                        SMSMessages.INSERT;
                        */


                        // IF Cust.GET(rec."Client Code") THEN BEGIN
                        //     rec."Account No" := Cust."FOSA Account";

                        //     IF rec.Installments <= 24 THEN BEGIN
                        //         Msg := 'Dear ' + //SkyMbanking.FirstName(rec."Client Name") + ', your ' + rec."Loan Product Type Name" + ' application of KSHs.' + FORMAT(rec."Requested Amount") +
                        //                                 ' has been received and is being worked on.Will be disbursed on ' + FORMAT(rec."Application Date") + ' at ' + FORMAT(rec."Registration Time" + 10800000);
                        //     END ELSE BEGIN
                        //         Msg := 'Dear ' + //SkyMbanking.FirstName(rec."Client Name") + ', your ' + rec."Loan Product Type Name" + ' application of KSHs.' + FORMAT(rec."Requested Amount") +
                        //                                  ' has been received and is being worked on.Will be disbursed on ' + FORMAT(CALCDATE('<1M>', rec."Application Date"));
                        //     END;

                        //     //SkyMbanking.SendSms(SMSSource::LOAN_APPLICATION, Cust."Phone No.", Msg, rec."Loan  No.", rec."Account No", TRUE, 0, TRUE);
                        // END;






                        /*LoanGuar.RESET;
                        LoanGuar.SETRANGE(LoanGuar."Loan No","Loan  No.");
                        IF LoanGuar.FIND('-') THEN BEGIN
                        REPEAT
                        
                        
                        
                            IF Cust.GET(LoanGuar."Member No") THEN BEGIN
                        
                                Msg := 'Dear '+SkyMbanking.FirstName(LoanGuar.Name)+ ', you have guaranteed '+"Client Name"+'  '+"Loan Product Type Name"+' of Ksh.'+FORMAT("Requested Amount")
                           +' with your shares worth '+FORMAT(LoanGuar."Amont Guaranteed")+' at TELEPOST SACCO'
                              +' '+'Please call '+' +254205029200 '+ ' if in dispute.';
                        
                        
                                SkyMbanking.SendSms(SMSSource::LOAN_GUARANTORS,Cust."Phone No.",Msg,"Loan  No.","Account No",TRUE,0,TRUE);
                            END;
                        
                        {
                          Cust.RESET;
                          Cust.SETRANGE(Cust."No.",LoanGuar."Member No");
                          //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                          IF Cust.FIND('-') THEN BEGIN
                        
                          //SMS MESSAGE
                        
                          SMSMessages.RESET;
                          IF SMSMessages.FIND('+') THEN BEGIN
                          iEntryNo:=SMSMessages."Entry No";
                          iEntryNo:=iEntryNo+1;
                          END
                          ELSE BEGIN
                          iEntryNo:=1;
                          END;
                        
                          SMSMessages.INIT;
                          SMSMessages."Entry No":=iEntryNo;
                          SMSMessages."Account No":=LoanGuar."Member No";
                          SMSMessages."Date Entered":=TODAY;
                          SMSMessages."Time Entered":=TIME;
                          SMSMessages.Source:='LOAN GUARANTORS';
                          SMSMessages."Entered By":=USERID;
                          SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
                          //IF LoanApp.GET(LoanGuar."Loan No") THEN
                          {SMSMessages."SMS Message":='You have guaranteed a loan of '+FORMAT(LoanGuar."Amont Guaranteed")
                          +' to '+"Client Name"+' '+'Staff No:-'+"Staff No"+' '+
                          'Loan Type '+"Loan Product Type"+' '+'of '+FORMAT("Requested Amount") +' at TELEPOST SACCO Ltd.'
                          ;}
                        
                           SMSMessages."SMS Message":='Dear '+LoanGuar.Name+ ', you have guaranteed '+"Client Name"+'  '+"Loan Product Type Name"+' of Ksh.'+FORMAT("Requested Amount")
                           +' with your shares worth '+FORMAT(LoanGuar."Amont Guaranteed")+' at TELEPOST SACCO'
                              +' '+'Please call '+' +254205029200 '+ ' if in dispute.';
                        
                          SMSMessages."Telephone No":=Cust."Phone No.";
                          SMSMessages.INSERT;
                        //MESSAGE('%1',Cust."Phone No.");
                            END;
                            }
                         UNTIL LoanGuar.NEXT=0;
                          END;
                          */
                        //SFac.FnValidateSameLoanProduct(Rec);

                    end;
                }
                action("Loan Appraisal")
                {
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin


                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.", rec."Loan  No.");
                        IF LoanApp.FIND('-') THEN BEGIN

                            REPORT.RUN(51516263, TRUE, FALSE, LoanApp);
                        END;
                    end;
                }
                separator(Sep08)
                {
                }
                action("View Schedule")
                {
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

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
                                                  ' has been issued. TELEPOST SACCO LTD';
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
            group(Approval)
            {
                Caption = 'Approvals';
                action(Approvals)
                {
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ApprovalMgt.OpenApprovalEntriesPage(rec.RECORDID)
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

                                ERROR('Please Insert Loan Applicant Guarantor Information');
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
                            ERROR(Text001);

                        // IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                        //     ApprovalsMgmt.OnSendLoanAppDocForApproval(Rec);

                        /*"Loan Status":="Loan Status"::Approved;
                        "Approval Status":="Approval Status"::Approved;
                        MODIFY;
                        */

                        rec.TESTFIELD("Requested Amount");
                        //SMS MESSAGE
                        /*
                              SMSMessages.RESET;
                              IF SMSMessages.FIND('+') THEN BEGIN
                              iEntryNo:=SMSMessages."Entry No";
                              iEntryNo:=iEntryNo+1;
                              END
                              ELSE BEGIN
                              iEntryNo:=1;
                              END;
                        
                              SMSMessages.RESET;
                              SMSMessages.INIT;
                              SMSMessages."Entry No":=iEntryNo;
                              SMSMessages."Account No":="Client Code";
                              SMSMessages."Date Entered":=TODAY;
                              SMSMessages."Time Entered":=TIME;
                              SMSMessages.Source:='LOAN APPL';
                              SMSMessages."Entered By":=USERID;
                              SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
                              SMSMessages."SMS Message":='Your loan application of KSHs.'+FORMAT("Requested Amount")+
                                                        ' has been received. TELEPOST SACCO.';
                              Cust.RESET;
                              IF Cust.GET("Client Code") THEN
                              SMSMessages."Telephone No":=Cust."Phone No.";
                              SMSMessages.INSERT;
                        */


                        IF Cust.GET(rec."Client Code") THEN BEGIN
                            rec."Account No" := Cust."FOSA Account";
                            Msg := 'Your loan application of KSHs.' + FORMAT(rec."Requested Amount") +
                                                    ' has been received. TELEPOST SACCO.';


                            //SkyMbanking.SendSms(SMSSource::LOAN_APPLICATION, Cust."Phone No.", Msg, rec."Loan  No.", rec."Account No", TRUE, 0, TRUE);
                        END;



                        // SMS Message to Guarantors
                        LoanGuar.RESET;
                        LoanGuar.SETRANGE(LoanGuar."Loan No", rec."Loan  No.");
                        IF LoanGuar.FIND('-') THEN BEGIN
                            REPEAT

                                Vend.RESET;
                                Vend.SETRANGE(Vend."No.", LoanGuar."Account No.");
                                //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                                IF Vend.FIND('-') THEN BEGIN

                                    //SMS MESSAGE


                                    rec."Account No" := rec."Account No";
                                    Msg := 'You have guaranteed an amount of ' + FORMAT(LoanGuar."Amont Guaranteed")
                              + ' to ' + rec."Client Name" + ' ' + 'Staff No:-' + rec."Staff No" + ' ' +
                              'Loan Type ' + rec."Loan Product Type" + ' ' + 'of ' + FORMAT(rec."Approved Amount") + ' at TELEPOST SACCO.'
                              + ' ' + 'Please call if in dispute.';


                                    //SkyMbanking.SendSms(SMSSource::LOAN_GUARANTORS, Vend."Phone No.", Msg, rec."Loan  No.", rec."Account No", TRUE, 0, TRUE);



                                    /*
                                      SMSMessages.RESET;
                                      IF SMSMessages.FIND('+') THEN BEGIN
                                      iEntryNo:=SMSMessages."Entry No";
                                      iEntryNo:=iEntryNo+1;
                                      END
                                      ELSE BEGIN
                                      iEntryNo:=1;
                                      END;

                                      SMSMessages.INIT;
                                      SMSMessages."Entry No":=iEntryNo;
                                      SMSMessages."Account No":=LoanGuar."Account No.";
                                      SMSMessages."Date Entered":=TODAY;
                                      SMSMessages."Time Entered":=TIME;
                                      SMSMessages.Source:='LOAN GUARANTORS';
                                      SMSMessages."Entered By":=USERID;
                                      SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
                                      //IF LoanApp.GET(LoanGuar."Loan No") THEN
                                      SMSMessages."SMS Message":='You have guaranteed an amount of '+FORMAT(LoanGuar."Amont Guaranteed")
                                      +' to '+"Client Name"+' '+'Staff No:-'+"Staff No"+' '+
                                      'Loan Type '+"Loan Product Type"+' '+'of '+FORMAT("Approved Amount") +' at TELEPOST SACCO.'
                                      +' '+'Please call if in dispute.';
                                      SMSMessages."Telephone No":=Vend."Phone No.";
                                      SMSMessages.INSERT;
                                    //MESSAGE('%1',Cust."Phone No.");
                                    */
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

                    // trigger OnAction()
                    // var
                    //     ApprovalMgt: Codeunit 439;
                    // begin
                    //     IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                    //         ApprovalsMgmt.OnCancelLoanAppApprovalRequest(Rec);
                    // end;
                }
                action(Reject)
                {
                    Image = reject;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        IF rec."Loan Status" <> rec."Loan Status"::Appraisal THEN
                            ERROR(Text001);
                        /*
                       Doc_Type:=Doc_Type::Loan;
                       Table_id:=DATABASE::"Loans Register";
                       */
                        /*
                        IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendLoanAppDocForApproval(Rec);
                          */
                        /*
                        Doc_Type:=Doc_Type::Loan;
                        Table_id:=DATABASE::"Loans Register";
                        IF ApprovalMgt.SendApproval(Table_id,"Loan  No.",Doc_Type,"Loan Status")THEN;
                        
                        */
                        IF rec."Reason for rejection" = '' THEN
                            ERROR('You must give a reason for rejecting the loan');

                        rec."Loan Status" := rec."Loan Status"::Rejected;
                        rec."Approval Status" := rec."Approval Status"::Rejected;
                        rec.MODIFY;
                        MESSAGE('Loan rejection successful');

                        //SMS MESSAGE

                        /*
                        SMSMessages.RESET;
                        IF SMSMessages.FIND('+') THEN BEGIN
                        iEntryNo:=SMSMessages."Entry No";
                        iEntryNo:=iEntryNo+1;
                        END
                        ELSE BEGIN
                        iEntryNo:=1;
                        END;

                        SMSMessages.RESET;
                        SMSMessages.INIT;
                        SMSMessages."Entry No":=iEntryNo;
                        SMSMessages."Account No":="Account No";
                        SMSMessages."Date Entered":=TODAY;
                        SMSMessages."Time Entered":=TIME;
                        SMSMessages.Source:='LOAN APPL';
                        SMSMessages."Entered By":=USERID;
                        SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
                        SMSMessages."SMS Message":='Dear '+"Client Name"+', your '+"Loan Product Type Name"+ ' application of KSHs.'+FORMAT("Requested Amount")+
                                                  ' has been rejected due to: '+ "Reason for rejection"+ ' TELEPOST SACCO';
                        Cust.RESET;
                        IF Cust.GET("Client Code") THEN
                        SMSMessages."Telephone No":=Cust."Phone No.";
                        SMSMessages.INSERT;
                        */


                        IF Cust.GET(rec."Client Code") THEN BEGIN
                            rec."Account No" := Cust."FOSA Account";
                            Msg := 'Dear ' + //SkyMbanking.FirstName(rec."Client Name") + ', your ' + rec."Loan Product Type Name" + ' application of KSHs.' + FORMAT(rec."Requested Amount") +
                                                    ' has been rejected due to: ' + rec."Reason for rejection" + ' TELEPOST SACCO';


                            //SkyMbanking.SendSms(SMSSource::LOAN_REJECTED, Cust."Phone No.", Msg, rec."Loan  No.", rec."Account No", TRUE, 0, TRUE);
                        END;

                    end;
                }
                action(Reopen)
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec."Loan Status" := rec."Loan Status"::Application;
                        rec."Approval Status" := rec."Approval Status"::Open;
                        rec.MODIFY

                        /*IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnCancelLoanAppApprovalRequest(Rec);
                        */

                    end;
                }
                // action(SendToApproved)
                // {
                //     Caption = 'Send To Disbursement';
                //     Image = PostSendTo;
                //     Promoted = true;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         Rec."Loan Buy-Off Facilitated" := true;
                //         Rec."External loan" := Rec."Requested Amount";
                //         Rec."External loan" := Rec."Requested Amount";
                //         rec."Loan Status" := rec."Loan Status"::Approved;
                //         rec."Approval Status" := rec."Approval Status"::Approved;
                //         rec.MODIFY

                //     end;
                // }
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
        /*    Register2.RESET;
           Register2.SETRANGE(Source, Register2.Source::FOSA);
           Register2.SETRANGE("Loan Status", Register2."Loan Status"::Application);
           IF Register2.FINDFIRST THEN
               ERROR('Number %1 must be used before you can create a new application', Register2."Loan  No."); */




        rec.Source := rec.Source::FOSA;
        rec."Source." := rec."Source."::Income;
        rec."Mode of Disbursement" := rec."Mode of Disbursement"::"FOSA Account";
        //rec."Loan Product Type" := 'M_OD';
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        IF rec."Loan Status" = rec."Loan Status"::Approved THEN
            CurrPage.EDITABLE := FALSE;
    end;

    trigger OnOpenPage()
    begin
        rec.SETRANGE(Posted, FALSE);

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
        RequestedAmountEditable: Boolean;
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
        compinfo: Record 79;
        LoanGr: Record "Loans Guarantee Details";
        LoanProducts: Record "Loan Products Setup";
        TotalGuaranteed: Decimal;
        //SkyMbanking: Codeunit "51516167";
        SMSSource: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL;
        Msg: Text;
        Register2: Record "Loans Register";
        VEND6: Record 23;
        VEND1: Record 23;
        CustS: Record "Customer";
        ApprovalMgt: Codeunit 1535;
        ApprovalEntry: Record 454;
        //CustomApprovals: Codeunit "51516163";
        VarVariant: Variant;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        GuarantorAmount: Decimal;

    procedure UpdateControl()
    begin
        RequestedAmountEditable := false;
        IF rec."Loan Status" = rec."Loan Status"::Application THEN BEGIN
            MNoEditable := TRUE;
            ApplcDateEditable := TRUE;
            LoanStatusEditable := FALSE;
            LProdTypeEditable := TRUE;
            InstallmentEditable := TRUE;
            NetIncome := TRUE;
            Interrest := FALSE;
            AppliedAmountEditable := TRUE;
            ApprovedAmountEditable := FALSE;
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
            ApprovedAmountEditable := FALSE;
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

        if rec."Overdrawn Reconciliation" then RequestedAmountEditable := false else RequestedAmountEditable := true;
    end;

    procedure LoanAppPermisions()
    begin
    end;
}

