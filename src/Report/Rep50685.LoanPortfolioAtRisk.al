report 50685 "Loan Portfolio At Risk"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Loan Portfolio At Risk.rdlc';;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = SORTING("Staff No")ORDER(Ascending)WHERE(Posted=CONST(True),"Outstanding Balance"=FILTER(>0));
            RequestFilterFields = Source,"Loan Product Type","Date filter","Application Date","Loan Status","Issued Date",Posted,"Batch No.","Captured By","Branch Code","Outstanding Balance","Loan  No.";
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(LoanType;LoanType)
            {
            }
            column(RFilters;RFilters)
            {
            }
            column(EmployerCode;CompanyCode)
            {
            }
            column(StaffNo;"Staff No")
            {
            }
            column(Loans__Loan__No__;"Loan  No.")
            {
            }
            column(AccountNo_Loans;Loans."Account No")
            {
            }
            column(Loans__Client_Code_;"Client Code")
            {
            }
            column(Loans__Client_Name_;"Client Name")
            {
            }
            column(Loans__Requested_Amount_;"Requested Amount")
            {
            }
            column(Loans__Approved_Amount_;"Approved Amount")
            {
            }
            column(Repayment;Repayment)
            {
            }
            column(Loans_Installments;Installments)
            {
            }
            column(Loans__Loan_Status_;"Loan Status")
            {
            }
            column(Loans_Loans__Outstanding_Balance_;Loans."Outstanding Balance")
            {
            }
            column(Loans__Application_Date_;"Application Date")
            {
            }
            column(Loans__Issued_Date_;"Issued Date")
            {
            }
            column(Loans__Oustanding_Interest_;"Outstanding Interest")
            {
            }
            column(Loans_Loans__Loan_Product_Type_;Loans."Loan Product Type")
            {
            }
            column(Loans__Last_Pay_Date_;"Last Pay Date")
            {
            }
            column(Loans__Top_Up_Amount_;"Top Up Amount")
            {
            }
            column(Loans__Approved_Amount__Control1102760017;"Approved Amount")
            {
            }
            column(Loans__Requested_Amount__Control1102760038;"Requested Amount")
            {
            }
            column(LCount;LCount)
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1102760040;Loans."Outstanding Balance")
            {
            }
            column(Loans__Oustanding_Interest__Control1102760041;"Outstanding Interest")
            {
            }
            column(Loans__Top_Up_Amount__Control1000000001;"Top Up Amount")
            {
            }
            column(Loans_RegisterCaption;Loans_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_TypeCaption;Loan_TypeCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption;FIELDCAPTION("Loan  No."))
            {
            }
            column(Client_No_Caption;Client_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption;FIELDCAPTION("Client Name"))
            {
            }
            column(Loans__Requested_Amount_Caption;FIELDCAPTION("Requested Amount"))
            {
            }
            column(Loans__Approved_Amount_Caption;FIELDCAPTION("Approved Amount"))
            {
            }
            column(Loans__Loan_Status_Caption;FIELDCAPTION("Loan Status"))
            {
            }
            column(Outstanding_LoanCaption;Outstanding_LoanCaptionLbl)
            {
            }
            column(PeriodCaption;PeriodCaptionLbl)
            {
            }
            column(Loans__Application_Date_Caption;FIELDCAPTION("Application Date"))
            {
            }
            column(Approved_DateCaption;Approved_DateCaptionLbl)
            {
            }
            column(Loans__Oustanding_Interest_Caption;FIELDCAPTION("Outstanding Interest"))
            {
            }
            column(Loan_TypeCaption_Control1102760043;Loan_TypeCaption_Control1102760043Lbl)
            {
            }
            column(Loans__Last_Pay_Date_Caption;FIELDCAPTION("Last Pay Date"))
            {
            }
            column(Loans__Top_Up_Amount_Caption;FIELDCAPTION("Top Up Amount"))
            {
            }
            column(Verified_By__________________________________________________Caption;Verified_By__________________________________________________CaptionLbl)
            {
            }
            column(Confirmed_By__________________________________________________Caption;Confirmed_By__________________________________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption;Sign________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption_Control1102755003;Sign________________________Caption_Control1102755003Lbl)
            {
            }
            column(Date________________________Caption;Date________________________CaptionLbl)
            {
            }
            column(Date________________________Caption_Control1102755005;Date________________________Caption_Control1102755005Lbl)
            {
            }
            column(Lbal;LBalance)
            {
            }
            column(StartDate;StartDate)
            {
            }
            column(EndDate;EndDate)
            {
            }
            column(AmountReceived;AmountReceived)
            {
            }
            column(AmountExpected;AmountExpected)
            {
            }
            column(MonthsInArrears;MonthsInArrears)
            {
            }
            column(companyPicture; CompanyInfo.Picture)
            {}
            column(CompanyName; CompanyInfo.Name)
            {}
            column(CompanyAddress2; CompanyInfo."Address 2")
            {}
            column(CompanyAddress; CompanyInfo.Address)
            {}
            column(CompanyPhoneNo;CompanyInfo."Phone No.")
            {}
            column(CompanyEmail; CompanyInfo."E-Mail")
            {}

            trigger OnAfterGetRecord()
            var
                RSch: Record "Loan Repayment Schedule";
            begin
                LBalance:=0;AmountExpected:=0;AmountReceived:=0;
                /*
                MonthsInArrears := 0;
                CustLedger.RESET;
                CustLedger.SETRANGE(CustLedger."Loan No",Loans."Loan  No.");
                CustLedger.SETFILTER(CustLedger."Transaction Type",'%1|%2',CustLedger."Transaction Type"::Repayment,CustLedger."Transaction Type"::"Interest Paid");
                CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,EndDate);
                CustLedger.SETRANGE(CustLedger.Reversed,FALSE);
                IF CustLedger.FIND('-') THEN
                REPEAT
                  AmountReceived += ABS(CustLedger.Amount);
                
                UNTIL CustLedger.NEXT=0;
                
                RSch.RESET;
                RSch.SETRANGE(RSch."Loan No.",Loans."Loan  No.");
                RSch.SETRANGE(RSch."Repayment Date",StartDate,EndDate);
                RSch.SETRANGE(RSch."Close Schedule",FALSE);
                IF RSch.FINDFIRST THEN
                   AmountExpected := RSch."Monthly Repayment";
                
                IF AmountExpected=0 THEN
                  AmountExpected := Loans.Repayment;*/
                
                CompanyCode:='';
                IF cust.GET(Loans."Client Code") THEN
                CompanyCode:=cust."Employer Code";
                
                LCount:=LCount+1;

            end;

            trigger OnPreDataItem()
            begin
                IF LoanProdType.GET(Loans.GETFILTER(Loans."Loan Product Type")) THEN
                LoanType:=LoanProdType."Product Description";
                LCount:=0;
                
                IF Loans.GETFILTER(Loans."Branch Code") <> '' THEN BEGIN
                DValue.RESET;
                DValue.SETRANGE(DValue."Global Dimension No.",2);
                DValue.SETRANGE(DValue.Code,Loans.GETFILTER(Loans."Branch Code"));
                IF DValue.FIND('-') THEN
                RFilters:='Branch: ' + DValue.Name;
                
                END;
                
                RFilters := Loans.GETFILTERS;
                
                /*IF (StartDate=0D) OR (EndDate=0D) THEN
                  ERROR('Start date and end date must have a value');*/
                
                //Datefilter:=Loans.GETRANGEMAX(Loans."Date filter");
                //Loans.SETRANGE(Loans."Date filter",0D,Datefilter);
                //Loans.SETFILTER(Loans."Date filter",'..%1',EndDate);
                //Loans.SETRANGE(Loans."Issued Date",StartDate,EndDate);

            end;
        }
    }
    requestpage
    {
        
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(CurrentDate;CurrentDate)
                    {
                    ApplicationArea = All;
                    }
                }
            }
        }
    }
    trigger OnPreReport();															
            begin															
                CompanyInfo.Get();															
                CompanyInfo.CalcFields(CompanyInfo.Picture);


                if CurrentDate = 0D then
                    CurrentDate := Today;
                DateSFilter := '..' + format(CurrentDate);														
            end;

      var
        CompanyInfo: Record "Company Information";
        CurrentDate: Date;
        DatesFilter: Text[30]; 
        RPeriod: Decimal;
        BatchL: Code[100];
        Batches: Record "Loans Disbursement Buffer"; //loan disbursement-batching
        ApprovalSetup: Record "Approvals Set Up";
        LocationFilter: Code[20];
        TotalApproved: Decimal;
        cust: Record "Members Register";
        BOSABal: Decimal;
        SuperBal: Decimal;
        LAppl: Record "Loans Register";
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LoanProdType: Record "Loan Products Setup";
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record "Dimension Value";
        VALREPAY: Record "Member Ledger Entry";
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
        CustLedger: Record "Member Ledger Entry";
        DateFilterr: Date;
        LBalance: Decimal;
        StartDate: Date;
        EndDate: Date;
        AmountReceived: Decimal;
        AmountExpected: Decimal;
        MonthsInArrears: Integer;
}




