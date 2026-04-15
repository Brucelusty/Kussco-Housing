report 50709 "Interest On Savings"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Interest On Savings.rdlc';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = Status, "No.", "Account Type";
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
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CDiv; CDiv)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer__Current_Shares_Caption; FIELDCAPTION("Current Shares"))
            {
            }
            column(StaffNo_Customer; "Personal No.")
            {
            }
            column(Balance_Customer; Balance)
            {
            }
            column(AccountType_Customer; "Account Type")
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF AccountTypes.GET(Vendor."Account Type") THEN BEGIN
                    IF AccountTypes."Earns Interest" THEN BEGIN
                        Vendor."Deposits Interest Amount" := 0;


                        // Endyear:=CALCDATE('+1Y',StartDate);
                        // Cust.RESET;
                        // Cust.SETRANGE(Cust."No.",Customer."No.");
                        // Cust.SETFILTER(Cust."Date Filter",'..%1',Endyear);
                        // IF Cust.FIND('-') THEN BEGIN
                        // Cust.CALCFIELDS(Cust.Balance);
                        // IF Cust.Balance <> 0 THEN BEGIN

                        IF StartDate = 0D THEN
                            ERROR('You must specify start Date.');

                        DivTotal := 0;
                        GenSetUp.GET();
                        VendLedge.RESET;
                        VendLedge.SETRANGE(VendLedge."Vendor No.", Vendor."No.");
                        VendLedge.SETFILTER(VendLedge."Posting Date", '..%1', StartDate);
                        IF VendLedge.FINDSET THEN BEGIN
                            VendLedge.CALCSUMS(VendLedge.Amount);
                            AccountBalance := 0;
                            AccountBalance := -VendLedge.Amount;
                        END;
                        IF AccountBalance < 0 THEN
                            AccountBalance := AccountBalance * -1;
                        //MESSAGE('Balance%1',AccountBalance);
                        IF AccountBalance > AccountTypes."Interest Calc Min Balance" THEN BEGIN

                            //1
                            //EVALUATE(BDate,'01/01/05');
                            FromDate := CALCDATE('-CM', StartDate);//StartDate;
                                                                   //ToDate:=CALCDATE('-1D',CALCDATE('1M',StartDate));
                            ToDate := CALCDATE('CM', StartDate);
                            EVALUATE(FromDateS, FORMAT(FromDate));
                            EVALUATE(ToDateS, FORMAT(ToDate));

                            DateFilter := FromDateS + '..' + ToDateS;
                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.", Vendor."No.");
                            Cust.SETFILTER(Cust."Date Filter", DateFilter);
                            //Cust.SETFILTER(Cust."Account Type",'MDOSI JUNIOR');
                            IF Cust.FIND('-') THEN BEGIN
                                Cust.CALCFIELDS(Cust.Balance);
                                IF Cust.Balance <> 0 THEN BEGIN
                                    CDiv := 0;
                                    CDiv := (((AccountTypes."Interest Rate" / 12) / 100) * ((Cust.Balance)));
                                    DivTotal := CDiv;

                                    IF CDiv > 0 THEN BEGIN
                                        DivProg.INIT;
                                        DivProg."Member No" := Vendor."No.";
                                        DivProg.Date := ToDate;
                                        DivProg."Gross Interest" := CDiv;
                                        DivProg."PF No" := Cust."Personal No.";
                                        DivProg."Member Name" := Cust.Name;
                                        DivProg."Account Type" := Cust."Account Type";
                                        //DivProg."Witholding Tax":=CDiv*(GenSetUp."Withholding Tax (%)"/100);
                                        //DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                                        //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained")*-1)*(12/12);
                                        //DivProg."Qualifying Shares":=((Cust.Balance)*-1)*(12/12);
                                        DivProg."FOSA Balance" := ((Cust.Balance));
                                        //DivProg.de:="Deposit Type"::Deposits;
                                        DivProg.Year := FORMAT(DATE2DMY(StartDate, 3));
                                        DivProg.INSERT;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
                IF CDiv = 0 THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");

                //Cust.RESET;
                //Cust.MODIFYALL(Cust."Dividend Amount",0);
                //Cust.MODIFYALL(Cust."Deposits Interest Amount",0);
                //Cust.MODIFYALL(Cust."ESS Interest Amount",0);


                DivProg.RESET;
                //DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                    DivProg.DELETEALL;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record 23;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        CDeposits: Decimal;
        CustDiv: Record "Membership Applications";
        DivProg: Record "Interest On Savings Prog";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record "Membership Applications";
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Endyear: Date;
        "Deposit Type": Option ,"Jibambe Savings","Mdosi Junior","Pension Akiba","FOSA Savings";
        AccountTypes: Record "Account Types-Saving Products";
        VendLedge: Record 380;
        AccountBalance: Decimal;
}




