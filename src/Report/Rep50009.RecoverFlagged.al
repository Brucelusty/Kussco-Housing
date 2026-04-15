report 50009 "Recover Flagged"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(DataItemName; Customer)
        {
            RequestFilterFields = Status, "Membership Status";

            DataItemTableView = where(IsNormalMember = filter(true));
            // DataItemTableView = where("Loan Product Type" = filter(''));
            // DataItemTableView = where("Outstanding Balance" = filter(> 0), Posted = filter(true));
            column(No_; "No.")
            {

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                /*                 BATCH_TEMPLATE := 'GENERAL';
                                BATCH_NAME := 'RECOVERY';
                                GenJournalLine.Reset();
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                                if GenJournalLine.FindSet() then begin
                                    GenJournalLine.DeleteAll();
                                end; */
            end;

            trigger OnAfterGetRecord()
            var

                loanapp: Record "Loans Register";
                MembersRegister: Record Customer;
                RSchedule: Record "Loan Repayment Schedule";
            begin
                DataItemName.CalcFields(DataItemName."Shares Retained", DataItemName."Current Shares", DataItemName."Total Loan Balance", DataItemName."Ordinary Savings");
                /*                 if (DataItemName."Shares Retained" = 0) and (DataItemName."Current Shares" = 0) and (DataItemName."Total Loan Balance" > 0) and (DataItemName."Ordinary Savings" > 0) then begin
                                    DataItemName.Status := DataItemName.Status::Dormant;
                                    DataItemName."Membership Status" := DataItemName."Membership Status"::Dormant;
                                    DataItemName.Modify();

                                    Vendor.Reset();
                                    Vendor.SetRange(Vendor."BOSA Account No", DataItemName."No.");
                                    if Vendor.FindSet() then begin
                                        repeat
                                            Vendor.Status := Vendor.Status::Dormant;
                                            Vendor.Blocked := Vendor.Blocked::" ";
                                            Vendor.Modify();
                                        until Vendor.Next() = 0;
                                    end;
                                end;
                 */
                if (DataItemName."Shares Retained" > 0) or (DataItemName."Current Shares" > 0) or (DataItemName."Total Loan Balance" <> 0) or (DataItemName."Ordinary Savings" <> 0) then begin
                    DataItemName.Status := DataItemName.Status::Dormant;
                    DataItemName."Membership Status" := DataItemName."Membership Status"::Dormant;
                    DataItemName.Modify();

                    Vendor.Reset();
                    Vendor.SetRange(Vendor."BOSA Account No", DataItemName."No.");
                    if Vendor.FindSet() then begin
                        repeat
                            Vendor.Status := Vendor.Status::Dormant;
                            Vendor.Blocked := Vendor.Blocked::" ";
                            Vendor.Modify();
                        until Vendor.Next() = 0;
                    end;

                end;



                /*                 DataItemName.CalcFields(DataItemName."Outstanding Balance");
                                if (DataItemName."Outstanding Balance"<>0) and (Posted=false) then begin
                                    DataItemName.Posted:=true;
                                    DataItemName.Modify();
                                end; */

                // Codeunit.Run(131070);

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

                /*                 if DataItemName."Sector Specific" = '' then begin
                                    if DataItemName."Loan Product Type" = 'L01' then begin
                                        // DataItemName."Main Sector" := '6000';
                                        // DataItemName."Sub Sector" := '6100';
                                        // DataItemName."Sub-Sector" := '6100';
                                        // DataItemName."Specific Sector" := '6210';
                                        DataItemName."Sector Specific" := '6210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'L02' then begin
                                        // DataItemName."Main Sector" := '4000';
                                        // DataItemName."Sub Sector" := '4100';
                                        // DataItemName."Sub-Sector" := '4100';
                                        // DataItemName."Specific Sector" := '4120';
                                        DataItemName."Sector Specific" := '4120';
                                    end;

                                    if DataItemName."Loan Product Type" = 'L04' then begin
                                        // DataItemName."Main Sector" := '4000';
                                        // DataItemName."Sub Sector" := '4100';
                                        // DataItemName."Sub-Sector" := '4100';
                                        // DataItemName."Specific Sector" := '4110';
                                        DataItemName."Sector Specific" := '4110';
                                    end;

                                    if DataItemName."Loan Product Type" = 'L06' then begin
                                        // DataItemName."Main Sector" := '6000';
                                        // DataItemName."Sub Sector" := '6100';
                                        // DataItemName."Sub-Sector" := '6100';
                                        // DataItemName."Specific Sector" := '6210';
                                        DataItemName."Sector Specific" := '6210';
                                    end;


                                    if DataItemName."Loan Product Type" = 'L11' then begin
                                        // DataItemName."Main Sector" := '6000';
                                        // DataItemName."Sub Sector" := '6100';
                                        // DataItemName."Sub-Sector" := '6100';
                                        // DataItemName."Specific Sector" := '6210';
                                        DataItemName."Sector Specific" := '6210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'L14' then begin
                                        // DataItemName."Main Sector" := '6000';
                                        // DataItemName."Sub Sector" := '6100';
                                        // DataItemName."Sub-Sector" := '6100';
                                        // DataItemName."Specific Sector" := '6210';
                                        DataItemName."Sector Specific" := '6210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A02' then begin
                                        // DataItemName."Main Sector" := '5000';
                                        // DataItemName."Sub Sector" := '5100';
                                        // DataItemName."Sub-Sector" := '5100';
                                        // DataItemName."Specific Sector" := '5110';
                                        DataItemName."Sector Specific" := '5110';
                                    end;


                                    if DataItemName."Loan Product Type" = 'A10' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A07' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;


                                    if DataItemName."Loan Product Type" = 'A05' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;


                                    if DataItemName."Loan Product Type" = 'A12' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A01' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A12' then begin
                                        // DataItemName."Main Sector" := '2000';
                                        // DataItemName."Sub Sector" := '2100';
                                        // DataItemName."Sub-Sector" := '2100';
                                        // DataItemName."Specific Sector" := '2120';
                                        DataItemName."Sector Specific" := '2120';
                                    end;

                                    if DataItemName."Loan Product Type" = 'L16' then begin
                                        // DataItemName."Main Sector" := '6000';
                                        // DataItemName."Sub Sector" := '6200';
                                        // DataItemName."Sub-Sector" := '6200';
                                        // DataItemName."Specific Sector" := '6210';
                                        DataItemName."Sector Specific" := '6210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A11' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A20' then begin
                                        // DataItemName."Main Sector" := '4000';
                                        // DataItemName."Sub Sector" := '4100';
                                        // DataItemName."Sub-Sector" := '4100';
                                        // DataItemName."Specific Sector" := '4110';
                                        DataItemName."Sector Specific" := '4110';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A03' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A16' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;


                                    if DataItemName."Loan Product Type" = 'M_OD' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A14' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'L05' then begin
                                        // DataItemName."Main Sector" := '8000';
                                        // DataItemName."Sub Sector" := '8200';
                                        // DataItemName."Sub-Sector" := '8200';
                                        // DataItemName."Specific Sector" := '8210';
                                        DataItemName."Sector Specific" := '8210';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A13' then begin
                                        // DataItemName."Main Sector" := '4000';
                                        // DataItemName."Sub Sector" := '4100';
                                        // DataItemName."Sub-Sector" := '4100';
                                        // DataItemName."Specific Sector" := '4110';
                                        DataItemName."Sector Specific" := '4110';
                                    end;

                                    if DataItemName."Loan Product Type" = 'A18' then begin
                                        /*                     DataItemName."Main Sector" := '4000';
                                                            DataItemName."Sub Sector" := '4100';
                                                            DataItemName."Sub-Sector" := '4100';
                                                            DataItemName."Specific Sector" := '4110'; */
                //         DataItemName."Sector Specific" := '4110';
                //     end;
                //     if DataItemName."Loan Product Type" = 'A19' then begin
                //         //  DataItemName."Main Sector" := '6000';
                //         // DataItemName."Sub Sector" := '6100';
                //         //  DataItemName."Sub-Sector" := '6100';
                //         //DataItemName."Specific Sector" := '6210';
                //         DataItemName."Sector Specific" := '6210';
                //     end;

                //     if DataItemName."Loan Product Type" = 'L20' then begin
                //         /*                     DataItemName."Main Sector" := '8000';
                //                             DataItemName."Sub Sector" := '8300';
                //                             DataItemName."Sub-Sector" := '8300';
                //                             DataItemName."Specific Sector" := '8310'; */
                //         DataItemName."Sector Specific" := '8310';
                //     end;

                //     if DataItemName."Loan Product Type" = 'A17' then begin
                //         /*                     DataItemName."Main Sector" := '8000';
                //                             DataItemName."Sub Sector" := '8400';
                //                             DataItemName."Sub-Sector" := '8400';
                //                             DataItemName."Specific Sector" := '8410'; */
                //         DataItemName."Sector Specific" := '8410';
                //     end;

                //     if DataItemName."Loan Product Type" = 'L12' then begin
                //         /*                     DataItemName."Main Sector" := '8000';
                //                             DataItemName."Sub Sector" := '8400';
                //                             DataItemName."Sub-Sector" := '8400';
                //                             DataItemName."Specific Sector" := '8410'; */
                //         DataItemName."Sector Specific" := '8210';
                //     end;

                //     if DataItemName."Loan Product Type" = 'L12' then begin
                //         /*                     DataItemName."Main Sector" := '8000';
                //                             DataItemName."Sub Sector" := '8400';
                //                             DataItemName."Sub-Sector" := '8400';
                //                             DataItemName."Specific Sector" := '8410'; */
                //         DataItemName."Sector Specific" := '8210';
                //     end;

                //     if DataItemName."Loan Product Type" = 'L13' then begin

                //         DataItemName."Sector Specific" := '6210';
                //     end;
                //     if DataItemName."Loan Product Type" = 'L07' then begin

                //         DataItemName."Sector Specific" := '5110';
                //     end;
                //     if DataItemName."Loan Product Type" = 'L09' then begin

                //         DataItemName."Sector Specific" := '2220';
                //     end;

                //     if DataItemName."Loan Product Type" = 'L17' then begin

                //         DataItemName."Sector Specific" := '8310';
                //     end;
                //     if DataItemName."Loan Product Type" = 'L15' then begin

                //         DataItemName."Sector Specific" := '8310';
                //     end;
                //     DataItemName.Validate(DataItemName."Sector Specific");
                //     DataItemName.Modify();

                // end; */


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
                // AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");
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
                //if (DataItemName."Repayment Start Date"=0D) and (DataItemName."Loan Disbursement Date"<>0D) then begin 
                //DataItemName.Validate(DataItemName."Loan Disbursement Date");
                // DataItemName.Modify();
                // end;
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

                /*                                  if (DataItemName."Loan Disbursement Date" <> 0D) then begin
                                    DataItemName."Expected Date of Completion" := CalcDate('CM', CalcDate(Format(DataItemName.Installments) + 'M', DataItemName."Repayment Start Date"));
                                    DataItemName.Modify();
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
                /*                 BATCH_TEMPLATE := 'GENERAL';
                                BATCH_NAME := 'RECOVERY';
                                DOCUMENT_NO := 'MOBILEWITH 14/06/2024';


                                Customer.Get(DataItemName."BOSA Account No");
                                DataItemName.CalcFields("Flagged Transactions"); */
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



                // DataItemName.CalcFields(DataItemName."Flagged Transactions", DataItemName.Balance);
                // if DataItemName."Flagged Transactions" > 0 then begin
                //     AmountToDebit := 0;
                //     IntrestOnFlagged := 0;
                //     AmountToDebit := Round(DataItemName."Flagged Transactions", 0.01, '=');

                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                // GenJournalLine."Account Type"::Vendor, DataItemName."No.", Today, AmountToDebit, 'FOSA', DOCUMENT_NO,
                //  'Mobile Transaction' + ' ' + DataItemName."No.", '');


                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                // GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, -AmountToDebit, 'FOSA', DOCUMENT_NO,
                //  'Mobile Transaction' + ' ' + DataItemName."No.", '');

                // if AuFactory.FnCalculateAvailableBalanceKit(DataItemName."No.") > 0 then begin
                //     OverdranAmount := 0;
                //     OverdranAmount := AuFactory.FnCalculateAvailableBalanceKit(DataItemName."No.") - AmountToDebit;
                //     if OverdranAmount < 0 then begin
                //         OverdranAmount := -OverdranAmount;
                //         IntrestOnFlagged := Round((7 / 100 * OverdranAmount),0.01,'=');
                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         GenJournalLine."Account Type"::Vendor, DataItemName."No.", Today, IntrestOnFlagged, 'FOSA', DOCUMENT_NO,
                //          'Interest On OverDraft' + ' ' + DataItemName."No.", '');

                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         GenJournalLine."Account Type"::"G/L Account", '300-000-035', Today, -IntrestOnFlagged, 'FOSA', DOCUMENT_NO,
                //          'Interest On OverDraft' + ' ' + DataItemName."No.", '');


                //         ChargeAmount := 0;

                //         GraduatedCharge.Reset;
                //         if GraduatedCharge.Find('-') then begin
                //             repeat
                //                 if (OverdranAmount >= GraduatedCharge."Min Band") and (OverdranAmount <= GraduatedCharge."Upper Band") then begin
                //                     VendorComm := 0;
                //                     ChargeAmount := 0;
                //                     ExciseDuty := 0;
                //                     MpesaComm := 0;
                //                     TotalAmount := 0;
                //                     ChargeAmount := GraduatedCharge.Total;
                //                     VendorComm := GraduatedCharge."Vendor Comm";
                //                     SaccoCommission := GraduatedCharge."Sacco Comm";
                //                     MpesaComm := GraduatedCharge.Mpesa;
                //                     ExciseDuty := GraduatedCharge."Excise Duty";
                //                     TotalAmount := GraduatedCharge.Total;
                //                     MpesaCommAccount := GraduatedCharge."Mpesa Account";
                //                     VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                //                     SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                //                 end;
                //             until GraduatedCharge.Next = 0;
                //         end;
                //         // LineNo := LineNo + 10000;
                //         // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         // GenJournalLine."Account Type"::Vendor, DataItemName."No.", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
                //         //  'Mobile charges' + ' ' + DataItemName."No.", '');//


                //         // LineNo := LineNo + 10000;
                //         // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         // GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
                //         //  'Mobile Trans Mpesa' + ' ' + DataItemName."No.", '');

                //         // LineNo := LineNo + 10000;
                //         // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         // GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
                //         //  'Mobile Trans Mpesa Comm' + ' ' + DataItemName."No.", '');

                //         // LineNo := LineNo + 10000;
                //         // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         // GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
                //         //  'Mobile Trans Mpesa Comm' + ' ' + DataItemName."No.", '');

                //         // SaccoGen.Get();
                //         // LineNo := LineNo + 10000;
                //         // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         // GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
                //         //  'Excise Duty Mpesa Comm' + ' ' + DataItemName."No.", '');
                //     end;
                //     if OverdranAmount > 0 then begin
                //      ChargeAmount := 0;

                //         GraduatedCharge.Reset;
                //         if GraduatedCharge.Find('-') then begin
                //             repeat
                //                 if (AmountToDebit >= GraduatedCharge."Min Band") and (AmountToDebit <= GraduatedCharge."Upper Band") then begin
                //                     VendorComm := 0;
                //                     ChargeAmount := 0;
                //                     ExciseDuty := 0;
                //                     MpesaComm := 0;
                //                     TotalAmount := 0;
                //                     ChargeAmount := GraduatedCharge.Total;
                //                     VendorComm := GraduatedCharge."Vendor Comm";
                //                     SaccoCommission := GraduatedCharge."Sacco Comm";
                //                     MpesaComm := GraduatedCharge.Mpesa;
                //                     ExciseDuty := GraduatedCharge."Excise Duty";
                //                     TotalAmount := GraduatedCharge.Total;
                //                     MpesaCommAccount := GraduatedCharge."Mpesa Account";
                //                     VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                //                     SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                //                 end;
                //             until GraduatedCharge.Next = 0;
                //         end;
                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         GenJournalLine."Account Type"::Vendor, DataItemName."No.", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
                //          'Mobile charges' + ' ' + DataItemName."No.", '');//


                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
                //          'Mobile Trans Mpesa' + ' ' + DataItemName."No.", '');

                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
                //          'Mobile Trans Mpesa Comm' + ' ' + DataItemName."No.", '');

                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
                //          'Mobile Trans Mpesa Comm' + ' ' + DataItemName."No.", '');

                //         SaccoGen.Get();
                //         LineNo := LineNo + 10000;
                //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //         GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
                //          'Excise Duty Mpesa Comm' + ' ' + DataItemName."No.", ''); */

                //     end;

                // end;
                // if AuFactory.FnCalculateAvailableBalanceKit(DataItemName."No.") = 0 then begin

                // ChargeAmount := 0;

                // GraduatedCharge.Reset;
                // if GraduatedCharge.Find('-') then begin
                //     repeat
                //         if (AmountToDebit >= GraduatedCharge."Min Band") and (AmountToDebit <= GraduatedCharge."Upper Band") then begin
                //             VendorComm := 0;
                //             ChargeAmount := 0;
                //             ExciseDuty := 0;
                //             MpesaComm := 0;
                //             TotalAmount := 0;
                //             ChargeAmount := GraduatedCharge.Total;
                //             VendorComm := GraduatedCharge."Vendor Comm";
                //             SaccoCommission := GraduatedCharge."Sacco Comm";
                //             MpesaComm := GraduatedCharge.Mpesa;
                //             ExciseDuty := GraduatedCharge."Excise Duty";
                //             TotalAmount := GraduatedCharge.Total;
                //             MpesaCommAccount := GraduatedCharge."Mpesa Account";
                //             VendorCommAccount := GraduatedCharge."Vendor Comm G/L";
                //             SaccoCommissionAccount := GraduatedCharge."Sacco Comm G/L";
                //         end;
                //     until GraduatedCharge.Next = 0;
                // end;
                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                // GenJournalLine."Account Type"::Vendor, DataItemName."No.", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
                //  'Mobile charges' + ' ' + DataItemName."No.", '');//


                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                // GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
                //  'Mobile Trans Mpesa' + ' ' + DataItemName."No.", '');

                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                // GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
                //  'Mobile Trans Mpesa Comm' + ' ' + DataItemName."No.", '');

                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                // GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
                //  'Mobile Trans Mpesa Comm' + ' ' + DataItemName."No.", '');

                // SaccoGen.Get();
                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                // GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseDuty * -1, 'FOSA', DOCUMENT_NO,
                //  'Excise Duty Mpesa Comm' + ' ' + DataItemName."No.", '');
                /*                         OverdranAmount := 0;
                                        OverdranAmount := AuFactory.FnCalculateAvailableBalanceKit(DataItemName."No.") - AmountToDebit;
                                        IF OverdranAmount<0 then
                                        OverdranAmount:=-OverdranAmount;

                                        Members.Reset();
                                        Members.SetRange(Members."FOSA Account No.", DataItemName."No.");
                                        if Members.FindFirst() then begin
                                            CreationMessage := 'Dear '+ BName.NameStyle(Members."No.") +', your account has been overdrawn by ksh. '+Format(OverdranAmount)+' and has attracted overdraft charge of 7% p.m. Repay as soon as possible to avoid further charges.';
                                            smsManagement.SendSmsWithID(Source::CRM, Members."Mobile Phone No", CreationMessage, Members."No.", Members."FOSA Account No.", TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                                        end; */

                //end;

                //  DataItemName.CalcFields(DataItemName.Balance,DataItemName."Flagged Transactions");

                /*  if (DataItemName.Balance < 0) and (DataItemName."Flagged Transactions" > 0) then begin
                     OverdranAmount := 0;
                     OverdranAmount := -DataItemName.Balance;
                         //OverdranAmount := -OverdranAmount;
                         IntrestOnFlagged := Round((7 / 100 * OverdranAmount), 0.01, '=');
                         LineNo := LineNo + 10000;
                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                         GenJournalLine."Account Type"::Vendor, DataItemName."No.", 20240614D, IntrestOnFlagged, 'FOSA', DOCUMENT_NO,
                          'Interest On OverDraft' + ' ' + DataItemName."No.", '');

                         LineNo := LineNo + 10000;
                         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                         GenJournalLine."Account Type"::"G/L Account", '300-000-035', 20240614D, -IntrestOnFlagged, 'FOSA', DOCUMENT_NO,
                          'Interest On OverDraft' + ' ' + DataItemName."No.", '');

                 end; */
            END;

            //end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                //Paybill.UpdateSchedule();
            end;


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

        Penalty: Decimal;

        OverdranAmount: decimal;
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;


        OutInt: Decimal;

        BName: Codeunit "Send Birthday SMS";

        // AUFactory: Codeunit "Au Factory";

        LineNo: Integer;
        BATCH_TEMPLATE: Code[60];
        BATCH_NAME: Code[80];
        DOCUMENT_NO: Code[40];
        ChargeAmount: Decimal;
        GraduatedCharge: Record "MPESA  Withdrawal";
        GraduatedCharges: Record "Airtime Purchase Charges";
        GraduatedChargeB: Record "External Transfer Charges";
        MpesaComm: Decimal;
        SaccoCommission: Decimal;
        VendorComm: Decimal;
        ExciseDuty: Decimal;
        TotalAmount: Decimal;
        Category: Text;
        VendorCommAccount: Code[20];
        ExciseDutyAccount: Code[20];
        TotalAmountAccount: Code[20];
        SaccoCommissionAccount: Code[20];
        MpesaCommAccount: Code[20];
        SaccoGen: Record "Sacco General Set-Up";
        smsManagement: Codeunit "Sms Management";
        Members: Record Customer;
        MpesaMobile: Record "MOBILE MPESA Trans";
        CreationMessage: Text[2500];
        MBuffer: Record "Mpesa Withdawal Buffer";
        Vendor: Record Vendor;
        AvailableBalance: Decimal;

        SFactory: Codeunit "SURESTEP FactoryMobile";

        Customer: Record Customer;
        Paybill: Codeunit "AU Paybill Automations";
        TotalMRepay: Decimal;
        LInterest: Decimal;
        loantype: Record "Loan Products Setup";
        GenJournalLine: Record "Gen. Journal Line";
        LPrincipal: Decimal;

        AmountToDebit: Decimal;
        IntrestOnFlagged: Decimal;
        IntDate: Integer;
        LoanregisterCopy: Record "Loans Register";
        Classify: Codeunit "Classify Loans";

}
