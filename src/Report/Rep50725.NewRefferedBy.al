report 50725 "New Reffered By"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column("No_";"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         cust.Reset();
        //         cust.SetRange("No.", Customer."No.");
        //         if cust.Find('-') then begin
        //             if (cust."Reffered By Member No" = '') or (cust."Reffered By Member Name" = '') then begin
        //                 if custom.Get(memberNo) then begin
        //                     cust."Reffered By Member No":= memberNo;
        //                     cust."Reffered By Member Name" := custom.Name;
        //                     cust.Modify;
        //                 end;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord()
        //     begin
        //         loanRepay.Reset();
        //         loanRepay.SetRange("Loan No.", "Loans Register"."Loan  No.");
        //         if loanRepay.Find('-') then begin
        //             "Loans Register".Repayment := loanRepay."Monthly Repayment";
        //             "Loans Register".Modify();
        //         end;
        //     end;
        // }
        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnPreDataItem() begin
        //         if Confirm('Do you wish to correct the member''s registration date?', true) = false then begin
        //             CurrReport.Skip();
        //         end;
        //     end;
        //     trigger OnAfterGetRecord() begin
        //         cust.Reset();
        //         cust.SetRange("No.", Customer."No.");
        //         if cust.Find('-') then begin
        //             cust."Registration Date" := regDate;
        //             cust.modify;
        //         end;
        //     end;
        //     trigger OnPostDataItem() begin
        //         Message('Registration date updated successfully.');
        //     end;
        // }

        // dataitem("Vendor Ledger Entry";"Vendor Ledger Entry")
        // {
        //     RequestFilterFields = "Document No.", "Posting Date", Description;
        //     column(Document_No_;"Document No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Vendor Ledger Entry".Description = 'PCK Salary Dec 2025' then begin
        //             "Vendor Ledger Entry".Description := 'PCK Salary Dec 2024';
        //             "Vendor Ledger Entry".Modify;
        //         end;
        //     end;
        // }

        // dataitem("Membership Exist";"Membership Exist")
        // {
        //     RequestFilterFields = "No.", "Notice No", "Member No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if cust.Get("Membership Exist"."Member No.") then begin
        //             detVend.Reset();
        //             detVend.SetRange("Vendor No.", cust."Deposits Account No");
        //             detVend.SetRange(Reversed, false);
        //             detVend.SetFilter("Debit Amount", '>%1', 0);
        //             if detVend.Find('-') then begin
        //                 repeat
        //                 if CopyStr(detVend."Document No.", 1, 6) = 'REFUND' then begin
        //                     "Membership Exist"."Refunded On" := detVend."Posting Date";
        //                     "Membership Exist".Modify;
        //                 end;
        //                 until detVend.Next() = 0;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem("Treasury Transactions";"Treasury Transactions")
        // {
        //     DataItemTableView = where("Transaction Type" = filter("End of Day Return to Treasury"|"Issue From Bank"|"Return To Treasury"|"Issue To Teller"|"Return To Bank"), Posted = filter(true));
        //     column(No;No)
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Treasury Transactions".CalcFields("Actual Cash At Hand");
        //         if "Treasury Transactions"."Actual Cash At Hand" = 0 then begin
        //             Message('%1', "Treasury Transactions".No);
        //         end;
        //     end;
        // }

        dataitem("Import Mobile Banking Member"; "Import Mobile Banking Member")
        {
            column(Phone_No_; "Phone No.")
            { }

            trigger OnAfterGetRecord()
            var

                NoSeriesMgt: Codeunit "No. Series";
                generalSetup: Record "Sacco General Set-Up";
                NoSetup: Record "Sacco No. Series";
            begin
                atms.Reset();
                atms.SetRange("Account No", "Import Mobile Banking Member"."ID No.");
                if atms.Find('-') = false then begin
                    atms.Init();
                    atms."Account No" := "Import Mobile Banking Member"."ID No.";
                    atms.Validate("Account No");
                    atms."Card No" := "Import Mobile Banking Member"."Phone No.";
                    atms.Validate("Card No");
                    atms."Legacy ATMs" := true;
                    atms."ATM Card Linked" := true;

                    if atms."No." = '' then begin
                        NoSetup.Get();
                        NoSetup.TestField(NoSetup."ATM Applications");
                        atms."No." := NoSeriesMgt.GetNextNo(NoSetup."ATM Applications", Today, true);
                    end;

                    atms."Application Date" := Today;
                    atms."Time Captured" := Time;
                    atms."Captured By" := UpperCase(UserId);
                    atms.Validate("Application Date");
                    atms.Insert();
                end;
            end;
        }

        // dataitem(Vendor;Vendor)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         loanProduct.Reset();
        //         loanProduct.SetRange(Code, memberNo);
        //         if loanProduct.Find('-') then begin
        //             gross:= mobile.GetGrossSalary(Vendor."No.", loanProduct.Code);
        //             // Error('Gross: %1.', gross);
        //             // gross:= mobile.GetSalaryLoanQualifiedAmount(Vendor."No.", loanProduct.Code, loanProduct."Max. Loan Amount", msg, nokNo);
        //             // gross:= mobile.GetOverdraftLoanQualifiedAmount(Vendor."No.", loanProduct.Code, loanProduct."Max. Loan Amount", msg);
        //             gross:= mobile.FnGetMobileAdvanceEligibility(Vendor."No.", loanProduct.Code, msg, loanProduct."Max. Loan Amount", nokNo);
        //             // gross:= mobile.GetReloadedLoanQualifiedAmount(Vendor."No.", loanProduct.Code, loanProduct."Max. Loan Amount", msg, nokNo);
        //             Error('Gross: %1.', gross);
        //         end;

        //         // Error('Masked string is: %1', AUFactory.FnMaskString('254741911610', 6, 5, '*'));
        //     end;
        // }

        // dataitem("Membership Exist";"Membership Exist")
        // {
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         notice.Reset();
        //         notice.SetRange("No.", "Membership Exist"."Notice No");
        //         if notice.Find('-') then begin
        //             "Membership Exist"."Notice Date" := notice."Notice Date";
        //             "Membership Exist"."Exit Notice Date" := notice."Notice Date";
        //             "Membership Exist"."Reason For Exit" := notice."Reason for Exit";
        //             "Membership Exist".modify;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         if Customer."Membership Status" <> Customer."Membership Status"::Dormant then begin
        //             Customer."Membership Status" := Customer."Membership Status"::Dormant;
        //             Customer.Status := Customer.Status::Dormant;
        //             Customer.Validate("Membership Status");
        //             Customer.modify;
        //         end else begin
        //             Customer."Membership Status" := Customer."Membership Status"::Active;
        //             Customer.Status := Customer.Status::Active;
        //             Customer.Validate("Membership Status");
        //             Customer.modify;
        //         end;
        //     end;
        // }

        // dataitem("Member Ledger Entries Buffer";"Member Ledger Entries Buffer")
        // {
        //     column(Entry_No;"Entry No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Member Ledger Entries Buffer".Delete();
        //     end;
        // }
        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     DataItemTableView = where(/*"Total Loan Balance" = filter(<1), "Current Shares" = filter(<1), "Shares Retained" = filter(<1)*/"Membership Status" = filter(Closed), ISNormalMember = filter(true));
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         Customer.CalcFields("Current Shares", "Shares Retained");
        //         if (Customer."Shares Retained" > 0) or (Customer."Current Shares" > 0) then begin
        //             Customer.Status := Customer.Status::Dormant;
        //             Customer."Membership Status" := Customer."Membership Status"::Dormant;
        //             Customer.Validate("Membership Status");
        //             Customer.Modify;
        //         end
        //     end;
        // }

        // dataitem("Salary Details";"Salary Details")
        // {
        //     RequestFilterFields = "Document Number";
        //     column(Document_Number;"Document Number")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Salary Details"."Salary Type" := "Salary Details"."Salary Type"::Allowance;
        //         "Salary Details".Modify();
        //     end;
        // }

        // dataitem("Import Buffer";"Import Buffer")
        // {
        //     column(Reference_No;"Reference No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         loanReg.Reset();
        //         loanReg.SetRange("Loan  No.", "Import Buffer"."Reference No");
        //         if loanReg.Find('-') then begin
        //             // loanReg.WriteOff := true;
        //             loanReg."Debt Collector Name" := "Import Buffer"."Other Details 2";
        //             loanReg."Debtor Collection Status" := "Import Buffer"."Other Details 3";
        //             loanReg."Write Off Amount" := "Import Buffer"."Write Off";
        //             loanReg.Modify;
        //         end;
        //     end;
        // }

        // dataitem(Vendor;Vendor)
        // {
        //     DataItemTableView = where("Creditor Type" = filter("FOSA Account"));
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         cust.Init();
        //         cust."No." := Vendor."BOSA Account No";
        //         cust."Applicant No." := Vendor."No.";
        //         cust."Created On" := 20161019D;
        //         cust.Name := Vendor.Name;
        //         cust.Designation := Vendor.Designation;
        //         cust.Workstation := Vendor.Workstation;
        //         cust."Last Name" := Vendor."Last Name";
        //         cust.Surname := Vendor."Last Name";
        //         cust."First Name" := Vendor."First Name";
        //         cust."Middle Name" := Vendor."Middle Name";
        //         cust.Address := Vendor.Address;
        //         cust."Address 2" := Vendor."Address 2";
        //         cust."Post Code" := Vendor."Postal Code";
        //         cust.Town := Vendor.Town;
        //         cust."Religion." := Vendor."Religion.";
        //         cust.Religion := Format(Vendor.Religion);
        //         cust."NHIF No" := Vendor."NHIF No";
        //         cust.County := Vendor.County;
        //         cust."Allow Multiple Posting Groups" := TRUE;
        //         cust.ISNormalMember := true;
        //         cust."Allow Multiple Posting Groups" := TRUE;
        //         cust.City := Vendor.City;
        //         cust."Member Type" := Vendor."Member Type";
        //         cust."Country/Region Code" := Vendor."Country/Region Code";
        //         cust."Phone No." := Vendor."Mobile Phone No";
        //         cust."Mobile Phone No" := Vendor."Mobile Phone No";
        //         cust."Mobile Phone No." := Vendor."Mobile Phone No.";
        //         cust."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
        //         cust."Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
        //         cust."Customer Posting Group" := 'MEMBER';
        //         cust."Registration Date" := 20161019D;
        //         cust."Mobile Phone No" := Vendor."Mobile Phone No";
        //         cust.Status := cust.Status::Dormant;
        //         cust."Membership Status" := cust."Membership Status"::Dormant;
        //         cust."Date of Birth" := Vendor."Date of Birth";
        //         cust.Piccture := Vendor.piccture;
        //         cust.Signature := Vendor.Signature;
        //         cust."ID Front" := Vendor."ID Front";
        //         cust."ID Back" := Vendor."ID Back";
        //         cust."Station/Department" := '';
        //         cust."E-Mail" := Vendor."E-Mail (Personal)";
        //         cust."E-Mail (Personal)" := Vendor."E-Mail (Personal)";
        //         cust.Location := Vendor.Location;
        //         cust.Title := Vendor.Title;
        //         cust."Applicant No.":= Vendor."No.";
        //         cust."Home Address" := Vendor."Home Address";
        //         cust."Home Postal Code" := Vendor."Home Postal Code";
        //         cust."Home Town" := Vendor."Home Town";
        //         cust."Recruited By" := Vendor."Recruited By";
        //         cust."Contact Person" := Vendor."Contact Person";
        //         cust."ContactPerson Relation" := Vendor."ContactPerson Relation";
        //         cust."ContactPerson Occupation" := Vendor."ContactPerson Occupation";
        //         cust."Reffered By Member No" := Vendor."Reffered By Member No";
        //         cust."Reffered By Member Name":= Vendor."Reffered By Member Name";
        //         cust."Member Share Class" := cust."Member Share Class"::" ";
        //         cust."Member's Residence" := Vendor."Member's Residence";
        //         cust."Member House Group" := '';
        //         cust."Member House Group Name" := '';
        //         cust."Occupation Details" := Vendor."Employment Info";
        //         cust."Employer Code" := Vendor."Employer Code";
        //         cust."Employer Name" := Vendor."Employer Name";
        //         cust."Referee Member No" := Vendor."Referee Member No";
        //         cust."Referee Name" := Vendor."Referee Name";
        //         cust."Referee ID No" := Vendor."Referee ID No";
        //         cust."Referee Mobile Phone No" := Vendor."Referee Mobile Phone No";
        //         cust."Created By" := UserId;
        //         cust."Mode Of Remmittance" := Vendor."Mode Of Remmittance";
        //         cust.Gender := Vendor.Gender;
        //         cust."Nearest Landmark" := Vendor."Nearest Landmark";
        //         cust.Designation := Vendor.Designation;
        //         cust."Retirement Date" := Vendor."Retirement Date";
        //         cust.Age := Vendor.Age;
        //         cust."Receive SMS Notification" := Vendor."Receive SMS Notification";
        //         cust."Station Representative" := Vendor."Station Representative";
        //         cust."Sales Person" := Vendor."Sales Person";
        //         cust."Customer Service Rep." := Vendor."Customer Service Rep.";
        //         cust."Customer Service Rep. Name" := Vendor."Customer Service Rep. Name";
        //         //*****************************to Sort Joint
        //         cust."Name 2" := Vendor."Name 2";
        //         cust.Address3 := Vendor.Address3;
        //         cust."Postal Code 2" := Vendor."Postal Code 2";
        //         cust."Home Postal Code2" := Vendor."Home Postal Code2";
        //         cust."Home Town2" := Vendor."Home Town2";
        //         cust."ID No.2" := Vendor."ID No.2";
        //         cust."Passport 2" := Vendor."Passport 2";
        //         cust.Gender2 := Vendor.Gender2;
        //         cust."Marital Status2" := Vendor."Marital Status2";
        //         cust."E-Mail (Personal2)" := Vendor."E-Mail (Personal2)";
        //         cust."Employer Code2" := Vendor."Employer Code2";
        //         cust."Employer Name2" := Vendor."Employer Name2";
        //         cust."Picture 2" := Vendor."Picture 2";
        //         cust."Signature  2" := Vendor."Signature  2";
        //         cust."Name 3" := Vendor."Name 3";
        //         cust."Address3-Joint" := Vendor.Address4;
        //         cust."Postal Code 3" := Vendor."Postal Code 3";
        //         cust."Home Postal Code3" := Vendor."Home Postal Code3";
        //         cust."Mobile No. 4" := Vendor."Mobile No. 4";
        //         cust."Home Town3" := Vendor."Home Town3";
        //         cust."ID No.3" := Vendor."ID No.3";
        //         cust."Passport 3" := Vendor."Passport 3";
        //         cust.Gender3 := Vendor.Gender3;
        //         cust."Marital Status3" := Vendor."Marital Status3";
        //         cust."E-Mail (Personal3)" := Vendor."E-Mail (Personal3)";
        //         cust."Employer Code3" := Vendor."Employer Code3";
        //         cust."Employer Name3" := Vendor."Employer Name3";
        //         cust."Picture 3" := Vendor."Picture 3";
        //         cust."Signature  3" := Vendor."Signature  3";
        //         cust."Account Category" := Vendor."Account Category";
        //         cust."Joint Account Name" := Vendor."Joint Account Name";
        //         cust."Employment Start Date" := Vendor."Employment Start Date";
        //         cust."Employment End Date" := Vendor."Employment End Date";
        //         cust."Employment Period" := Vendor."Employment Period";
        //         cust."Tax Exemption End Date" := Vendor."Tax Exemption End Date";
        //         cust."Tax Exemption Period" := Vendor."Tax Exemption Period";
        //         cust."Tax Exemption Start Date" := Vendor."Tax Exemption Start Date";
        //         if Vendor."Account Category" = Vendor."account category"::Joint then
        //             cust.Name := Vendor."Joint Account Name";
        //         cust.Designation := Vendor.Designation;
        //         cust.Designation := Vendor.Designation;
        //         cust.Workstation := Vendor.Workstation;
        //         cust."Bank Code" := Vendor."Bank Code";
        //         cust."Bank Branch Code" := Vendor."Bank Code";
        //         cust."Bank Branch Name" := UpperCase(Vendor."Bank Branch Name");
        //         cust."Bank Name" := Vendor."Bank Name";
        //         cust."Bank Account No." := Vendor."Bank Account No";
        //         cust."Sub-Location" := Vendor."Sub-Location";
        //         cust.District := Vendor.District;
        //         cust."Payroll No" := Vendor."Personal No.";
        //         cust."ID No." := Vendor."ID No.";
        //         cust."Mobile Phone No" := Vendor."Mobile Phone No";
        //         cust."Marital Status" := Vendor."Marital Status";
        //         cust."Customer Type" := cust."customer type"::Member;
        //         cust.Gender := Vendor.Gender;
        //         cust."Monthly Contribution" := Vendor."Monthly Contribution";
        //         cust."Contact Person" := Vendor."Contact Person";
        //         cust."Contact Person Phone" := Vendor."Contact Person Phone";
        //         cust."ContactPerson Relation" := Vendor."ContactPerson Relation";
        //         cust."Recruited By" := Vendor."Recruited By";
        //         cust."ContactPerson Occupation" := Vendor."ContactPerson Occupation";
        //         cust.Pin := Vendor."KRA PIN";
        //         cust."KYC Completed" := true;
        //         cust."Employment Start Date" := Vendor."Employment Start Date";
        //         cust."Employment End Date" := Vendor."Employment End Date";
        //         cust."Employment Period" := Vendor."Employment Period";
        //         cust."Tax Exemption End Date" := Vendor."Tax Exemption End Date";
        //         cust."Tax Exemption Period" := Vendor."Tax Exemption Period";
        //         cust."Tax Exemption Start Date" := Vendor."Tax Exemption Start Date";
        //         cust."Old Ordinary Account NAV2016" := '0502-001-05540';
        //         if not cust.Insert() then cust.Modify();
        //     end;
        // }

        // dataitem("ATM Log Entries3";"ATM Log Entries3")
        // {
        //     DataItemTableView = where("Connection Mode" = filter('Balance Enquiry'));
        //     RequestFilterFields = "Trace ID";
        //     column(Trace_ID;"Trace ID")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Balance Enquiry_Sacco_Direct";
        //         "ATM Log Entries3".Modify;
        //     end;
        // }

        // dataitem("Penalty Counter";"Penalty Counter")
        // {
        //     RequestFilterFields = "Loan Number";
        //     column(Loan_Number;"Loan Number")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Penalty Counter".Reversed := true;
        //         "Penalty Counter".Modify;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";

        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Loans Register"."Loan Disbursement Date" = 0D then CurrReport.Skip();

        //         if "Loans Register"."Loan Disbursement Date" = CalcDate('<CM>', "Loans Register"."Loan Disbursement Date") then begin
        //             "Loans Register".Validate("Loan Disbursement Date");
        //             "Loans Register".Modify;
        //         end;
        //         // "Loans Register"."Loan Disbursement Date" := regDate;
        //     end;
        // }


        // dataitem("Approval Entry";"Approval Entry")
        // {
        //     RequestFilterFields = "Document No.";
        //     column(Document_No_;"Document No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         if "Approval Entry"."Due Date" < Today then begin
        //             "Approval Entry".Status := "Approval Entry".Status::Rejected;
        //             "Approval Entry".Modify;
        //         end else CurrReport.Skip();
        //     end;
        // }
        // dataitem("Approval Entry";"Approval Entry")
        // {
        //     column(Document_No_;"Document No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Approval Entry"."Approver ID" := memberNo;
        //         "Approval Entry".Modify;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         loanProducts.Reset();
        //         loanProducts.SetRange(Code, "Loans Register"."Loan Product Type");
        //         if loanProducts.Find('-') then begin
        //             "Loans Register".Interest := loanProducts."Interest rate";
        //             "Loans Register".Modify();
        //         end;
        //     end;
        // }

        // dataitem("Withdrawal Notice";"Withdrawal Notice")
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Withdrawal Notice"."Notice Status" := "Withdrawal Notice"."Notice Status"::Registered;
        //         "Withdrawal Notice"."Registration Date" := "Withdrawal Notice"."Notice Date";
        //         "Withdrawal Notice".Modify;
        //     end;
        // }

        // dataitem("Detailed Cust. Ledg. Entry";"Detailed Cust. Ledg. Entry")
        // {
        //     RequestFilterFields = "Loan No";
        //     DataItemTableView = where("Transaction Type" = filter(Repayment|"Interest Paid"|"Loan Penalty Paid"), Reversed = filter(false));

        //     column(Loan_No;"Loan No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         loansReg.Reset();
        //         loansReg.SetRange("Loan  No.", "Detailed Cust. Ledg. Entry"."Loan No");
        //         if loansReg.Find('-') then begin
        //             if loansReg."Client Code" = '' then CurrReport.Skip();
        //             if "Detailed Cust. Ledg. Entry"."Customer No." = loansReg."Client Code" then CurrReport.Skip();

        //             "Detailed Cust. Ledg. Entry"."Customer No." := loansReg."Client Code";
        //             "Detailed Cust. Ledg. Entry".Modify;
        //         end;
        //     end;
        // }

        // dataitem(Vendor;Vendor)
        // {
        //     DataItemTableView = where("Account Type" = filter('103'));
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         if Vendor."Frozen Amount" = 0 then begin
        //             Vendor."Frozen Amount" := Vendor."Amount to freeze";
        //             Vendor.Modify;
        //         end;

        //         if Vendor."Amount to Freeze" = 0 then begin
        //             Vendor."Amount to Freeze" := Vendor."Frozen Amount";
        //             Vendor.Modify;
        //         end;
        //     end;
        // }

        // dataitem("Savings Variation";"Savings Variation")
        // {
        //     RequestFilterFields = "Variation No";
        //     column(Variation_No;"Variation No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Savings Variation".Updated := true;
        //         "Savings Variation".Modify;
        //     end;
        // }

        // dataitem("Salary Details";"Salary Details")
        // {
        //     RequestFilterFields = "Document Number", "Payroll No", "Gross Amount";
        //     DataItemTableView = where("Gross Amount" = filter(<1000), "Salary Type" = filter(Salary));

        //     column(Document_Number;"Document Number")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Salary Details"."Salary Type" := "Salary Details"."Salary Type"::Erroneous;
        //         "Salary Details".Modify;
        //     end;
        // }
        // dataitem("Interest On Savings Prog";"Interest On Savings Prog")
        // {
        //     DataItemTableView = where(Posted = filter(true), Period = filter('Jul-Sep'));
        //     column(FOSA_Account;"FOSA Account")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Interest On Savings Prog".Delete();
        //     end;
        // }
        // dataitem("G/L Entry";"G/L Entry")
        // {
        //     RequestFilterFields = "Document No.", "Posting Date", "Entry No.";
        //     column(Document_No_;"Document No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "G/L Entry"."G/L Account No." := memberNo;
        //         "G/L Entry".Modify;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     DataItemTableView = where("Membership Status" = filter(Closed), "Total Loan Balance" = filter(>0));
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         Customer."Membership Status" := Customer."Membership Status"::Dormant;
        //         Customer.Modify;
        //     end;
        // }

        // dataitem("Import Buffer";"Import Buffer")
        // {
        //     RequestFilterFields = "Reference No";
        //     DataItemTableView = where("Date of Birth" = filter(<>0D));
        //     column("Reference_No";"Reference No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Import Buffer"."Date of Birth" > Today then CurrReport.Skip();

        //         cust.Reset();
        //         cust.SetRange("No.", "Import Buffer"."Reference No");
        //         cust.SetFilter("Date Of Birth", '<>%1', "Import Buffer"."Date of Birth");
        //         if cust.Find('-') then begin
        //             cust."Date Of Birth" := "Import Buffer"."Date of Birth";
        //             cust.Validate("Date Of Birth");
        //             cust.Modify;

        //             vend.Reset();
        //             vend.SetRange("BOSA Account No", cust."No.");
        //             if vend.FindSet() then begin
        //                 repeat
        //                 vend."Date of Birth" := "Import Buffer"."Date of Birth";
        //                 vend.Validate("Date of Birth");
        //                 vend.Modify;
        //                 until vend.Next() = 0;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Loans Register".Posted = false then CurrReport.Skip();
        //         "Loans Register".CalcFields("Total Outstanding Balance");
        //         if "Loans Register"."Total Outstanding Balance" <= 0 then CurrReport.Skip();

        //         loanReg.Reset();
        //         loanReg.SetRange("Loan  No.", "Loans Register"."Loan  No.");
        //         if loanReg.Find('-') then begin
        //             loanRepay.Reset;
        //             loanRepay.SetRange("Loan No.", loanReg."Loan  No.");
        //             loanRepay.SetFilter("Repayment Date", '..%1', 20241231D);
        //             if loanRepay.FindLast = false then begin
        //                 if loanProducts.Get(loanReg."Loan Product Type") then begin
        //                     if loanProducts."Non Recurring Interest" = false then begin
        //                         AUFactory.FnGenerateLoanRepaymentSchedule(loanReg."Loan  No.");
        //                     end else begin
        //                         AUFactory.FnGenerateLoanRepaymentScheduleZero(loanReg."Loan  No.");
        //                     end;
        //                 end;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";

        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         Customer.Name := Customer."First Name" + Customer.Surname + Customer."Last Name";
        //         Customer.Modify;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnPreDataItem() begin
        //         BATCH_TEMPLATE:= 'PAYMENTS';
        //         BATCH_NAME:= 'A03RECOV';

        //         GenJournalLine.Reset();
        //         GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        //         GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        //         if GenJournalLine.FindSet() then begin
        //             GenJournalLine.DeleteAll();
        //         end;
        //     end;

        //     trigger OnAfterGetRecord() begin
        //         DOCUMENT_NO := "Loans Register"."Loan  No.";
        //         vend.Reset();
        //         vend.SetRange("Account Type", '103');
        //         vend.SetRange("BOSA Account No", "Loans Register"."Client Code");
        //         if vend.Find('-') then begin
        //             balance := vend.GetAvailableBalance();
        //             "Loans Register".CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");

        //                 if "Loans Register"."Outstanding Penalty" > 0 then begin
        //                     if "Loans Register"."Outstanding Penalty" > balance then begin
        //                         recovery := balance;
        //                     end else recovery := "Loans Register"."Outstanding Penalty";

        //                     LineNo := LineNo + 1000;
        //                     AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
        //                     vend."No.", Today, recovery, 'BOSA', "Loans Register"."Loan  No.", 'Mobile Loan Advance Penalty Repayment', DOCUMENT_NO, GenJournalLine."Application Source"::CBS);

        //                     LineNo := LineNo + 1000;
        //                     AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Loan Penalty Paid", GenJournalLine."Account Type"::Customer,
        //                     "Loans Register"."Client Code", Today, (recovery * -1), 'BOSA', "Loans Register"."Loan  No.", 'Mobile Loan Advance Penalty Repayment', DOCUMENT_NO, GenJournalLine."Application Source"::CBS);

        //                     balance := balance - recovery;
        //                 end;

        //             if balance > 0 then begin
        //                 if "Loans Register"."Outstanding Interest" > 0 then begin
        //                     if "Loans Register"."Outstanding Interest" > balance then begin
        //                         recovery := balance;
        //                     end else recovery := "Loans Register"."Outstanding Interest";

        //                     LineNo := LineNo + 1000;
        //                     AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
        //                     vend."No.", Today, recovery, 'BOSA', "Loans Register"."Loan  No.", 'Mobile Loan Advance Interest Repayment', DOCUMENT_NO, GenJournalLine."Application Source"::CBS);

        //                     LineNo := LineNo + 1000;
        //                     AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer,
        //                     "Loans Register"."Client Code", Today, (recovery * -1), 'BOSA', "Loans Register"."Loan  No.", 'Mobile Loan Advance Interest Repayment', DOCUMENT_NO, GenJournalLine."Application Source"::CBS);

        //                     balance := balance - recovery;
        //                 end;
        //             end;

        //             if balance > 0 then begin
        //                 if "Loans Register"."Outstanding Balance" > 0 then begin
        //                     if "Loans Register"."Outstanding Balance" > balance then begin
        //                         recovery := balance;
        //                     end else recovery := "Loans Register"."Outstanding Balance";

        //                     LineNo := LineNo + 1000;
        //                     AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::Vendor,
        //                     vend."No.", Today, recovery, 'BOSA', "Loans Register"."Loan  No.", 'Mobile Loan Advance Principal Repayment', DOCUMENT_NO, GenJournalLine."Application Source"::CBS);

        //                     LineNo := LineNo + 1000;
        //                     AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."Account Type"::Customer,
        //                     "Loans Register"."Client Code", Today, (recovery * -1), 'BOSA', "Loans Register"."Loan  No.", 'Mobile Loan Advance Principal Repayment', DOCUMENT_NO, GenJournalLine."Application Source"::CBS);

        //                     balance := balance - recovery;
        //                 end;
        //             end;
        //         end;
        //     end;
        // }
    }
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(regDate; regDate)
                    {
                        ShowMandatory = true;
                        Caption = 'Registration Date';
                    ApplicationArea = All;
                    }
                    field(memberNo; memberNo)
                    {
                        ShowMandatory = true;
                        Caption = 'Refference Code';
                    ApplicationArea = All;
                        Visible = false;
                        // TableRelation = User;
                    }
                }
            }
        }
    }

    var
        myInt: Integer;
        LineNo: integer;
        memberNo: Code[50];
        erroneousNo: Code[20];
        accurateNo: Code[20];
        BATCH_TEMPLATE: code[100];
        BATCH_NAME: code[100];
        DOCUMENT_NO: code[100];
        regDate: Date;
        balance: Decimal;
        recovery: Decimal;
        AUFactory: Codeunit "Au Factory";
        genBatches: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        cust: Record Customer;
        custom: Record Customer;
        vend: Record Vendor;
        loanReg: Record "Loans Register";
        loanRepay: Record "Loan Repayment Schedule";
        atms: Record "ATM Card Applications";
        notice: Record "Withdrawal Notice";
        approvals: Record "Approval Entry";
        salDetails: Record "Salary Details";
        loanProducts: Record "Loan Products Setup";
        loansReg: Record "Loans Register";
        detVend: Record "Detailed Vendor Ledg. Entry";
}



