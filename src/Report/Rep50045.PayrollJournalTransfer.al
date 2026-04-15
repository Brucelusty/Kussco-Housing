Report 50045 "Payroll JournalTransfer."
{
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "Current Month Filter", "No.";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin


                //For use when posting Pension and NSSF
                PostingGroup.Get('PAYROLL');
                PostingGroup.TestField("SSF Employer Account");
                PostingGroup.TestField("SSF Employee Account");
                PostingGroup.TestField("Pension Employer Acc");
                PostingGroup.TestField("Pension Employee Acc");
                objEmp.SetRange(objEmp."No.", "No.");
                if objEmp.Find('-') then begin
                    strEmpName := '[' + "No." + '] ' + objEmp.Lastname + ' ' + objEmp.Firstname + ' ' + objEmp.Surname;
                end;

                LineNumber := LineNumber + 10;

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                if PeriodTrans.Find('-') then begin
                    repeat

                        //BPAY
                        if PeriodTrans."Transaction Code" = 'BPAY' then begin

                            CreateJnlEntry(0, PostingGroup."Salary Account",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), PeriodTrans.Amount, 0,
                            PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");

                        end;

                        //Alloances
                        if PeriodTrans."Group Text" = 'ALLOWANCE' then begin
                            PayrollTrans.Reset();
                            PayrollTrans.SetRange(PayrollTrans."Transaction Code", PeriodTrans."Transaction Code");
                            if PayrollTrans.FindFirst() then begin
                                CreateJnlEntry(0, PayrollTrans."G/L Account",
                                GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), PeriodTrans.Amount, 0,
                                PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");
                            end;
                        end;


                        //Life Insurance
                        if PeriodTrans."Transaction Code" = 'LIFE INSURANCE' then begin
                            PayrollTrans.Reset();
                            PayrollTrans.SetRange(PayrollTrans."Transaction Code", PeriodTrans."Transaction Code");
                            if PayrollTrans.FindFirst() then begin
                                CreateJnlEntry(0, PayrollTrans."G/L Account",
                                GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                                PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");
                            end;
                        end;
                        //Paye          
                        if PeriodTrans."Transaction Code" = 'PAYE' then begin

                            //Credit Payables


                            CreateJnlEntry(0, PostingGroup."PAYE Account",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                            PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");

                            //Debit Staff Expense

                            /*                             CreateJnlEntry(0, PostingGroup."SSF Employer Account",
                                                        GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), PeriodTrans.Amount, 0, 1, '',
                                                        SaccoTransactionType, GlobalDim3, "No."); */


                        end;

                        //NSSF
                        if PeriodTrans."Transaction Code" = 'NSSF' then begin

                            //Credit Payables


                            CreateJnlEntry(0, PostingGroup."SSF Employee Account",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                            PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");

                            //Debit Staff Expense

                            CreateJnlEntryBal(0, PostingGroup."SSF Employer Account",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), PeriodTrans.Amount, 0, 1, '',
                            SaccoTransactionType, GlobalDim3, "No.", PostingGroup."SSF Employee Account");


                        end;
                        //nhif
                        if PeriodTrans."Transaction Code" = 'SHIF' then begin//HELB LOAN

                            //Credit Payables


                            CreateJnlEntry(0, PostingGroup."NHIF Employee Account",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                            PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");

                            //Debit Staff Expense

                            /*                             CreateJnlEntry(0, PostingGroup."SSF Employer Account",
                                                        GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), PeriodTrans.Amount, 0, 1, '',
                                                        SaccoTransactionType, GlobalDim3, "No."); */


                        end;
                        if PeriodTrans."Transaction Code" = 'HELB LOAN' then begin//HELB LOAN

                            //Credit Payables


                            CreateJnlEntry(0, PostingGroup."NHIF Employee Account",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                            PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");




                        end;
                        // if PeriodTrans."Transaction Code" = 'D027' then begin
                        if PeriodTrans."Transaction Code" = 'HSNLVY' then begin

                            //Credit Payables

                            CreateJnlEntry(0, PostingGroup."Housing Levy Employee Acc",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                            PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");

                            //Debit Staff Expense

                            CreateJnlEntryBal(0, PostingGroup."Housing Levy Employer Acc",
                            GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), PeriodTrans.Amount, 0, 1, '',
                            SaccoTransactionType, GlobalDim3, "No.", PostingGroup."Housing Levy Employee Acc");

                        end;


                        //if PeriodTrans."Journal Account Code" <> '' then begin
                        if PeriodTrans."Journal Account Type" <> PeriodTrans."Journal Account Type"::" " then begin
                            AmountToDebit := 0;
                            AmountToCredit := 0;
                            if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                                AmountToDebit := PeriodTrans.Amount;

                            if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                                AmountToCredit := PeriodTrans.Amount;

                            if PeriodTrans."Journal Account Type" = 1 then
                                IntegerPostAs := 0;
                            if PeriodTrans."Journal Account Type" = 2 then
                                IntegerPostAs := 1;

                            SaccoTransactionType := Saccotransactiontype::" ";
                            // Message('%1-%2-%3', PeriodTrans."Employee Code", PeriodTrans."coop parameters");
                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan then begin
                                if Loans.Get(PeriodTrans."Loan Number") then
                                    Loans.CalcFields(Loans."Outstanding Interest");
                                LoanAmount := 0;
                                InterestAmount := Loans."Outstanding Interest";
                                LoanAmount := PeriodTrans.Amount - Loans."Outstanding Interest";

                            end;
                            /* 
                                                        if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::shares then
                                                            SaccoTransactionType := Saccotransactiontype::"Deposit Contribution";

                                                        if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Holiday then
                                                            SaccoTransactionType := Saccotransactiontype::"Holiday Savings";



                                                        if PeriodTrans."Journal Account Type" = PeriodTrans."journal account type"::Customer then begin
                                                            PeriodTrans."Journal Account Type" := PeriodTrans."journal account type"::Customer;
                                                        end; */


                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan then begin
                                CreateJnlEntry(IntegerPostAs, PeriodTrans.Membership,
                                GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 40), AmountToDebit, LoanAmount,
                                PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType::"Loan Repayment", GlobalDim3, "No.");

                                IntText := CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 10, 40);
                                CreateJnlEntry(IntegerPostAs, PeriodTrans.Membership,
                                GlobalDim1, '', 'Interest Paid ' + IntText, AmountToDebit, InterestAmount,
                                PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType::"Interest Paid", GlobalDim3, "No.");
                            end;

                            if PeriodTrans."Transaction Code" = 'D018' then begin
                                CreateJnlEntry(IntegerPostAs, PeriodTrans.Membership,
                                GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), AmountToDebit, AmountToCredit,
                                PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType::"Benevolent Fund", GlobalDim3, "No.");
                            end;


                            if PeriodTrans."Transaction Code" = 'WELFARE DEDUCTION' then begin
                                PayrollTrans.Reset();
                                PayrollTrans.SetRange(PayrollTrans."Transaction Code", PeriodTrans."Transaction Code");
                                if PayrollTrans.FindFirst() then begin
                                    CreateJnlEntry(0, PayrollTrans."G/L Account",
                                    GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                                    PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");
                                end;
                            end;


                            if PeriodTrans."Transaction Code" = 'D001' then begin
                                Vendors.Reset();
                                Vendors.SetRange(Vendors."BOSA Account No", PeriodTrans.Membership);
                                Vendors.SetFilter(Vendors."Account Type", '102');
                                if Vendors.FindFirst() then
                                    CreateJnlEntry(AccountTypes::Vendor, Vendors."No.",
                                    GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), AmountToDebit, AmountToCredit,
                                    PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType::" ", GlobalDim3, "No.");
                            end;

                            if PeriodTrans."Transaction Code" = 'D002' then begin
                                //Message('Here');
                                Vendors.Reset();
                                Vendors.SetRange(Vendors."BOSA Account No", PeriodTrans.Membership);
                                Vendors.SetFilter(Vendors."Account Type", '104');
                                if Vendors.FindFirst() then
                                    CreateJnlEntry(AccountTypes::Vendor, Vendors."No.",
                                    GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), AmountToDebit, AmountToCredit,
                                    PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType::" ", GlobalDim3, "No.");
                            end;

                            if (PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Pension) then begin
                                //Get from Employer Deduction

                                //Credit Payables
                                CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), AmountToDebit,
                                AmountToCredit, PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");
                                //Message('Pension%1',PostingGroup."Pension Employer Acc");
                                //Debit Staff Expense
                                //Debit Staff Expense

                                /*                                 CreateJnlEntryBal(0, PostingGroup."Pension Employer Acc",
                                                                GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), PeriodTrans.Amount , 0, 1, '',
                                                                SaccoTransactionType, GlobalDim3, "No.", PostingGroup."Pension Employee Acc"); */





                            end;
                            if PeriodTrans."Transaction Code" = 'NPAY' then begin

                                CreateJnlEntry(0, PostingGroup."Net Salary Payable",
                                GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), 0, PeriodTrans.Amount,
                                PeriodTrans."Post As", '', SaccoTransactionType, GlobalDim3, "No.");

                            end;

                            // end;

                        end;
                    until PeriodTrans.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Journals Created Successfully');
            end;

            trigger OnPreDataItem()
            begin

                LineNumber := 10000;

                //Create batch*****************************************************************************
                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARY');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SALARY';
                    GenJnlBatch.Insert;
                end;
                // End Create Batch

                // Clear the journal Lines
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARY');
                if GeneraljnlLine.Find('-') then
                    GeneraljnlLine.DeleteAll;

                //"Slip/Receipt No":=UPPERCASE(objPeriod."Period Name");
                "Slip/Receipt No" := kk."Period Name";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    Caption = 'Period';
                    TableRelation = "Payroll Calender."."Date Opened";
                    ApplicationArea = All;
                }
                field("Document No"; DocumentNo)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; varPostingDate)
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

    trigger OnPreReport()
    begin

        PeriodFilter := "Payroll Employee.".GetFilter("Current Month Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "Payroll Employee.".GetRangeMin("Current Month Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        PostingDate := CalcDate('1M-1D', SelectedPeriod);

        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    var
        PeriodTrans: Record "prPeriod Transactions.";
        objEmp: Record "Payroll Employee.";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Calender.";
        ControlInfo: Record "Control-Information.";
        strEmpName: Text[150];
        GeneraljnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        "Slip/Receipt No": Code[50];

        Loans: Record "Loans Register";
        LineNumber: Integer;

        LoanAmount: Decimal;

        InterestAmount: Decimal;
        "Salary Card": Record "Payroll Employee.";
        TaxableAmount: Decimal;
        PostingGroup: Record "Payroll Posting Groups.";
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        TransCode: Record "Payroll Transaction Code.";
        PostingDate: Date;
        AmountToDebit: Decimal;
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Jiokoe Savings","Kanisa Savings","Standing Order Charges","Watoto Savings","Withdrawable Savings",Housing,"Holiday Savings";
        EmployerDed: Record "Payroll Employer Deductions.";
        GlobalDim3: Code[10];
        kk: Record "Payroll Calender.";
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        IntText: Text[200];
        varPostingDate: Date;
        Vendors: Record Vendor;

        PayrollTrans: record "Payroll Transaction Code.";

        AccountTypes: Option " ","G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None",Member;


    procedure CreateJnlEntry(AccountType: Option " ","G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None",Member; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Jiokoe Savings","Kanisa Savings","Standing Order Charges","Watoto Savings","Withdrawable Savings",Housing; BalAccountNo: Code[20]; MemberNo: Code[50])
    begin


        if AccountType <> AccountType::Vendor then begin
            if AccountType = Accounttype::Customer then begin
                AccountType := Accounttype::Customer;

                GlobalDime1 := 'BOSA';
            end;
            LineNumber := LineNumber + 100;
            GeneraljnlLine.Init;
            GeneraljnlLine."Journal Template Name" := 'GENERAL';
            GeneraljnlLine."Journal Batch Name" := 'SALARY';
            GeneraljnlLine."Line No." := LineNumber;
            GeneraljnlLine."Document No." := DocumentNo;
            GeneraljnlLine."Loan No" := LoanNo;
            GeneraljnlLine."Transaction Type" := TransType;
            GeneraljnlLine."Posting Date" := varPostingDate;
            if TransType <> Transtype::" " then begin
                GeneraljnlLine."Account Type" := GeneraljnlLine."account type"::Customer;
                GeneraljnlLine."Account No." := AccountNo;
            end else begin
                GeneraljnlLine."Account Type" := GeneraljnlLine."account type"::"G/L Account";
                GeneraljnlLine."Account No." := AccountNo;
            end;
            //GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
            GeneraljnlLine.Description := Description;
            if PostAs = Postas::Debit then begin
                GeneraljnlLine."Debit Amount" := DebitAmount;// ROUND(DebitAmount, 1, '=');
                GeneraljnlLine.Validate("Debit Amount");
            end else begin
                GeneraljnlLine."Credit Amount" := CreditAmount; //ROUND(CreditAmount, 1, '=');
                GeneraljnlLine.Validate("Credit Amount");
            end;
            if GeneraljnlLine.Amount <> 0 then
                GeneraljnlLine.Insert;
        end;



        if AccountType = AccountType::Vendor then begin
            if AccountType = Accounttype::Customer then begin
                AccountType := Accounttype::Customer;

                GlobalDime1 := 'BOSA';
            end;
            LineNumber := LineNumber + 100;
            GeneraljnlLine.Init;
            GeneraljnlLine."Journal Template Name" := 'GENERAL';
            GeneraljnlLine."Journal Batch Name" := 'SALARY';
            GeneraljnlLine."Line No." := LineNumber;
            GeneraljnlLine."Document No." := DocumentNo;
            GeneraljnlLine."Loan No" := LoanNo;
            GeneraljnlLine."Transaction Type" := TransType;
            GeneraljnlLine."Posting Date" := varPostingDate;

            GeneraljnlLine."Account Type" := GeneraljnlLine."account type"::Vendor;
            GeneraljnlLine."Account No." := AccountNo;

            //GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
            GeneraljnlLine.Description := Description;
            if PostAs = Postas::Debit then begin
                GeneraljnlLine."Debit Amount" := DebitAmount;// ROUND(DebitAmount, 1, '=');
                GeneraljnlLine.Validate("Debit Amount");
            end else begin
                GeneraljnlLine."Credit Amount" := CreditAmount; //ROUND(CreditAmount, 1, '=');
                GeneraljnlLine.Validate("Credit Amount");
            end;
            if GeneraljnlLine.Amount <> 0 then
                GeneraljnlLine.Insert;
        end;

    end;


    procedure CreateJnlEntryBal(AccountType: Option " ","G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None",Member; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Jiokoe Savings","Kanisa Savings","Standing Order Charges","Watoto Savings","Withdrawable Savings",Housing; BalAccountNo: Code[20]; MemberNo: Code[50]; BalsAccountNo: Code[20])
    begin

        if AccountType = Accounttype::Customer then begin
            AccountType := Accounttype::Customer;

            GlobalDime1 := 'BOSA';
        end;
        LineNumber := LineNumber + 100;
        GeneraljnlLine.Init;
        GeneraljnlLine."Journal Template Name" := 'GENERAL';
        GeneraljnlLine."Journal Batch Name" := 'SALARY';
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := DocumentNo;
        GeneraljnlLine."Loan No" := LoanNo;
        GeneraljnlLine."Transaction Type" := TransType;
        GeneraljnlLine."Posting Date" := varPostingDate;
        if TransType <> Transtype::" " then begin
            GeneraljnlLine."Account Type" := GeneraljnlLine."account type"::Customer;
            GeneraljnlLine."Account No." := AccountNo;
        end else begin
            GeneraljnlLine."Account Type" := GeneraljnlLine."account type"::"G/L Account";
            GeneraljnlLine."Account No." := AccountNo;
        end;
        //GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        if PostAs = Postas::Debit then begin
            GeneraljnlLine."Debit Amount" := DebitAmount;// ROUND(DebitAmount, 1, '=');
            GeneraljnlLine.Validate("Debit Amount");
        end else begin
            GeneraljnlLine."Credit Amount" := CreditAmount; //ROUND(CreditAmount, 1, '=');
            GeneraljnlLine.Validate("Credit Amount");
        end;
        GeneraljnlLine."Bal. Account Type" := GeneraljnlLine."Bal. Account Type"::"G/L Account";
        GeneraljnlLine."Bal. Account No." := BalsAccountNo;
        if GeneraljnlLine.Amount <> 0 then
            GeneraljnlLine.Insert;
    end;
}



