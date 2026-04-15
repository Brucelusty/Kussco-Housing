report 50695 "Salary Loans Recovery Analysis"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Salary Loans Recovery Analysis.rdlc';

    dataset
    {
        dataitem("Vendor Ledger Entry";"Vendor Ledger Entry")
        {
            RequestFilterFields = "Vendor No.";
            column(Company_Name;CompanyInformation.Name)
            {
            }
            column(CompanyPic;CompanyInformation.Picture)
            {
            }
            column(Description;Desc)
            {
            }
            column(Description_VendorLedgerEntry;"Vendor Ledger Entry".Description)
            {
            }
            column(Amount_VendorLedgerEntry;"Vendor Ledger Entry".Amount)
            {
            }
            column(Doc;Docno)
            {
            }
            dataitem(Loans;"Loans Register")
            {
                DataItemLink = "Account No"=FIELD("Vendor No.");
                DataItemTableView = SORTING("Staff No")
                                    ORDER(Ascending)
                                    WHERE("Recovery Mode"=FILTER(Salary|Pension|"Standing Order"));
                RequestFilterFields = "Client Code","Recovery Mode";
                column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
                {
                }
                column(COMPANYNAME;COMPANYNAME)
                {
                }
                column(USERID;USERID)
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
                column(Loans_Loans__Outstanding_Balance_;"Outstanding Balance")
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
                column(Loans_Loans__Loan_Product_Type_;"Loan Product Type")
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
                column(Loans_Loans__Outstanding_Balance__Control1102760040;"Outstanding Balance")
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
                column(prinrec;prinrec)
                {
                }
                column(intrec;Intrec)
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
                column(Expected;"Expected Amount")
                {
                }
                column(Recovered;"Recovered Amount")
                {
                }
                column(Docno;Docno)
                {
                }
                column(ExpectedInterest;ExpectedInterest)
                {
                }
                column(InterestVariance;InterestVariance)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Document No.",Docno);
                    IF CustLedger.FINDLAST THEN BEGIN
                      pdate:=CALCDATE('2D',CustLedger."Posting Date");
                    
                      END;
                    IF Loans."Issued Date">pdate THEN CurrReport.SKIP;
                    //Datefilter:=Loans.GETRANGEMAX(Loans."Date filter");
                    LBalance:=0;
                    
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Loan No",Loans."Loan  No.");
                    //CustLedger.SETRANGE(CustLedger."Transaction Type",CustLedger."Transaction Type"::"Interest Due");
                    CustLedger.SETRANGE(CustLedger."Posting Date",0D,DateFilterr);
                    //CustLedger.SETRANGE(CustLedger.Open,TRUE);
                    IF CustLedger.FIND('-') THEN BEGIN
                    REPEAT
                    
                    IF (CustLedger."Transaction Type"=CustLedger."Transaction Type"::Loan) OR
                    (CustLedger."Transaction Type"=CustLedger."Transaction Type"::Repayment) THEN BEGIN
                    
                    LBalance:=LBalance+CustLedger.Amount;
                    
                    END;
                    UNTIL
                    CustLedger.NEXT=0;
                    END;
                     ///MESSAGE('here  ne %1',pdate);
                    /*
                    BOSABal:=0;
                    SuperBal:=0;
                    Deposits:=0;
                    LCount:=LCount+1;
                    CompanyCode:='';
                    
                    LocationFilter:='';
                    RPeriod:=Loans.Installments;
                    IF (Loans."Outstanding Balance" > 0) AND (Loans.Repayment > 0) THEN
                    RPeriod:=Loans."Outstanding Balance"/Loans.Repayment;
                    
                    BatchL:='';
                    IF Batches.GET(Loans."Batch No.") THEN BEGIN
                    Batches.CALCFIELDS(Batches."Currect Location");
                    BatchL:=Batches."Currect Location";
                    END;
                    
                    IF Loans.GETFILTER(Loans."Location Filter") <> '' THEN  BEGIN
                    ApprovalSetup.RESET;
                    ApprovalSetup.SETRANGE(ApprovalSetup."Approval Type",ApprovalSetup."Approval Type"::"File Movement");
                    ApprovalSetup.SETFILTER(ApprovalSetup.Stage,Loans.GETFILTER(Loans."Location Filter"));
                    IF ApprovalSetup.FIND('-') THEN
                    LocationFilter:=ApprovalSetup.Station;
                    END;
                    
                    IF LocationFilter = '' THEN
                    TotalApproved:=TotalApproved+Loans."Approved Amount"
                    ELSE BEGIN
                    IF LocationFilter = BatchL THEN
                    TotalApproved:=TotalApproved+Loans."Approved Amount"
                    END;
                    
                    //Get balance of BOSA Loans + super loans
                    IF (Loans.Source=Loans.Source::BOSA) OR (Loans."Loan Product Type"='SUPER') THEN BEGIN
                    cust.RESET;
                    cust.SETRANGE(cust."No.",Loans."Client Code");
                    cust.SETRANGE(cust."Customer Type",cust."Customer Type"::Member);
                    IF cust.FIND('-') THEN BEGIN
                    cust.CALCFIELDS(cust."Outstanding Balance",cust."Current Shares");
                    BOSABal:=cust."Outstanding Balance";
                    Deposits:=ABS(cust."Current Shares");
                    CompanyCode:=cust."Employer Code";
                    END ELSE BEGIN
                    cust.RESET;
                    cust.SETRANGE(cust."No.",Loans."BOSA No");
                    cust.SETRANGE(cust."Customer Type",cust."Customer Type"::Member);
                    
                    IF cust.FIND('-') THEN BEGIN
                    cust.CALCFIELDS(cust."Outstanding Balance",cust."Current Shares");
                    BOSABal:=cust."Outstanding Balance";
                    Deposits:=ABS(cust."Current Shares");
                    CompanyCode:=cust."Employer Code";
                    
                    END;
                    END;
                    LAppl.RESET;
                    LAppl.SETRANGE(LAppl."Client Code",Loans."Account No");
                    LAppl.SETRANGE(LAppl."Loan Product Type",'SUPER');
                    LAppl.SETFILTER(LAppl."Outstanding Balance",'>0');
                    LAppl.SETRANGE(LAppl.Posted,TRUE);
                    IF LAppl.FIND('-') THEN BEGIN
                    REPEAT
                    LAppl.CALCFIELDS(LAppl."Outstanding Balance");
                    SuperBal:=SuperBal+LAppl."Outstanding Balance";
                    UNTIL LAppl.NEXT=0;
                    END;
                    END;
                    
                    //Loans."Net Amount":=Loans."Approved Amount"-Loans."Top Up Amount";
                    
                    //Get The Loan Type
                    */
                    
                    CompanyCode:='';
                    IF cust.GET(Loans."Client Code") THEN
                    CompanyCode:=cust."Employer Code";
                    
                    LCount:=LCount+1;
                    
                    Loans.CALCFIELDS(Loans."Outstanding Balance");
                    IF Loans."Outstanding Balance"<=0 THEN CurrReport.SKIP;
                    
                    "Expected Amount":=0;
                    "Recovered Amount":=0;
                    
                    
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Loan No",Loans."Loan  No.");
                    CustLedger.SETRANGE(CustLedger."Document No.",Docno);
                    CustLedger.SETFILTER(CustLedger."Transaction Type",'%1|%2',CustLedger."Transaction Type"::Repayment,CustLedger."Transaction Type"::"Interest Paid");
                    IF CustLedger.FINDSET THEN BEGIN
                    REPEAT
                    "Recovered Amount":="Recovered Amount"+CustLedger.Amount;
                    
                    UNTIL CustLedger.NEXT=0;
                    END;
                    //prin
                    IF Loans."Outstanding Balance"<=0 THEN CurrReport.SKIP;
                    
                    "Expected Amount":=0;
                    prinrec:=0;
                    Intrec:=0;
                    
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Loan No",Loans."Loan  No.");
                    CustLedger.SETRANGE(CustLedger."Document No.",Docno);
                    CustLedger.SETFILTER(CustLedger."Transaction Type",'%1',CustLedger."Transaction Type"::Repayment);
                    IF CustLedger.FINDSET THEN BEGIN
                    REPEAT
                    prinrec:=prinrec+(CustLedger.Amount*-1);
                    
                    UNTIL CustLedger.NEXT=0;
                    END;
                    //int
                    //prin
                    IF Loans."Outstanding Balance"<=0 THEN CurrReport.SKIP;
                    
                    "Expected Amount":=0;
                    Intrec:=0;
                    
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Loan No",Loans."Loan  No.");
                    CustLedger.SETRANGE(CustLedger."Document No.",Docno);
                    CustLedger.SETFILTER(CustLedger."Transaction Type",'%1',CustLedger."Transaction Type"::"Interest Paid");
                    IF CustLedger.FINDSET THEN BEGIN
                    REPEAT
                    Intrec:=Intrec+(CustLedger.Amount*-1);
                    
                    UNTIL CustLedger.NEXT=0;
                    END;
                    //MESSAGE('%1',pdate);
                    Datefiltertext:='..'+FORMAT(pdate);
                    ExpectedInterest := 0;
                    LoanRepaymentSchedule.RESET;
                    LoanRepaymentSchedule.SETFILTER(LoanRepaymentSchedule."Repayment Date",'<=%1',pdate);
                    LoanRepaymentSchedule.SETRANGE(LoanRepaymentSchedule."Loan No.",Loans."Loan  No.");
                    IF LoanRepaymentSchedule.FINDLAST THEN BEGIN
                    //MESSAGE('%1|%2|%3',"Expected Amount",LoanRepaymentSchedule."Loan No.",pdate);
                       "Expected Amount":=LoanRepaymentSchedule."Monthly Repayment";
                       ExpectedInterest:=LoanRepaymentSchedule."Monthly Interest";
                    
                    END;
                    InterestVariance := ExpectedInterest - Intrec;
                    IF (Loans."Issued Date"< pdate) AND (Loans."Recovery Mode"= Loans."Recovery Mode"::Salary) THEN BEGIN
                    IF ("Expected Amount" =0) AND (ExpectedInterest=0) THEN
                    LoanRepaymentSchedule.RESET;
                    //LoanRepaymentSchedule.SETFILTER(LoanRepaymentSchedule."Repayment Date",'<=%1',pdate);
                    LoanRepaymentSchedule.SETRANGE(LoanRepaymentSchedule."Loan No.",Loans."Loan  No.");
                    IF LoanRepaymentSchedule.FINDFIRST THEN BEGIN
                       "Expected Amount":=LoanRepaymentSchedule."Monthly Repayment";
                       ExpectedInterest:=LoanRepaymentSchedule."Monthly Interest";
                    
                    END
                    END;

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



                    //Datefilter:=Loans.GETRANGEMAX(Loans."Date filter");
                    //Loans.SETRANGE(Loans."Date filter",0D,Datefilter);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //"Vendor Ledger Entry".SETFILTER("Vendor Ledger Entry"."Posting Date",'%1..%2',"Salary Date","Salary Date2");
                "Vendor Ledger Entry".SETRANGE("Vendor Ledger Entry"."Document No.",Docno);
                "Vendor Ledger Entry".SETRANGE("Vendor Ledger Entry".Description,'Salary');
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;CompanyInformation.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Docno;Docno)
                {
                    Caption = 'Document No';
                    ApplicationArea = All;
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
        RPeriod: Decimal;
        BatchL: Code[100];
        Batches: Record "Loan Disburesment-Batching";
        ApprovalSetup: Record "Approvals Set Up";
        Datefiltertext: Text;
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
        Docno: Code[100];
        Desc: Text;
        Docno2: Code[100];
        Desc2: Text;
        "Expected Amount": Decimal;
        "Recovered Amount": Decimal;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        pdate: Date;
        prinrec: Decimal;
        Intrec: Decimal;
        CompanyInformation: Record "Company Information";
        ExpectedInterest: Decimal;
        InterestVariance: Decimal;
}




