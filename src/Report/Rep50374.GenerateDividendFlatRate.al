Report 50374 "Generate Dividend FlatRate"
{
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING ("No.")where(IsNormalMember = filter(true));
            RequestFilterFields = "No.", "Date Filter", "Employer Code";
            column(No_;"No.")
            {}
            trigger OnPreDataItem();
            begin
                //LastFieldNo := FIELDNO("");	userSetup.Reset();
                userSetup.Reset();
                userSetup.Get(UserId);
                if userSetup."Can Edit Chart Of Accounts" = false then begin
                    Error('The user %1 does not have permissions to process dividends.', UserId);
                end;

                if "Calculation Year" = 0 then Error('Kindly select a year for the dividend calculation');
                if "Deposit Type" = "Deposit Type"::" " then Error('Kindly select which account type to calculate.');

                msg := 'You are calculating %1 for the Period of %2, ending %3 through Flat-Rate Calculation. Do you wish to continue?';
                skip := false;
                IF "Deposit Type" = "Deposit Type"::Deposits THEN BEGIN
                    confirmationMsg := StrSubstNo(msg, 'Interest on Deposits', "Calculation Year", ToDate);
                    if Confirm(confirmationMsg, false) = true then begin
                        DivProg.RESET;
                        DivProg.SetRange(Posted, false);
                        DivProg.SETRANGE(DivProg."Deposit Type", DivProg."Deposit Type"::Deposits);
                        IF DivProg.FINDSET THEN begin
                            DivProg.DELETEALL;
                        end;
                        Cust.RESET;
                        Cust.MODIFYALL(Cust."Deposits Interest Amount", 0);
                    end else skip := true;
                END;

                IF "Deposit Type" = "Deposit Type"::ESS THEN BEGIN
                    confirmationMsg := StrSubstNo(msg, 'Interest on ESS', "Calculation Year", ToDate);
                    if Confirm(confirmationMsg, false) = true then begin
                        DivProg.RESET;
                        DivProg.SetRange(Posted, false);
                        DivProg.SETRANGE(DivProg."Deposit Type", DivProg."Deposit Type"::ESS);
                        IF DivProg.FINDSET THEN begin
                            DivProg.DELETEALL;
                        end;
                        Cust.RESET;
                        Cust.MODIFYALL(Cust."ESS Interest Amount", 0);
                    end else skip := true;
                END;

                IF "Deposit Type" = "Deposit Type"::"Share Capital" THEN BEGIN
                    confirmationMsg := StrSubstNo(msg, 'Dividends', "Calculation Year", ToDate);
                    if Confirm(confirmationMsg, false) = true then begin
                        DivProg.RESET;
                        DivProg.SetRange(Posted, false);
                        DivProg.SETRANGE(DivProg."Deposit Type", DivProg."Deposit Type"::"Share Capital");
                        IF DivProg.FINDSET THEN begin
                            DivProg.DELETEALL;
                        end;
                        Cust.RESET;
                        Cust.MODIFYALL(Cust."Dividend Amount", 0);
                    end else skip := true;
                END;													
            end;

            trigger OnAfterGetRecord();
            var
                CoopShares: Decimal;
                NetCoop: Decimal;
            begin
                // DivTotal := 0;
                // Tax := 0;
                // CoopShares := 0;
                // NetCoop := 0;
                GenSetUp.Get();
                // CalcFields("Un-allocated Funds");
                // CoopShares := "Un-allocated Funds" / 6 * 1.415;
                // Tax := Tax + ((10 / 100) * Abs(CoopShares));
                // NetCoop := CoopShares - Tax;
                // Customer."Coop Shares" := CoopShares;
                // Customer."Coop Shares Net" := NetCoop;
                // Customer.Modify;
                
                if skip = true then begin
                    CurrReport.Skip();
                end;

                if "Deposit Type" = "Deposit Type"::Deposits then begin
                    DivTotal := 0;
                    cust.Reset();
                    cust.SetRange("No.", Customer."No.");
                    cust.SetFilter("Date Filter", '..%1', ToDate);
                    if Cust.Find('-') then begin
                        cust.CalcFields("Current Shares");

                        CDiv := ((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares" + 0) * -1));
                        DivTotal := DivTotal + CDiv;

                        DivProg.Init();
                        DivProg."Member No" := Cust."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Dividends" / 100);
                        DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares" + 0) * -1);
                        DivProg.Shares := ((Cust."Current Shares" + 0) * -1);
                        DivProg."Deposit Type" := DivProg."Deposit Type"::Deposits;
                        DivProg.Year := "Calculation Year";
                        divProg.Insert();
                    end;
                end;
                if "Deposit Type" = "Deposit Type"::ESS then begin
                    DivTotal := 0;
                    cust.Reset();
                    cust.SetRange("No.", Customer."No.");
                    cust.SetFilter("Date Filter", '..%1', ToDate);
                    if Cust.Find('-') then begin
                        cust.CalcFields("School Fees Shares");
                                        
                        CDiv := ((GenSetUp."Ess Interest%" / 100) * ((Cust."School Fees Shares" + 0) * -1));
                        DivTotal := DivTotal + CDiv;

                        DivProg.Init();
                        DivProg."Member No" := Cust."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Deposits" / 100);
                        DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."School Fees Shares" + 0) * -1);
                        DivProg.Shares := ((Cust."School Fees Shares" + 0) * -1);
                        DivProg."Deposit Type" := DivProg."Deposit Type"::ESS;
                        DivProg.Year := "Calculation Year";
                        divProg.Insert();
                    end;
                end;
                if "Deposit Type" = "Deposit Type"::"Share Capital" then begin
                    DivTotal := 0;
                    cust.Reset();
                    cust.SetRange("No.", Customer."No.");
                    cust.SetFilter("Date Filter", '..%1', ToDate);
                    if Cust.Find('-') then begin
                        cust.CalcFields("Shares Retained");
                        
                        CDiv := ((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained" + 0) * -1));
                        DivTotal := DivTotal + CDiv;

                        DivProg.Init();
                        DivProg."Member No" := Cust."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Witholding Tax" := CDiv * (GenSetUp."Withholding Tax on Dividends" / 100);
                        DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Shares Retained" + 0) * -1);
                        DivProg.Shares := ((Cust."Shares Retained" + 0) * -1);
                        DivProg."Deposit Type" := DivProg."Deposit Type"::"Share Capital";
                        DivProg.Year := "Calculation Year";
                        divProg.Insert();
                    end;
                end;
            end;
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("Calculation Year";"Calculation Year")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate() begin
                        FromDate :=  DMY2Date(1,1,("Calculation Year"));
                        ToDate :=  DMY2Date(31,12,"Calculation Year");
                    end;
                }
                field("Deposit  Type"; "Deposit Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //:= false;															
        end;
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    trigger OnPostReport()
    begin
        Message('Flat-Rate Processing Done.');
    end;

    trigger OnPreReport()
    begin

    end;

    var
        userSetup: Record "User Setup";
        skip: Boolean;
        "Calculation Year": Integer;
        confirmationMsg: Text;
        msg: Text;
        Endyear: Date;
        "Deposit Type": Option " ","Share Capital",Deposits,ESS;
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        smsManagement: Codeunit "Sms Management";
        NameStyle: Codeunit "Send Birthday SMS";
        CreationMessage: Text[2500];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        NameCreditOff: label 'Name......................................';
        NameCreditDate: label 'Date........................................';
        NameCreditSign: label 'Signature..................................';
        NameCreditMNG: label 'Name......................................';
        NameCreditMNGDate: label 'Date.....................................';
        NameCreditMNGSign: label 'Signature..................................';
        NameCEO: label 'Name........................................';
        NameCEOSign: label 'Signature...................................';
        NameCEODate: label 'Date.....................................';
        CreditCom1: label 'Name........................................';
        CreditCom1Sign: label 'Signature...................................';
        CreditCom1Date: label 'Date.........................................';
        CreditCom2: label 'Name........................................';
        CreditCom2Sign: label 'Signature....................................';
        CreditCom2Date: label 'Date..........................................';
        CreditCom3: label 'Name.........................................';
        CreditComDate3: label 'Date..........................................';
        CreditComSign3: label 'Signature..................................';
        Comment: label '....................';
        SN: Integer;
        Company: Record "Company Information";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record Customer;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        CDeposits: Decimal;
        CustDiv: Record Customer;
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        Tax: Decimal;
        TotalDiv: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DivTotal2: Decimal;
        LineNo: Integer;
        Vend: Record Vendor;
        PostingDate: Date;

    // --> Reports ForNAV Autogenerated code - do not delete or modify															
    //51516421_v6_3_0_2259;															






    // Reports ForNAV Autogenerated code - do not delete or modify -->															
}






