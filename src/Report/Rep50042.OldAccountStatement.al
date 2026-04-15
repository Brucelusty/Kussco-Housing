report 50042 "Old Account Statement"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Account Statement N.rdlc';
    Caption = 'Old FOSA Account Statement';

    dataset
    {
        dataitem(DataItem3182; Vendor)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Creditor Type" = CONST("FOSA Account"));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Global Dimension 2 Filter", "Date Filter";
            column(OpeningBal; OpeningBal)
            {
            }
            column(ToBal; ToBal)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(company_pic; CompanyInfo.Picture)
            {
            }
            column(STRSUBSTNO_Text000_VendDateFilter_; STRSUBSTNO(Text000, VendDateFilter))
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Vendor__Account_Type_; Vendor."Account Type")
            {
            }
            column(BOSA_Account_No; "BOSA Account No")
            {
            }
            column(Company_Code; "Employer Code")
            {
            }
            column(CompanyNamee; CompanyNamee)
            {
            }
            column(Vendor_Vendor__Staff_No_; Vendor."Personal No.")
            {
            }
            column(StartBalanceLCY__1; StartBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(VendBalanceLCY__1; VendBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY__1_Control29; StartBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___1; ("Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY____Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___1; (StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
            {
                AutoFormatType = 1;
            }
            column(Vendor__Uncleared_Cheques_; "Uncleared Cheques")
            {
            }
            column(DataItem1102760019; ((StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1) - "Uncleared Cheques" - MinBal)
            {
            }
            column(Account_StatementCaption; Account_StatementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(VendBalanceLCY__1_Control40Caption; VendBalanceLCY__1_Control40CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry_DescriptionCaption; "Vendor Ledger Entry".FIELDCAPTION(Description))
            {
            }
            column(Vendor_Ledger_Entry__Document_No__Caption; "Vendor Ledger Entry".FIELDCAPTION("Document No."))
            {
            }
            column(Vendor_Ledger_Entry__Posting_Date_Caption; "Vendor Ledger Entry".FIELDCAPTION("Posting Date"))
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Account_TypeCaption; Account_TypeCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Debit_Amount_Caption; "Vendor Ledger Entry".FIELDCAPTION("Debit Amount"))
            {
            }
            column(Vendor_Ledger_Entry__Credit_Amount_Caption; "Vendor Ledger Entry".FIELDCAPTION("Credit Amount"))
            {
            }
            column(Vendor_Ledger_Entry__External_Document_No__Caption; "Vendor Ledger Entry".FIELDCAPTION("External Document No."))
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Adj__of_Opening_BalanceCaption; Adj__of_Opening_BalanceCaptionLbl)
            {
            }
            column(Total_BalanceCaption; Total_BalanceCaptionLbl)
            {
            }
            column(Total_Balance_Before_PeriodCaption; Total_Balance_Before_PeriodCaptionLbl)
            {
            }
            column(Vendor__Uncleared_Cheques_Caption; FIELDCAPTION("Uncleared Cheques"))
            {
            }
            column(Available_BalanceCaption; Available_BalanceCaptionLbl)
            {
            }
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            column(Vendor_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Vendor_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoCity; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_EMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Home_Page; CompanyInfo."Home Page")
            {
            }
            dataitem(DataItem4114; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                               "Date Filter" = FIELD("Date Filter");
                DataItemTableView = SORTING("Vendor No.", "Posting Date");
                RequestFilterFields = "Posting Date";
                column(RunBal; RunBal)
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Vendor_Ledger_Entry_Description; Description)
                {
                }
                column(VendAmount__1; VendAmount * -1)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendBalanceLCY__1_Control40; VendBalanceLCY * -1)
                {
                    AutoFormatType = 1;
                }
                column(VendCurrencyCode; VendCurrencyCode)
                {
                }
                column(Vendor_Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Vendor_Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1_Control53; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Vendor_Ledger_Entry_Date_Filter; "Date Filter")
                {
                }
                column(TotalDebits; TotalDebits)
                {
                }
                column(TotalCredits; TotalCredits)
                {
                }
                column(Totals; Totals)
                {
                }
                column(UserID_VendorLedgerEntry; VendorLedgerEntry."User ID")
                {
                }
                dataitem(DataItem2149; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE("Entry Type" = CONST("Correction of Remaining Amount"));

                    trigger OnAfterGetRecord()
                    begin
                        Correction := Correction + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        //SETFILTER("Posting Date",'%1..%2',FromDate,ToDate);
                    end;
                }
                dataitem("Detailed Vendor Ledg. Entry2"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE("Entry Type" = CONST("Appln. Rounding"));

                    trigger OnAfterGetRecord()
                    begin
                        ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", VendDateFilter);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TotalDebits := 0;
                    TotalCredits := 0;
                    ENtryAmount := 0;
                    "Vendor Ledger Entry".CALCFIELDS("Vendor Ledger Entry".Amount);
                    ENtryAmount := "Vendor Ledger Entry".Amount * -1;
                    RunBal := RunBal + ENtryAmount;

                    CALCFIELDS(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");

                    VendLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                        VendAmount := "Amount (LCY)";
                        VendRemainAmount := "Remaining Amt. (LCY)";
                        VendCurrencyCode := '';
                    END ELSE BEGIN
                        VendAmount := Amount;
                        VendRemainAmount := "Remaining Amount";
                        VendCurrencyCode := "Currency Code";
                    END;
                    VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                        VendEntryDueDate := 0D
                    ELSE
                        VendEntryDueDate := "Due Date";
                    TotalDebits := "Vendor Ledger Entry"."Debit Amount";
                    //FinaleDebits:=FinaleDebits+TotalDebits;
                    Vendor.Reset();
                    Vendor.SetRange(Vendor."No.", "Vendor Ledger Entry"."Vendor No.");
                    if Vendor.FindFirst() then
                        //Vendor.GET("Vendor Ledger Entry"."Vendor No.");
                        Totals := Vendor."Balance (LCY)";
                    //MESSAGE('Balance is %1',Totals);
                end;

                trigger OnPreDataItem()
                begin
                    VendLedgEntryExists := FALSE;
                    //CurrReport.CREATETOTALS(VendAmount,"Amount (LCY)");
                    "Vendor Ledger Entry".SETFILTER("Vendor Ledger Entry"."Posting Date", '%1..%2', FromDate, ToDate);
                    RunBal := OpRunBal * -1;
                    //MESSAGE('Runbal%1',RunBal);
                end;
            }
            // Muia
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));

                trigger OnAfterGetRecord()
                begin
                    IF NOT VendLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                        StartBalanceLCY := 0;
                        CurrReport.SKIP;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Vendor.CatchStaff;
                //Totals:=0;
                DActivity := 'FOSA';

                IF CONFIRM('Do you want to charge the member for this statement?', FALSE) = TRUE THEN BEGIN
                    ChargeAmount := 0;
                    //IF TransactionCharges."Use Percentage" = TRUE THEN
                    //ChargeAmount:=(Amount*TransactionCharges."Percentage of Amount")*0.01
                    //ELSE  ChargeAmount:=TransactionCharges."Charge Amount";
                    //IF "Account Type"='M-pesa' THEN BEGIN
                    /*IF (Amount>=300)  AND (Amount<1000) THEN
                    ChargeAmount:=160
                    ELSE IF  (Amount>=1001) AND (Amount<2500) THEN
                    ChargeAmount:=200
                    ELSE IF (Amount>=2501) AND (Amount<5000) THEN
                    ChargeAmount:=250
                    ELSE IF (Amount>=50001) AND (Amount<100000) THEN
                    ChargeAmount:=300
                    ELSE IF (Amount>=10001) AND (Amount<200000) THEN
                    ChargeAmount:=350
                    ELSE IF Amount>200000 THEN
                    */
                    ChargeAmount := 100;
                    VendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
                    VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                    VendorLedgerEntry.SETFILTER("Posting Date", VendDateFilter);
                    IF VendorLedgerEntry.FIND('-') THEN
                        Echarge := ChargeAmount;

                    //delete
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name", 'FTRANS');
                    GenJournalLine.DELETEALL;

                    //delete
                    LineNo := LineNo + 1000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := VendorLedgerEntry."Document No.";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    //IF "Account No"='00-0000000000' THEN
                    //GenJournalLine."External Document No.":="ID No";
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := TODAY;
                    GenJournalLine.Description := 'Printing Statement charges';
                    GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                    //IF (TransactionCharges."Charge Code",'<>SD') AND (Amount > 20000)  THEN
                    //ChargeAmount:=200 ELSE
                    GenJournalLine.Amount := ChargeAmount;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                    //GenJournalLine."Bal. Account No.":=TransactionCharges."G/L Account";
                    GenJournalLine."Bal. Account No." := '300-000-418';
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    IF GenJournalLine.Amount <> 0 THEN
                        GenJournalLine.INSERT;

                    TChargeAmount := TChargeAmount + ChargeAmount;


                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name", 'FTRANS');
                    IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    END;
                END;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                IF VendDateFilter <> '' THEN BEGIN
                    IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                        SETRANGE("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                        CALCFIELDS("Net Change (LCY)");
                        StartBalanceLCY := -"Net Change (LCY)";
                    END;
                    SETFILTER("Date Filter", VendDateFilter);
                    CALCFIELDS("Net Change (LCY)");
                    StartBalAdjLCY := -"Net Change (LCY)";
                    VendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
                    VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                    VendorLedgerEntry.SETFILTER("Posting Date", VendDateFilter);
                    IF VendorLedgerEntry.FIND('-') THEN
                        REPEAT
                            VendorLedgerEntry.SETFILTER("Date Filter", VendDateFilter);
                            VendorLedgerEntry.CALCFIELDS("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)";
                            "Detailed Vendor Ledg. Entry".SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Vendor Ledg. Entry".SETRANGE("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                            "Detailed Vendor Ledg. Entry".SETFILTER("Entry Type", '%1|%2',
                              "Detailed Vendor Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
                              "Detailed Vendor Ledg. Entry"."Entry Type"::"Appln. Rounding");
                            "Detailed Vendor Ledg. Entry".SETFILTER("Posting Date", VendDateFilter);
                            IF "Detailed Vendor Ledg. Entry".FIND('-') THEN
                                REPEAT
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";
                                UNTIL "Detailed Vendor Ledg. Entry".NEXT = 0;
                            "Detailed Vendor Ledg. Entry".RESET;
                        UNTIL VendorLedgerEntry.NEXT = 0;
                END;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                MinBal := 0;
                IF AccType.GET(Vendor."Account Type") THEN
                    MinBal := AccType."Minimum Balance";


                Cust.RESET;
                Cust.SETRANGE(Cust."No.", "BOSA Account No");
                IF Cust.FIND('-') THEN BEGIN
                    CompanyNamee := Cust.Name;
                END;
                OpeningBal := 0;
                OpRunBal := 0;
                VLedger.RESET;
                VLedger.SETRANGE(VLedger."Vendor No.", Vendor."No.");
                VLedger.SETFILTER(VLedger."Posting Date", '..%1', FromDate);
                IF VLedger.FIND('-') THEN BEGIN
                    REPEAT
                        VLedger.CALCFIELDS(VLedger.Amount);
                        OpeningBal := OpeningBal + VLedger.Amount;
                    UNTIL VLedger.NEXT = 0;
                END;
                OpRunBal := OpeningBal;
                ToBal := 0;
                VLedger.RESET;
                VLedger.SETRANGE(VLedger."Vendor No.", Vendor."No.");
                VLedger.SETFILTER(VLedger."Posting Date", '..%1', ToDate);
                IF VLedger.FIND('-') THEN BEGIN
                    REPEAT
                        VLedger.CALCFIELDS(VLedger.Amount);
                        ToBal := ToBal + VLedger.Amount;
                    UNTIL VLedger.NEXT = 0;
                END;
                OpeningBal := OpeningBal * -1;
                ToBal := ToBal * -1;

            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CurrReport.CREATETOTALS("Vendor Ledger Entry"."Amount (LCY)", StartBalanceLCY, Correction, ApplicationRounding);

                IF CompanyInfo.GET() THEN
                    CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                /*
               //Hide Balances
               IF UsersID.GET(USERID) THEN BEGINfvv
               IF UsersID."Show Hiden" = FALSE THEN
               Vendor.SETRANGE(Vendor.Hide,FALSE);
               END;
               //Hide Balances
               */
                IF FromDate <> 0D THEN
                    DateFilterX := FORMAT(FromDate) + '..' + FORMAT(ToDate)
                ELSE
                    DateFilterX := '..' + FORMAT(ToDate);

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("From Date"; FromDate)
                    {
                        Caption = 'From Date';
                    ApplicationArea = All;
                        //OptionCaption = 'Checks,Deposits,Both';
                    }
                    field("To Date"; ToDate)
                    {
                        Caption = 'To Date';
                    ApplicationArea = All;
                        //OptionCaption = 'Checks,Deposits,Both';
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

    trigger OnPreReport()
    begin
        VendFilter := Vendor.GETFILTERS;
        VendDateFilter := Vendor.GETFILTER("Date Filter");

        WITH "Vendor Ledger Entry" DO
            IF PrintAmountsInLCY THEN BEGIN
                AmountCaption := FIELDCAPTION("Amount (LCY)");
                RemainingAmtCaption := FIELDCAPTION("Remaining Amt. (LCY)");
            END ELSE BEGIN
                AmountCaption := FIELDCAPTION(Amount);
                RemainingAmtCaption := FIELDCAPTION("Remaining Amount");
            END;
    end;

    var
        Text000: Label 'Period: %1';
        VendorLedgerEntry: Record 25;
        Vendor: Record Vendor;
        "Vendor Ledger Entry": Record "Vendor Ledger Entry";
        "Detailed Vendor Ledg. Entry": Record "Detailed Vendor Ledg. Entry";
        VendFilter: Text[250];
        VendDateFilter: Text[30];
        VendAmount: Decimal;
        VendRemainAmount: Decimal;
        VendBalanceLCY: Decimal;
        VendEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        ExcludeBalanceOnly: Boolean;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        VendLedgEntryExists: Boolean;
        AmountCaption: Text[30];
        RemainingAmtCaption: Text[30];
        VendCurrencyCode: Code[10];
        CompanyInfo: Record 79;
        AccType: Record "Account Types-Saving Products";
        MinBal: Decimal;
        Account_StatementCaptionLbl: Label 'Account Statement';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        VendBalanceLCY__1_Control40CaptionLbl: Label 'Balance (LCY)';
        Account_No_CaptionLbl: Label 'Account No.';
        NamesCaptionLbl: Label 'Names';
        Account_TypeCaptionLbl: Label 'Account Type';
        Staff_No_CaptionLbl: Label 'Staff No.';
        Adj__of_Opening_BalanceCaptionLbl: Label 'Adj. of Opening Balance';
        Total_BalanceCaptionLbl: Label 'Total Balance';
        Total_Balance_Before_PeriodCaptionLbl: Label 'Total Balance Before Period';
        Available_BalanceCaptionLbl: Label 'Available Balance';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control46Lbl: Label 'Continued';
        UsersID: Record 2000000120;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        Totals: Decimal;
        CompanyNamee: Code[50];
        Cust: Record 18;
        DActivity: Code[10];
        ChargeAmount: Decimal;
        Echarge: Decimal;
        GenJournalLine: Record 81;
        LineNo: Integer;
        TransactionCharges: Record "Transaction Charges";
        TChargeAmount: Integer;
        FromDate: Date;
        ToDate: Date;
        VLedger: Record 25;
        OpeningBal: Decimal;
        ToBal: Decimal;
        RunBal: Decimal;
        OpRunBal: Decimal;
        ENtryAmount: Decimal;
        DateFilterX: Text;
}




