report 50785 "Loans Variances"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/LoansVariance.rdlc';

    dataset
    {
        dataitem(SalHeader; "Salary Processing Lines")
        {
            RequestFilterFields = "Member No", "Staff No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(LoanType; LoanType)
            {
            }
            column(RFilters; RFilters)
            {
            }
            column(SalheaderNo; "Salary Header No.")
            {
            }

            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("Member No");
                DataItemTableView = SORTING("Staff No")
                                ORDER(Ascending)
                                WHERE(Posted = CONST(True),
                                      "Outstanding Balance" = FILTER(> 0));
                RequestFilterFields = Source, "Loan Product Type", "Date filter", "Application Date", "Loan Status", "Issued Date", Posted, "Batch No.", "Captured By", "Branch Code", "Outstanding Balance", "Loan  No.";

                column(EmployerCode; CompanyCode)
                {
                }
                column(StaffNo; "Staff No")
                {
                }
                column(Loans__Loan__No__; "Loan  No.")
                {
                }
                column(AccountNo_Loans; Loans."Account No")
                {
                }
                column(Loans__Client_Code_; "Client Code")
                {
                }
                column(Loans__Client_Name_; "Client Name")
                {
                }
                column(Loans__Requested_Amount_; "Requested Amount")
                {
                }
                column(Loans__Approved_Amount_; "Approved Amount")
                {
                }
                column(Repayment; Repayment)
                {
                }
                column(Loans_Installments; Installments)
                {
                }
                column(Loans__Loan_Status_; "Loan Status")
                {
                }
                column(Loans_Loans__Outstanding_Balance_; Loans."Outstanding Balance")
                {
                }
                column(Loans__Application_Date_; "Application Date")
                {
                }
                column(Loans__Issued_Date_; "Issued Date")
                {
                }
                column(Loans__Oustanding_Interest_; "Outstanding Interest")
                {
                }
                column(Loans_Loans__Loan_Product_Type_; Loans."Loan Product Type")
                {
                }
                column(Loans__Last_Pay_Date_; "Last Pay Date")
                {
                }
                column(Loans__Top_Up_Amount_; "Top Up Amount")
                {
                }
                column(Loans__Approved_Amount__Control1102760017; "Approved Amount")
                {
                }
                column(Loans__Requested_Amount__Control1102760038; "Requested Amount")
                {
                }
                column(LCount; LCount)
                {
                }
                column(Loans_Loans__Outstanding_Balance__Control1102760040; Loans."Outstanding Balance")
                {
                }
                column(Loans__Oustanding_Interest__Control1102760041; Loans."Outstanding Interest")
                {
                }
                column(Loans__Top_Up_Amount__Control1000000001; "Top Up Amount")
                {
                }
                column(Loans_RegisterCaption; Loans_RegisterCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Loan_TypeCaption; Loan_TypeCaptionLbl)
                {
                }
                column(Loans__Loan__No__Caption; FIELDCAPTION("Loan  No."))
                {
                }
                column(Client_No_Caption; Client_No_CaptionLbl)
                {
                }
                column(Loans__Client_Name_Caption; FIELDCAPTION("Client Name"))
                {
                }
                column(Loans__Requested_Amount_Caption; FIELDCAPTION("Requested Amount"))
                {
                }
                column(Loans__Approved_Amount_Caption; FIELDCAPTION("Approved Amount"))
                {
                }
                column(Loans__Loan_Status_Caption; FIELDCAPTION("Loan Status"))
                {
                }
                column(Outstanding_LoanCaption; Outstanding_LoanCaptionLbl)
                {
                }
                column(PeriodCaption; PeriodCaptionLbl)
                {
                }
                column(Loans__Application_Date_Caption; FIELDCAPTION("Application Date"))
                {
                }
                column(Approved_DateCaption; Approved_DateCaptionLbl)
                {
                }
                column(Loans__Oustanding_Interest_Caption; FIELDCAPTION(Loans."Outstanding Interest"))
                {
                }
                column(LoanProduct; "Loan Product Type")
                {
                }

                column(ExpectedInterest; ExpectedInterest)
                {
                }
                column(ExpectedRepayment; ExpectedRepayment)
                {
                }

                column(InterestRepayment; InterestRepayment)
                {
                }
                column(RepaymentAmount; RepaymentAmount)
                {
                }
                column(Lbal; LBalance)
                {
                }
                column(StartDate; StartDate)
                {
                }
                column(EndDate; EndDate)
                {
                }
                column(AmountReceived; AmountReceived)
                {
                }
                column(AmountExpected; AmountExpected)
                {
                }
                column(ShareCapital; ShareCapital)
                {
                }
                column(DepositAmount; DepositAmount)
                {
                }
                column(OrdinaryAmount; OrdinaryAmount)
                {
                }

                column(EssAmount; EssAmount)
                {
                }
                column(JibambeAmount; JibambeAmount)
                {
                }
                column(ChamaaAmount; ChamaaAmount)
                {
                }
                column(WezeshaAmount; WezeshaAmount)
                {
                }

                column(MdosiAmount; MdosiAmount)
                {
                }

                column(PensionAkiba; PensionAkiba)
                {
                }

                column(BussinessAmount; BussinessAmount)
                {
                }
                column(ExpectedDeposits; ExpectedDeposits)
                {
                }
                trigger OnAfterGetRecord()
                var
                    RSch: Record "Loan Repayment Schedule";
                    STO: Record "Standing Orders";
                    STOLines: Record "Receipt Allocation";
                begin
                    LBalance := 0;
                    AmountExpected := 0;
                    AmountReceived := 0;
                    ExpectedRepayment := 0;
                    ExpectedInterest := 0;
                    InterestRepayment := 0;
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Loan No", Loans."Loan  No.");
                    CustLedger.SETFILTER(CustLedger."Transaction Type", '%1', CustLedger."Transaction Type"::"Interest Due");
                    CustLedger.SetRange(CustLedger."Document No.", SalHeader."Salary Header No.");
                    //CustLedger.SETRANGE(CustLedger."Posting Date", StartDate, EndDate);
                    CustLedger.SETRANGE(CustLedger.Reversed, FALSE);
                    IF CustLedger.FIND('-') THEN BEGIN
                        REPEAT
                            ExpectedInterest += ABS(CustLedger.Amount);
                        UNTIL CustLedger.NEXT = 0;
                    END;


                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Loan No", Loans."Loan  No.");
                    CustLedger.SETFILTER(CustLedger."Transaction Type", '%1', CustLedger."Transaction Type"::"Interest Paid");
                    CustLedger.SetRange(CustLedger."Document No.", SalHeader."Salary Header No.");
                    //CustLedger.SETRANGE(CustLedger."Posting Date", StartDate, EndDate);
                    CustLedger.SETRANGE(CustLedger.Reversed, FALSE);
                    IF CustLedger.FIND('-') THEN BEGIN
                        REPEAT
                            InterestRepayment += ABS(CustLedger.Amount);
                        UNTIL CustLedger.NEXT = 0;
                    END;


                    RepaymentAmount := 0;
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Loan No", Loans."Loan  No.");
                    CustLedger.SETFILTER(CustLedger."Transaction Type", '%1', CustLedger."Transaction Type"::Repayment);
                    CustLedger.SetRange(CustLedger."Document No.", SalHeader."Salary Header No.");
                    //  CustLedger.SETRANGE(CustLedger."Posting Date", StartDate, EndDate);
                    CustLedger.SETRANGE(CustLedger.Reversed, FALSE);
                    IF CustLedger.FIND('-') THEN BEGIN
                        REPEAT
                            RepaymentAmount += ABS(CustLedger.Amount);
                        UNTIL CustLedger.NEXT = 0;
                    END;

                    STO.Reset();
                    STO.SetRange(STO."Source Account No.", SalHeader."Account No.");
                    STO.SetRange(STO.Status, STO.Status::Approved);
                    if STO.FindFirst() then begin

                        STOLines.Reset();
                        STOLines.SetRange(STOLines."Document No", STO."No.");
                        //STOLines.SetRange(STOLines."Account Type Name", 'BOSA Deposits');
                        if STOLines.FindFirst() then begin

                            repeat
                                // Message('Sto%1', STOLines."Account No");
                                Vend.Reset();
                                Vend.SetRange(Vend."No.", STOLines."Account No");
                                Vend.SetRange(Vend."Account Type", '102');
                                if Vend.FindFirst() then begin
                                    ExpectedDeposits := 0;
                                    ExpectedDeposits := STOLines.Amount;
                                end;
                            until STOLines.Next() = 0;
                        end;
                    end;


                    ExpectedRepayment := 0;
                    RSch.RESET;
                    RSch.SETRANGE(RSch."Loan No.", Loans."Loan  No.");
                    RSch.SETRANGE(RSch."Repayment Date", StartDate, EndDate);
                    // RSch.SETRANGE(RSch."Close Schedule", FALSE);
                    IF RSch.FIND THEN BEGIN
                        RSch.CALCSUMS(RSch."Principal Repayment");
                        ExpectedRepayment := RSch."Principal Repayment";
                    END;


                    /*           Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '101');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      ShareCapital := -VendL.Amount;

                                  end;
                              end;

                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '102');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      DepositAmount := -VendL.Amount;

                                  end;
                              end;

                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '103');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      OrdinaryAmount := -VendL.Amount;

                                  end;
                              end;

                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '104');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      EssAmount := -VendL.Amount;

                                  end;
                              end;


                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '105');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      ChamaaAmount := -VendL.Amount;

                                  end;
                              end;



                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '106');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      JibambeAmount := -VendL.Amount;

                                  end;
                              end;


                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '107');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      WezeshaAmount := -VendL.Amount;

                                  end;
                              end;


                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '109');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      MdosiAmount := -VendL.Amount;

                                  end;
                              end;


                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '110');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      PensionAkiba := -VendL.Amount;

                                  end;
                              end;


                              Vend.Reset();
                              Vend.SetRange(Vend."BOSA Account No", Loans."Client Code");
                              Vend.SetRange(Vend."Account Type", '111');
                              if Vend.FindFirst() then begin
                                  VendL.Reset();
                                  VendL.SetRange(VendL."Vendor No.", Vend."No.");
                                  VendL.SetRange(VendL."Posting Date", StartDate, EndDate);
                                  if VendL.FindSet() then begin
                                      VendL.CalcSums(VendL.Amount);

                                      BussinessAmount := -VendL.Amount;

                                  end;
                              end; */
                    PensionAkiba := 0;
                    BussinessAmount := 0;
                    WezeshaAmount := 0;
                    JibambeAmount := 0;
                    ChamaaAmount := 0;
                    EssAmount := 0;
                    OrdinaryAmount := 0;
                    DepositAmount := 0;
                    ShareCapital := 0;
                    MdosiAmount := 0;
                    CalculateBosaAccountAmount('101', Loans."Client Code", SalHeader."Salary Header No.", ShareCapital);
                    CalculateBosaAccountAmount('102', Loans."Client Code", SalHeader."Salary Header No.", DepositAmount);
                    CalculateBosaAccountAmount('103', Loans."Client Code", SalHeader."Salary Header No.", OrdinaryAmount);
                    CalculateBosaAccountAmount('104', Loans."Client Code", SalHeader."Salary Header No.", EssAmount);
                    CalculateBosaAccountAmount('105', Loans."Client Code", SalHeader."Salary Header No.", ChamaaAmount);
                    CalculateBosaAccountAmount('106', Loans."Client Code", SalHeader."Salary Header No.", JibambeAmount);
                    CalculateBosaAccountAmount('107', Loans."Client Code", SalHeader."Salary Header No.", WezeshaAmount);
                    CalculateBosaAccountAmount('109', Loans."Client Code", SalHeader."Salary Header No.", MdosiAmount);
                    CalculateBosaAccountAmount('110', Loans."Client Code", SalHeader."Salary Header No.", PensionAkiba);
                    CalculateBosaAccountAmount('111', Loans."Client Code", SalHeader."Salary Header No.", BussinessAmount);


                    IF ExpectedRepayment = 0 THEN
                        ExpectedRepayment := Loans."Loan Principle Repayment";

                    CompanyCode := '';
                    IF cust.GET(Loans."Client Code") THEN
                        CompanyCode := cust."Employer Code";
                    LCount := LCount + 1;
                end;

                trigger OnPreDataItem()
                begin
                    IF LoanProdType.GET(Loans.GETFILTER(Loans."Loan Product Type")) THEN
                        LoanType := LoanProdType."Product Description";
                    LCount := 0;

                    IF Loans.GETFILTER(Loans."Branch Code") <> '' THEN BEGIN
                        DValue.RESET;
                        DValue.SETRANGE(DValue."Global Dimension No.", 2);
                        DValue.SETRANGE(DValue.Code, Loans.GETFILTER(Loans."Branch Code"));
                        IF DValue.FIND('-') THEN
                            RFilters := 'Branch: ' + DValue.Name;

                    END;

                    RFilters := Loans.GETFILTERS;

                    IF (StartDate = 0D) OR (EndDate = 0D) THEN
                        ERROR('Start date and end date must have a value');

                    //Datefilter:=Loans.GETRANGEMAX(Loans."Date filter");
                    //Loans.SETRANGE(Loans."Date filter",0D,Datefilter);
                    Loans.SETFILTER(Loans."Date filter", '..%1', EndDate);
                end;
            }
        }
    }
    requestpage
    {

        layout
        {
            area(content)
            {
                group("Please Select")
                {
                    field("Start Date"; StartDate)
                    {
                    ApplicationArea = All;
                    }
                    field("End Date"; EndDate)
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

    var
        ExpectedDeposits: Decimal;
        RPeriod: Decimal;
        BatchL: Code[100];
        Batches: Record "Loan Disburesment-Batching";
        ApprovalSetup: Record "Approvals Users Set Up";
        LocationFilter: Code[20];
        TotalApproved: Decimal;
        cust: Record Customer;
        BOSABal: Decimal;
        SuperBal: Decimal;
        LAppl: Record "Loans Register";
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LoanProdType: Record "Loan Products Setup";
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record 349;
        VALREPAY: Record "Detailed Cust. Ledg. Entry";
        Loans_RegisterCaptionLbl: Label 'Loans Register';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Loan_TypeCaptionLbl: Label 'Loan Type';
        Client_No_CaptionLbl: Label 'Client No.';
        Outstanding_LoanCaptionLbl: Label 'Outstanding Loan';
        PeriodCaptionLbl: Label 'Period';
        Approved_DateCaptionLbl: Label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: Label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: Label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: Label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: Label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: Label 'Sign........................';
        Date________________________CaptionLbl: Label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: Label 'Date........................';
        Datefilter: Date;
        CustLedger: Record "Detailed Cust. Ledg. Entry";
        DateFilterr: Date;
        LBalance: Decimal;
        StartDate: Date;
        EndDate: Date;
        AmountReceived: Decimal;
        AmountExpected: Decimal;
        RepaymentAmount: Decimal;

        ExpectedRepayment: Decimal;

        ExpectedInterest: Decimal;

        InterestRepayment: Decimal;

        Vend: Record Vendor;

        VendL: Record "Detailed Vendor Ledg. Entry";


        DepositAmount: Decimal;

        OrdinaryAmount: Decimal;

        ShareCapital: Decimal;

        EssAmount: Decimal;

        ChamaaAmount: Decimal;

        JibambeAmount: Decimal;

        WezeshaAmount: Decimal;

        MdosiAmount: Decimal;

        PensionAkiba: Decimal;

        BussinessAmount: Decimal;

    procedure CalculateBosaAccountAmount(AccountType: Code[20]; ClientCode: Code[40]; DocumentNo: code[60]; var TargetAmount: Decimal)

    begin
        Vend.Reset();
        Vend.SetRange("BOSA Account No", ClientCode);
        Vend.SetRange("Account Type", AccountType);
        if Vend.FindFirst() then begin
            VendL.Reset();
            VendL.SetRange("Vendor No.", Vend."No.");
            //VendL.SetRange("Posting Date", StartDate, EndDate);
            VendL.SetRange(VendL."Document No.", DocumentNo);
            if VendL.FindSet() then begin
                VendL.CalcSums(Amount);
                TargetAmount := -VendL.Amount;
            end else
                TargetAmount := 0;
        end else
            TargetAmount := 0;
    end;

}




