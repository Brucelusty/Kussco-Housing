codeunit 50102 "Generate Schedule"
{

    trigger OnRun()
    var
        "code": Code[10];
        Mkopo: Record "Loans Register";
    begin
        /*code:='LN008091';
        //Autogenerateschedule(cd);
        Mkopo.GET(code);
        MESSAGE(FORMAT(Mkopo.GetRepaymentStartDate));
        MESSAGE('Done');
        MESSAGE(FORMAT(CALCDATE('1D',CALCDATE('-CM',TODAY))));*/

    end;

    var
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
        CustomerRecord: Record "Members Register";
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit 12;
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record 232;
        LineNo: Integer;
        GnljnlineCopy: Record 81;
        NewLNApplicNo: Code[10];
        Cust: Record "Members Register";
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record "Members Register";
        CustPostingGroup: Record 92;
        GenSetUp:Record 311;
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
        CustE: Record "Members Register";
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "Members Register";
        InstallNo2: Integer;
        currency: Record 330;
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loans Disbursement Buffer";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
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
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record 454;
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record 454;
        Overdue: Option Yes," ";
        LoansRegister: Record "Loans Register";
        LN: Code[10];
        RScheduleB: Record "Loan Repayment Schedule";
        RDate: Date;

    procedure Autogenerateschedule(var LOANNO: Code[100])
    var
        LoanProductsSetup: Record "Loan Products Setup";
        Mkopo: Record "Loans Register";
    begin
        IF LoansRegister.GET(LOANNO) THEN BEGIN
            WITH LoansRegister DO BEGIN
                IF LoansRegister.Interest = 0 THEN EXIT;

                IF "Repayment Frequency" = "Repayment Frequency"::Daily THEN
                    EVALUATE(InPeriod, '1D')
                ELSE IF "Repayment Frequency" = "Repayment Frequency"::Weekly THEN
                    EVALUATE(InPeriod, '1W')
                ELSE IF "Repayment Frequency" = "Repayment Frequency"::Monthly THEN
                    EVALUATE(InPeriod, '1M')
                ELSE IF "Repayment Frequency" = "Repayment Frequency"::Quaterly THEN
                    EVALUATE(InPeriod, '1Q');
                //MESSAGE(FORMAT("Repayment Start Date"));
                LoanProductsSetup.GET("Loan Product Type");
                RSchedule.RESET;
                RSchedule.SETRANGE(RSchedule."Loan No.", LOANNO);
                IF RSchedule.FINDSET THEN BEGIN
                    RSchedule.DELETEALL;
                END;
                Mkopo.GET(LOANNO);
                IF Mkopo."Issued Date" <> 0D THEN
                    IF Mkopo."Issued Date" <> Mkopo."Loan Disbursement Date" THEN BEGIN
                        Mkopo."Loan Disbursement Date" := Mkopo."Issued Date";
                        Mkopo."Repayment Start Date" := CALCDATE('CM', Mkopo."Issued Date");
                        IF (Mkopo."Loan Product Type" = 'A01') OR (Mkopo."Loan Product Type" = 'A03') THEN
                            Mkopo."Repayment Start Date" := Mkopo."Loan Disbursement Date";
                        Mkopo.MODIFY;
                    END;
                // MESSAGE(FORMAT("Repayment Start Date"));
                QCounter := 0;
                QCounter := 3;
                //EVALUATE(InPeriod,'1D');
                GrPrinciple := "Grace Period - Principle (M)";
                GrInterest := "Grace Period - Interest (M)";
                InitialGraceInt := "Grace Period - Interest (M)";

                LoansR.RESET;
                LoansR.SETRANGE(LoansR."Loan  No.", "Loan  No.");
                IF LoansR.FIND('-') THEN BEGIN
                    RDate := LoansR."Repayment Start Date";
                    TESTFIELD("Loan Disbursement Date");
                    IF (LoansR."Loan Product Type" = 'A03') OR (LoansR."Loan Product Type" = 'A01') THEN BEGIN
                        LoansR."Repayment Start Date" := LoansR."Loan Disbursement Date";
                        LoansR."Expected Date of Completion" := CALCDATE(FORMAT(Installments) + 'M', "Loan Disbursement Date");

                    END ELSE BEGIN
                        // IF "Repayment Start Date"<>GetRepaymentStartDate THEN BEGIN
                        //   "Repayment Start Date":=GetRepaymentStartDate;
                        //   LoansR."Repayment Start Date":=GetRepaymentStartDate;
                        //   IF Installments>0 THEN
                        //     LoansR."Expected Date of Completion":=CALCDATE(FORMAT(Installments)+'M',"Repayment Start Date");
                        // END;
                    END;
                    //MESSAGE(FORMAT("Repayment Start Date"));
                    //LoansR.MODIFY;
                    /* IF "Repayment Start Date"=0D THEN BEGIN
                        "Repayment Start Date":=CALCDATE('1M',"Loan Disbursement Date");

                         IF DATE2DMY("Loan Disbursement Date",1) <=15 THEN
                            "Repayment Start Date":=CALCDATE('CM',"Loan Disbursement Date")
                           ELSE
                             "Repayment Start Date":=CALCDATE('1M+CM',"Loan Disbursement Date");
                       END;*/
                    TESTFIELD("Repayment Start Date");

                    RSchedule.RESET;
                    RSchedule.SETRANGE(RSchedule."Loan No.", "Loan  No.");
                    //     RSchedule.DELETEALL;


                    LoanAmount := LoansR."Approved Amount";
                    InterestRate := LoansR.Interest;

                    RepayPeriod := LoansR.Installments;
                    InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
                    LBalance := LoansR."Approved Amount";

                    RunDate := "Repayment Start Date";//"Loan Disbursement Date";
                                                      // MESSAGE(FORMAT(RunDate));
                    IF ("Loan Product Type" = 'A03') OR ("Loan Product Type" = 'A01') THEN
                        RunDate := "Loan Disbursement Date";
                    //MESSAGE(FORMAT(RunDate));
                    //RunDate:=CALCDATE('-1W',RunDate);
                    InstalNo := 0;
                    //EVALUATE(RepayInterval,'1W');
                    //EVALUATE(RepayInterval,InPeriod);

                    //Repayment Frequency
                    //     IF "Repayment Frequency"="Repayment Frequency"::Daily THEN
                    //     RunDate:=CALCDATE('-1D',RunDate)
                    //     ELSE IF "Repayment Frequency"="Repayment Frequency"::Weekly THEN
                    //     RunDate:=CALCDATE('-1W',RunDate)
                    //     ELSE IF "Repayment Frequency"="Repayment Frequency"::Monthly THEN
                    //     RunDate:=CALCDATE('-1M',RunDate)
                    //     ELSE IF "Repayment Frequency"="Repayment Frequency"::Quaterly THEN
                    //     RunDate:=CALCDATE('-1Q',RunDate);
                    //Repayment Frequency
                    //MESSAGE(FORMAT(RunDate));
                    // MESSAGE('Start%1',RunDate);
                    REPEAT
                        InstalNo := InstalNo + 1;
                        //RunDate:=CALCDATE("Instalment Period",RunDate);
                        //RunDate:=CALCDATE('1W',RunDate);


                        //Repayment Frequency
                        IF InstalNo > 1 THEN BEGIN
                            IF "Repayment Frequency" = "Repayment Frequency"::Daily THEN
                                RunDate := CALCDATE('1D', RunDate)
                            ELSE IF "Repayment Frequency" = "Repayment Frequency"::Weekly THEN
                                RunDate := CALCDATE('1W', RunDate)
                            ELSE IF "Repayment Frequency" = "Repayment Frequency"::Monthly THEN
                                RunDate := CALCDATE('1M', RunDate)
                            ELSE IF "Repayment Frequency" = "Repayment Frequency"::Quaterly THEN
                                RunDate := CALCDATE('1Q', RunDate);
                        END ELSE BEGIN
                            IF InstalNo = 1 THEN
                                RunDate := RDate;
                            //MESSAGE('Ins%1Run%2Repay%3',InstalNo,RunDate,LoansR."Repayment Start Date");
                        END;
                        //Repayment Frequency

                        IF (Interest = 0) AND (LoanProductsSetup."Interest rate" > 0) THEN BEGIN
                            LoanProductsSetup.GET("Loan Product Type");
                            Interest := LoanProductsSetup."Interest rate";
                            MODIFY;
                            //COMMIT;
                        END;
                        IF (Installments = 0) AND (LoanProductsSetup."No of Installment" > 0) THEN BEGIN
                            LoanProductsSetup.GET("Loan Product Type");
                            Interest := LoanProductsSetup."No of Installment";
                            MODIFY;
                            //COMMIT;
                        END;

                        IF LoanProductsSetup."Interest rate" > 0 THEN
                            TESTFIELD(Interest);
                        IF LoanProductsSetup."No of Installment" > 0 THEN
                            TESTFIELD(Installments);

                        IF "Repayment Method" = "Repayment Method"::Amortised THEN BEGIN
                            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - POWER((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                            LPrincipal := TotalMRepay - LInterest;
                        END;

                        IF "Repayment Method" = "Repayment Method"::"Straight Line" THEN BEGIN
                            LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                            LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.05, '>');
                            //Grace Period Interest
                            LInterest := ROUND((LInterest * InitialInstal) / (InitialInstal - InitialGraceInt), 0.05, '>');
                        END;

                        IF "Repayment Method" = "Repayment Method"::"Reducing Balance" THEN BEGIN
                            LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                            LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                        END;

                        IF "Repayment Method" = "Repayment Method"::Constants THEN BEGIN
                            TESTFIELD(Repayment);
                            IF LBalance < Repayment THEN
                                LPrincipal := LBalance
                            ELSE
                                LPrincipal := Repayment;
                            LInterest := Interest;
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


                        IF LoanProductsSetup.Code = 'A16' THEN
                            LInterest := 0;
                        IF LoanProductsSetup.Code <> 'A16' THEN BEGIN
                            RSchedule.INIT;
                            RSchedule."Repayment Code" := RepayCode;
                            RSchedule."Loan No." := "Loan  No.";
                            RSchedule."Loan Amount" := LoanAmount;
                            RSchedule."Loan Balance" := LBalance;//..
                            RSchedule."Instalment No" := InstalNo;
                            RSchedule."Repayment Date" := RunDate;
                            RSchedule."Member No." := "Client Code";
                            RSchedule."Loan Category" := "Loan Product Type";
                            RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                            RSchedule."Monthly Interest" := LInterest;
                            RSchedule."Principal Repayment" := LPrincipal;
                            RSchedule.INSERT;
                            //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                            WhichDay := DATE2DWY(RSchedule."Repayment Date", 1);
                            //MESSAGE('which day is %1',WhichDay);
                            //BEEP(2,10000);
                        END ELSE IF LoanProductsSetup.Code = 'A16' THEN BEGIN
                            RSchedule.INIT;
                            RSchedule."Repayment Code" := RepayCode;
                            RSchedule."Loan No." := "Loan  No.";
                            RSchedule."Loan Amount" := LoanAmount;
                            RSchedule."Loan Balance" := LBalance;
                            RSchedule."Repayment Date" := RunDate;
                            RSchedule."Member No." := "Client Code";
                            RSchedule."Loan Category" := "Loan Product Type";
                            RSchedule."Principal Repayment" := LPrincipal;
                            RSchedule."Monthly Interest" := 0;
                            RSchedule.INSERT;
                            WhichDay := DATE2DWY(RSchedule."Repayment Date", 1);
                        END;
                    UNTIL LBalance < 1

                END;

                //COMMIT;
            END;
        END;

    end;

    procedure AutogeneratescheduleBuffer(var LOANNO: Code[100])
    var
        LoanProductsSetup: Record "Loan Products Setup";
        Mkopo: Record "Loans Register";
    begin
        IF LoansRegister.GET(LOANNO) THEN BEGIN
            IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Daily THEN
                EVALUATE(InPeriod, '1D')
            ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Weekly THEN
                EVALUATE(InPeriod, '1W')
            ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Monthly THEN
                EVALUATE(InPeriod, '1M')
            ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Quaterly THEN
                EVALUATE(InPeriod, '1Q');


            QCounter := 0;
            QCounter := 3;
            //EVALUATE(InPeriod,'1D');
            GrPrinciple := LoansRegister."Grace Period - Principle (M)";
            GrInterest := LoansRegister."Grace Period - Interest (M)";
            InitialGraceInt := LoansRegister."Grace Period - Interest (M)";

            LoansR.RESET;
            LoansR.SETRANGE(LoansR."Loan  No.", LoansRegister."Loan  No.");
            IF LoansR.FIND('-') THEN BEGIN

                //TESTFIELD("Loan Disbursement Date");
                //TESTFIELD("Repayment Start Date");

                RScheduleB.RESET;
                RScheduleB.SETRANGE(RScheduleB."Loan No.", LoansRegister."Loan  No.");
                RScheduleB.DELETEALL;

                LoanAmount := LoansR."Approved Amount";
                InterestRate := LoansR.Interest;
                RepayPeriod := LoansR.Installments;
                InitialInstal := LoansR.Installments + LoansRegister."Grace Period - Principle (M)";
                LBalance := LoansR."Approved Amount";
                RunDate := TODAY;//"Loan Disbursement Date";
                                 //RunDate:=CALCDATE('-1W',RunDate);
                InstalNo := 0;
                //EVALUATE(RepayInterval,'1W');
                //EVALUATE(RepayInterval,InPeriod);

                //Repayment Frequency
                IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Daily THEN
                    RunDate := CALCDATE('-1D', RunDate)
                ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Weekly THEN
                    RunDate := CALCDATE('-1W', RunDate)
                ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Monthly THEN
                    RunDate := CALCDATE('-1M', RunDate)
                ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Quaterly THEN
                    RunDate := CALCDATE('-1Q', RunDate);
                //Repayment Frequency


                REPEAT
                    InstalNo := InstalNo + 1;
                    //RunDate:=CALCDATE("Instalment Period",RunDate);
                    //RunDate:=CALCDATE('1W',RunDate);


                    //Repayment Frequency
                    IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Daily THEN
                        RunDate := CALCDATE('1D', RunDate)
                    ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Weekly THEN
                        RunDate := CALCDATE('1W', RunDate)
                    ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Monthly THEN
                        RunDate := CALCDATE('1M', RunDate)
                    ELSE IF LoansRegister."Repayment Frequency" = LoansRegister."Repayment Frequency"::Quaterly THEN
                        RunDate := CALCDATE('1Q', RunDate);
                    //Repayment Frequency

                    //kma
                    //IF "Repayment Method"="Repayment Method"::Amortised THEN BEGIN
                    LoansRegister.TESTFIELD(LoansRegister.Interest);
                    LoansRegister.TESTFIELD(LoansRegister.Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - POWER((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                    LPrincipal := TotalMRepay - LInterest;
                    //END;

                    /*IF "Repayment Method"="Repayment Method"::"Straight Line" THEN BEGIN
                    TESTFIELD(Interest);
                    TESTFIELD(Installments);
                    LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                    LInterest:=ROUND((InterestRate/12/100)*LoanAmount,0.05,'>');
                    //Grace Period Interest
                    LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                    END;

                    IF "Repayment Method"="Repayment Method"::"Reducing Balance" THEN BEGIN
                    TESTFIELD(Interest);
                    TESTFIELD(Installments);
                    LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                    LInterest:=ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                    END;

                    IF "Repayment Method"="Repayment Method"::Constants THEN BEGIN
                    TESTFIELD(Repayment);
                    IF LBalance < Repayment THEN
                    LPrincipal:=LBalance
                    ELSE
                    LPrincipal:=Repayment;
                    LInterest:=Interest;
                    END;
                    //kma
                    */


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
                    RScheduleB.INIT;
                    RScheduleB."Repayment Code" := RepayCode;
                    RScheduleB."Loan No." := LoansRegister."Loan  No.";
                    RScheduleB."Loan Amount" := LoanAmount;
                    RScheduleB."Instalment No" := InstalNo;
                    RScheduleB."Repayment Date" := RunDate;
                    RScheduleB."Member No." := LoansRegister."Client Code";
                    RScheduleB."Loan Category" := LoansRegister."Loan Product Type";
                    RScheduleB."Monthly Repayment" := LInterest + LPrincipal;
                    RScheduleB."Monthly Interest" := LInterest;
                    RScheduleB."Principal Repayment" := LPrincipal;
                    RScheduleB.INSERT;
                    //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                    WhichDay := DATE2DWY(RScheduleB."Repayment Date", 1);
                //MESSAGE('which day is %1',WhichDay);
                //BEEP(2,10000);
                UNTIL LBalance < 1

            END;
        END;

    end;
}

