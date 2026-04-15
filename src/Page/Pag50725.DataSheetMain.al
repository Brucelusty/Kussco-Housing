page 50725 "Data Sheet Main"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Data Sheet Main";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PF/Staff No";Rec."PF/Staff No")
                {
                }
                field(Name;Rec.Name)
                {
                    Editable = false;
                }
                field("ID NO.";Rec."ID NO.")
                {
                    Editable = false;
                }
                field("Type of Deduction";Rec."Type of Deduction")
                {
                }
                field("Amount ON";Rec."Amount ON")
                {
                }
                field("Amount OFF";Rec."Amount OFF")
                {
                    Visible = false;
                }
                field("New Balance";Rec."New Balance")
                {
                }
                field("REF.";Rec."REF.")
                {
                }
                field("Remark/LoanNO";Rec."Remark/LoanNO")
                {
                }
                field("Sort Code";Rec."Sort Code")
                {
                }
                field(Employer;Rec.Employer)
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field(Date;Rec.Date)
                {
                }
                field("Payroll Month";FORMAT(Rec.Date,0,'<Month Text> <Year4>'))
                {
                }
                field("Interest Amount";Rec."Interest Amount")
                {
                    Visible = false;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                }
                field("Uploaded Interest";Rec."Uploaded Interest")
                {
                    Visible = false;
                }
                field("Batch No.";Rec."Batch No.")
                {
                    Visible = false;
                }
                field("Principal Amount";Rec."Principal Amount")
                {
                    Visible = false;
                }
                field(UploadInt;Rec.UploadInt)
                {
                    Visible = false;
                }
                field(Source;Rec.Source)
                {
                }
                field(Code;Rec.Code)
                {
                    Visible = false;
                }
                field("Shares OFF";Rec."Shares OFF")
                {
                    Visible = false;
                }
                field("Adjustment Type";Rec."Adjustment Type")
                {
                    Visible = false;
                }
                field(Period;Rec.Period)
                {
                    Visible = false;
                }
                field("aMOUNT ON 1";Rec."aMOUNT ON 1")
                {
                    Visible = false;
                }
                field("Vote Code";Rec."Vote Code")
                {
                    Visible = false;
                }
                field(EDCode;Rec.EDCode)
                {
                    Visible = false;
                }
                field("Current Balance";Rec."Current Balance")
                {
                    Visible = false;
                }
                field(TranType;Rec.TranType)
                {
                    Visible = false;
                }
                field(TranName;Rec.TranName)
                {
                    Visible = false;
                }
                field(Action;Rec.Action)
                {
                    Visible = false;
                }
                field("Interest Fee";Rec."Interest Fee")
                {
                    Visible = false;
                }
                field(Recoveries;Rec.Recoveries)
                {
                    Visible = false;
                }
                field("Date Filter";Rec."Date Filter")
                {
                    Visible = false;
                }
                field("Interest Off";Rec."Interest Off")
                {
                    Visible = false;
                }
                field("Repayment Method";Rec."Repayment Method")
                {
                    Visible = false;
                }
                field(SaccoCode;SaccoCode)
                {
                    Visible = false;
                }
                field("Emp Loan Code";Rec."Emp Loan Code")
                {
                    Visible = false;
                }
                field("Advice Option";Rec."Advice Option")
                {
                }
                field(OutstandingBalnace;OutstandingBalnace)
                {
                    Caption = 'Outstanding Balance';
                }
                field(Outstandinginterest;Outstandinginterest)
                {
                    Caption = 'Outstanding Interest';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate DataSHEET")
            {
                Caption = 'Generate Data SHEET';
                Image = process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Gen Data Sheet";

                trigger OnAction()
                begin
 

                end;
            }
            action("Validate Data Sheet")
            {
                Caption = 'Validate Data Sheet';
                Image = "Process";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = Report 51516483;
                Visible = false;
            }
            action("Advise Codes")
            {
                Caption = 'Advise Codes';
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = Page 51516465;
            }
            action(DatasheetRepoot)
            {
                Caption = 'DATASHEET REPORT';
                Image = AnalysisView;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    REPORT.RUN(50014);
                    /*
                    Options := Text000;
                    // Sets the default to option 3
                    Selected := DIALOG.STRMENU(Options, 1, Text002);
                    IF (Selected=1) THEN BEGIN
                            ERROR('Please Choose Employer');
                    END ELSE IF (Selected=2) THEN BEGIN
                                DatasheetMain.RESET;
                                DatasheetMain.SETRANGE(DatasheetMain.Employer,'TELKOM');
                                IF DatasheetMain.FIND('-') THEN BEGIN
                                    REPORT.RUN(51516294,TRUE,FALSE);
                                END;
                        END ELSE IF (Selected=3) THEN BEGIN
                                DatasheetMain.RESET;
                                DatasheetMain.SETRANGE(DatasheetMain.Employer,'POSTAL CORP');
                                IF DatasheetMain.FIND('-') THEN BEGIN
                                    REPORT.RUN(51516315,TRUE,FALSE);
                                END;
                        END ELSE  IF (Selected=4) THEN BEGIN
                        END;
                    */
                end;
            }
            action("Advice Updates")
            {
                Image = "Action";
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                //RunObject = Page 51516090;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OutstandingBalnace:=0;
        Outstandinginterest:=0;
        LoanApp.RESET;
        LoanApp.SETRANGE(LoanApp."Loan  No.",Rec."Remark/LoanNO");
        LoanApp.SETAUTOCALCFIELDS(LoanApp."Outstanding Interest",LoanApp."Outstanding Balance");
        IF LoanApp.FIND('-') THEN BEGIN
          OutstandingBalnace:=LoanApp."Outstanding Balance";
          Outstandinginterest:=LoanApp."Outstanding Interest";
          END;
    end;

    var
        LoanType: Record "Loan Products Setup";
        i: Integer;
        OutstandingBalnace: Decimal;
        Outstandinginterest: Decimal;
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
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
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
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record "User";
        TotalTopupComm: Decimal;
        Notification: Codeunit "Mail";
        CustE: Record Customer;
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
        ApprovalUsers: Record "Approvals Users Set Up";
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
       //BridgedLoans: Record "Special Loan Clearances";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        Vendor: Record Vendor;
        LoanTypes: Record "Loan Products Setup";
        DataSheet: Record "Data Sheet Main";
        IssuedDatetel: Date;
        loansAppz: Record "Loans Register";
        DatasheetMain: Record "Data Sheet Main";
        Text000: Label ',TELKOM,POSTAL CORP,MULTIMEDIA';
        Text001: Label 'You selected option%1.';
        Text002: Label 'Choose one of the following options:';
        Options: Code[50];
        Selected: Integer;
        LoansOffset: Record "Loan Offset Details";
        SaccoCode: Code[10];
        Dia: Dialog;

    local procedure FnGetInt(LoanNumber: Code[50];CustNumber: Code[50]) InterestAmount: Decimal
    var
        LoansReg: Record "Loans Register";
        Installment: Integer;
        NewApprovedAmount: Decimal;
        "Count": Integer;
        Interest: Decimal;
        TotalInterest: Decimal;
    begin
        Count:=0;
        LoansReg.RESET;
        LoansReg.SETRANGE(LoansReg."Loan  No.",LoanNumber);
        //LoansReg.SETRANGE(LoansReg."Client Code",CustNumber);
        IF LoansReg.FIND('-') THEN BEGIN
          Installment:=LoansReg.Installments;
            //REPEAT
            WHILE (Count<Installment) DO BEGIN
              Interest:=(LoansReg."Approved Amount"-(LoansReg."Loan Principle Repayment"*Count))*(LoansReg.Interest/1200);
              TotalInterest:=TotalInterest+ Interest;
            //UNTIL Count=Installment;
            Count:=Count+1;
            END;
              InterestAmount:=ROUND(TotalInterest,1,'>');
        END;
        EXIT(InterestAmount);
    end;

    local procedure GetContributionDeductionAmount(TransactionType: Option;ProductCode: Code[20]): Decimal
    var
       // AdvProduct: Record "51516019";
    begin
       // AdvProduct.RESET;
    end;
}




