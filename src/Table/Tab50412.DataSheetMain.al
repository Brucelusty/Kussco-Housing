table 50412 "Data Sheet Main"
{

    fields
    {
        field(1;"PF/Staff No";Code[30])
        {
        }
        field(2;Name;Code[50])
        {
        }
        field(3;"ID NO.";Code[50])
        {
        }
        field(4;"Type of Deduction";Code[50])
        {
        }
        field(5;"Amount ON";Decimal)
        {

            trigger OnValidate()
            begin
                Cust.RESET;
                Cust.SETCURRENTKEY(Cust."Payroll No");
                Cust.SETRANGE(Cust."Payroll No","PF/Staff No");
                Cust.SETRANGE(Cust."ID No.","ID NO.");
                IF Cust.FIND('-') THEN BEGIN
                Name:=Cust.Name;
                "ID NO.":=Cust."ID No.";
                "REF.":='2026';
                Employer:=Cust."Employer Code";
                Date2:=TODAY+30;
                Date:=TODAY;
                "Repayment Method":=Cust."Repayment Method";
                "Payroll Month":=FORMAT(DATE2DMY(Date2,2))+'/'+FORMAT(DATE2DMY(Date2,3));
                END;
                
                PTEN:='';
                
                IF STRLEN("PF/Staff No")=10 THEN BEGIN
                PTEN:=COPYSTR("PF/Staff No",10);
                END ELSE IF STRLEN("PF/Staff No")=9 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",9);
                END ELSE IF STRLEN("PF/Staff No")=8 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",8);
                END ELSE IF STRLEN("PF/Staff No")=7 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",7);
                END ELSE IF STRLEN("PF/Staff No")=6 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",6);
                END ELSE IF STRLEN("PF/Staff No")=5 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",5);
                END ELSE IF STRLEN("PF/Staff No")=4 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",4);
                END ELSE IF STRLEN("PF/Staff No")=3 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",3);
                END ELSE IF STRLEN("PF/Staff No")=2 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",2);
                END ELSE IF STRLEN("PF/Staff No")=1 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",1);
                 END;
                
                "Sort Code":=PTEN;
                
                
                /*IF LoanTypes.GET(LoanTopUp."Loan Type") THEN BEGIN
                IF customer.GET(LoanTopUp."Client Code") THEN BEGIN
                //Loans."Staff No":=customer."Payroll/Staff No";
                DataSheet.INIT;
                DataSheet."PF/Staff No":=LoanTopUp."Staff No";
                DataSheet."Type of Deduction":=LoanTypes."Product Description";
                DataSheet."Remark/LoanNO":=LoanTopUp."Loan Top Up";
                DataSheet.Name:=LoanApps."Client Name";
                DataSheet."ID NO.":=LoanApps."ID NO";
                DataSheet."Amount ON":=0;
                DataSheet."Amount OFF":=LoanTopUp."Total Top Up";
                DataSheet."REF.":='2026';
                DataSheet."New Balance":=0;
                DataSheet.Date:=Loans."Issued Date";
                DataSheet.Employer:=customer."Employer Code";
                DataSheet."Transaction Type":=DataSheet."Transaction Type"::ADJUSTMENT;
                DataSheet."Sort Code":=PTEN;
                DataSheet.INSERT;
                END;
                END; */

            end;
        }
        field(6;"Amount OFF";Decimal)
        {

            trigger OnValidate()
            begin
                Cust.RESET;
                Cust.SETCURRENTKEY(Cust."Payroll No");
                Cust.SETRANGE(Cust."Payroll No","PF/Staff No");
                Cust.SETRANGE(Cust."ID No.","ID NO.");
                IF Cust.FIND('-') THEN BEGIN
                Name:=Cust.Name;
                "ID NO.":=Cust."ID No.";
                "REF.":='2026';
                Employer:=Cust."Employer Code";
                Date2:=TODAY+30;
                Date:=TODAY;
                "Payroll Month":=FORMAT(DATE2DMY(Date2,2))+'/'+FORMAT(DATE2DMY(Date2,3));
                END;

                PTEN:='';

                IF STRLEN("PF/Staff No")=10 THEN BEGIN
                PTEN:=COPYSTR("PF/Staff No",10);
                END ELSE IF STRLEN("PF/Staff No")=9 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",9);
                END ELSE IF STRLEN("PF/Staff No")=8 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",8);
                END ELSE IF STRLEN("PF/Staff No")=7 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",7);
                END ELSE IF STRLEN("PF/Staff No")=6 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",6);
                END ELSE IF STRLEN("PF/Staff No")=5 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",5);
                END ELSE IF STRLEN("PF/Staff No")=4 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",4);
                END ELSE IF STRLEN("PF/Staff No")=3 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",3);
                END ELSE IF STRLEN("PF/Staff No")=2 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",2);
                END ELSE IF STRLEN("PF/Staff No")=1 THEN BEGIN
                 PTEN:=COPYSTR("PF/Staff No",1);
                 END;

                "Sort Code":=PTEN;
            end;
        }
        field(7;"New Balance";Decimal)
        {
        }
        field(8;"REF.";Code[10])
        {
        }
        field(9;"Remark/LoanNO";Text[50])
        {
            TableRelation = "Loans Register"."Loan  No." WHERE ("ID NO"=FIELD("ID NO."));
            ValidateTableRelation = false;
        }
        field(10;"Sort Code";Code[2])
        {
        }
        field(11;Employer;Text[50])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(12;"Transaction Type";Option)
        {
            OptionCaption = 'EFFECT,VARIATION,ADJUSTMENT,CEASE,OFFSET';
            OptionMembers = EFFECT,VARIATION,"ADJUSTMENT",CEASE,OFFSET;
            //ValuesAllowed = EFFECT,VARIATION,CEASE;

            trigger OnValidate()
            begin
                IF "Transaction Type"="Transaction Type"::VARIATION THEN BEGIN
                 Source:=Source::BOSA;
                END;
            end;
        }
        field(13;Date;Date)
        {

            trigger OnValidate()
            begin
                 // Month:=CALCDATE('CM',Date);
                Month:= DATE2DMY(Date,2);
                //MESSAGE('the current month is %1',Month);
                IF Month=1 THEN
                "Payroll Month":='January'
                ELSE IF Month=2 THEN
                "Payroll Month":='FEBRUARY'
                ELSE IF Month=3 THEN
                "Payroll Month":='MARCH'
                ELSE IF Month=4 THEN
                "Payroll Month":='APRIL'
                ELSE IF Month=5 THEN
                "Payroll Month":='MAY'
                ELSE IF Month=6 THEN
                "Payroll Month":='JUNE'
                ELSE IF Month=7 THEN
                "Payroll Month":='JULY'
                ELSE IF Month=8 THEN
                "Payroll Month":='AUGUST'
                ELSE IF Month=9 THEN
                "Payroll Month":='SEPTEMBER'
                ELSE IF Month=10 THEN
                "Payroll Month":='OCTOBER'
                ELSE IF Month=11 THEN
                "Payroll Month":='NOVEMBER'
                ELSE IF Month=12 THEN
                "Payroll Month":='DECEMBER';
            end;
        }
        field(14;"Payroll Month";Code[30])
        {

            trigger OnValidate()
            begin
                 // Month:=CALCDATE('CM',Date);
                  //MESSAGE('the current month is %1',Month);
            end;
        }
        field(15;"Interest Amount";Decimal)
        {
        }
        field(16;"Approved Amount";Decimal)
        {
        }
        field(17;"Uploaded Interest";Decimal)
        {
        }
        field(18;"Batch No.";Code[50])
        {
        }
        field(19;"Principal Amount";Decimal)
        {
        }
        field(20;UploadInt;Decimal)
        {
           // CalcFormula = Sum("Loan Interest Variance ScheduX"."Monthly Interest" WHERE ("Loan No."=FIELD("Remark/LoanNO")));
            //FieldClass = FlowField;
        }
        field(21;Source;Option)
        {
            OptionCaption = 'BOSA,FOSA';
            OptionMembers = BOSA,FOSA;
        }
        field(22;"Code";Code[50])
        {
        }
        field(23;"Shares OFF";Decimal)
        {
        }
        field(24;"Adjustment Type";Option)
        {
            OptionCaption = ' ,Additional Loan,BELA Loan,Benevolent Fund,Defaulters Loan,Emergency Loan,Entrance Fee,Jitegemee Loan,Normal Loan,School Fee Loan,Shares,Lariba loan,Chipukizi Loan';
            OptionMembers = " ","Additional Loan","BELA Loan","Benevolent Fund","Defaulters Loan","Emergency Loan","Entrance Fee","Jitegemee Loan","Normal Loan","School Fee Loan",Shares,"Lariba loan","Chipukizi Loan";

            trigger OnValidate()
            begin
                /*
                IF "Adjustment Type"="Adjustment Type"::" " THEN BEGIN
                
                END ELSE IF "Adjustment Type"="Adjustment Type"::"Additional Loan" THEN BEGIN
                "Type of Deduction":='ADDITIONAL LOAN';
                END ELSE IF "Adjustment Type"="Adjustment Type"::"BELA Loan" THEN BEGIN
                "Type of Deduction":='BELA LOAN';
                END ELSE IF "Adjustment Type"="Adjustment Type"::"Benevolent Fund" THEN BEGIN
                "Type of Deduction":='Benevolent Fund';
                END ELSE IF "Adjustment Type"="Adjustment Type"::"Defaulters Loan" THEN BEGIN
                 "Type of Deduction":='Defaulters Loan';
                END ELSE IF "Adjustment Type"="Adjustment Type"::"Emergency Loan" THEN BEGIN
                "Type of Deduction":='Emergency Loan';
                END ELSE IF "Adjustment Type"="Adjustment Type"::"Entrance Fee" THEN BEGIN
                "Type of Deduction":='Entrance Fee';
                END ELSE IF "Adjustment Type"="Adjustment Type"::"Jitegemee Loan" THEN BEGIN
                "Type of Deduction":='Jitegemee Loan';
                END ELSE IF "Adjustment Type"="Adjustment Type"::"Normal Loan" THEN BEGIN
                 "Type of Deduction":='Normal Loan';
                 END ELSE IF "Adjustment Type"="Adjustment Type"::"School Fee Loan" THEN BEGIN
                "Type of Deduction":='School Fee Loan';
                 END ELSE IF "Adjustment Type"="Adjustment Type"::Shares THEN BEGIN
                "Type of Deduction":='shares';
                 END ELSE IF "Adjustment Type"="Adjustment Type"::"Lariba loan" THEN BEGIN
                "Type of Deduction":='Lariba Loan';
                 END ELSE IF "Adjustment Type"="Adjustment Type"::"Chipukizi Loan" THEN BEGIN
                "Type of Deduction":='Chipukizi Loan';
                
                
                END;*/

            end;
        }
        field(25;Period;Integer)
        {
        }
        field(26;"aMOUNT ON 1";Decimal)
        {
        }
        field(27;"Vote Code";Code[10])
        {
        }
        field(28;EDCode;Code[10])
        {
        }
        field(29;"Current Balance";Decimal)
        {
        }
        field(30;TranType;Decimal)
        {
        }
        field(31;TranName;Text[50])
        {
        }
        field(32;"Action";Option)
        {
            OptionCaption = 'Existing Loan,New Loan';
            OptionMembers = "Existing Loan","New Loan";
        }
        field(33;"Interest Fee";Option)
        {
            OptionCaption = 'Interest,Interest Free';
            OptionMembers = Interest,"Interest Free";
        }
        field(34;Recoveries;Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE ("Loan No"=FIELD("Remark/LoanNO"),
                                                                  "Transaction Type"=FILTER(Repayment),
                                                                  "Posting Date"=FIELD(Date)));
            FieldClass = FlowField;
        }
        field(35;"Date Filter";Date)
        {
        }
        field(36;"Interest Off";Decimal)
        {
        }
        field(69023;"Repayment Method";Option)
        {
           OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(69024;"Entry No";Integer)
        {
            AutoIncrement = true;
        }
        field(69025;Installments;Code[50])
        {
        }
        field(69026;Ceased;Boolean)
        {
        }
        field(69027;"Pck Principle Amount";Decimal)
        {
        }
        field(69028;"Emp Loan Code";Code[20])
        {
        }
        field(69029;"Advice Option";Option)
        {
            OptionCaption = ' ,Amount,Balance';
            OptionMembers = " ",Amount,Balance;
        }
        field(69030;"Entry Number";Integer)
        {
        }
        field(69031;"Outstanding Interest";Decimal)
        {
        }
        field(69032;"Outstanding balance";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"PF/Staff No","Type of Deduction","Remark/LoanNO",Date,"ID NO.","Entry No")
        {
            SumIndexFields = "Amount ON";
        }
        key(Key2;"Sort Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Month: Integer;
       // StatusPermissions: Record "51516310";
        Cust: Record customer;
        PTEN: Code[20];
        Date2: Date;

    procedure GetContributionDeductionCode(TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard",Lukenya,Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","Loan Due","FOSA Shares","Loan Form Fee","PassBook Fee","Normal shares","SchFee Shares","Principle Unallocated","Interest Unallocated";ProductCode: Code[20];EmployerCode: Code[20];"Amnt/Bal": Option " ","Advice Amount",Balance): Code[20]
    var
        //AdvProduct: Record "CheckoffAdvice Product Codes";
    begin
/*         AdvProduct.RESET;
        IF ProductCode<>'' THEN
          AdvProduct.SETRANGE("Product Code",ProductCode);
        IF TransactionType<>TransactionType::" " THEN
          AdvProduct.SETRANGE("Transaction Type",TransactionType);
        IF EmployerCode<>'' THEN
          AdvProduct.SETRANGE("Employer Code",EmployerCode);
        IF "Amnt/Bal"<>"Amnt/Bal"::" " THEN
          AdvProduct.SETRANGE("Monthly Ded or RunningBalance","Amnt/Bal");
        IF AdvProduct.FINDFIRST THEN
          EXIT(AdvProduct."CheckoffAdvise Code"); */
    end;
}

