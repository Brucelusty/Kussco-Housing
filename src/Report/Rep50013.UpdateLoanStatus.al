report 50013 "UpdateLoanStatus"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            RequestFilterFields = "Loan Product Type", "Loan  No.", "Sector Specific";

            // DataItemTableView = where(Posted = const(true));
            // DataItemTableView = where("Loan Product Type" = filter('A03'), Posted = filter(true));
            // DataItemTableView = where("Outstanding Balance" = filter(> 0), Posted = filter(true));
            column(Loan_Status;
            "Loan Status")
            {

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'WTF';
                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DeleteAll();
                end;
            end;

            trigger OnAfterGetRecord()
            var

                loanapp: Record "Loans Register";
                MembersRegister: Record Customer;
                RSchedule: Record "Loan Repayment Schedule";
            begin

                DOCUMENT_NO := 'WRITEOFF';
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                RunBals := 0;

                if FnCheckifWriteoff(Loans."Loan  No.") = true then begin
                    If Loans."Outstanding Interest" < 0 then begin
                        OutInt := 0;
                        OutInt := Loans."Outstanding Interest" * -1;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, Loans."Client Code", Today, OutInt, 'BOSA', Loans."Loan  No.",
                        'Loan Writeoff Recovery', Loans."Loan  No.");
                        RunBals += OutInt;
                    end;

                    If Loans."Outstanding Balance" < 0 then begin
                        OutBal := 0;
                        OutBal := Loans."Outstanding Balance" * -1;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                        GenJournalLine."Account Type"::Customer, Loans."Client Code", Today, OutBal, 'BOSA', Loans."Loan  No.",
                        'Loan Writeoff Recovery', Loans."Loan  No.");
                        RunBals += OutBal;
                    end;


                    if (loans."Outstanding Interest" > 0) and (RunBals > 0) then begin

                        OutsInt := 0;
                        if Loans."Outstanding Interest" > RunBals then
                            OutsInt := RunBals
                        else
                            OutsInt := Loans."Outstanding Interest";
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, Loans."Client Code", Today, -OutsInt, 'BOSA', Loans."Loan  No.",
                        'Interest Writeoff', Loans."Loan  No.");
                        RunBals -= OutsInt;

                    end;


                    if (loans."Outstanding Balance" > 0) and (RunBals > 0) then begin
                        OutsBal := 0;
                        if loans."Outstanding Balance" > RunBals then
                            OutsBal := RunBals
                        else
                            OutsBal := loans."Outstanding Balance";
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                        GenJournalLine."Account Type"::Customer, Loans."Client Code", Today, -OutsBal, 'BOSA', Loans."Loan  No.",
                        'Loan Writeoff', Loans."Loan  No.");
                        RunBals -= OutsBal;
                    end;

                    if (RunBals > 0) then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", '300-000-075', Today, -RunBals, 'BOSA', Loans."Loan  No.",
                        'Writeoff', Loans."Loan  No.");//
                    end;










                end;

                //  end;
                /*                 DataItemName.CalcFields(DataItemName."Outstanding Balance");
                                if (Posted = true) then begin
                                    DataItemName."Loan Status" := DataItemName."Loan Status"::Disbursed;
                                    DataItemName.Modify();
                                end; */

                // Codeunit.Run(131070);
                /*                 DataItemName.CalcFields(DataItemName."Outstanding Balance");
                                if DataItemName."Outstanding Balance" <> 0 then begin
                                    DataItemName.Posted := true;
                                    DataItemName.Modify();
                                end; */

                /*                                 MembersRegister.Reset();
                                                MembersRegister.SetRange(MembersRegister."No.", DataItemName."Client Code");
                                                if MembersRegister.FindFirst() then begin
                                                    //Message('Here%1',MembersRegister."Employer Code");
                                                    DataItemName."Staff No" := MembersRegister."Payroll No";
                                                    //DataItemName."Account No" := MembersRegister."FOSA Account No.";
                                                    DataItemName."ID NO" := MembersRegister."ID No.";
                                                    DataItemName."Client Name" := MembersRegister.Name;
                                                    DataItemName."Phone No.":=MembersRegister."Mobile Phone No";
                                                    DataItemName."Employer Code" := MembersRegister."Employer Code";
                                                    DataItemName.Modify();
                                                end;  */
                //  if data
                //   AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");

                /*                 if loantype.Get("Loan Product Type") then begin
                                    DataItemName."Repayment Method" := loantype."Repayment Method";
                                    DataItemName."Loan Status" := DataItemName."Loan Status"::Issued;
                                    DataItemName."Loan Product Type Name" := loantype."Product Description";
                                    DataItemName.Validate(DataItemName."Loan Disbursement Date");
                                    DataItemName.Modify();
                                end; */
                // Message('%1', LoanType."Interest rate");
                // DataItemName.Interest := loantype."Interest rate";
                // DataItemName."Repayment Method" := loantype."Repayment Method";
                // DataItemName."Loan Product Type Name" := loantype."Product Description";
                // LPrincipal := ROUND(DataItemName."Approved Amount" / DataItemName.Installments, 1, '>');
                // if DataItemName.Installments > 12 then
                ///   LInterest := ROUND((DataItemName.Interest / 12 / 100) * DataItemName."Approved Amount", 1, '>')
                // else
                // LInterest := ROUND((DataItemName.Interest / DataItemName.Installments / 100) * DataItemName."Approved Amount", 1, '>');
                //LPrincipal := TotalMRepay - LInterest;
                //  DataItemName."Loan Status" := DataItemName."Loan Status"::Appraisal;
                //   DataItemName."Approval Status" := DataItemName."Approval Status"::Approved;
                //  DataItemName.Posted:=false;

                // DataItemName.Modify();
                /* 
                                IF (DataItemName.Repayment= 0) then begin
                                    RSchedule.Reset();
                                    RSchedule.SetRange(RSchedule."Loan No.", DataItemName."Loan  No.");
                                    if RSchedule.FindFirst() then begin
                                        AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");
                                        DataItemName."Loan Principle Repayment" := Round(RSchedule."Principal Repayment", 1, '>');
                                        DataItemName."Loan Interest Repayment" := Round(RSchedule."Monthly Interest", 1, '>');
                                        DataItemName.Repayment := Round(RSchedule."Monthly Repayment", 1, '>');
                                        DataItemName.Modify();
                                    end;
                                end; */


                /*           if (DataItemName."Approved Amount" = 0) and (DataItemName."Requested Amount" <> 0) then begin
                              DataItemName."Approved Amount" := DataItemName."Requested Amount";
                              DataItemName.Modify();
                          end; */

                /*    if DataItemName."Sector Specific" = '' then begin
                        if DataItemName."Loan Product Type" = 'L01' then begin
                            DataItemName."Main Sector" := '6000';
                            DataItemName."Sub Sector" := '6100';
                            DataItemName."Sub-Sector" := '6100';
                            DataItemName."Specific Sector" := '6210';
                            DataItemName."Sector Specific" := '6210';
                        end;

                        if DataItemName."Loan Product Type" = 'L02' then begin
                            DataItemName."Main Sector" := '4000';
                            DataItemName."Sub Sector" := '4100';
                            DataItemName."Sub-Sector" := '4100';
                            DataItemName."Specific Sector" := '4120';
                            DataItemName."Sector Specific" := '4120';
                        end;

                        if DataItemName."Loan Product Type" = 'L04' then begin
                            DataItemName."Main Sector" := '4000';
                            DataItemName."Sub Sector" := '4100';
                            DataItemName."Sub-Sector" := '4100';
                            DataItemName."Specific Sector" := '4110';
                            DataItemName."Sector Specific" := '4110';
                        end;

                        if DataItemName."Loan Product Type" = 'L06' then begin
                            DataItemName."Main Sector" := '6000';
                            DataItemName."Sub Sector" := '6100';
                            DataItemName."Sub-Sector" := '6100';
                            DataItemName."Specific Sector" := '6210';
                            DataItemName."Sector Specific" := '6210';
                        end;


                        if DataItemName."Loan Product Type" = 'L11' then begin
                            DataItemName."Main Sector" := '6000';
                            DataItemName."Sub Sector" := '6100';
                            DataItemName."Sub-Sector" := '6100';
                            DataItemName."Specific Sector" := '6210';
                            DataItemName."Sector Specific" := '6210';
                        end;

                        if DataItemName."Loan Product Type" = 'L14' then begin
                            DataItemName."Main Sector" := '6000';
                            DataItemName."Sub Sector" := '6100';
                            DataItemName."Sub-Sector" := '6100';
                            DataItemName."Specific Sector" := '6210';
                            DataItemName."Sector Specific" := '6210';
                        end;

                        if DataItemName."Loan Product Type" = 'A02' then begin
                            DataItemName."Main Sector" := '5000';
                            DataItemName."Sub Sector" := '5100';
                            DataItemName."Sub-Sector" := '5100';
                            DataItemName."Specific Sector" := '5110';
                            DataItemName."Sector Specific" := '5110';
                        end;


                        if DataItemName."Loan Product Type" = 'A10' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;

                        if DataItemName."Loan Product Type" = 'A07' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;


                        if DataItemName."Loan Product Type" = 'A05' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;


                        if DataItemName."Loan Product Type" = 'A12' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;

                        if DataItemName."Loan Product Type" = 'A01' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;

                        if DataItemName."Loan Product Type" = 'A12' then begin
                            DataItemName."Main Sector" := '2000';
                            DataItemName."Sub Sector" := '2100';
                            DataItemName."Sub-Sector" := '2100';
                            DataItemName."Specific Sector" := '2120';
                            DataItemName."Sector Specific" := '2120';
                        end;

                        if DataItemName."Loan Product Type" = 'L16' then begin
                            DataItemName."Main Sector" := '6000';
                            DataItemName."Sub Sector" := '6200';
                            DataItemName."Sub-Sector" := '6200';
                            DataItemName."Specific Sector" := '6210';
                            DataItemName."Sector Specific" := '6210';
                        end;

                        if DataItemName."Loan Product Type" = 'A11' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;

                        if DataItemName."Loan Product Type" = 'A20' then begin
                            DataItemName."Main Sector" := '4000';
                            DataItemName."Sub Sector" := '4100';
                            DataItemName."Sub-Sector" := '4100';
                            DataItemName."Specific Sector" := '4110';
                            DataItemName."Sector Specific" := '4110';
                        end;

                        if DataItemName."Loan Product Type" = 'A03' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;

                        if DataItemName."Loan Product Type" = 'A16' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;


                        if DataItemName."Loan Product Type" = 'M_OD' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;

                        if DataItemName."Loan Product Type" = 'A14' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;

                        if DataItemName."Loan Product Type" = 'L05' then begin
                            DataItemName."Main Sector" := '8000';
                            DataItemName."Sub Sector" := '8200';
                            DataItemName."Sub-Sector" := '8200';
                            DataItemName."Specific Sector" := '8210';
                            DataItemName."Sector Specific" := '8210';
                        end;

                        if DataItemName."Loan Product Type" = 'A13' then begin
                            DataItemName."Main Sector" := '4000';
                            DataItemName."Sub Sector" := '4100';
                            DataItemName."Sub-Sector" := '4100';
                            DataItemName."Specific Sector" := '4110';
                            DataItemName."Sector Specific" := '4110';
                        end;

                        if DataItemName."Loan Product Type" = 'A18' then begin
                                                 DataItemName."Main Sector" := '4000';
                                                DataItemName."Sub Sector" := '4100';
                                                DataItemName."Sub-Sector" := '4100';
                                                DataItemName."Specific Sector" := '4110'; 
             DataItemName."Sector Specific" := '4110';
        end;
        if DataItemName."Loan Product Type" = 'A19' then begin
              DataItemName."Main Sector" := '6000';
             DataItemName."Sub Sector" := '6100';
              DataItemName."Sub-Sector" := '6100';
            DataItemName."Specific Sector" := '6210';
            DataItemName."Sector Specific" := '6210';
        end;

        if DataItemName."Loan Product Type" = 'L20' then begin
                                DataItemName."Main Sector" := '8000';
                                DataItemName."Sub Sector" := '8300';
                                DataItemName."Sub-Sector" := '8300';
                                DataItemName."Specific Sector" := '8310'; 
            DataItemName."Sector Specific" := '8310';
        end;

        if DataItemName."Loan Product Type" = 'A17' then begin
                                 DataItemName."Main Sector" := '8000';
                                DataItemName."Sub Sector" := '8400';
                                DataItemName."Sub-Sector" := '8400';
                                DataItemName."Specific Sector" := '8410'; 
            DataItemName."Sector Specific" := '8410';
        end;

        if DataItemName."Loan Product Type" = 'L12' then begin
                                 DataItemName."Main Sector" := '8000';
                                DataItemName."Sub Sector" := '8400';
                                DataItemName."Sub-Sector" := '8400';
                                DataItemName."Specific Sector" := '8410'; 
            DataItemName."Sector Specific" := '8210';
        end;

        if DataItemName."Loan Product Type" = 'L12' then begin
                                 DataItemName."Main Sector" := '8000';
                                DataItemName."Sub Sector" := '8400';
                                DataItemName."Sub-Sector" := '8400';
                                DataItemName."Specific Sector" := '8410'; 
            DataItemName."Sector Specific" := '8210';
        end;

        if DataItemName."Loan Product Type" = 'L13' then begin

            DataItemName."Sector Specific" := '6210';
        end;
        if DataItemName."Loan Product Type" = 'L07' then begin

            DataItemName."Sector Specific" := '5110';
        end;
        if DataItemName."Loan Product Type" = 'L09' then begin

            DataItemName."Sector Specific" := '2220';
        end;

        if DataItemName."Loan Product Type" = 'L17' then begin

            DataItemName."Sector Specific" := '8310';
        end;
        if DataItemName."Loan Product Type" = 'L15' then begin

            DataItemName."Sector Specific" := '8310';
        end;
        DataItemName.Validate(DataItemName."Sector Specific");
        DataItemName.Modify();

     end;  */


                //  if DataItemName."Loan Product Type" = 'A03' then begin
                //   DataItemName."Recovery Mode" := DataItemName."Recovery Mode"::Mobile;
                //   DataItemName.Modify();
                //end;
                //     if DataItemName."Repayment Start Date" = 0D then begin
                //        DataItemName."Repayment Start Date" := CalcDate('1M', DataItemName."Issued Date");
                //  end;
                //DataItemName."Repayment Frequency" := DataItemName."Repayment Frequency"::Monthly;
                //if DataItemName."Loan Product Type" <> 'SALARY IN ADVANCE' then begin
                // DataItemName."Repayment Frequency" := DataItemName."Repayment Frequency"::Monthly;
                //if DataItemName.Interest <> 0 then begin
                //  AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");
                //  end;
                // DataItemName.Validate(DataItemName."Loan Disbursement Date");
                //DataItemName.Modify();
                // loantype.Get(DataItemName."Loan Product Type");
                // if DataItemName.Interest = 0 then begin
                // DataItemName.Interest := loantype."Interest rate";

                //DataItemName.Modify(true);
                //end;
                // if DataItemName."Approved Amount"=0 then begin

                //  end;
                //if DataItemName.Interest<>0 then begin 
                //AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");
                //end;
                //   DataItemName."Recovery Mode":=DataItemName."Recovery Mode"::Salary;
                //   if  (DataItemName."Loan Disbursement Date"<=20231231D) then begin 
                //if (DataItemName.Interest <> 0) then begin
                //   AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");
                //end;
                //else
                //if (DataItemName.Interest=0) and (DataItemName."Repayment Start Date"<>0D) and (DataItemName."Recovery Mode"=DataItemName."Recovery Mode") then begin 

                //   loantype.Get(DataItemName."Loan Product Type");
                ///if loantype."Non Recurring Interest"=true then begin
                //  AuFactory.FnGenerateLoanRepaymentScheduleZero(DataItemName."Loan  No."); 
                //  end;
                // end;  
                //  end;
                ///  AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");
                // end
                /*                            IF DataItemName."Loan Disbursement Date" <> 0D then begin
                                                IntDate := Date2DMY(DataItemName."Loan Disbursement Date", 1);
                                                // Message('IntDate%1',IntDate);


                                                    if IntDate < 24 then begin
                                                        DataItemName."Repayment Start Date" := CalcDate('CM', DataItemName."Loan Disbursement Date");
                                                    end;
                                                    if IntDate > 23 then begin
                                                        DataItemName."Repayment Start Date" := CalcDate('1M', CalcDate('CM', DataItemName."Loan Disbursement Date"));                        
                                                    end;
                                                    DataItemName.Modify();
                                                end;  */
                //  DataItemName."Loan Status":=DataItemName."Loan Status"::Issued;
                //    DataItemName.Modify(); 

                // DataItemName.CalcFields(DataItemName."Outstanding Balance");
                // if DataItemName."Outstanding Balance" > 0 then begin
                //  DataItemName."Loan Status" := DataItemName."Loan Status"::Issued;
                //  DataItemName."Approval Status" := DataItemName."Approval Status"::Approved;
                // DataItemName.Posted := true;
                //DataItemName."Loan Disbursement Date" := DataItemName."Application Date";
                /*                 if DataItemName."Repayment Frequency" <> DataItemName."Repayment Frequency"::Monthly then begin
                                    DataItemName."Repayment Frequency" := DataItemName."Repayment Frequency"::Monthly;
                                    DataItemName.Modify();
                                end; */
                //  end;

                /*                if (DataItemName."Loan Disbursement Date" <> 0D) and (DataItemName."Repayment Start Date" = 0D) then begin

                                    loantype.Get("Loan Product Type");
                                    DataItemName."Repayment Method" := loantype."Repayment Method";
                                    DataItemName."Loan Status" := DataItemName."Loan Status"::Issued;
                                    DataItemName."Loan Product Type Name" := loantype."Product Description";
                                    DataItemName.Posted := true;
                                    DataItemName.Validate(DataItemName."Loan Disbursement Date");
                                    DataItemName.Modify();

                                end; */

                /*                 if DataItemName.Interest = 0 then begin
                                    loantype.Get("Loan Product Type");
                                    DataItemName.Interest:=loantype."Interest rate";
                                    DataItemName.Modify();
                                end; */
                // if CalcDate('CM', CalcDate(Format(1) + 'M', DataItemName."Repayment Start Date")) = DataItemName."Repayment Start Date" then
                // CurrReport.Skip();
                /*                                 if (DataItemName."Loan Disbursement Date" = 0D) then begin
                                                    DataItemName."Loan Disbursement Date":=DataItemName."Application Date";
                                                    DataItemName.Validate(DataItemName."Loan Disbursement Date");
                                                   // DataItemName."Repayment Start Date" := DataItemName."Loan Disbursement Date";
                                                   // DataItemName."Expected Date of Completion" := CalcDate('CM', CalcDate(Format(DataItemName.Installments) + 'M', DataItemName."Repayment Start Date"));
                                                    DataItemName.Modify();
                                                    AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");
                                                end;  */

                /*                 if DataItemName."Loan Product Type"='DIVIDENDS ADVANCE' then begin
                                DataItemName."Recovery Mode":=DataItemName."Recovery Mode"::"Dividend Processing";
                                DataItemName.Modify();
                                end; */

                /*              loanapp.Reset();
                                loanapp.SetRange(loanapp."Loan  No.", DataItemName."Loan  No.");
                                if loanapp.FindFirst() then begin */
                //    loantype.Reset();
                // loantype.SetRange(loantype.Code, DataItemName."Loan Product Type");
                /// if loantype.FindFirst() then begin
                //    DataItemName."Loan Product Type Name":=loantype."Product Description";
                //     DataItemName.Modify();
                // end;
                // end; 
                //      BATCH_TEMPLATE := 'GENERAL';
                /*                 BATCH_NAME := 'RECOVERY';
                                DOCUMENT_NO := 'INT 13/06/2024';


                                Customer.Get(DataItemName."Client Code");
                                DataItemName.CalcFields(DataItemName."Outstanding Balance", DataItemName."Outstanding Interest", DataItemName."Outstanding Penalty"); */
                // if DataItemName."Outstanding Balance" < 0 then begin
                //     LineNo := LineNo + 10000;
                //     SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                //     GenJournalLine."Account Type"::Customer, Customer."No.", Today, -DataItemName."Outstanding Balance", 'FOSA', DOCUMENT_NO,
                //      'Loan Repayment' + ' ' + Customer."No.", DataItemName."Loan  No.");


                //     RunBal := -DataItemName."Outstanding Balance";

                //     if DataItemName."Outstanding Interest" > 0 then begin
                //         OutInt := 0;
                //         if RunBal > DataItemName."Outstanding Interest" then
                //             OutInt := DataItemName."Outstanding Interest"
                //         else
                //             OutInt := RunBal;

                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                //         GenJournalLine."Account Type"::Customer, Customer."No.", Today, OutInt * -1, 'FOSA', DOCUMENT_NO,
                //          'Interest Repayment' + ' ' + Customer."No.", DataItemName."Loan  No.");
                //         RunBal := RunBal - OutInt;
                //     end;

                //     if DataItemName."Outstanding Penalty" > 0 then begin
                //         IF DataItemName."Outstanding Penalty" > 0 THEN begin
                //             Penalty := 0;
                //             IF RunBal > DataItemName."Outstanding Penalty" then
                //                 Penalty := DataItemName."Outstanding Penalty"
                //             ELSE
                //                 Penalty := RunBal;

                //             LineNo := LineNo + 10000;
                //             SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Paid",
                //             GenJournalLine."Account Type"::Customer, Customer."No.", Today, Penalty * -1, 'FOSA', DOCUMENT_NO,
                //              'Loan Penalty Repayment' + ' ' + Customer."No.", DataItemName."Loan  No.");
                //             RunBal := RunBal - Penalty;

                //         end;
                //     end;

                //     if RunBal > 0 then begin
                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         GenJournalLine."Account Type"::Vendor, Customer."Deposits Account No", Today, RunBal * -1, 'FOSA', DOCUMENT_NO,
                //          'Excess Loan' + ' ' + Customer."No.", DataItemName."Loan  No.");
                //     end;


                // end;



                /*                 DataItemName.CalcFields(DataItemName."Outstanding Balance", DataItemName."Outstanding Interest", DataItemName."Outstanding Penalty");
                                if DataItemName."Outstanding Interest" < 0 then begin
                                    loantype.Get(DataItemName."Loan Product Type");
                                    OutInt := 0;
                                    OutInt := -DataItemName."Outstanding Interest";
                                    LineNo := LineNo + 10000;
                                    AuFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                                    GenJournalLine."Account Type"::Customer, DataItemName."Client Code", Today, (OutInt), FORMAT(DataItemName.Source), DataItemName."Loan  No.",
                                    'Interest Charged', DataItemName."Loan  No.", GenJournalLine."Application Source"::" ", GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account");


                                END; */


                /*                 if DataItemName."Archive Loan"=true then begin 
                DataItemName."Loan Status":=DataItemName."Loan Status"::Rejected;
                DataItemName."Approval Status":=DataItemName."Approval Status"::Rejected;
                DataItemName.Modify(); */
                //   end;




            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                //Paybill.UpdateSchedule();
                // LoansSeeping.SweepDefaultedLoans();
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

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        myInt: Integer;
        AuFactory: Codeunit "Au Factory";
        RunBal: Decimal;

        OutBal: Decimal;

        Penalty: Decimal;
        OutInt: Decimal;
        LoansSeeping: Codeunit "Loan Sweeping";
        // AUFactory: Codeunit "Au Factory";
        LineNo: Integer;
        BATCH_TEMPLATE: Code[60];
        BATCH_NAME: Code[80];
        DOCUMENT_NO: Code[40];

        OutsBal: Decimal;

        OutsInt: Decimal;
        SFactory: Codeunit "SURESTEP FactoryMobile";
        Customer: Record Customer;
        Paybill: Codeunit "AU Paybill Automations";
        TotalMRepay: Decimal;
        LInterest: Decimal;
        loantype: Record "Loan Products Setup";
        GenJournalLine: Record "Gen. Journal Line";
        LPrincipal: Decimal;
        IntDate: Integer;
        LoanregisterCopy: Record "Loans Register";
        Classify: Codeunit "Classify Loans";
        DetCust: Record "Detailed Cust. Ledg. Entry";

        RunBals: Decimal;

    procedure FnCheckifWriteoff(Loan: Code[40]) WriteOff: boolean

    begin
        WriteOff := false;
        DetCust.Reset();
        DetCust.SetRange(DetCust."Loan No", Loan);
        DetCust.SetRange(DetCust."Document No.", 'WRITEOFF');
        DetCust.SetRange(DetCust.Reversed, false);
        if DetCust.FindFirst() then begin
            WriteOff := true;
        end;
    end;

}
