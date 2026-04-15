report 50646 "Gen Data Sheet"
{
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Start Date";StartDate)
                    {
                    ApplicationArea = All;
                    }
                    field("End Date";EndDate)
                    {
                    ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Data Sheet Generated Successfully');
    end;

    trigger OnPreReport()
    var
        Reg: Boolean;
        Dep: Boolean;
        Ess: Boolean;
        IssuedLoan: Boolean;
        ThisMemb: Record Customer;
        LoanIsCompleted: Boolean;
        OffSet: Record "Loan Offset Details";
       //CheckoffAdvUpdate: Record "Checkoff Advise Updates";
        Mkopo: Record "Loans Register";
        LoansR: Record "Loans Register";
        DataSht: Record "Data Sheet Main";
    begin
        SaccoCode:='1872';
        
        SaccoGeneralSetUp.GET;
        SaccoGeneralSetUp.TESTFIELD(SaccoGeneralSetUp."Registration Fee");
        IF (StartDate=0D) OR (EndDate = 0D) THEN
          ERROR('Start Date or End Date, must have a value!!');
        
          Dia.OPEN('Generating Datasheet \'+
          'Now :#1########################\'+
          '##################');
        
          DataSheet.RESET;
          DataSheet.SETRANGE(Date,StartDate,EndDate);
          IF DataSheet.FIND('-') THEN BEGIN
             Dia.UPDATE(1,'Deleting Old Records');
             DataSheet.DELETEALL;
          END;
        IF DataSht.FINDLAST THEN BEGIN
        EntryNo:=EntryNo+DataSht."Entry No";
        END ELSE BEGIN
        EntryNo:=0;
          END;
        //Insert Shares
        Cust.RESET;
        Cust.SETFILTER(Cust.Status,'%1|%2',Cust.Status::Active,Cust.Status::Dormant);
        Cust.SETAUTOCALCFIELDS(Cust."Current Shares",Cust."Registration Fee Paid",Cust."School Fees Shares");
        IF Cust.FIND('-') THEN BEGIN
          REPEAT
            EntryNo:=EntryNo+1;
                  Reg := ((Cust."Registration Date">=StartDate) AND (Cust."Registration Date"<=EndDate));
                  Dep := ((Cust."Variation Date Deposits">=StartDate) AND (Cust."Variation Date Deposits"<=EndDate));
                  Ess := ((Cust."Variation Date ESS">=StartDate) AND (Cust."Variation Date ESS"<=EndDate));
        
                  IF  Reg OR Dep THEN BEGIN
        
                          Dia.UPDATE(1,'Updating Monthly Contribution for '+Cust.Name);
                          DataSheet.INIT;
                          DataSheet."PF/Staff No":=Cust."Payroll No";
                          DataSheet.Name:=Cust.Name;
                          IF Cust."Monthly Contribution" = 0 THEN BEGIN
                             Cust."Monthly Contribution":=SaccoGeneralSetUp."Min. Contribution";
                             SaccoGeneralSetUp.TESTFIELD(SaccoGeneralSetUp."Min. Contribution");
                            END;
                          DataSheet."Amount ON":=Cust."Monthly Contribution";
                          DataSheet."Approved Amount":=Cust."Monthly Contribution";
                          IF (Cust."Registration Date">DMY2DATE(21,10,2016)) AND (Cust."Registration Fee Paid"=0) AND Reg THEN BEGIN
                            DataSheet."Amount ON":=DataSheet."Amount ON"+SaccoGeneralSetUp."Registration Fee";
                            DataSheet."Approved Amount":=DataSheet."Amount ON";
                            END;
                          DataSheet.Employer:=Cust."Employer Code";
                          DataSheet.Date:=Cust."Variation Date Deposits";
                          DataSheet."Transaction Type":=DataSheet."Transaction Type"::VARIATION;
                          IF DataSheet.Date=0D THEN BEGIN
                             DataSheet.Date := Cust."Registration Date";
                             DataSheet."Transaction Type":=DataSheet."Transaction Type"::EFFECT;
                            END;
                            DataSheet."Entry No":=EntryNo;
                          DataSheet."Type of Deduction":='Shares';
                          DataSheet."REF.":=DataSheet.GetContributionDeductionCode(GenJournalLine."Transaction Type"::"Deposit Contribution",
                          '',Cust."Employer Code",1);
                          DataSheet."Advice Option":=DataSheet."Advice Option"::Amount;
                          DataSheet."New Balance":=Cust."Current Shares";
                          DataSheet.INSERT;
        
                          IF Cust."Employer Code"='TELKOM' THEN BEGIN
                            EntryNo:=EntryNo+1;
                              DataSheet.INIT;
                              DataSheet."PF/Staff No":=Cust."Payroll No";
                              DataSheet.Name:=Cust.Name;
                              DataSheet."Amount ON":=Cust."Current Shares";
                              DataSheet."Approved Amount":=Cust."Current Shares";
                              DataSheet.Employer:=Cust."Employer Code";
                              DataSheet.Date:=Cust."Variation Date Deposits";
                              DataSheet."Transaction Type":=DataSheet."Transaction Type"::VARIATION;
                              IF DataSheet.Date=0D THEN BEGIN
                                DataSheet.Date := Cust."Registration Date";
                                DataSheet."Transaction Type":=DataSheet."Transaction Type"::EFFECT;
                              END;
                              DataSheet."Entry No":=EntryNo;
                              DataSheet."Type of Deduction":='SharesBalance';
                              DataSheet."REF.":=DataSheet.GetContributionDeductionCode(GenJournalLine."Transaction Type"::"Deposit Contribution",
                              '',Cust."Employer Code",2);
                              DataSheet."Advice Option":=DataSheet."Advice Option"::Balance;
                              DataSheet."New Balance":=Cust."Current Shares";
                              DataSheet.INSERT;
                            END;
        
                              /*IF (Cust."Registration Date">DMY2DATE(21,10,2016)) AND (Cust."Registration Fee Paid"=0) AND Reg THEN BEGIN
                                  Dia.UPDATE(1,'Updating Registration Fee for '+Cust.Name);
                                  DataSheet.INIT;
                                  DataSheet."PF/Staff No":=Cust."Payroll/Staff No";
                                  DataSheet.Name:=Cust.Name;
                                  DataSheet."Amount ON":=SaccoGeneralSetUp."Registration Fee";
                                  DataSheet."Approved Amount":=SaccoGeneralSetUp."Registration Fee";
                                  DataSheet."Transaction Type":=DataSheet."Transaction Type"::"FRESH FEED";
                                  DataSheet.Date:=Cust."Registration Date";
                                  DataSheet.Employer:=Cust."Employer Code";
                                  DataSheet."ID NO.":=Cust."ID No.";
                                  DataSheet."Type of Deduction":='MembershipFee';
                                  DataSheet."REF.":=DataSheet.GetContributionDeductionCode(GenJournalLine."Transaction Type"::"Registration Fee",'',Cust."Employer Code",1);
                                  DatasheetMain."Advice Option":=DatasheetMain."Advice Option"::Amount;
                                  DataSheet.INSERT;
                             END;*/
                       END;
        
                             IF Ess THEN BEGIN
                             EntryNo:=EntryNo+1;
                                  Dia.UPDATE(1,'Updating Ess Contribution for '+Cust.Name);
                                  DataSheet.INIT;
                                  DataSheet."PF/Staff No":=Cust."Payroll No";
                                  DataSheet.Name:=Cust.Name;
                                  DataSheet."Amount ON":=Cust."Monthly Sch.Fees Cont.";
                                  DataSheet."Transaction Type":=DataSheet."Transaction Type"::VARIATION;
                                  DataSheet."Approved Amount":=Cust."Monthly Sch.Fees Cont.";
                                  DataSheet.Date:=Cust."Variation Date ESS";
                                  DataSheet.Employer:=Cust."Employer Code";
                                  DataSheet."ID NO.":=Cust."ID No.";
                                  DataSheet."Type of Deduction":='ESS Shares';
                                 // DataSheet."REF.":=DataSheet.GetContributionDeductionCode(GenJournalLine."Transaction Type"::"SchFee Shares",'',Cust."Employer Code",1);
                                  DatasheetMain."Advice Option":=DatasheetMain."Advice Option"::Amount;
                                  DataSheet."New Balance":=Cust."School Fees Shares";
                                  DataSheet."Entry No":=EntryNo+1;
                                  DataSheet.INSERT;
                                  IF Cust."Employer Code"='TELKOM' THEN BEGIN
                                  EntryNo:=EntryNo+1;
                                      DataSheet.INIT;
                                      DataSheet."PF/Staff No":=Cust."Payroll No";
                                      DataSheet.Name:=Cust.Name;
                                      DataSheet."Amount ON":=Cust."School Fees Shares";
                                      DataSheet."Transaction Type":=DataSheet."Transaction Type"::VARIATION;
                                      DataSheet."Approved Amount":=Cust."School Fees Shares";
                                      DataSheet.Date:=Cust."Variation Date ESS";
                                      DataSheet.Employer:=Cust."Employer Code";
                                      DataSheet."ID NO.":=Cust."ID No.";
                                      DataSheet."Entry No":=EntryNo;
                                      DataSheet."Type of Deduction":='ESS Shares Balance';
                                     // DataSheet."REF.":=DataSheet.GetContributionDeductionCode(GenJournalLine."Transaction Type"::,'',Cust."Employer Code",2);
                                      DatasheetMain."Advice Option":=DatasheetMain."Advice Option"::Balance;
                                      DataSheet."New Balance":=Cust."School Fees Shares";
                                      DataSheet.INSERT;
                                  END;
                             END;
        
        
          UNTIL Cust.NEXT=0;
        END;
        
        
        //End Shares
        
        IssuedDatetel:=20161019D;
        loansAppz.RESET;
        loansAppz.SETRANGE(loansAppz."Loan Status",loansAppz."Loan Status"::Issued);
        //loansAppz.SETRANGE(loansAppz."Recovery Mode",loansAppz."Recovery Mode"::Checkoff);
        loansAppz.SETRANGE(loansAppz.Posted,TRUE);
        loansAppz.SETFILTER(loansAppz."Issued Date",'>%1',IssuedDatetel);
        loansAppz.SETFILTER(loansAppz."Approved Amount",'>%1',0);
        loansAppz.SETFILTER(loansAppz."Loan Product Type",'<>%1','A03');
        loansAppz.SETAUTOCALCFIELDS(loansAppz."Last Pay Date",loansAppz."Outstanding Balance",loansAppz."Outstanding Interest");
        IF loansAppz.FIND('-') THEN BEGIN
         REPEAT
        
              IssuedLoan := (loansAppz."Issued Date">=StartDate) AND (loansAppz."Issued Date"<=EndDate);
              LoanIsCompleted := (loansAppz."Last Pay Date">=StartDate) AND (loansAppz."Last Pay Date"<=EndDate) AND (loansAppz."Outstanding Balance"<=0);
              ThisMemb.GET(loansAppz."Client Code");
        
              IF (loansAppz."Outstanding Balance">0) AND IssuedLoan  THEN BEGIN
                      Dia.UPDATE(1,'Updating Loan for '+loansAppz."Client Name");
                      EntryNo:=EntryNo+1;
                      DataSheet.INIT;
                      Cust.RESET;
                      Cust.SETRANGE(Cust."No.",loansAppz."Client Code");
                      IF Cust.FIND('-') THEN BEGIN
                          DataSheet."PF/Staff No":=Cust."Payroll No";
                          DataSheet.Name:=loansAppz."Client Name";
                       END;
                      LoanTypes.RESET;
                      LoanTypes.SETRANGE(LoanTypes.Code,loansAppz."Loan Product Type");
                      IF LoanTypes.FIND('-') THEN BEGIN
                      DataSheet."Type of Deduction":=LoanTypes."Product Description";
                      END;
                      DataSheet."Remark/LoanNO":=loansAppz."Loan  No.";
                      DataSheet."Approved Amount":=loansAppz."Approved Amount";
                      DataSheet."ID NO.":=Cust."ID No.";
                      DataSheet."Amount ON":=loansAppz.Repayment;
                      DataSheet."REF.":=DataSheet.GetContributionDeductionCode(Gnljnline."Transaction Type"::" ",loansAppz."Loan Product Type",ThisMemb."Employer Code",1);
                      DataSheet."New Balance":=loansAppz."Outstanding Balance";
                      DataSheet.Date:=loansAppz."Issued Date";
                      DataSheet.Employer:=ThisMemb."Employer Code";
                      DataSheet."Entry No":=EntryNo;
                      DataSheet.Installments:=FORMAT(loansAppz.Installments);
                     // DataSheet.Ceased:=loansAppz.Bridged;
                      DataSheet."Principal Amount":=loansAppz.Repayment;
                      DataSheet."Transaction Type":=DataSheet."Transaction Type"::EFFECT;
                      DataSheet."Advice Option":=DataSheet."Advice Option"::Amount;
                      DataSheet.INSERT(TRUE);
        
                      IF ThisMemb."Employer Code"='TELKOM' THEN BEGIN
                      EntryNo:=EntryNo+1;
                          DataSheet.INIT;
                          Cust.RESET;
                          Cust.SETRANGE(Cust."No.",loansAppz."Client Code");
                          IF Cust.FIND('-') THEN BEGIN
                              DataSheet."PF/Staff No":=Cust."Payroll No";
                              DataSheet.Name:=loansAppz."Client Name";
                           END;
                          LoanTypes.RESET;
                          LoanTypes.SETRANGE(LoanTypes.Code,loansAppz."Loan Product Type");
                          IF LoanTypes.FIND('-') THEN BEGIN
                          DataSheet."Type of Deduction":=LoanTypes."Product Description"+' Balance';
                          END;
                          DataSheet."Remark/LoanNO":=loansAppz."Loan  No.";
                          DataSheet."Approved Amount":=loansAppz."Approved Amount";
                          DataSheet."ID NO.":=Cust."ID No.";
                         // IF loansAppz.Source=loansAppz.Source::BOSA THEN BEGIN
                           //  DataSheet."Amount ON":=loansAppz."Outstanding Balance";
                         // END;
                          // IF  loansAppz.Source=loansAppz.Source::FOSA THEN BEGIN
                          DataSheet."Amount ON":=loansAppz.Repayment*loansAppz.Installments;
                              //loansAppz."Outstanding Balance"+loansAppz."Oustanding Interest";
                           //END;
                          DataSheet."REF.":=DataSheet.GetContributionDeductionCode(Gnljnline."Transaction Type"::" ",loansAppz."Loan Product Type",ThisMemb."Employer Code",2);
                          DataSheet."New Balance":=loansAppz."Outstanding Balance";
                          DataSheet.Date:=loansAppz."Issued Date";
                          DataSheet.Employer:=Cust."Employer Code";
                          DataSheet.Installments:=FORMAT(loansAppz.Installments);
                         // DataSheet.Ceased:=loansAppz.Bridged;
                          DataSheet."Principal Amount":=loansAppz.Repayment;
                           DataSheet."Entry No":=EntryNo;
                          DataSheet."Transaction Type":=DataSheet."Transaction Type"::EFFECT;
                          DataSheet."Advice Option":=DataSheet."Advice Option"::Balance;
                          DataSheet.INSERT(TRUE);
                      END;
              END;
        
        //Insert Loans Offset
             loansAppz.CALCFIELDS(loansAppz."Outstanding Balance");
        
          //IF loansAppz."Outstanding Balance">0 THEN BEGIN 14/07/2023 Kitui
                     IF loansAppz."Approval Status"=loansAppz."Approval Status"::Approved THEN BEGIN
                     EntryNo:=EntryNo+1;
                      Dia.UPDATE(1,'Updating Loan offset for '+loansAppz."Client Name");
                      OffSet.RESET;
                      OffSet.SETRANGE(OffSet."Loan No.",loansAppz."Loan  No.");
                      OffSet.SETRANGE(OffSet."Mark Adviced",FALSE);
                      IF OffSet.FINDFIRST THEN
                      BEGIN
                      REPEAT
                      IF LoansR.GET(OffSet."Loan Top Up") THEN BEGIN
                      LoansR.CALCFIELDS(LoansR."Outstanding Balance");
                      //IF LoansR."Outstanding Balance">0 THEN BEGIN
                      DataSheet.INIT;
                      DataSheet."REF.":=DataSheet.GetContributionDeductionCode(GenJournalLine."Transaction Type"::" ",LoansR."Loan Product Type",ThisMemb."Employer Code",1);
                      DataSheet."Remark/LoanNO":=LoansR."Loan  No.";
                      DataSheet."PF/Staff No":=ThisMemb."Payroll No";
                      DataSheet.Name:=ThisMemb.Name;
                      DataSheet."ID NO.":=ThisMemb."ID No.";
                      DataSheet."Amount ON":=loansAppz.Repayment;
                       DataSheet."Entry No":=EntryNo;
                      LoanTypes.RESET;
                      LoanTypes.SETRANGE(LoanTypes.Code,LoansR."Loan Product Type");
                      IF LoanTypes.FIND('-') THEN BEGIN
                      DataSheet."Type of Deduction":=LoanTypes."Product Description"+' Completed';
                      END;
                      DataSheet."New Balance":=0;
                      DataSheet.Installments:='0';
                      LoansR.CALCFIELDS(LoansR."Last Pay Date");
                      DataSheet.Date:=LoansR."Last Pay Date";
                      DataSheet.Employer:=ThisMemb."Employer Code";
                      DataSheet."Principal Amount":=0;
                      DataSheet."Transaction Type":=DataSheet."Transaction Type"::CEASE;
                      DataSheet."Advice Option":=DataSheet."Advice Option"::Balance;
                      DataSheet.Ceased:=TRUE;
                      DataSheet.INSERT(TRUE);
                      //OffSet."Mark Adviced":=TRUE;
                      //OffSet.MODIFY;
                      //END;
                      END;
                   UNTIL OffSet.NEXT=0;
                   END;
                END;
        
        //END;
        //Insert Loans Offset
        UNTIL loansAppz.NEXT=0;
        END;
        loansAppz.RESET;
        loansAppz.SETRANGE(loansAppz."Loan Status",loansAppz."Loan Status"::Issued);
       // loansAppz.SETRANGE(loansAppz."Recovery Mode",loansAppz."Recovery Mode"::Checkoff);
        loansAppz.SETRANGE(loansAppz.Posted,FALSE);
        loansAppz.SETRANGE(loansAppz."Approval Status",loansAppz."Approval Status"::Approved);
        loansAppz.SETFILTER(loansAppz."Issued Date",'>%1',IssuedDatetel);
        loansAppz.SETFILTER(loansAppz."Approved Amount",'>%1',0);
        loansAppz.SETFILTER(loansAppz."Loan Product Type",'<>%1','A03');
        loansAppz.SETAUTOCALCFIELDS(loansAppz."Last Pay Date",loansAppz."Outstanding Balance",loansAppz."Outstanding Interest");
        IF loansAppz.FIND('-') THEN BEGIN
         REPEAT
                //Insert Loans Offset   approved
             loansAppz.CALCFIELDS(loansAppz."Outstanding Balance");
          IF loansAppz."Outstanding Balance"=0 THEN BEGIN
                EntryNo:=EntryNo+1;
                      Dia.UPDATE(1,'Updating Loan offset for '+loansAppz."Client Name");
                      OffSet.RESET;
                      OffSet.SETRANGE(OffSet."Loan No.",loansAppz."Loan  No.");
                      OffSet.SETRANGE(OffSet."Mark Adviced",FALSE);
                      IF OffSet.FINDFIRST THEN
                      BEGIN
                      REPEAT
                      IF LoansR.GET(OffSet."Loan Top Up") THEN BEGIN
                      //LoansR.CALCFIELDS(LoansR."Outstanding Balance");
                      //IF LoansR."Outstanding Balance">0 THEN BEGIN
                      DataSheet.INIT;
                      DataSheet."REF.":=DataSheet.GetContributionDeductionCode(GenJournalLine."Transaction Type"::" ",LoansR."Loan Product Type",ThisMemb."Employer Code",1);
                      DataSheet."Remark/LoanNO":=LoansR."Loan  No.";
                      DataSheet."PF/Staff No":=ThisMemb."Payroll No";
                      DataSheet.Name:=ThisMemb.Name;
                      DataSheet."ID NO.":=ThisMemb."ID No.";
                      DataSheet."Amount ON":=loansAppz.Repayment;
                       DataSheet."Entry No":=EntryNo;
                      LoanTypes.RESET;
                      LoanTypes.SETRANGE(LoanTypes.Code,LoansR."Loan Product Type");
                      IF LoanTypes.FIND('-') THEN BEGIN
                      DataSheet."Type of Deduction":=LoanTypes."Product Description"+' Completed';
                      END;
                      DataSheet."New Balance":=0;
                      DataSheet.Installments:='0';
                      LoansR.CALCFIELDS(LoansR."Last Pay Date");
                      DataSheet.Date:=LoansR."Last Pay Date";
                      DataSheet.Employer:=ThisMemb."Employer Code";
                      DataSheet."Principal Amount":=0;
                      DataSheet."Transaction Type":=DataSheet."Transaction Type"::CEASE;
                      DataSheet."Advice Option":=DataSheet."Advice Option"::Balance;
                      DataSheet.Ceased:=TRUE;
                      DataSheet.INSERT(TRUE);
                      //OffSet."Mark Adviced":=TRUE;
                      //OffSet.MODIFY;
                      //END;
                      END;
                   UNTIL OffSet.NEXT=0;
                   END;
                END;
        UNTIL loansAppz.NEXT=0;
        END;
      //  CheckoffAdvUpdate.RESET;
      //   CheckoffAdvUpdate.SETRANGE(CheckoffAdvUpdate."Advice Date",StartDate,EndDate);
      //   IF CheckoffAdvUpdate.FINDSET THEN
      //   REPEAT
      //   EntryNo:=EntryNo+1;
      //        Dia.UPDATE(1,'Updating Advice Update for '+CheckoffAdvUpdate."Member No");
      //                 ThisMemb.GET(CheckoffAdvUpdate."Member No");
      //                 DataSheet.INIT;
      //                 DataSheet."REF.":=DataSheet.GetContributionDeductionCode(CheckoffAdvUpdate."Savings Product",CheckoffAdvUpdate."Product Type",ThisMemb."Employer Code",1);
      //                 DataSheet."Remark/LoanNO":=CheckoffAdvUpdate."Loan Number";
      //                 DataSheet."PF/Staff No":=ThisMemb."Payroll No";
      //                 DataSheet.Name:=ThisMemb.Name;
      //                 DataSheet."ID NO.":=ThisMemb."ID No.";
      //                 IF CheckoffAdvUpdate."Loan Number"<>'' THEN  BEGIN
      //                     Mkopo.GET(CheckoffAdvUpdate."Loan Number");
      //                     LoanTypes.GET(Mkopo."Loan Product Type");
      //                     DataSheet."Type of Deduction":=LoanTypes."Product Description";
      //                 END;
      //                 CASE CheckoffAdvUpdate."Savings Product" OF
      //                   CheckoffAdvUpdate."Savings Product"::"Deposit Contribution":DataSheet."Type of Deduction":='Shares';
      //                   CheckoffAdvUpdate."Savings Product"::"SchFee Shares":DataSheet."Type of Deduction":='ESS Shares';
      //                 END;
      //                 DataSheet."Amount ON":=CheckoffAdvUpdate.Amount;
      //                 DataSheet."New Balance":=0;
      //                  DataSheet."Entry No":=EntryNo;
      //                 DataSheet.Installments:='0';
      //                 DataSheet.Date:=CheckoffAdvUpdate."Advice Date";
      //                 DataSheet.Employer:=CheckoffAdvUpdate."Employer Code";
      //                 DataSheet."Principal Amount":=0;
      //                 DataSheet."Transaction Type":=CheckoffAdvUpdate."Transaction Type";
      //                 DataSheet."Advice Option":=DataSheet."Advice Option"::Amount;
      //                 DataSheet.INSERT(TRUE);
        
      //   UNTIL CheckoffAdvUpdate.NEXT = 0;
      
        
        
        
        Dia.CLOSE;

    end;

    var
        LoanType: Record "Loan Products Setup";
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
        UsersID: Record User;
        TotalTopupComm: Decimal;
        Notification: Codeunit Mail;
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
       // BridgedLoans: Record "Special Loan Clearances";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        Vendor: Record "Vendor";
        LoanTypes: Record "Loan Products Setup";
        DataSheet: Record "Data Sheet Main";
        IssuedDatetel: Date;
        loansAppz: Record "Loans Register";
        DatasheetMain: Record "Data Sheet Main";
        Options: Code[50];
        Selected: Integer;
        LoansOffset: Record "Loan Offset Details";
        SaccoCode: Code[10];
        Dia: Dialog;
        StartDate: Date;
        EndDate: Date;
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
        EntryNo: Integer;
        DataSht: Record "Data Sheet Main";

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
}




