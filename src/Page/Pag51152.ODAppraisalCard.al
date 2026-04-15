page 51152 "OD Appraisal Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
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
                field("Loan  No."; rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Account No"; rec."Account No")
                {
                    Caption = 'FOSA Account No';
                    Editable = MNoEditable;
                }
                field("Source"; rec."Source")
                {
                    Caption = 'FOSA Account No';
                    Editable = MNoEditable;
                }
                field("Staff No"; rec."Staff No")
                {
                    Caption = 'Staff No';
                    Editable = false;
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
                    Editable = ApplcDateEditable;

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
                field("Loan Product Type Name"; rec."Loan Product Type Name")
                {
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
                field("Recommended Amount"; rec."Recommended Amount")
                {
                    Editable = false;
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
                field("Loan Principle Repayment"; rec."Loan Principle Repayment")
                {
                }
                field("Loan Interest Repayment"; rec."Loan Interest Repayment")
                {
                }
                field(Repayment; rec.Repayment)
                {
                    Editable = RepaymentEditable;
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
                    Editable = false;
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
                field("Bridge Amount Release"; rec."Bridge Amount Release")
                {
                    Editable = false;
                }
                field("Reason for Loan Re-open"; rec."Reason for Loan Re-open")
                {
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
                    Editable = BasicPayHeditable;
                }
                field("Other Income."; rec."Other Income.")
                {
                }
                field("Total Earnings(Salary)"; rec."Total Earnings(Salary)")
                {
                    Editable = false;
                }
                field("Total Deductions(Salary)"; rec."Total Deductions(Salary)")
                {
                    Editable = Totaldeductsal;
                }
                field("Third basic"; rec."Third basic")
                {
                    Editable = false;
                }
                field("Two Thirds Basic"; rec."Two Thirds Basic")
                {
                    Editable = false;
                }
                field("Net take Home"; rec."Net take Home")
                {
                    Caption = 'Ability';
                    Editable = false;
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
                action("Update Employer Loan Codes")
                {
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        CheckoffMatrix.RESET;
                        CheckoffMatrix.SETRANGE(CheckoffMatrix."Employer Code", rec."Employer Code");
                        CheckoffMatrix.SETRANGE(CheckoffMatrix."Loan Product Code", rec."Loan Product Type");
                        CheckoffMatrix.SETRANGE(CheckoffMatrix."check Interest", FALSE);
                        IF CheckoffMatrix.FIND('-') THEN BEGIN
                            rec."Emp Loan Codes" := CheckoffMatrix."Check off Code";
                            rec.MODIFY;
                        END;
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
                        Register.RESET;
                        Register.SETRANGE(Register."Client Code", rec."Client Code");
                        Register.SETRANGE(Register."Loan Product Type", rec."Loan Product Type");
                        Register.SETFILTER(Register."Outstanding Balance", '>0');
                        IF Register.FIND('-') THEN BEGIN
                            OffsetDetails.RESET;
                            OffsetDetails.SETRANGE(OffsetDetails."Client Code", Register."Client Code");
                            OffsetDetails.SETFILTER(OffsetDetails."Loan Type", Register."Loan Product Type");
                            IF OffsetDetails.FIND('-') = FALSE THEN BEGIN
                                ERROR('Offset the previous %1 to continue', rec."Loan Product Type Name")
                            END;
                        END;

                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.", rec."Loan  No.");
                        IF LoanApp.FIND('-') THEN BEGIN
                            //     //update salary details
                            //     IF LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary THEN BEGIN
                            //         Basic := 0;
                            //         OtherIncome := 0;
                            //         LoanAppraisalSalaryDetails.RESET;
                            //         LoanAppraisalSalaryDetails.SETRANGE(LoanAppraisalSalaryDetails."Loan No", LoanApp."Loan  No.");

                            //         /* IF LoanApp."Recovery Mode"=LoanApp."Recovery Mode"::Salary THEN
                            //          LoanAppraisalSalaryDetails.SETRANGE(LoanAppraisalSalaryDetails."Salary Type",LoanAppraisalSalaryDetails."Salary Type"::Salary);
                            //           IF LoanApp."Recovery Mode"=LoanApp."Recovery Mode"::Pension THEN
                            //          LoanAppraisalSalaryDetails.SETRANGE(LoanAppraisalSalaryDetails."Salary Type",LoanAppraisalSalaryDetails."Salary Type"::Pension);*/

                            //         IF LoanAppraisalSalaryDetails.FINDSET THEN BEGIN
                            //             REPEAT
                            //                 IF LoanAppraisalSalaryDetails.Type = LoanAppraisalSalaryDetails.Type::Basic THEN
                            //                     Basic := Basic + LoanAppraisalSalaryDetails.Amount;
                            //                 Accounts.GET(LoanApp."Account No");
                            //                 IF Accounts."Employer Code" = 'STAFF' THEN BEGIN
                            //                     Basic := Basic * -1;
                            //                 END;

                            //                 IF LoanAppraisalSalaryDetails.Type = LoanAppraisalSalaryDetails.Type::Earnings THEN
                            //                     OtherIncome := OtherIncome + LoanAppraisalSalaryDetails.Amount;
                            //             UNTIL LoanAppraisalSalaryDetails.NEXT = 0;
                            //         END;

                            //         LoanApp.VALIDATE(LoanApp."Basic Pay H", Basic);
                            //         LoanApp.VALIDATE(LoanApp."Other Income.", OtherIncome);
                            //         LoanApp.MODIFY;
                            //         COMMIT;
                            //     END;

                            REPORT.RUN(50056, TRUE, FALSE, LoanApp);
                            //     Message('The Appraisal Report is undergoing some changes, kindly refer to it later.');
                            //     exit;
                        END;

                    end;
                }
                action("Update PAYE")
                {
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin


                        GenSetUp.GET();

                        rec.MODIFY;


                        GrossPay := rec."Basic Pay H" + rec."Other Income.";//"Medical AllowanceH"+"House AllowanceH"+"Transport/Bus Fare";
                        rec."Gross Pay" := GrossPay;
                        rec.MODIFY;

                        rec.CALCFIELDS("Bridge Amount Release");

                        rec."Utilizable Amount" := 0;
                        NetUtilizable := 0;
                        NetRealizable := 0;

                        OTrelief := rec."Other Tax Relief";

                        IF rec.Disabled <> TRUE THEN BEGIN
                            /* Rec.PAYE:=SFactory.FnCalculatePaye("Chargeable Pay");
                           END;*/

                            //CALCULATE PAYE
                            IF TAXABLEPAY.FIND('-') THEN BEGIN
                                REPEAT
                                    IF (GrossPay >= TAXABLEPAY."Lower Limit") AND (GrossPay <= TAXABLEPAY."Upper Limit") THEN BEGIN
                                        Chargeable := ROUND(GrossPay - rec."Pension Scheme" - rec."Other Non-Taxable", 1);
                                        Taxrelief := 1408;

                                        IF TAXABLEPAY."Tax Band" = '01' THEN BEGIN
                                            BAND1 := 12298 * 0.1;
                                            PAYE := ROUND(BAND1 - Taxrelief - OTrelief);
                                        END ELSE
                                            IF TAXABLEPAY."Tax Band" = '02' THEN BEGIN
                                                BAND1 := 12298 * 0.1;
                                                BAND2 := (Chargeable - TAXABLEPAY."Lower Limit") * 0.15;
                                                PAYE := ROUND(BAND1 + BAND2 - Taxrelief - OTrelief);
                                            END ELSE
                                                IF TAXABLEPAY."Tax Band" = '03' THEN BEGIN
                                                    BAND1 := 12298 * 0.1;
                                                    BAND2 := 11587 * 0.15;
                                                    BAND3 := (Chargeable - TAXABLEPAY."Lower Limit") * 0.2;
                                                    PAYE := ROUND(BAND1 + BAND2 + BAND3 - Taxrelief - OTrelief, 1);
                                                END ELSE BEGIN
                                                    IF TAXABLEPAY."Tax Band" = '04' THEN BEGIN
                                                        BAND1 := 12298 * 0.1;
                                                        BAND2 := 11587 * 0.15;
                                                        BAND3 := 11587 * 0.2;
                                                        BAND4 := (Chargeable - TAXABLEPAY."Lower Limit") * 0.25;
                                                        PAYE := ROUND(BAND1 + BAND2 + BAND3 + BAND4 - Taxrelief - OTrelief);
                                                    END ELSE BEGIN
                                                        IF TAXABLEPAY."Tax Band" = '05' THEN BEGIN
                                                            BAND1 := 12298 * 0.1;
                                                            BAND2 := 11587 * 0.15;
                                                            BAND3 := 11587 * 0.2;
                                                            BAND4 := 11587 * 0.25;
                                                            BAND5 := (Chargeable - TAXABLEPAY."Lower Limit") * 0.3;
                                                            PAYE := ROUND(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - Taxrelief - OTrelief);

                                                            IF (rec."Recovery Mode" = rec."Recovery Mode"::Checkoff) OR (rec."Recovery Mode" = rec."Recovery Mode"::Salary) THEN BEGIN
                                                                PAYE := PAYE
                                                            END ELSE
                                                                PAYE := PAYE;
                                                            IF rec."Exempted from PAYE" = TRUE THEN
                                                                PAYE := 0;
                                                            rec.MODIFY;
                                                            //MESSAGE('PAYE is %1',PAYE)
                                                            // PAYE:=0;


                                                        END;
                                                    END;
                                                END;

                                        xRec.PAYE := PAYE;

                                    END;
                                UNTIL TAXABLEPAY.NEXT = 0;
                            END;
                        END;
                        //END;
                        //nssfCalculation
                        prNSSF.RESET;
                        prNSSF.SETRANGE(prNSSF."Tier Code");
                        IF prNSSF.FIND('-') THEN BEGIN
                            REPEAT
                                IF ((GrossPay >= prNSSF."Lower Limit") AND (GrossPay <= prNSSF."Upper Limit")) THEN
                                    CalcNSSF := prNSSF."Tier 1 Employee Deduction" + prNSSF."Tier 2 Employee Deduction";
                            // MESSAGE('CalcNSSF %1',CalcNSSF);
                            UNTIL prNSSF.NEXT = 0;
                        END;

                        rec.NSSF := 200;//CalcNSSF;
                        rec.MODIFY;
                        //end of nssf calculation
                        //calcNHIF


                        prNHIF.RESET;
                        prNHIF.SETCURRENTKEY(prNHIF."Tier Code");
                        IF prNHIF.FINDFIRST THEN BEGIN
                            REPEAT
                                IF ((GrossPay >= prNHIF."NHIF Tier") AND (GrossPay <= prNHIF.Amount)) THEN
                                    CalcNHIF := prNHIF."Lower Limit";
                            UNTIL prNHIF.NEXT = 0;
                        END;

                        rec.NHIF := CalcNHIF;
                        rec.MODIFY;
                        //End Calc NHIF

                        //insert Member Contribution Range
                        TotalLoanOutstanding := 0;

                        LoansR.RESET;
                        LoansR.SETRANGE(LoansR."Loan  No.", rec."Loan  No.");
                        IF LoansR.FIND('-') THEN BEGIN
                            TotalLoanOutstanding := LoansR."Total Outstanding Loan BAL";

                        END;


                        ContribTier.RESET;
                        ContribTier.SETCURRENTKEY(ContribTier."Line No");
                        IF ContribTier.FIND('-') THEN BEGIN
                            REPEAT
                                IF ((TotalLoanOutstanding >= ContribTier."Lower Limit") AND (TotalLoanOutstanding <= ContribTier."Upper Limit")) THEN
                                    CalcContrib := ContribTier."Contribution Amount";
                            //MESSAGE('CalcContrib %1',CalcContrib);
                            //MESSAGE('TotalLoanOutstanding %1',TotalLoanOutstanding);
                            UNTIL ContribTier.NEXT = 0;
                        END;
                        rec."Monthly Contribution" := CalcContrib;//CalcNSSF;
                        rec.MODIFY;
                        //insert Member Contribution Range_End

                        //+Nettakehome
                        rec."Utilizable Amount" := (GrossPay +/*"Other Incomes Amount")-("Monthly Contribution"+NSSF+NHIF+PAYE+"Staff Union Contribution"*/+rec."Medical Insurance"
                        + rec."Life Insurance" + rec."Other Liabilities" + rec."Other Loans Repayments" + rec."Sacco Deductions" + rec."Bridge Amount Release");


                        TotalDeductions := rec."Monthly Contribution" + rec.NSSF + rec.NHIF + PAYE +/*"Staff Union Contribution"*/+rec."Medical Insurance"
                        + rec."Life Insurance" + rec."Other Liabilities"/*+Nettakehome*/+ rec."Other Loans Repayments" + rec."Sacco Deductions";
                        //MESSAGE('%1,%2',NSSF,NHIF);




                        //Nettakehome:={"Gross Pay"}{+("Other Incomes Amount")}-{"Total DeductionsH"}("Total Deductions(Salary)"+"Bridge Amount Release");
                        Nettakehome := rec."Two Thirds Basic" - (rec."Total Deductions(Salary)");
                        NetUtilizable := rec."Utilizable Amount" + rec."Bridge Amount Release" - (1 / 3 * rec."Gross Pay");
                        rec."Utilizable Amount" := rec."Utilizable Amount";
                        rec."Net Utilizable Amount" := NetUtilizable;
                        rec."Total DeductionsH" := TotalDeductions;
                        rec."Net take Home" := Nettakehome;
                        rec."Net Income" := GrossPay;
                        rec.MODIFY;


                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.", rec."Client Code");
                        IF Cust.FIND('-') THEN BEGIN
                            IF rec."Monthly Contribution" = 0 THEN BEGIN
                                rec."Monthly Contribution" := Cust."Monthly Contribution";
                                rec.MODIFY;
                            END;
                        END;
                        IF LoansR."Recovery Mode" = LoansR."Recovery Mode"::Checkoff THEN BEGIN
                            rec."Utilizable Amount" := rec."Net take Home";
                            rec."Net Utilizable Amount" := rec."Net take Home";
                            NetUtilizable := rec."Net take Home";
                            rec."Net take Home" := Nettakehome;
                            rec."Gross Pay" := GrossPay;
                            rec.MODIFY;
                        END;
                        // Added to cate for people having salay throuh fosa
                        IF rec."Recovery Mode" = rec."Recovery Mode"::Salary THEN BEGIN
                            Basic := 0;
                            OtherIncome := 0;
                            LoanAppraisalSalaryDetails.RESET;
                            LoanAppraisalSalaryDetails.SETRANGE(LoanAppraisalSalaryDetails."Loan No", rec."Loan  No.");
                            IF LoanAppraisalSalaryDetails.FINDSET THEN BEGIN
                                REPEAT
                                    IF LoanAppraisalSalaryDetails.Type = LoanAppraisalSalaryDetails.Type::Basic THEN
                                        Basic := Basic + LoanAppraisalSalaryDetails.Amount;
                                    Basic := Basic * -1;
                                    IF LoanAppraisalSalaryDetails.Type = LoanAppraisalSalaryDetails.Type::Earnings THEN
                                        OtherIncome := OtherIncome + LoanAppraisalSalaryDetails.Amount;
                                UNTIL LoanAppraisalSalaryDetails.NEXT = 0;
                            END;

                            // clear deductions
                            rec."Monthly Contribution" := 0;
                            rec.NHIF := 0;
                            rec.NSSF := 0;
                            PAYE := 0;
                            rec."Medical Insurance" := 0;
                            rec."Life Insurance" := 0;
                            rec."Other Liabilities" := 0;
                            rec."Sacco Deductions" := 0;
                            rec."Cleared Effects" := 0;
                            rec."Bridge Amount Release" := 0;
                            rec."Total Deductions(Salary)" := 0;
                            //end of clear

                            rec.VALIDATE("Basic Pay H", Basic);
                            rec.VALIDATE("Other Income.", OtherIncome);
                            GrossPay := Basic + OtherIncome;

                            //load total deductions
                            LoansRegister6.RESET;
                            LoansRegister6.SETRANGE(LoansRegister6."Client Code", rec."Client Code");
                            LoansRegister6.SETRANGE(LoansRegister6."Recovery Mode", LoansRegister6."Recovery Mode"::Salary);
                            IF LoansRegister6.FIND('-') THEN BEGIN
                                REPEAT
                                    LoansRegister6.CALCFIELDS("Outstanding Balance");
                                    IF LoansRegister6."Outstanding Balance" > 0 THEN BEGIN
                                        ScheduleRep6.RESET;
                                        ScheduleRep6.SETRANGE(ScheduleRep6."Loan No.", LoansRegister6."Loan  No.");
                                        IF ScheduleRep6.FINDFIRST THEN BEGIN
                                            rec."Total Deductions(Salary)" := rec."Total Deductions(Salary)" + ScheduleRep6."Monthly Repayment"
                                        END ELSE BEGIN
                                            rec."Total Deductions(Salary)" := rec."Total Deductions(Salary)" + LoansRegister6.Repayment;
                                        END;
                                    END;
                                UNTIL LoansRegister6.NEXT = 0;
                            END;
                            // end of load
                            STO.RESET;
                            STO.SETRANGE(STO."BOSA Account No.", rec."Client Code");
                            STO.SETRANGE(STO.Status, STO.Status::Approved);
                            IF STO.FINDFIRST THEN BEGIN
                                REPEAT
                                    rec."Total Deductions(Salary)" := STO.Amount + rec."Total Deductions(Salary)";
                                UNTIL STO.NEXT = 0;
                            END;
                            //MESSAGE('tOTALsAL%1',"Total Deductions(Salary)");

                            //MESSAGE('TotalDed%1',"Total Deductions(Salary)");
                            //end of load
                            SaccoGeneralSetUp.GET();
                            ProcessingFee := 0;
                            Charges.RESET;
                            Charges.SETRANGE(Charges.Code, 'SAL');
                            IF Charges.FINDFIRST THEN
                                ProcessingFee := Charges."Charge Amount" + ((SaccoGeneralSetUp."Excise Duty(%)" / 100) * Charges."Charge Amount");
                            rec.VALIDATE("Total Deductions(Salary)", rec."Total Deductions(Salary)" + ProcessingFee);
                            TotalDeductions := rec."Total Deductions(Salary)";

                            //get offset
                            Itemsoffset := 0;
                            LoanOffsetDetails.RESET;
                            LoanOffsetDetails.SETRANGE(LoanOffsetDetails."Loan No.", rec."Loan  No.");
                            IF LoanOffsetDetails.FINDSET THEN BEGIN
                                REPEAT
                                    rec."Net take Home" := rec."Net take Home" + LoanOffsetDetails."Monthly Repayment";
                                UNTIL LoanOffsetDetails.NEXT = 0;
                            END;
                            //end of get
                            /*IF LoansR."Recovery Mode"= LoansR."Recovery Mode"::Checkoff THEN BEGIN
                            "Utilizable Amount":="Net take Home";
                            "Net Utilizable Amount":="Net take Home";
                            NetUtilizable:="Net take Home";
                            "Gross Pay":=GrossPay;
                            MODIFY;
                            END ELSE*/

                            rec."Utilizable Amount" := rec."Net take Home";
                            rec."Net Utilizable Amount" := rec."Net take Home";
                            rec."Net take Home" := Nettakehome;
                            rec."Gross Pay" := GrossPay;
                            rec.MODIFY;
                        END;
                        // END ELSE
                        // "Utilizable Amount":="Gross Pay"-(TotalDeductions+Nettakehome);
                        // //MESSAGE('Utilizable Amount=Gross Pay-TotalDeducti+ns',"Utilizable Amount","Gross Pay",TotalDeductions);
                        // NetUtilizable:=("Utilizable Amount"+"Bridge Amount Release");
                        // "Net Utilizable Amount":=NetUtilizable;
                        // "Total DeductionsH":=TotalDeductions;
                        // //"Net take Home":=Nettakehome;
                        // // "Utilizable Amount":="Net take Home";
                        // // "Net Utilizable Amount":="Net take Home";
                        // // NetUtilizable:="Net take Home";
                        // "Gross Pay":=GrossPay;
                        //MODIFY;
                        //END of add

                    end;
                }
                separator(Sep07)
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
                        LoanProductSetup: Record "Loan Products Setup";
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
                separator(Sep02)
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
                separator(Sep03)
                {
                }
                separator(Sep04)
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
                separator(Sep05)
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
                    Visible = true;

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

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
                        /// ApprovalMgt: Codeunit "Approvals Mgmt.";
                        Workflowintegration: Codeunit WorkflowIntegration;

                        ApprovalEntry: Record "Approval Entry";
                        Table_id: Integer;
                        Doc_No: Code[20];
                    begin

                        if rec."Approved Amount" = 0 then Error('Kindly upraise your loan application before sending approval request');

                        rec.TestField(rec."Loan Product Type");
                        rec.TestField(rec."Recovery Mode");
                        rec.TestField(rec."Sector Specific");
                        rec.TestField(rec."Account No");



                        LoanGuar.Reset;
                        LoanGuar.SetRange("Loan No", Rec."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            if LoanType.Get(rec."Loan Product Type") then begin
                                if LoanGuar.Count < LoanType."Min No. Of Guarantors" then
                                    Error('You must capture atleast ' + Format(LoanType."Min No. Of Guarantors") + ' for ' + rec."Loan Product Type");
                            end;
                        end;

                        //Message('Approval%1',rec."Approval Status");
                        if rec."Approval Status" <> rec."approval status"::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::LoanApplication;
                        Table_id := Database::"Loans Register";
                        rec.TestField("Requested Amount");
                        if Workflowintegration.CheckLoanAppliedApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnSendLoanAppliedForApproval(Rec);
                        CurrPage.Close;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

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
                        SMSMessages."Account No" := rec."Account No";
                        SMSMessages."Date Entered" := TODAY;
                        SMSMessages."Time Entered" := TIME;
                        SMSMessages.Source := 'LOAN APPL';
                        SMSMessages."Entered By" := USERID;
                        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                        SMSMessages."SMS Message" := 'Dear ' + rec."Client Name" + ', your ' + rec."Loan Product Type Name" + ' application of KSHs.' + FORMAT(rec."Requested Amount") +
                                                  ' has been rejected due to: ' + rec."Reason for rejection" + ' TELEPOST SACCO';
                        Cust.RESET;
                        IF Cust.GET(rec."Client Code") THEN
                            SMSMessages."Telephone No" := Cust."Phone No.";
                        SMSMessages.INSERT;

                    end;
                }
                action(Reopen)
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF rec."Reason for Loan Re-open" = '' THEN
                            ERROR('You must give a reason fo loan Reopen');
                        rec."Loan Status" := rec."Loan Status"::Application;
                        rec."Approval Status" := rec."Approval Status"::Open;
                        rec."Captured By" := '';
                        rec.MODIFY;

                        /*IF ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnCancelLoanAppApprovalRequest(Rec);
                        */

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
        RSchedule: Record //"51516356"
        "Loan Repayment Schedule";
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
        OffsetDetails: Record "Loan Offset Details";
        LRegister: Record "Loans Register";
        CheckoffMatrix: Record "Checkoff Distributed Matrix";
        Basic: Decimal;
        OtherIncome: Decimal;
        LoanAppraisalSalaryDetails: Record "Loan Appraisal Salary Details";
        AuditTrail: Codeunit "AU Audit Management";
        Trail: Record //"51516655"
        "Audit Trail";
        EntryNo: Integer;
        GrossPay: Decimal;
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        NetRealizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        TAXABLEPAY: Record //"51516483"
        "PAYE Brackets Credit";
        PAYE: Decimal;
        PAYESUM: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        Taxrelief: Decimal;
        OTrelief: Decimal;
        Chargeable: Decimal;
        PartPay: Record //"51516494"
        "Loan Partial Disburesments";
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        prNSSF: Record //"51516215"
        "Payroll NSSF Setup.";
        CalcNSSF: Decimal;
        prNHIF: Record //"51516214"
        "Payroll NHIF Setup.";
        CalcNHIF: Decimal;
        ContribTier: Record "Deposit Contribution Tiers";
        CalcContrib: Decimal;
        TotalLoanOutstanding: Decimal;
        ObjLoasToOffset: Record "Loan Offset Details";
        LoansRegister6: Record "Loans Register";
        Charges: Record Charges;
        ProcessingFee: Decimal;
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
        LoanOffsetDetails: Record "Loan Offset Details";
        Itemsoffset: Decimal;
        ScheduleRep6: Record "Loan Repayment Schedule";
        BasicPayHeditable: Boolean;
        otherincomee: Boolean;
        Totaldeductsal: Boolean;
        Accounts: Record 23;
        STO: Record //"51516307"
        "Standing Orders";

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
            IF rec."Recovery Mode" = rec."Recovery Mode"::Salary THEN
                BasicPayHeditable := FALSE;
            IF rec."Recovery Mode" = rec."Recovery Mode"::Salary THEN
                otherincomee := FALSE;
            IF rec."Recovery Mode" = rec."Recovery Mode"::Salary THEN
                Totaldeductsal := FALSE;
            IF rec."Recovery Mode" = rec."Recovery Mode"::Checkoff THEN
                BasicPayHeditable := TRUE;
            IF rec."Recovery Mode" = rec."Recovery Mode"::Checkoff THEN
                otherincomee := TRUE;
            IF rec."Recovery Mode" = rec."Recovery Mode"::Checkoff THEN
                Totaldeductsal := TRUE;
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




