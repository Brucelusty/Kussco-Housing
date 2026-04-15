report 50043 "Old Detailed  Statement"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Detailed  Statement.rdlc';
    Caption = 'Old Detailed Statement';

    dataset
    {
        dataitem(DataItem1102755000; Customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";
            column(USERID; USERID)
            {
            }
            column(PayrollStaffNo_Members; "Members Register"."Payroll No")
            {
            }
            column(No_Members; "Members Register"."No.")
            {
            }
            column(Name_Members; "Members Register".Name)
            {
            }
            column(EmployerCode_Members; "Members Register"."Employer Code")
            {
            }
            column(PageNo_Members; CurrReport.PAGENO)
            {
            }
            column(Defaultedloan; Defaultedloan)
            {
            }
            column(Shares_Retained; "Members Register"."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; "Members Register"."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; "Members Register"."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            dataitem(Shares; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = CONST("Shares Capital"),
                                          Reversed = FILTER(false));
                RequestFilterFields = "Posting Date";
                column(openBalances; OpenBalance)
                {
                }
                column(CLosingBalances; CLosingBalance)
                {
                }
                column(Description_Shares; Shares.Description)
                {
                }
                column(DocumentNo_Shares; Shares."Document No.")
                {
                }
                column(PostingDate_Shares; Shares."Posting Date")
                {
                }
                column(CreditAmount_Shares; Shares."Credit Amount")
                {
                }
                column(DebitAmount_Shares; Shares."Debit Amount")
                {
                }
                column(Amount_Shares; Shares.Amount)
                {
                }
                column(TransactionType_Shares; Shares."Transaction Type")
                {
                }
                column(Shares_Description; Shares.Description)
                {
                }
                column(UserID_Shares; Shares."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalance := CLosingBalance - Shares.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalance := ShareCapBF;
                    OpeningBal := ShareCapBF * -1;
                end;
            }
            dataitem(CoopShares; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = CONST("Co-op Shares"),
                                          Reversed = FILTER(false));
                column(OpenBalanceCoop; OpenBalanceCoop)
                {
                }
                column(CLosingBalanceCoop; CLosingBalanceCoop)
                {
                }
                column(Description_CoopShares; CoopShares.Description)
                {
                }
                column(DocumentNo_CoopShares; CoopShares."Document No.")
                {
                }
                column(PostingDate_CoopShares; CoopShares."Posting Date")
                {
                }
                column(CreditAmount_CoopShares; CoopShares."Credit Amount")
                {
                }
                column(DebitAmount_CoopShares; CoopShares."Debit Amount")
                {
                }
                column(Amount_CoopShares; CoopShares.Amount)
                {
                }
                column(TransactionType_CoopShares; CoopShares."Transaction Type")
                {
                }
                column(CoopShares_Description; CoopShares.Description)
                {
                }
                column(UserID_CoopShares; CoopShares."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalanceCoop := CLosingBalanceCoop - CoopShares.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceCoop := CoopSharesBF;
                    OpenBalanceCoop := CoopSharesBF * -1;
                end;
            }
            dataitem(Deposits; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = CONST("Deposit Contribution"),
                                          Reversed = FILTER(false));
                PrintOnlyIfDetail = false;
                column(OpeningBal; OpeningBal)
                {
                }
                column(ClosingBal; ClosingBal)
                {
                }
                column(TransactionType_Deposits; Deposits."Transaction Type")
                {
                }
                column(Amount_Deposits; Deposits.Amount)
                {
                }
                column(Description_Deposits; Deposits.Description)
                {
                }
                column(DocumentNo_Deposits; Deposits."Document No.")
                {
                }
                column(PostingDate_Deposits; Deposits."Posting Date")
                {
                }
                column(DebitAmount_Deposits; Deposits."Debit Amount")
                {
                }
                column(CreditAmount_Deposits; Deposits."Credit Amount")
                {
                }
                column(Deposits_Description; Deposits.Description)
                {
                }
                column(UserID_Deposits; Deposits."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ClosingBal := ClosingBal + Deposits.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBal := SharesBF;
                    OpeningBal := SharesBF * -1;
                    //MESSAGE('OpeningBal is %1',CLosingBalanceSF);
                end;
            }
            dataitem(Junior; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = CONST(Konza),
                                          Reversed = FILTER(false));
                column(OpenBalancesJuja; OpenBalanceJuja)
                {
                }
                column(CLosingBalancesJuja; CLosingBalanceJuja)
                {
                }
                column(Description_Juja; Junior.Description)
                {
                }
                column(DocumentNo_Juja; Junior."Document No.")
                {
                }
                column(PostingDate_Juja; Junior."Posting Date")
                {
                }
                column(CreditAmount_Juja; Junior."Credit Amount")
                {
                }
                column(DebitAmount_Juja; Junior."Debit Amount")
                {
                }
                column(Amount_Juja; Junior.Amount)
                {
                }
                column(TransactionType_Juja; Junior."Transaction Type")
                {
                }
                column(UserID_Junior; Junior."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalanceXmas := CLosingBalanceXmas - Junior.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceXmas := XmasBF;
                    OpenBalanceXmas := XmasBF * -1;
                end;
            }
            dataitem(Fanikisha; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = CONST("Co-op Shares"),
                                          Reversed = FILTER(false));
                column(OpenBalancesHse; OpenBalanceHse)
                {
                }
                column(CLosingBalancesHse; CLosingBalanceHse)
                {
                }
                column(DescriptionHse; Fanikisha.Description)
                {
                }
                column(DocumentNoHse; Fanikisha."Document No.")
                {
                }
                column(PostingDateHse; Fanikisha."Posting Date")
                {
                }
                column(CreditAmountHse; Fanikisha."Credit Amount")
                {
                }
                column(DebitAmountHse; Fanikisha."Debit Amount")
                {
                }
                column(AmountHse; Fanikisha.Amount)
                {
                }
                column(TransactionTypeHse; Fanikisha."Transaction Type")
                {
                }
                column(UserID_Fanikisha; Fanikisha."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalanceHse := CLosingBalanceHse - Fanikisha.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceHse := HseBF;
                    OpenBalanceHse := HseBF * -1;
                end;
            }
            dataitem(Gpange; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = CONST(Lukenya),
                                          Reversed = FILTER(false));
                column(OpenBalancesKonza; OpenBalanceHse)
                {
                }
                column(CLosingBalancesKonza; CLosingBalanceHse)
                {
                }
                column(DescriptionKonza; Gpange.Description)
                {
                }
                column(DocumentNoKonza; Gpange."Document No.")
                {
                }
                column(PostingDateKonza; Gpange."Posting Date")
                {
                }
                column(CreditAmountKonza; Gpange."Credit Amount")
                {
                }
                column(DebitAmountKonza; Gpange."Debit Amount")
                {
                }
                column(AmountKonza; Gpange.Amount)
                {
                }
                column(TransactionTypeKonza; Gpange."Transaction Type")
                {
                }
                column(UserID_Gpange; Gpange."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalanceHse := CLosingBalanceHse - Gpange.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceHse := HseBF;
                    OpenBalanceHse := HseBF * -1;
                end;
            }
            dataitem(Jpange; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = CONST(Lukenya),
                                          Reversed = FILTER(false));
                column(OpenBalancesLukenya; OpenBalanceHse)
                {
                }
                column(CLosingBalancesLukenya; CLosingBalanceHse)
                {
                }
                column(DescriptionLukenya; Jpange.Description)
                {
                }
                column(DocumentNoLukenya; Jpange."Document No.")
                {
                }
                column(PostingDateLukenya; Jpange."Posting Date")
                {
                }
                column(CreditAmountLukenya; Jpange."Credit Amount")
                {
                }
                column(DebitAmountLukenya; Jpange."Debit Amount (LCY)")
                {
                }
                column(AmountLukenya; Jpange.Amount)
                {
                }
                column(TransactionTypeLukenya; Jpange."Transaction Type")
                {
                }
                column(UserID_Jpange; Jpange."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalanceHse := CLosingBalanceHse - Jpange.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceHse := HseBF;
                    OpenBalanceHse := HseBF * -1;
                end;
            }
            dataitem(Holiday_Savers; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = CONST("Xmas Contribution"),
                                          Reversed = FILTER(false));
                column(OpenBalancesDep1; OpenBalanceDep1)
                {
                }
                column(CLosingBalancesDep1; CLosingBalanceDep1)
                {
                }
                column(DescriptionDep1; Holiday_Savers.Description)
                {
                }
                column(DocumentNoDep1; Holiday_Savers."Document No.")
                {
                }
                column(PostingDateDep1; Holiday_Savers."Posting Date")
                {
                }
                column(CreditAmountDep1; Holiday_Savers."Credit Amount")
                {
                }
                column(DebitAmountDep1; Holiday_Savers."Debit Amount")
                {
                }
                column(AmountDep1; Holiday_Savers.Amount)
                {
                }
                column(TransactionTypeDep1; Holiday_Savers."Transaction Type")
                {
                }
                column(UserID_HolidaySavers; Holiday_Savers."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalanceHse := CLosingBalanceHse - Holiday_Savers.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceHse := Dep1BF;
                    OpenBalanceHse := Dep1BF * -1;
                end;
            }
            dataitem(HousingTitle; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Transaction Type", "Loan No", "Posting Date")
                                    WHERE("Transaction Type" = FILTER("Housing Title"),
                                          Reversed = FILTER(false));
                column(OpenBalancesDep2; OpenBalanceDep2)
                {
                }
                column(CLosingBalancesDep2; CLosingBalanceDep2)
                {
                }
                column(DescriptionDep2; HousingTitle.Description)
                {
                }
                column(DocumentNoDep2; HousingTitle."Document No.")
                {
                }
                column(PostingDateDep2; HousingTitle."Posting Date")
                {
                }
                column(CreditAmountDep2; HousingTitle."Credit Amount")
                {
                }
                column(DebitAmountDep2; HousingTitle."Debit Amount")
                {
                }
                column(AmountDep2; HousingTitle.Amount)
                {
                }
                column(TransactionTypeDep2; HousingTitle."Transaction Type")
                {
                }
                column(UserID_HousingTitle; HousingTitle."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalanceDep2 := CLosingBalanceDep2 - HousingTitle.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceDep2 := Dep2BF;
                    OpenBalanceDep2 := Dep2BF * -1;
                end;
            }
            dataitem(SchoolFees; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Posting Date")
                                    WHERE("Transaction Type" = CONST("SchFee Shares"),
                                          Reversed = FILTER(false));
                PrintOnlyIfDetail = false;
                column(OpeningBalSF; OpenBalanceSF)
                {
                }
                column(ClosingBalSFees; CLosingBalanceSF)
                {
                }
                column(TransactionType_DepositsSF; SchoolFees."Transaction Type")
                {
                }
                column(Amount_DepositsSF; SchoolFees.Amount)
                {
                }
                column(Description_DepositsSF; SchoolFees.Description)
                {
                }
                column(DocumentNo_DepositsSF; SchoolFees."Document No.")
                {
                }
                column(PostingDate_DepositsSF; SchoolFees."Posting Date")
                {
                }
                column(DebitAmount_DepositsSF; SchoolFees."Debit Amount")
                {
                }
                column(CreditAmount_DepositsSF; SchoolFees."Credit Amount")
                {
                }
                column(UserID_SchoolFees; SchoolFees."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLosingBalanceSF := CLosingBalanceSF + SchoolFees.Amount;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceSF := SchoolfeesBF;
                    OpenBalanceSF := SchoolfeesBF * -1;
                end;
            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = FIELD("No."),
                               "Loan Product Type" = FIELD("Loan Product Filter"),
                               "Date filter" = FIELD("Date Filter");
                DataItemTableView = SORTING("Loan  No.")
                                    WHERE(Posted = CONST(true),
                                          "Loan  No." = FILTER(<> ''));
                column(PrincipleBF; PrincipleBF)
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; Loans."Loan Product Type Name")
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                dataitem(loan; "Member Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD("Client Code"),
                                   "Loan No" = FIELD("Loan  No."),
                                   "Posting Date" = FIELD("Date filter");
                    DataItemTableView = SORTING("Posting Date")
                                        WHERE("Transaction Type" = FILTER(Loan | Repayment),
                                              Reversed = FILTER(false),
                                              "Loan No" = FILTER(<> ''),
                                              Description = FILTER(<> 'Interest on salary advance'));
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; loan.Amount)
                    {
                    }
                    column(openBalance_loan; OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan; CLosingBalance)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }
                    column(Loan_Description; loan.Description)
                    {
                    }
                    column(UserID_loan; loan."User ID")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /*CLosingBalance:=CLosingBalance+loan.Amount;
                        ClosingBalInt:=ClosingBalInt+loan.Amount;
                        
                        //interest
                        ClosingBal:=ClosingBal+LoanInterest.Amount;
                        OpeningBal:=ClosingBal-LoanInterest.Amount;
                        */
                        CLosingBalance := CLosingBalance + loan.Amount;
                        IF Loans."Loan  No." = '' THEN BEGIN
                        END;

                        IF loan."Transaction Type" = loan."Transaction Type"::"Interest Paid" THEN BEGIN
                            InterestPaid := loan."Credit Amount";
                            SumInterestPaid := InterestPaid + SumInterestPaid;
                        END;
                        IF loan."Transaction Type" = loan."Transaction Type"::Repayment THEN BEGIN
                            loan."Credit Amount" := loan."Credit Amount"//+InterestPaid;
                        END;

                    end;

                    trigger OnPreDataItem()
                    begin
                        CLosingBalance := PrincipleBF;
                        OpeningBal := PrincipleBF;
                    end;
                }
                dataitem(Interest; "Member Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD("Client Code"),
                                   "Loan No" = FIELD("Loan  No."),
                                   "Posting Date" = FIELD("Date filter");
                    DataItemTableView = SORTING("Posting Date")
                                        WHERE("Transaction Type" = FILTER("Interest Due" | "Interest Paid"),
                                              Reversed = FILTER(false),
                                              "Loan No" = FILTER(<> ''),
                                              Description = FILTER(<> 'Interest on salary advance'));
                    column(PostingDate_Interest; Interest."Posting Date")
                    {
                    }
                    column(DocumentNo_Interest; Interest."Document No.")
                    {
                    }
                    column(Description_Interest; Interest.Description)
                    {
                    }
                    column(DebitAmount_Interest; Interest."Debit Amount")
                    {
                    }
                    column(CreditAmount_Interest; Interest."Credit Amount")
                    {
                    }
                    column(Amount_Interest; Interest.Amount)
                    {
                    }
                    column(OpeningBalInt; OpeningBalInt)
                    {
                    }
                    column(ClosingBalInt; ClosingBalInt)
                    {
                    }
                    column(TransactionType_Interest; Interest."Transaction Type")
                    {
                    }
                    column(LoanNo_Interest; Interest."Loan No")
                    {
                    }
                    column(InterestBF; InterestBF)
                    {
                    }
                    column(UserID_Interest; Interest."User ID")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin

                    IF DateFilterBF <> '' THEN BEGIN
                        LoansR.RESET;
                        LoansR.SETRANGE(LoansR."Loan  No.", "Loan  No.");
                        LoansR.SETFILTER(LoansR."Date filter", DateFilterBF);
                        IF LoansR.FIND('-') THEN BEGIN
                            LoansR.CALCFIELDS(LoansR."Outstanding Balance");
                            PrincipleBF := LoansR."Outstanding Balance";
                            //InterestBF:=LoansR."Interest Paid";
                        END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    Loans.SETFILTER(Loans."Date filter", "Members Register".GETFILTER("Members Register"."Date Filter"));
                end;
            }
            dataitem(DataItem1000000042; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = FIELD("No.");
                column(LoanNumb; "Loans Guarantee Details"."Loan No")
                {
                }
                column(MembersNo; "Loans Guarantee Details"."Member No")
                {
                }
                column(Name; "Loans Guarantee Details".Name)
                {
                }
                column(LBalance; "Loans Guarantee Details"."Loan Balance")
                {
                }
                column(Shares; "Loans Guarantee Details".Shares)
                {
                }
                column(LoansGuaranteed; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted; "Loans Guarantee Details".Substituted)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //MESSAGE('aZSsdfgh');
                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                CoopSharesBF := 0;
                XmasBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                SchoolfeesBF := 0;
                Defaultedloan := 0;


                IF DateFilterBF <> '' THEN BEGIN
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.", "No.");
                    Cust.SETFILTER(Cust."Date Filter", DateFilterBF);
                    IF Cust.FIND('-') THEN BEGIN
                        Cust.CALCFIELDS(Cust."Shares Retained", Cust."Current Shares", Cust."Insurance Fund", Cust."School Fees Shares", Cust."Total Loans Outstanding");//,Cust."Co-operative Shares");
                        SharesBF := Cust."Current Shares";
                        //CoopSharesBF:=Cust."Co-operative Shares";

                        ShareCapBF := Cust."Shares Retained";
                        InsuranceBF := Cust."Insurance Fund";
                        SchoolfeesBF := Cust."School Fees Shares";
                        Defaultedloan := 0;
                        IF Cust."Loans Defaulter Status" = Cust."Loans Defaulter Status"::Loss THEN
                            Defaultedloan := Cust."Total Loans Outstanding";
                        //MESSAGE('Defaulted loan is %1',Cust."Total Loans Outstanding");
                    END;
                END;

                /*GuarantorsRecoveryHeader.RESET;
                GuarantorsRecoveryHeader.SETRANGE(GuarantorsRecoveryHeader."Member No","Members Register"."No.");
                
                IF GuarantorsRecoveryHeader.FIND('-') THEN
                  IF  GuarantorsRecoveryHeader.Posted=TRUE THEN
                    GuarantorsRecoveryHeader.CALCFIELDS(GuarantorsRecoveryHeader."Loan Distributed to Guarantors");
                Defaultedloan:=GuarantorsRecoveryHeader."Loan Distributed to Guarantors";*/
                //MESSAGE('Defaulted loan is %1',Defaultedloan);

            end;

            trigger OnPreDataItem()
            begin

                IF "Members Register".GETFILTER("Members Register"."Date Filter") <> '' THEN
                    DateFilterBF := '..' + FORMAT(CALCDATE('-1D', "Members Register".GETRANGEMIN("Members Register"."Date Filter")));
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        Company.GET();
        Company.CALCFIELDS(Company.Picture);
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        "Members Register": Record Customer;
        "Loans Guarantee Details": Record "Loans Guarantee Details";
        Cust: Record Customer;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        XmasBF: Decimal;
        Company: Record 79;
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceJuja: Decimal;
        CLosingBalanceJuja: Decimal;
        OpenBalanceFani: Decimal;
        CLosingBalanceFani: Decimal;
        OpenBalancejpange: Decimal;
        CLosingBalancejpange: Decimal;
        OpenBalancejunior: Decimal;
        CLosingBalancejunior: Decimal;
        OpenBalanceholiday: Decimal;
        CLosingBalanceholiday: Decimal;
        PrincipleBF1: Decimal;
        SchoolfeesBF: Integer;
        OpenBalanceSF: Decimal;
        CLosingBalanceSF: Decimal;
        Defaultedloan: Decimal;
        GuarantorsRecoveryHeader: Record "Guarantor Recovery Ledger";
        OpenBalanceCoop: Decimal;
        CLosingBalanceCoop: Decimal;
        CoopSharesBF: Decimal;
}



