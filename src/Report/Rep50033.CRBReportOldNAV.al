report 50033 "CRB Report Old NAV"
{
    ApplicationArea = All;
    // DefaultLayout = RDLC;
    // RDLCLayout = 'Layouts/CRBReport.rdlc';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            RequestFilterFields = "Client Code", "Staff No", "Outstanding Balance";

            trigger OnAfterGetRecord()
            var
                Days_In_Arrears: Integer;
                DateOverDue: Date;
            begin
                // Days_In_Arrears := Loans.GetDefaultedAmounts(1, AsAt, Loans."Loan  No.");
                IF Loans."Days In Arrears" <= 90 THEN
                    CurrReport.SKIP;


                NoDays := 0;
                CurrRep := 0;
                SchRep := 0;
                Days_In_Arrears := Loans."Days In Arrears";
                Loans.CALCFIELDS(Loans."Outstanding Balance", Loans."Outstanding Interest", Loans."Last Pay Date");
                IF Loans."Outstanding Interest" < 0 THEN Loans."Outstanding Interest" := 0;

                IF Loans."Outstanding Balance" > 0 THEN BEGIN

                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.", Loans."Client Code");
                    IF Cust.FIND('-') THEN BEGIN

                        NoLine := NoLine + 1;

                        CRBA.INIT;
                        CRBA.No := NoLine;

                        TempString := '';
                        MyString := Cust.Name;
                        TempString := ConvertStr(MyString, ' ', ',');
                        String1 := SplitNamesSurname(TempString);
                        String2 := SplitNamesFirstname(TempString);
                        String3 := SplitNamesLastname(TempString);

                        if TempString <> '' then begin
                            String1 := SelectStr(1, TempString);
                            CRBA.Surname := String3;
                            CRBA."Name 2" := String2;
                            CRBA."Name 3" := String1;
                            CRBA."Forename 1" := String2;
                            CRBA."Forename 2" := String1;
                        end;

                        IF Cust."Date of Birth" <> 0D THEN BEGIN

                            Day := FORMAT(DATE2DMY(Cust."Date of Birth", 1));
                            IF STRLEN(Day) <> 2 THEN
                                Day := '0' + Day;
                            Month := FORMAT(DATE2DMY(Cust."Date of Birth", 2));
                            IF STRLEN(Month) <> 2 THEN
                                Month := '0' + Month;
                            Year := FORMAT(DATE2DMY(Cust."Date of Birth", 3));
                            DateFor := Year + Month + Day;
                        END
                        ELSE
                            DateFor := '0';
                        CRBA."Date of Birth" := DateFor;


                        CRBA."Client Code" := Cust."No.";
                        CRBA."Account Number" := Loans."Loan  No.";
                        if cust.Gender = cust.Gender::Male then begin
                            CRBA.Gender := 'M';
                            CRBA."Customer Gender" := cust.Gender;
                        END else begin
                            CRBA.Gender := 'F';
                            CRBA."Customer Gender" := cust.Gender;
                        end;
                        CRBA.Nationality := 'KE';
                        CRBA."Marital Status" := Cust."Marital Status";
                        if Cust."Marital Status" = Cust."Marital Status"::Divorced then
                            CRBA."Marital Status 2" := 'S'
                        else
                            if Cust."Marital Status" = Cust."Marital Status"::Married then
                                CRBA."Marital Status 2" := 'M'
                            else
                                if Cust."Marital Status" = Cust."Marital Status"::Single then
                                    CRBA."Marital Status 2" := 'S'
                                else
                                    if Cust."Marital Status" = Cust."Marital Status"::Widower then
                                        CRBA."Marital Status 2" := 'S'
                                    else
                                        CRBA."Marital Status 2" := 'M';

                        CRBA."Primary Identification 1" := Cust."ID No.";
                        CRBA."Primary Identification code" := '001';
                        CRBA."Secondary Identification code" := '002';
                        CRBA."Secondary Identification 1" := Cust."Passport No.";
                        CRBA."Mobile No" := Cust."Phone No.";
                        CRBA."Work Telephone" := Cust."Office Telephone No.";
                        CRBA."Postal Address 1" := Cust.Address;
                        CRBA."Postal Address 2" := Cust."Address 2";
                        CRBA."Postal Location Town" := Cust.City;
                        IF CRBA."Postal Location Town" = '' THEN
                            CRBA."Postal Location Town" := 'NAIROBI';
                        CRBA."Postal Location Country" := 'KE';
                        CRBA."Post Code" := Cust."Post Code";
                        CRBA."Physical Address 1" := Cust."Address 2";
                        CRBA."Physical Address 2" := Cust."Home Address";
                        CRBA."Location Town" := Cust.Location;
                        IF CRBA."Location Town" = '' THEN
                            CRBA."Location Town" := 'NAIROBI';
                        CRBA."Location Country" := 'KE';
                        CRBA."Date of Physical Address" := 0D;
                        CRBA."Customer Work Email" := Cust."E-Mail";
                        CRBA."Employer Name" := Cust."Employer Code";
                        CRBA."Occupational Industry Type" := '010';
                        CRBA."Employment Type" := Format(Cust."Type Of Organisation");
                        CRBA."Income Amount" := DelChr(Format(Loans."Basic Pay H"), '=', ',') + '00';
                        if Cust."Account Category" = Cust."Account Category"::Individual then begin
                            CRBA."Account Type" := CRBA."Account Type"::Single;
                            CRBA."Joint Single Indicator" := 'S';
                        end;
                        if (Cust."Account Category" = Cust."Account Category"::Joint) or (Cust."Account Category" = Cust."Account Category"::Corporate) then begin
                            CRBA."Account Type" := CRBA."Account Type"::Joint;
                            CRBA."Joint Single Indicator" := 'J';
                        end;
                        Loans.CALCFIELDS(Loans."Schedule Repayments", Loans."Current Repayment", Loans."Last Pay Date", Loans."Loan Amount");
                        LoanSche.RESET;
                        LoanSche.SETRANGE(LoanSche."Loan No.", Loans."Loan  No.");
                        LoanSche.SETRANGE(LoanSche."Repayment Date", 0D, TODAY);
                        IF LoanSche.FIND('-') THEN BEGIN
                            LoanSche.CALCSUMS(LoanSche."Monthly Repayment");
                            InstalmentDate := CALCDATE('1M', LoanSche."Repayment Date");
                            IDate := FORMAT(DATE2DMY(InstalmentDate, 1));
                            IF STRLEN(IDate) <> 2 THEN
                                IDate := '0' + IDate;
                            Imonth := FORMAT(DATE2DMY(InstalmentDate, 2));
                            IF STRLEN(Imonth) <> 2 THEN
                                Imonth := '0' + Imonth;
                            IF Loans."Expected Date of Completion" <> 0D THEN BEGIN

                                Day := FORMAT(DATE2DMY(Loans."Expected Date of Completion", 1));
                                IF STRLEN(Day) <> 2 THEN
                                    Day := '0' + Day;
                                Month := FORMAT(DATE2DMY(Loans."Expected Date of Completion", 2));
                                IF STRLEN(Month) <> 2 THEN
                                    Month := '0' + Month;
                                Year := FORMAT(DATE2DMY(Loans."Expected Date of Completion", 3));
                                DateFor := FORMAT(Year) + '' + FORMAT(Month) + '' + FORMAT(Day);
                            END
                            ELSE
                                DateFor := '0';

                            CRBA."Installment Due Date" := DateFor;

                            IF Days_In_Arrears > 90 THEN BEGIN
                                IF Loans."Expected Date of Completion" <> 0D THEN BEGIN

                                    Day := FORMAT(DATE2DMY(Loans."Expected Date of Completion", 1));
                                    IF STRLEN(Day) <> 2 THEN
                                        Day := '0' + Day;
                                    Month := FORMAT(DATE2DMY(Loans."Expected Date of Completion", 2));
                                    IF STRLEN(Month) <> 2 THEN
                                        Month := '0' + Month;
                                    Year := FORMAT(DATE2DMY(Loans."Expected Date of Completion", 3));
                                    DateFor := FORMAT(Year) + '' + FORMAT(Month) + '' + FORMAT(Day);

                                END
                                ELSE
                                    DateFor := '0';

                                DateOverDue := CalcDate('<-' + Format(Loans."Days In Arrears") + 'D>', AsAt);
                                // Error('%1',DateOverDue);
                                //CRBA."Overdue Date":=FORMAT(DATE2DMY(InstalmentDate,3))+Imonth+IDate;
                                IDate := FORMAT(DATE2DMY(DateOverDue, 1));
                                IF STRLEN(IDate) <> 2 THEN
                                    IDate := '0' + IDate;
                                Imonth := FORMAT(DATE2DMY(DateOverDue, 2));
                                IF STRLEN(Imonth) <> 2 THEN
                                    Imonth := '0' + Imonth;
                                CRBA."Overdue Date" := FORMAT(DATE2DMY(DateOverDue, 3)) + Imonth + IDate;


                                //CRBA."Overdue Date":=DateFor;
                                CRBA."Account Status Date" := FORMAT(DATE2DMY(DateOverDue, 3)) + Imonth + IDate;
                            END;
                            IF Days_In_Arrears = 0 THEN BEGIN
                                CRBA."Account Status Date" := FORMAT(DATE2DMY(InstalmentDate, 3)) + Imonth + IDate;
                            END;
                            DFDue := CRBA."Overdue Date";
                            EVALUATE(intDay, COPYSTR(DFDue, 7, 2));
                            EVALUATE(intMonth, COPYSTR(DFDue, 5, 2));
                            EVALUATE(intYear, COPYSTR(DFDue, 1, 4));
                            DateFallDue := DMY2DATE(intDay, intMonth, intYear);

                            CRBA."No of Installment In" := ROUND((TODAY - DateFallDue) / 30, 1, '=');
                            CRBA."No of Days in Arreas" := Days_In_Arrears;
                            //(TODAY-DateFallDue);
                            //END;

                            IF (CRBA."No of Days in Arreas" > 0) AND (CRBA."No of Days in Arreas" <= 30) THEN
                                CRBA."Prudential Risk Classification" := 'A'
                            ELSE
                                IF
                           (CRBA."No of Days in Arreas" > 30) AND (CRBA."No of Days in Arreas" <= 90) THEN
                                    CRBA."Prudential Risk Classification" := 'B'
                                ELSE
                                    IF
                               (CRBA."No of Days in Arreas" > 90) AND (CRBA."No of Days in Arreas" <= 180) THEN
                                        CRBA."Prudential Risk Classification" := 'C'
                                    ELSE
                                        IF
                                   (CRBA."No of Days in Arreas" > 180) AND (CRBA."No of Days in Arreas" <= 360) THEN
                                            CRBA."Prudential Risk Classification" := 'D'
                                        ELSE
                                            CRBA."Prudential Risk Classification" := 'E';
                        END;
                    END;
                    IF CRBA."Overdue Date" <> '' THEN
                        CRBA."Overdue Balance" := DELCHR(FORMAT(ROUND((Loans."Amount in Arrears" + Loans."Penalty Charged" + Loans."Outstanding Balance"), 1, '<')) + '00', '=', ',');
                    CRBA."Deferred Payment" := DELCHR(FORMAT(ROUND((Loans."Amount in Arrears"), 1, '<')) + '00', '=', ',');
                    CRBA."Account Product Type" := 'H';


                    IF Loans."Issued Date" <> 0D THEN BEGIN

                        Day := FORMAT(DATE2DMY(Loans."Issued Date", 1));
                        IF STRLEN(Day) <> 2 THEN
                            Day := '0' + Day;
                        Month := FORMAT(DATE2DMY(Loans."Issued Date", 2));
                        IF STRLEN(Month) <> 2 THEN
                            Month := '0' + Month;
                        Year := FORMAT(DATE2DMY(Loans."Issued Date", 3));
                        DateFor := Year + Month + Day;
                    END
                    ELSE
                        DateFor := '0';
                    IF Cust.GET(Loans."Client Code") THEN BEGIN
                        Day := Format(Date2DMY(Cust."Registration Date", 1));
                        if StrLen(Day) <> 2 then begin
                            Day := '0' + Day;
                        end;
                        Month := Format(Date2DMY(Cust."Registration Date", 2));
                        if StrLen(Month) <> 2 then begin
                            Month := '0' + Month;
                        end;
                        Year := Format(Date2DMY(Cust."Registration Date", 3));

                        DateFor := Year + Month + Day;
                        CRBA."Date Account Opened" := DateFor;
                    END;
                    CRBA."Original Amount" := DELCHR(FORMAT(ROUND(Loans."Approved Amount", 1, '<')) + '00', '=', ',');
                    CRBA."Currency of Facility" := 'KES';
                    CRBA."Amount in Kenya shillings" := DELCHR(FORMAT(ROUND(Loans."Approved Amount", 1, '<')) + '00', '=', ',');
                    CRBA."Current Balance" := DELCHR(FORMAT(ROUND(Loans."Outstanding Balance" + Loans."Outstanding Interest", 1, '<')) + '00', '=', ',');
                    CRBA."Lenders Registered Name" := 'TELEPOST SACCO LTD';
                    CRBA."Lenders Trading Name" := 'TELEPOST SACCO LTD';
                    CRBA."Lenders Branch Name" := 'HEAD OFFICE';
                    CRBA."Lenders Branch Code" := 'N151001';
                    IF Loans."Days In Arrears" > 0 THEN BEGIN
                        CRBA."Performing / NPL Indicator" := 'B';
                        CRBA."Account Status" := 'F';
                    END ELSE
                        CRBA."Performing / NPL Indicator" := 'A';
                    //CRBA."Account Status Date":='0';
                    CRBA."Repayment Period" := Loans.Installments;
                    CRBA."Payment Frequency" := 'M';

                    IF Loans."Loan Disbursement Date" <> 0D THEN BEGIN

                        Day := FORMAT(DATE2DMY(Loans."Loan Disbursement Date", 1));
                        IF STRLEN(Day) <> 2 THEN
                            Day := '0' + Day;
                        Month := FORMAT(DATE2DMY(Loans."Loan Disbursement Date", 2));
                        IF STRLEN(Month) <> 2 THEN
                            Month := '0' + Month;
                        Year := FORMAT(DATE2DMY(Loans."Loan Disbursement Date", 3));
                        DateFor := FORMAT(Year) + '' + FORMAT(Month) + '' + FORMAT(Day);
                    END
                    ELSE
                        DateFor := '20240331';
                    CRBA."Disbursement Date" := DateFor;
                    CRBA."Account Opened Date" := DateFor;

                    CRBA."Insallment Amount" := DELCHR(FORMAT(ROUND(Loans.Repayment, 1, '<')) + '00', '=', ',');
                    CRBA."Next paymentamount" := (CRBA."Overdue Balance");//+CRBA."Insallment Amount");
                    IF Loans."Last Pay Date" = 0D THEN
                        Loans."Last Pay Date" := Loans."Issued Date";
                    IF Loans."Last Pay Date" <> 0D THEN BEGIN
                        Day := FORMAT(DATE2DMY(Loans."Last Pay Date", 1));
                        IF STRLEN(Day) <> 2 THEN
                            Day := '0' + Day;
                        Month := FORMAT(DATE2DMY(Loans."Last Pay Date", 2));
                        IF STRLEN(Month) <> 2 THEN
                            Month := '0' + Month;
                        Year := FORMAT(DATE2DMY(Loans."Last Pay Date", 3));
                        DateFor := FORMAT(Year) + '' + FORMAT(Month) + '' + FORMAT(Day);
                    END
                    ELSE
                        DateFor := '0';


                    CRBA."Date of Latest Payment" := DateFor;
                    CRBA."Last Payment Amount" := DELCHR(FORMAT(ROUND(Loans."Last Repayment", 1, '=') * -1) + '00', '=', ',');
                    CRBA."Type of Security" := 'U';
                    CRBA."Group ID" := '1';
                    CRBA.INSERT;
                END;
                // Cust.RESET;
                // Cust.SETRANGE(Cust."No.", Loans."Client Code");
                // IF Cust.FIND('-') THEN BEGIN
                //     Cust.Crblisting := TRUE;

                //     Cust.MODIFY;
                // END;
            end;

            trigger OnPreDataItem()
            begin
                IF AsAt = 0D THEN ERROR('As at date must have a value!');
                CRBA.DELETEALL;
                Loans.SETFILTER(Loans."Date filter", '..%1', AsAt);
                Loans.SETFILTER(Loans."Outstanding Balance", '>%1', 1000);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Date)
                {
                    field("As At"; AsAt)
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
        Cust: Record Customer;
        CRBA: Record "CRBA Datas";
        MyString: Text;
        String1: Text;
        String2: Text;
        String3: Text;
        String5: Text;
        String4: Text;
        NoDays: Integer;
        Day: Text;
        Month: Text;
        Year: Text;
        DateFor: Text;
        AsatDate: Date;
        NoLine: Integer;
        TxtKeep: Text;
        DateInput: Date;
        TempString: Text;
        LoanSche: Record "Loan Repayment Schedule";
        InstalmentDate: Date;
        IDate: Text;
        Imonth: Text;
        DisburmentDate: Text;
        Ddate: Text;
        Dmonth: Text;
        CurrRep: Decimal;
        SchRep: Decimal;
        DateFallDue: Date;
        DFDue: Text;
        intDay: Integer;
        intMonth: Integer;
        intYear: Integer;
        AsAt: Date;

    procedure SplitNamesSurname(var Names: Text[100]) RtnSurname: Text[100]
    var
        lngPos: Integer;
        lngPos2: Integer;
        Surname: Text[50];
        "Other Names": Text[50];
        "First Names": Text;
        "Last Names": Text;
    begin
        /*Get the position of the space character*/
        lngPos := StrPos(Names, ',');
        if lngPos <> 0 then begin
            Surname := CopyStr(Names, 1, lngPos - 1);
            RtnSurname := Surname;
            exit(RtnSurname);
            "Other Names" := CopyStr(Names, lngPos + 1);
            lngPos2 := StrPos("Other Names", ',');
            if lngPos2 <> 0 then begin
                "First Names" := CopyStr("Other Names", 1, lngPos2 - 1);
                "Last Names" := CopyStr("Other Names", lngPos2 + 1);
            end
            else
                exit;
        end;

    end;

    procedure SplitNamesFirstname(var Names: Text[100]) RtnSurname: Text[100]
    var
        lngPos: Integer;
        lngPos2: Integer;
        Surname: Text[50];
        "Other Names": Text[100];
        "First Names": Text[100];
        "Last Names": Text[130];
    begin
        /*Get the position of the space character*/
        lngPos := StrPos(Names, ',');
        if lngPos <> 0 then begin
            Surname := CopyStr(Names, 1, lngPos - 1);
            ;
            "Other Names" := CopyStr(Names, lngPos + 1);
            lngPos2 := StrPos("Other Names", ',');
            if lngPos2 <> 0 then begin
                "First Names" := CopyStr("Other Names", 1, lngPos2 - 1);
                "Last Names" := CopyStr("Other Names", lngPos2 + 1);
                RtnSurname := "First Names";
                exit(RtnSurname);
            end
            else begin
                ;
                RtnSurname := "Other Names";
                exit(RtnSurname);
            end;
        end;

    end;

    procedure SplitNamesLastname(var Names: Text[100]) RtnSurname: Text[100]
    var
        lngPos: Integer;
        lngPos2: Integer;
        Surname: Text[50];
        "Other Names": Text[100];
        "First Names": Text[100];
        "Last Names": Text[100];
    begin
        /*Get the position of the space character*/
        lngPos := StrPos(Names, ',');
        if lngPos <> 0 then begin
            Surname := CopyStr(Names, 1, lngPos - 1);
            ;
            "Other Names" := CopyStr(Names, lngPos + 1);
            lngPos2 := StrPos("Other Names", ',');
            if lngPos2 <> 0 then begin
                "First Names" := CopyStr("Other Names", 1, lngPos2 - 1);
                "Last Names" := CopyStr("Other Names", lngPos2 + 1);
                RtnSurname := "Last Names";
                exit(RtnSurname);
            end
            else begin
                ;
                RtnSurname := '';
                exit(RtnSurname);
            end;
        end;

    end;

    [Scope('OnPrem')]
    procedure Token(Pos: Integer)
    begin
    end;
}



