report 50724 "Update Records"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    // DefaultRenderingLayout = ErroneousRegFee;

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
        //     RequestFilterFields = "Batch No.";
        //     column(Batch_No_;"Batch No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         loansReg.Reset();
        //         loansReg.SetRange("Batch No.", "Loans Register"."Batch No.");
        //         if loansReg.Find('-') then begin
        //             loansReg."Loan Status":= loansReg."Loan Status"::Approved;
        //             loansReg."Issued Date":= 0D;
        //             loansReg."Disbursed By":= '';
        //             loansReg."Disbursed By Date":= 0D;
        //             loansReg."Disbursed By Time":= 0T;
        //             loansReg."Disbursed Time":= 0T;
        //             loansReg."Offset Eligibility Amount":= 0;
        //             loansReg."Posting Date":= 0D;
        //             loansReg."Disbursed By":= '';
        //             loansReg."Loan Disbursement Date":= 0D;
        //             loansReg.Posted:= false;
        //             loansReg.Modify;

        //             loanBatch.Reset();
        //             loanBatch.SetRange("Batch No.", "Loans Register"."Batch No.");
        //             if loanBatch.Find('-') then begin
        //                 loanBatch."Posted By":= '';
        //                 loanBatch."Posting Date":= 0D;
        //                 loanBatch.Posted:= false;
        //                 loanBatch.Modify;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem("User Time Register";"User Time Register")
        // {
        //     RequestFilterFields= "User ID", Date;
        //     column(User_ID;"User ID")
        //     {}
        //     column(Date;Date)
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         userTimereg.Reset();
        //         userTimereg.SetRange(userTimereg."User ID", "User Time Register"."User ID");
        //         userTimereg.SetRange(userTimereg.Date, "User Time Register".Date);
        //         if userTimereg.FindSet() then begin
        //             repeat
        //                 loginTime:= 0T;
        //                 loginTime:= DT2Time(usertimeReg.SystemCreatedAt);
        //                 userTimereg."Login Time":= loginTime;
        //                 userTimereg.Modify;

        //                 logoutTime:= 0T;
        //                 minute:= 0;
        //                 minuteDuration:= usertimeReg.Minutes*60000;
        //                 logoutTime:= usertimeReg."Login Time" + minuteDuration;
        //                 userTimereg."Logout Time":= logoutTime;
        //                 userTimereg.Modify;
        //             until userTimereg.Next() = 0;
        //         end;
        //     end;
        // }

        // dataitem("Approval Entry";"Approval Entry")
        // {
        //     RequestFilterFields = "Table ID", "Document No.";
        //     column(Table_ID;"Table ID")
        //     {}
        //     column(Document_No_;"Document No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         approvalEntry.Reset();
        //         approvalEntry.SetRange("Table ID", "Approval Entry"."Table ID");
        //         approvalEntry.SetRange("Document No.", "Approval Entry"."Document No.");
        //         if approvalEntry.Find('-') then begin
        //             repeat
        //                 if (approvalEntry."Due Date" > Today) 
        //                 // or (approvalEntry."Due Date" > (Today-1D)) 
        //                 then begin
        //                     approvalEntry.Delete;
        //                 end;
        //             until approvalEntry.Next()= 0;
        //         end;
        //     end;

        // }
        // dataitem("FOSA Account Applicat. Details";"FOSA Account Applicat. Details")
        // {
        //     RequestFilterFields = "ID No.";
        //     column(ID_No_;"ID No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         vend.Reset();
        //         vend.SetRange("ID No.", "FOSA Account Applicat. Details"."ID No.");
        //         vend.SetRange("Account Type", "FOSA Account Applicat. Details"."Account Type");
        //         if vend.FindSet() then begin
        //             // if ("FOSA Account Applicat. Details".Count = 1) or ("FOSA Account Applicat. Details"."Account Type" = '109') and 
        //             if("FOSA Account Applicat. Details".Status = "FOSA Account Applicat. Details".Status::Approved) and ("FOSA Account Applicat. Details".Created = true) then begin
        //                 repeat
        //                     "FOSA Account Applicat. Details"."New FOSA No." := vend."No.";
        //                     "FOSA Account Applicat. Details".Modify;
        //                 until vend.Next() = 0;
        //             // end else begin
        //             //     Message('There exists more than 1 account application with the same ID No.');
        //             end;
        //             // if ("FOSA Account Applicat. Details".Created = true) and ("FOSA Account Applicat. Details".Status <> "FOSA Account Applicat. Details".Status::Approved) then begin
        //             //     repeat
        //             //         "FOSA Account Applicat. Details".Created := false;
        //             //         "FOSA Account Applicat. Details"."Registration Date" := 0D;
        //             //         "FOSA Account Applicat. Details".Modify;
        //             //     until vend.Next()= 0;
        //             // end;
        //             // if ("FOSA Account Applicat. Details".Count > 1) and ("FOSA Account Applicat. Details"."Account Type" <> '109') then begin
        //             //     repeat
        //             //         "FOSA Account Applicat. Details".Created := false;
        //             //         "FOSA Account Applicat. Details"."Registration Date" := 0D;
        //             //         "FOSA Account Applicat. Details".Modify;
        //             //     until vend.Next() = 1;
        //             // end;
        //         end;
        //     end;
        // }

        // dataitem("Change Request";"Change Request")
        // {
        //     RequestFilterFields = "No";
        //     DataItemTableView = where(Status = filter(Approved), "Approved by" = filter(''));
        //     column(No_;"No")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         approvalEntry.Reset();
        //         approvalEntry.SetRange("Document No.", "Change Request"."No");
        //         if approvalEntry.Find('-') then begin
        //             // repeat
        //             if changeReq.Get("Change Request".No) then begin
        //                 changeReq."Approved by":= approvalEntry."Approver ID";
        //                 changeReq."Approval Date":= approvalEntry."Due Date";
        //                 changeReq.modify;

        //             end;
        //             // until approvalEntry.Next()= 0;
        //         end;
        //     end;
        // }

        // dataitem("Payments Header";"Payments Header")
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         payments.Reset();
        //         payments.SetRange("No.", "Payments Header"."No.");
        //         if payments.Find('-') then begin
        //             payments.Posted := false;
        //             payments.Status := Payments.Status::Approved;
        //             payments."Posted By" := '';
        //             payments."Date Posted" := 0D;
        //             payments."Time Posted" := 0T;
        //             payments.Modify;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     DataItemTableView = where("No of Next of Kin" = filter(>0));
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         nextofkinTable.Reset();
        //         nextofkinTable.SetRange("Account No", Customer."No.");
        //         if nextofkinTable.FindSet() then begin
        //             nokNo:= 1;
        //             repeat
        //                 nextofkinTable."NoK No.":= nokNo;
        //                 nextofkinTable.modify;
        //                 nokNo := nokNo + 1;
        //             until nextofkinTable.Next() = 0;
        //         end;
        //     end;
        // }

        // dataitem("Detailed Cust. Ledg. Entry";"Detailed Cust. Ledg. Entry")
        // {
        //     RequestFilterFields = "Document No.";

        //     column(Document_No_;"Document No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         loansReg.Reset();
        //         loansReg.SetRange("Loan  No.", "Detailed Cust. Ledg. Entry"."Loan No");
        //         if loansReg.Find('-') then begin
        //             loansReg."Old System Loan with Balance" := true;
        //             loansReg.modify;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         cust.Reset();
        //         cust.SetRange("No.", Customer."No.");
        //         cust.SetAutoCalcFields("Total Loan Balance", "Current Shares", "Shares Retained", "Ordinary Savings");
        //         cust.SetFilter("Total Loan Balance", '< %1',1);
        //         cust.SetFilter("Current Shares", '< %1',1);
        //         cust.SetFilter("Shares Retained", '< %1',1);
        //         // cust.SetFilter("Ordinary Savings", '< %1',1);
        //         if cust.Find('-') then begin
        //             cust."Membership Status" := cust."Membership Status"::Closed;
        //             cust.Status := cust.Status::Closed;
        //             cust.Validate("Membership Status");
        //             cust.modify;
        //             // vend.Reset();
        //             // vend.SetRange("BOSA Account No", Customer."No.");
        //             // if vend.FindSet() then begin
        //             //     repeat
        //             //         vend."Membership Status":= vend."Membership Status"::Closed;
        //             //         vend.Status:= vend.Status::Closed;
        //             //         vend.modify;
        //             //     until vend.Next()=0;
        //             // end;
        //         end;
        //     end;
        // }

        // dataitem("HR Leave Application";"HR Leave Application")
        // {
        //     DataItemTableView = where("Is Manager" = filter(false), Status = filter("Pending Approval"));
        //     column(Application_Code;"Application Code")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         leaveSup.Reset();
        //         leaveSup.SetRange("Leave No.", "HR Leave Application"."Application Code");
        //         if leaveSup.Find('-') then begin
        //             if leaveSup."Approval Status" = leaveSup."Approval Status"::Rejected then begin
        //                 "HR Leave Application".Status := "HR Leave Application".Status::Rejected;
        //                 "HR Leave Application".modify;
        //             end;

        //             if leaveSup."Approval Status" = leaveSup."Approval Status"::Approved then begin
        //                 approvalEntry.Reset();
        //                 approvalEntry.SetRange("Document No.", leaveSup."Leave No.");
        //                 if approvalEntry.FindLast() then begin
        //                     if approvalEntry.Status = approvalEntry.Status::Approved then begin
        //                         "HR Leave Application".Status := "HR Leave Application".Status::Approved;
        //                         "HR Leave Application".modify;
        //                     end;
        //                     if approvalEntry.Status = approvalEntry.Status::Rejected then begin
        //                         "HR Leave Application".Status := "HR Leave Application".Status::Rejected;
        //                         "HR Leave Application".modify;
        //                     end;
        //                 end else begin
        //                     leaveSup.Validate("Approval Status");
        //                 end;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem("Import Mobile Banking Member";"Import Mobile Banking Member")
        // {
        //     RequestFilterFields = "Phone No.";
        //     column(Phone_No_;"Phone No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         cust.Reset();
        //         cust.SetRange("ID No.", "Import Mobile Banking Member"."ID No.");
        //         if cust.Find('-') then begin
        //             cust."Mobile Banking" := "Import Mobile Banking Member".Mobile;
        //             cust."Internet Banking" := "Import Mobile Banking Member".Internet;
        //             if "Import Mobile Banking Member".Status = 'ACTIVE' then begin
        //                 cust."Mobile Banking Status" := true;
        //             end else if "Import Mobile Banking Member".Status = 'INACTIVE' then begin
        //                 cust."Mobile Banking Status" := false;
        //             end;
        //             cust."Mobile Banking Registered" := true;
        //             cust.Modify;
        //         end;
        //     end;
        // }

        // dataitem("ATM Log Entries3";"ATM Log Entries3")
        // {
        //     RequestFilterFields = "Entry No", "Transaction Code";
        //     column(Entry_No;"Entry No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "ATM Log Entries3"."Transaction Code" = '0001' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"MPESA B2C";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0004' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"KPLC PostPaid";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0005' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"KPLC Prepaid";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0006' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::DSTV;
        //         end else if "ATM Log Entries3"."Transaction Code" = '0007' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::ZUKU;
        //         end else if "ATM Log Entries3"."Transaction Code" = '0008' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Safaricom Airtime Purchase";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0009' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::Pesalink;
        //         end else if "ATM Log Entries3"."Transaction Code" = '0010' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"POS Cash deposit";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0011' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Cash Withdrawal";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0012' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Cardless ATM withdrawal";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0013' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Safaricom C2B";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0014' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Ministatement Sacco direct";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0015' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Airtel Airtime purchase";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0016' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Balance Enquiry_Sacco_Direct";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0017' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Nairobi water bill payment";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0018' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Bank Account to sacco account";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0019' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Sacco account to bank account";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0020' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Airtel B2C";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0021' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"TELKOM B2C";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0022' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Sacco account to Virtual Card";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0023' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Virtual card to SACCO";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0024' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Sacco to other Sacco";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0025' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Other sacco to Sacco";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0026' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"TELCOM C2B";
        //         end else if "ATM Log Entries3"."Transaction Code" = '0027' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"VISA Cash withdrawal";
        //         end else if "ATM Log Entries3"."Transaction Code" = '1420' then begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::Reversal;
        //         end else begin
        //             "ATM Log Entries3"."Transaction Type" := "ATM Log Entries3"."Transaction Type"::"Balance Enquiry_Sacco_Direct";
        //         end;
        //         "ATM Log Entries3".Modify;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     CalcFields = "Total Outstanding Balance";
        //     DataItemTableView = where("Total Outstanding Balance" = filter(>0), "Loan Disbursement Date" = filter(0D));
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         if "Loans Register"."Loan Disbursement Date" = 0D then begin
        //             "Loans Register"."Loan Disbursement Date" := DT2Date("Loans Register".SystemCreatedAt);
        //             "Loans Register".Validate("Loan Disbursement Date");
        //             "Loans Register".Modify;
        //         end;
        //     end;
        // }
        // dataitem("Loans Register";"Loans Register")
        // {
        //     CalcFields = "Total Outstanding Balance";
        //     DataItemTableView = where("Total Outstanding Balance" = filter(>0), "Loan Disbursement Date" = filter(0D));

        // }

        // dataitem(Vendor;Vendor)
        // {
        //     RequestFilterFields = "BOSA Account No", "Account Type", "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         Vend.Reset();
        //         Vend.SetRange("BOSA Account No", Vendor."BOSA Account No");
        //         Vend.SetRange("Account Type", '109');
        //         if Vend.Find('+') then begin
        //             suffix := CopyStr(vend."No.", 12, 4);
        //             Error(IncStr(suffix));
        //         end;

        //         // DOCUMENT_NO := '001-00040-9000';
        //         // Vendor."No." := DOCUMENT_NO;
        //         // Vendor.Modify();
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.", "Client Code", "Loan Product Type", "Loan Disbursement Date";

        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Loans Register"."Loan Status" := "Loans Register"."Loan Status"::Disbursed;
        //         "Loans Register"."Approval Status" := "Loans Register"."Approval Status"::Approved;
        //         //Check Loan No: LN041800, if it was approved or not in the approval entries table: It was open on Approval Status and appraisal on Loan Status. 
        //         "Loans Register".Modify;
        //     end;
        // }

        // dataitem("Loans Guarantee Details";"Loans Guarantee Details")
        // {
        //     RequestFilterFields = "Member No", "Loan No";
        //     column(Member_No;"Member No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         cust.Reset();
        //         cust.SetRange("No.", "Loans Guarantee Details"."Member No");
        //         if cust.Find('-') then begin
        //             if cust."Payroll No" = "Loans Guarantee Details"."Staff/Payroll No." then CurrReport.Skip();

        //             "Loans Guarantee Details"."Staff/Payroll No." := cust."Payroll No";
        //             "Loans Guarantee Details".Modify(true);
        //         end
        //     end;
        // }

        // dataitem("Old Member Ledger Entries";"Old Member Ledger Entries")
        // {
        //     RequestFilterFields = "Member No.";
        //     column(Member_No_;"Member No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Old Member Ledger Entries"."Posting Date" > 20240331D then begin
        //             rectDate := 0;
        //             rectMonth := 0;
        //             rectYear := 0;
        //             currDate := 0D;
        //             rectifiedDate := 0D;
        //             currDate := "Old Member Ledger Entries"."Posting Date";

        //             rectDate := Date2DMY("Old Member Ledger Entries"."Posting Date", 1);
        //             rectMonth := Date2DMY("Old Member Ledger Entries"."Posting Date", 2);
        //             rectYear := Date2DMY("Old Member Ledger Entries"."Posting Date", 3);

        //             rectifiedDate := DMY2Date(rectMonth, rectDate, rectYear);

        //             "Old Member Ledger Entries"."Rectified Date" := currDate;
        //             "Old Member Ledger Entries"."Posting Date" := rectifiedDate;
        //             "Old Member Ledger Entries".Rectified := true;
        //             "Old Member Ledger Entries".Modify;
        //         end;
        //     end;
        // }

        // dataitem("Dividends Progression";"Dividends Progression")
        // {
        //     RequestFilterFields = Date, "Member No", "Deposit Type";
        //     column(Member_No;"Member No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Dividends Progression"."Deposit Type" = "Dividends Progression"."Deposit Type"::ESS then begin
        //             "Dividends Progression".Posted := true;
        //             "Dividends Progression".Modify;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         vend.Reset();
        //         vend.SetRange("BOSA Account No", Customer."No.");
        //         if vend.FindSet() then begin
        //             repeat

        //             if Customer.Piccture.Count() <> 0 then vend.piccture := Customer.Piccture;
        //             if Customer.Signature.Count() <> 0 then vend.Signature := Customer.Signature;
        //             if Customer."ID Front".Count() <> 0 then vend."ID Front" := Customer."ID Front";
        //             if Customer."ID Back".Count() <> 0 then vend."ID Back" := Customer."ID Back";

        //             vend.modify;

        //             until vend.Next()=0;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         // loansReg.Reset();
        //         // loansReg.SetRange("Loan  No.", "Loans Register"."Loan  No.");
        //         // loansReg.SetRange(Posted, True);
        //         // if loansReg.Find('-') then begin
        //         //     loansReg.CalcFields("Outstanding Balance");
        //         //     if loansReg."Outstanding Balance" = 0 then begin
        //         //         loansReg."Loans Category" := loansReg."Loans Category"::Perfoming;
        //         //         loansReg."Days In Arrears" := 0;
        //         //         loansReg.
        //         //         loansReg.Modify;
        //         //     end;
        //         // end;

        //         "Loans Register".CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");
        //         if ("Loans Register"."Outstanding Balance" <> 0) or ("Loans Register"."Outstanding Interest" <> 0) or ("Loans Register"."Outstanding Penalty" <> 0) then begin
        //             CurrReport.Skip();
        //         end else begin
        //             "Loans Register"."Loans Category" := "Loans Register"."Loans Category"::Perfoming;
        //             "Loans Register"."Days In Arrears" := 0;
        //             "Loans Register"."No of Months in Arrears" := 0;
        //             "Loans Register"."Principal In Arrears" := 0;
        //             "Loans Register"."Amount in Arrears" := 0;
        //             "Loans Register".Modify;
        //         end;
        //     end;
        // }

        // dataitem("G/L Entry";"G/L Entry")
        // {
        //     RequestFilterFields = "G/L Account No.", "Document No.";
        //     DataItemTableView = where(Reversed = filter(false));
        //     column(G_L_Account_No_;"G/L Account No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         // vend.Reset();
        //         // vend.SetRange("Account Type", '101');
        //         // if vend.Find('-') then begin
        //         //     repeat
        //             detVend.Reset();
        //             // detVend.SetRange("Vendor No.", vend."No.");
        //             detVend.SetRange("Document No.", "G/L Entry"."Document No.");
        //             if detVend.Find('-') = false then begin
        //                 Error('The entry %1 cannot be found in the related vendor ledger entries.',"G/L Entry"."Document No.");
        //             end;
        //         //     until vend.Next() = 0;
        //         // end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         vend.Reset();
        //         vend.SetRange("BOSA Account No", Customer."No.");
        //         vend.SetRange("Account Type", memberNo);
        //         if vend.Find('-') then begin
        //             repeat
        //                 vend.Name:= Customer.Name;
        //                 vend.modify;
        //             until vend.Next() = 0;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     DataItemTableView = where("Outstanding Balance" = filter(0), Posted = filter(true));
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         loansReg.Reset();
        //         loansReg.SetRange("Loan  No.", "Loans Register"."Loan  No.");
        //         if loansReg.Find('-') then begin
        //             loansReg."Loans Category" := loansReg."Loans Category"::Perfoming;
        //             loansReg.modify;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         nextofkinTable.Reset();
        //         nextofkinTable.SetRange("Account No", Customer."No.");
        //         nextofkinTable.SetRange("NoK No.", 0);
        //         if nextofkinTable.Find('-') then begin
        //             repeat
        //                 nextofkinTable.Delete();
        //             until nextofkinTable.Next() = 0;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         if Customer."Member Type" = Customer."Member Type"::"Station Representative" then begin

        //         end;
        //     end;
        // }

        // dataitem("Membership Applications";"Membership Applications")
        // {
        //     RequestFilterFields = "ID No.";
        //     DataItemTableView = where(Created = filter(false), "New/Rejoining" = filter(Rejoining));
        //     column(ID_No_;"ID No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Membership Applications"."Erroneous Application" := true;
        //         "Membership Applications".Modify();
        //     end;
        // }

        // dataitem(Transactions;Transactions)
        // {
        //     DataItemTableView = where("Type _Transactions" = const("Cheque Deposit"), Posted = filter(true));
        //     column(No;No)
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         transact.Reset();
        //         transact.SetRange(No, Transactions.No);
        //         if transact.Find('-') then begin
        //             transact."Cheque Status":= transact."Cheque Status"::Cleared;
        //             transact.Modify;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan Product Type";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         loansReg.Reset();
        //         loansReg.SetRange("Loan  No.", "Loans Register"."Loan  No.");
        //         loansReg.SetRange("Employer Code",'');
        //         if loansReg.Find('-') then begin
        //             cust.Reset();
        //             cust.SetRange("No.", "Loans Register"."Client Code");
        //             if cust.Find('-') then begin
        //                 loansReg."Employer Code" := cust."Employer Code";
        //                 loansReg.modify;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     DataItemTableView = where("Outstanding Balance" = filter(0), "Outstanding Interest" = filter(0), "Total Outstanding Balance" = filter(0), "Loans Category" = filter(<> Perfoming));
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         loansReg.Reset();
        //         loansReg.SetRange("Loan  No.", "Loans Register"."Loan  No.");
        //         loansReg.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Total Outstanding Balance");
        //         if loansReg.Find('-') then begin
        //             loansReg.CalcFields("Outstanding Balance", "Outstanding Interest", "Total Outstanding Balance");
        //             if((loansReg."Outstanding Balance" = 0) and (loansReg."Outstanding Interest" = 0) and (loansReg."Total Outstanding Balance" = 0)) then begin
        //                 loansReg."Loans Category" := loansReg."Loans Category"::Perfoming;
        //                 loansReg.modify;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     DataItemTableView = where("Date of Birth" = filter(<>0D));
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         ageCust:= '';
        //         retDate:= 0D;
        //         saccoGen.Get();
        //         vend.Reset();
        //         vend.SetRange("BOSA Account No", Customer."No.");
        //         // vend.SetFilter("Date Of Birth", '<>%1',0D);
        //         // vend.SetRange("Account Type", '103');
        //         if vend.Find('-') then begin
        //             repeat
        //             // ageCust:= dateCalc.DetermineAge(Customer."Date Of Birth", Today);
        //             // // ageDec:= Round((Today - Customer."Date Of Birth")/365.25, 1, '=');
        //             // retDate:= CalcDate(saccoGen."Retirement Age", Customer."Date Of Birth");

        //             // vend.Age := ageCust;
        //             // vend."Retirement Date" := retDate;
        //             vend."KRA Pin" := Customer.Pin;
        //             vend.Modify;
        //             until vend.Next() = 0;
        //         end;
        //     end;
        // }

        // dataitem("Loan Disburesment-Batching";"Loan Disburesment-Batching")
        // {
        //     DataItemTableView = where(Status = filter(Open));
        //     RequestFilterFields = "Batch No.";

        //     column(Batch_No_;"Batch No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Loan Disburesment-Batching".CalcFields("No of Loans");
        //         if "Loan Disburesment-Batching"."No of Loans" = 0 then begin
        //             if "Loan Disburesment-Batching"."Posting Date" <> Today then begin
        //                 "Loan Disburesment-Batching".Status := "Loan Disburesment-Batching".Status::Rejected;
        //                 "Loan Disburesment-Batching".Modify;
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
        //         "Loans Register"."Application Date" := Today;
        //         "Loans Register".Modify;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         cust.Reset();
        //         cust.SetRange("No.", Customer."No.");
        //         if cust.Find('-') then begin
        //             cust."Registration Date" := regDate;
        //             cust.modify;
        //         end;
        //     end;
        // }

        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            trigger OnAfterGetRecord()
            begin
                loanProduct.Reset();
                loanProduct.SetRange(Code, memberNo);
                if loanProduct.Find('-') then begin
                    gross := mobile.GetGrossSalary(Vendor."No.", loanProduct.Code);
                    // Error('Gross: %1.', gross);
                    // gross:= mobile.GetSalaryLoanQualifiedAmount(Vendor."No.", loanProduct.Code, loanProduct."Max. Loan Amount", msg, nokNo);
                    // gross:= mobile.GetOverdraftLoanQualifiedAmount(Vendor."No.", loanProduct.Code, loanProduct."Max. Loan Amount", msg);
                    gross := mobile.FnGetMobileAdvanceEligibility(Vendor."No.", loanProduct.Code, msg, loanProduct."Max. Loan Amount", nokNo);
                    // gross := mobile.GetCreditRatingLimit(Vendor."BOSA Account No", loanProduct.Code);
                    // gross:= mobile.GetReloadedLoanQualifiedAmount(Vendor."No.", loanProduct.Code, loanProduct."Max. Loan Amount", msg, nokNo);
                    Error('Gross: %1.', gross);
                end;

                // Error('Masked string is: %1', AUFactory.FnMaskString('254741911610', 6, 5, '*'));
            end;
        }

        // dataitem("Fixed Deposit";"Fixed Deposit")
        // {
        //     DataItemTableView = where(Credited = filter(true));
        //     column(FD_No;"FD No")
        //     {}

        //     trigger OnAfterGetRecord() begin

        //         vend.RESET;
        //         vend.SETRANGE("ID No.", "Fixed Deposit"."ID NO");
        //         vend.SETFILTER("Account Type", '108');
        //         IF vend.FIND('-') THEN BEGIN

        //         fdPlacement.Reset();
        //         fdPlacement.Init();
        //         fdPlacement."Fixed Deposit No." := "Fixed Deposit"."FD No";
        //         fdPlacement."Member No" := vend."BOSA Account No";
        //         fdPlacement.Validate("Member No");
        //         fdPlacement."Fixed Deposit Account No" := vend."No.";
        //         fdPlacement."Account to Tranfers FD Amount" := "Fixed Deposit"."Account No";
        //         fdPlacement."Amount to Fix" := "Fixed Deposit".Amount;
        //         fdPlacement."Fixed Deposit Start Date" := "Fixed Deposit".Date;
        //         fdPlacement."Fixed Duration" := "Fixed Deposit".Duration;
        //         fdPlacement."Application Date" := "Fixed Deposit".Date;
        //         fdPlacement."FD Interest Rate" := "Fixed Deposit"."Interest Rate";
        //         fdPlacement."Created On" := "Fixed Deposit".Date;
        //         fdPlacement."Created By" := "Fixed Deposit"."Created by";
        //         fdPlacement."Date Effected" := "Fixed Deposit".Date;
        //         fdPlacement."Fixed Deposit Type" := "Fixed Deposit"."Fd Duration";
        //         fdPlacement."Expected Interest Earned" := "Fixed Deposit"."Interest Earned";
        //         fdPlacement."Expected Tax After Term Period" := "Fixed Deposit"."Withholding Tax";
        //         fdPlacement."Expected Net After Term Period" := "Fixed Deposit"."Amount After maturity";
        //         fdPlacement."FD Maturity Date" := "Fixed Deposit".MaturityDate;
        //         fdPlacement."Maturity Instructions" := "Fixed Deposit"."Upon Maturity";
        //         fdPlacement.Effected := true;
        //         fdPlacement."Effected By" := "Fixed Deposit"."Created by";
        //         fdPlacement."Date Effected" := "Fixed Deposit".Date;
        //         fdPlacement.Insert(True);

        //         end;
        //     end;
        // }

        // dataitem("Import Mobile Banking Member";"Import Mobile Banking Member")
        // {
        //     column(ID_No_;"ID No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Import Mobile Banking Member".Delete();
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         Customer."Mobile Phone No" := memberNo;
        //         Customer."Mobile Phone No." := memberNo;

        //         vend.Reset();
        //         vend.SetRange("BOSA Account No", Customer."No.");
        //         if vend.FindSet() then begin
        //             repeat
        //             vend."Mobile Phone No" := memberNo;
        //             vend."Mobile Phone No." := memberNo;
        //             vend.Modify;
        //             until vend.Next() = 0;
        //         end;

        //         Customer.Modify;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     DataItemTableView = where(ISNormalMember = filter(true));
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         accTypes.Reset();
        //         if accTypes.Find('-') then begin
        //             repeat
        //             vend.Reset();
        //             vend.SetRange("BOSA Account No", Customer."No.");
        //             vend.SetRange("Account Type", accTypes.Code);
        //             if vend.Find('-') then begin
        //                 vend.CalcFields(Balance);
        //                 if vend.Balance = 0 then begin
        //                     vend.Status := vend.Status::Closed;
        //                     vend.Modify;
        //                 end;
        //                 TotalAmount := TotalAmount + vend.Balance;
        //             end;
        //             until accTypes.Next() = 0;
        //         end;

        //         Customer.CalcFields("Total Loan Balance");
        //         TotalAmount := TotalAmount + Customer."Total Loan Balance";

        //         if TotalAmount = 0 then begin
        //             Customer.Status := Customer.Status::Closed;
        //             Customer.Modify;
        //         end else begin
        //             Customer.Status := Customer.Status::Dormant;
        //             Customer.Modify;
        //         end;
        //     end;
        // }



        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(Account_No;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         LineNo := 0;
        //         nextofkinTable.Reset();
        //         nextofkinTable.SetRange("Account No", Customer."No.");
        //         if nextofkinTable.FindSet() then begin
        //             repeat
        //             LineNo := LineNo + 1;
        //             nextofkinTable."NoK No." := LineNo;
        //             nextofkinTable.Modify;
        //             until nextofkinTable.Next() = 0;
        //         end;
        //     end;
        // }

        // dataitem("Bank Account Ledger Entry";"Bank Account Ledger Entry")
        // {
        //     RequestFilterFields = "Document No.", "Posting Date", Description;
        //     column(Document_No_;"Document No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Bank Account Ledger Entry".Description = 'PCK Salary Dec 2025' then begin
        //             "Bank Account Ledger Entry".Description := 'PCK Salary Dec 2024';
        //             "Bank Account Ledger Entry".Modify;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         //LN042331
        //         "Loans Register"."Loan Status" := "Loans Register"."Loan Status"::Disbursed;
        //         "Loans Register"."Approval Status" := "Loans Register"."Approval Status"::Approved;
        //         "Loans Register".Modify;
        //     end;
        // }

        // dataitem("Import Buffer";"Import Buffer")
        // {
        //     column(Payroll_No;"Payroll No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         // "Import Buffer".Delete();
        //         // if memberNo <> "Import Buffer".Workstation then begin
        //         //     Workstations.Reset;
        //         //     Workstations.Init;
        //         //     Workstations.EmployerCode := 'POSTAL CORP';
        //         //     workstations.Code := "Import Buffer".Workstation;
        //         //     workstations.Region := "Import Buffer".Region;
        //         //     workstations.Description := 'PCK - ' + "Import Buffer".Town;
        //         //     if not workstations.Insert() then workstations.Modify();
        //         //     memberNo := "Import Buffer".Workstation;
        //         // end;

        //         // "Import Buffer"."PF No" := 'PCK'+"Import Buffer"."Payroll No";
        //         // "Import Buffer".Modify();

        //         cust.Reset();
        //         cust.SetRange("Payroll No", "Import Buffer"."PF No");
        //         if cust.Find('-') then begin
        //             cust.Workstation := "Import Buffer".Workstation;
        //             cust.Modify();
        //         end;
        //     end;
        // }

        // dataitem("prPeriod Transactions.";"prPeriod Transactions.")
        // {
        //     RequestFilterFields = "Period Year", "Transaction Code";
        //     column(Employee_Code;"Employee Code")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         P9Trans.Reset();
        //         P9Trans.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
        //         P9Trans.SetRange("Period Year", "prPeriod Transactions."."Period Year");
        //         P9Trans.SetRange("Period Month", "prPeriod Transactions."."Period Month");
        //         if P9Trans.Find('-') then begin
        //             P9Trans."Housing Levy" := "prPeriod Transactions.".Amount;
        //             P9Trans.Modify;
        //         end;
        //     end;
        // }
        // dataitem("Payroll Employee.";"Payroll Employee.")
        // {
        //     RequestFilterFields = "No.";

        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         TotalAmount := 0;
        //         ChargeAmount := 0;
        //         deficitInt := 0;

        //         periodTrans.Reset();
        //         periodTrans.SetRange("Employee Code", "Payroll Employee."."No.");
        //         periodTrans.SetRange("Period Month", 6);
        //         periodTrans.SetRange("Period Year", 2024);
        //         periodTrans.SetRange("Group Order", 8);
        //         if periodTrans.FindSet() then begin
        //             periodTrans.CalcSums(Amount);
        //             regDate := periodTrans."Payroll Period";
        //             TotalAmount := periodTrans.Amount;
        //         end;
        //         periodTrans.Reset();
        //         periodTrans.SetRange("Employee Code", "Payroll Employee."."No.");
        //         periodTrans.SetRange("Period Month", 6);
        //         periodTrans.SetRange("Period Year", 2024);
        //         periodTrans.SetRange("Group Order", 7);
        //         if periodTrans.FindSet() then begin
        //             periodTrans.CalcSums(Amount);
        //             ChargeAmount := periodTrans.Amount;
        //         end;
        //         periodTrans.Reset();
        //         periodTrans.SetRange("Employee Code", "Payroll Employee."."No.");
        //         periodTrans.SetRange("Period Month", 6);
        //         periodTrans.SetRange("Period Year", 2024);
        //         periodTrans.SetRange("Group Order", 4);
        //         if periodTrans.FindSet() then begin
        //             periodTrans.CalcSums(Amount);
        //             deficitInt := periodTrans.Amount;
        //         end;

        //         periodTrans.Reset();
        //         periodTrans.Init();
        //         periodTrans."Employee Code" := "Payroll Employee."."No.";
        //         periodTrans."Payroll Period" := regDate;
        //         periodTrans."Period Month" := 6;
        //         periodTrans."Period Year" := 2024;
        //         periodTrans."Transaction Code" := 'TOT-DED';
        //         periodTrans."Transaction Name" := 'TOTAL DEDUCTION';
        //         periodTrans."Group Text" := 'DEDUCTIONS';
        //         periodTrans."Group Order" := 8;
        //         periodTrans."Sub Group Order" := 9;
        //         periodTrans.Amount := TotalAmount + ChargeAmount;
        //         periodTrans.Insert();

        //         periodTrans.Reset();
        //         periodTrans.Init();
        //         periodTrans."Employee Code" := "Payroll Employee."."No.";
        //         periodTrans."Payroll Period" := regDate;
        //         periodTrans."Period Month" := 6;
        //         periodTrans."Period Year" := 2024;
        //         periodTrans."Transaction Code" := 'NPAY';
        //         periodTrans."Transaction Name" := 'NET PAY';
        //         periodTrans."Group Text" := 'NET PAY';
        //         periodTrans."Group Order" := 9;
        //         periodTrans."Sub Group Order" := 9;
        //         periodTrans.Amount := deficitInt - (TotalAmount + ChargeAmount);
        //         periodTrans."Journal Account Code" := '200-000-205';
        //         periodTrans."Journal Account Type" := periodTrans."Journal Account Type"::"G/L Account";
        //         periodTrans."Post As" := periodTrans."Post As"::Credit;
        //         periodTrans.Insert();
        //     end;
        // }
        // dataitem("Payroll Employee P9.";"Payroll Employee P9.")
        // {
        //     RequestFilterFields = "Employee Code", "Period Month", "Period Year";
        //     column(Period_Month;"Period Month")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Payroll Employee P9.".Delete();
        //     end;

        // }
        // dataitem("Payroll Calender.";"Payroll Calender.")
        // {
        //     RequestFilterFields = "Date Opened", "Period Month", "Period Year";
        //     column(Period_Month;"Period Month")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         payrollProc.fnP9PeriodClosure("Payroll Calender."."Period Month", "Payroll Calender."."Period Year", "Payroll Calender."."Date Opened", '');
        //     end;
        // }

        // dataitem("Payroll Employee.";"Payroll Employee.")
        // {
        //     RequestFilterFields = "No.";

        //     trigger OnAfterGetRecord()
        //     var
        //     P9EmployeeCode: Date;
        //     P9BasicPay: Decimal;
        //     P9Allowances: Decimal;
        //     P9Benefits: Decimal;
        //     P9ValueOfQuarters: Decimal;
        //     P9DefinedContribution: Decimal;
        //     P9OwnerOccupierInterest: Decimal;
        //     P9GrossPay: Decimal;
        //     P9TaxablePay: Decimal;
        //     P9TaxCharged: Decimal;
        //     P9InsuranceRelief: Decimal;
        //     P9TaxRelief: Decimal;
        //     P9Paye: Decimal;
        //     P9NSSF: Decimal;
        //     P9NHIF: Decimal;
        //     P9Deductions: Decimal;
        //     P9NetPay: Decimal;
        //     begin
        //         periodTrans.Reset();
        //         periodTrans.SetRange("Employee Code", P9Trans."Employee Code");
        //         periodTrans.SetRange("Period Year", 2024);
        //         periodTrans.SetRange("Period Month", 6);
        //         if periodTrans.Find('-') then begin

        //             P9BasicPay := 0;
        //             P9Allowances := 0;
        //             P9Benefits := 0;
        //             P9ValueOfQuarters := 0;
        //             P9DefinedContribution := 0;
        //             P9OwnerOccupierInterest := 0;
        //             P9GrossPay := 0;
        //             P9TaxablePay := 0;
        //             P9TaxCharged := 0;
        //             P9InsuranceRelief := 0;
        //             P9TaxRelief := 0;
        //             P9Paye := 0;
        //             P9NSSF := 0;
        //             P9NHIF := 0;
        //             P9Deductions := 0;
        //             P9NetPay := 0;
        //             P9EmployeeCode := periodTrans."Payroll Period";

        //             repeat
        //                 with periodTrans do begin
        //                     case periodTrans."Group Order" of
        //                         1: //Basic pay & Arrears
        //                             begin
        //                                 if "Sub Group Order" = 1 then P9BasicPay := Amount; //Basic Pay
        //                                 if "Sub Group Order" = 2 then P9BasicPay := P9BasicPay + Amount; //Basic Pay Arrears
        //                             end;
        //                         3:  //Allowances
        //                             begin
        //                                 P9Allowances := P9Allowances + Amount
        //                             end;
        //                         4: //Gross Pay
        //                             begin
        //                                 P9GrossPay := Amount
        //                             end;
        //                         6: //Taxation
        //                             begin
        //                                 if "Sub Group Order" = 1 then P9DefinedContribution := Amount; //Defined Contribution
        //                                 if "Sub Group Order" = 9 then P9TaxRelief := Amount; //Tax Relief
        //                                 if "Sub Group Order" = 8 then P9InsuranceRelief := Amount; //Insurance Relief
        //                                 if "Sub Group Order" = 6 then P9TaxablePay := Amount; //Taxable Pay
        //                                 if "Sub Group Order" = 7 then P9TaxCharged := Amount; //Tax Charged
        //                             end;
        //                         7: //Statutories
        //                             begin
        //                                 if "Sub Group Order" = 1 then P9NSSF := Amount; //Nssf
        //                                 if "Sub Group Order" = 2 then P9NHIF := Amount; //Nhif
        //                                 if "Sub Group Order" = 3 then P9Paye := Amount; //paye
        //                                 if "Sub Group Order" = 4 then P9Paye := P9Paye + Amount; //Paye Arrears
        //                             end;
        //                         8://Deductions
        //                             begin
        //                                 P9Deductions := P9Deductions + Amount;
        //                             end;
        //                         9: //NetPay
        //                             begin
        //                                 P9NetPay := Amount;
        //                             end;
        //                     end;
        //                 end;
        //             until periodTrans.Next = 0;
        //         end;

        //         P9Trans.Reset;
        //         with P9Trans do begin
        //             Init;
        //             "Employee Code" := "Payroll Employee."."No.";
        //             "Basic Pay" := P9BasicPay;
        //             Allowances := P9Allowances;
        //             Benefits := P9Benefits;
        //             "Value Of Quarters" := P9ValueOfQuarters;
        //             "Defined Contribution" := P9DefinedContribution;
        //             "Owner Occupier Interest" := P9OwnerOccupierInterest;
        //             "Gross Pay" := P9GrossPay;
        //             "Taxable Pay" := P9TaxablePay;
        //             "Tax Charged" := P9TaxCharged;
        //             "Insurance Relief" := P9InsuranceRelief;
        //             "Tax Relief" := P9TaxRelief;
        //             PAYE := P9Paye;
        //             NSSF := P9NSSF;
        //             NHIF := P9NHIF;
        //             Deductions := P9Deductions;
        //             "Net Pay" := P9NetPay;
        //             "Period Month" := 6;
        //             "Period Year" := 2024;
        //             "Payroll Period" := P9EmployeeCode;
        //             "Payroll Code" := "Payroll Employee."."No.";
        //             Insert;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         Customer."Member Type" := Customer."Member Type"::Board;
        //         Customer.Modify;
        //         // if Customer."Member Type" = Customer."Member Type"::Member then begin
        //         //     if (customer."Insider Status" = Customer."Insider Status"::"Regular Member") or (customer."Insider Status" = Customer."Insider Status"::" ") then begin
        //         //         customer."Insider Status" := Customer."Insider Status"::"Regular Member";
        //         //         Customer.Modify;
        //         //     end;
        //         // end
        //     end;
        // }

        // dataitem("Legacy Member Exits";"Legacy Member Exits")
        // {
        //     RequestFilterFields = "No";
        //     column(No;No)
        //     {}

        //     trigger OnAfterGetRecord()
        //     var
        //     // notice: Record "Membership Exist";
        //     notice: Record "Withdrawal Notice";
        //     noSeries: Codeunit "No. Series";
        //     saccoSeries: Record "Sacco No. Series";
        //     begin
        //         saccoSeries.Get();
        //         memberNo := noSeries.GetNextNo(saccoSeries."Closure  Nos", Today, True);
        //         notice.Reset();
        //         notice.SetRange("Member No", "Legacy Member Exits"."Member No");
        //         if notice.Find('-') = false then begin
        //             notice."No." := memberNo;
        //             notice."Member No" := "Legacy Member Exits"."Member No";
        //             notice.Name := "Legacy Member Exits"."Member Name";
        //             notice."Payroll No" := "Legacy Member Exits"."Staff  No";
        //             notice."Notice Date" := "Legacy Member Exits"."Notice Date";
        //             // notice.SchoolFeesShares := "Legacy Member Exits".ESS;
        //             // notice."Member Deposits" := "Legacy Member Exits".Deposits;
        //             // notice."Loan Balance" := "Legacy Member Exits"."Total Loan";
        //             // notice."Net Payable to the Member" := "Legacy Member Exits"."Total Amount";
        //             notice."Legacy Upload" := true;
        //             notice.Modify();
        //         end;
        //     end;
        // }

        // dataitem("Withdrawal Notice";"Withdrawal Notice")
        // {
        //     RequestFilterFields = "No.";
        //     DataItemTableView = where("Legacy Upload" = filter(true));
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Withdrawal Notice"."Notice Status" := "Withdrawal Notice"."Notice Status"::Matured;
        //         "Withdrawal Notice".Modify;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     DataItemTableView = where("Insider Status" = filter("Board Member"));

        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         insider.Init();
        //         insider."Member No" := Customer."No.";
        //         insider.Validate("Member No");
        //         insider."Position Held" := insider."Position Held"::Director;
        //         insider.Insert;
        //     end;
        // }

        // dataitem(InsiderLending;InsiderLending)
        // {
        //     RequestFilterFields = "Member No";
        //     DataItemTableView = where("Position Held" = filter(Delegate));

        //     column(Member_No;"Member No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         cust.Reset();
        //         cust.SetRange("No.", InsiderLending."Member No");
        //         cust.SetRange("Insider Status", cust."Insider Status"::"Delegate Member");
        //         if cust.Find('-') = false then begin
        //             InsiderLending.Delete();
        //         end;
        //     end;
        // }

        // dataitem("Paybill Transactions";"Paybill Transactions")
        // {
        //     RequestFilterFields = TransTime, TransID;
        //     column(TransID;TransID)
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Paybill Transactions".Status = "Paybill Transactions".Status::Pending then begin
        //             "Paybill Transactions".Status := "Paybill Transactions".Status::Failed;
        //             "Paybill Transactions"."Transaction Failed" := true;
        //             "Paybill Transactions".Modify;
        //         end;
        //     end;
        // }

        // dataitem("G/L Entry";"G/L Entry")
        // {
        //     RequestFilterFields = "G/L Account No.";
        //     DataItemTableView = where("Source No." = filter(''));
        //     column(Document_No_;"Document No.")
        //     {}
        //     column(Posting_Date;"Posting Date")
        //     {}
        //     column(VendorCommAccount;VendorCommAccount)
        //     {}
        //     column(VendorComm;VendorComm)
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         detCust.Reset();
        //         detCust.SetRange("Document No.", "G/L Entry"."Document No.");
        //         detCust.SetRange("Transaction Type", detCust."Transaction Type"::"Registration Fee");
        //         detVend.SetRange(Reversed, false);
        //         if detCust.Find('-') then begin
        //             CurrReport.Skip();
        //         end else begin
        //             detVend.Reset();
        //             detVend.SetRange("Document No.", "G/L Entry"."Document No.");
        //             detVend.SetRange(Reversed, false);
        //             if detVend.Find('-') then begin
        //                 VendorCommAccount := detVend."Vendor No.";
        //                 VendorComm := detVend.Amount;
        //             end else begin
        //                 CurrReport.Skip();
        //             end;
        //         end;
        //     end;
        // }

        // dataitem("ESS Refund II";"ESS Refund")
        // {
        //     RequestFilterFields = "ESSRef No.";
        //     column(ESSRef_No_;"ESSRef No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         if "ESS Refund II".Refunded = true then begin
        //             "ESS Refund II"."Posting Code" := 'ESSREF-'+ "ESS Refund II"."Member No";
        //             "ESS Refund II".Modify;
        //         end; 
        //     end;
        // }

        // dataitem("Membership Exist";"Membership Exist")
        // {
        //     RequestFilterFields = "Notice No";
        //     DataItemTableView = where(Posted = filter(true));
        //     column(Posted;Posted)
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Membership Exist"."Posting Code" := 'REFUND-FOSA-'+"Membership Exist"."Member No.";
        //         "Membership Exist"."Deposits Code" := '001-'+"Membership Exist"."Member No."+'-2000';
        //         "Membership Exist".Modify;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         vend.Reset();
        //         vend.SetRange("BOSA Account No", Customer."No.");
        //         if vend.FindSet() then begin
        //             repeat
        //             vend."Account Category" := vend."Account Category"::Group;
        //             vend."Group Category" := vend."Group Category"::"Co-operate";
        //             vend."Group ID No" := Customer."ID No.";
        //             vend."ID No." := Customer.Pin;
        //             vend."KRA Pin" := Customer.Pin;
        //             vend.Modify;
        //             until vend.Next() = 0;
        //         end;
        //         Customer."Account Category" := Customer."Account Category"::Group;
        //         Customer."Group ID No" := Customer."ID No.";
        //         Customer."ID No." := Customer.Pin;
        //         Customer.Modify;
        //     end;
        // }

        // dataitem("Salary Processing Lines";"Salary Processing Lines")
        // {
        //     RequestFilterFields = "Salary Header No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Salary Processing Lines"."SMS Received" := false;
        //         "Salary Processing Lines".Modify;
        //     end;
        // }

        // dataitem("Members Next of Kin";"Members Next of Kin")
        // {
        //     RequestFilterFields = "Account No", "NoK No.";
        //     column(Account_No;"Account No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         if "Members Next of Kin"."%Allocation" > 0 then begin
        //             "Members Next of Kin".Beneficiary := true;
        //             "Members Next of Kin".Modify;
        //         end;

        //         if "Members Next of Kin"."Date of Birth" > (CalcDate('<-18Y>', Today)) then begin
        //             if "Members Next of Kin"."ID No." <> '' then begin
        //                 "Members Next of Kin"."ID Type" := Format(1);
        //                 "Members Next of Kin".Modify;
        //             end else begin
        //                 "Members Next of Kin"."ID Type" := Format(1);
        //                 "Members Next of Kin".Modify;
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
        // loansReg.Reset();
        // loansReg.SetRange("Loan  No.", "Loans Register"."Loan  No.");
        // if loansReg.Find('-') then begin
        //     loansReg."Loan Disbursement Date" := disbursedDate;
        //     loansReg."Expected Date of Completion" := completionDate;
        //     loansReg.modify;
        // end;

        //         detCust.Reset();
        //         detCust.SetFilter("Posting Date", '..%1', disbursedDate);
        //         detCust.SetRange(Reversed, false);
        //         detCust.SetRange("Loan No", "Loans Register"."Loan  No.");
        //         detCust.SetRange("Customer No.", "Loans Register"."Client Code");
        //         detCust.SetFilter(detCust."Transaction Type", '%1|%2', detCust."Transaction Type"::"Interest Paid", detCust."Transaction Type"::"Interest Due");
        //         if detCust.FindSet() then begin
        //             detCust.CalcSums(Amount);
        //             totalInt:= detCust.Amount;
        //         end;

        //         detCust.Reset();
        //         detCust.SetFilter("Posting Date", '..%1', completionDate);
        //         detCust.SetRange(Reversed, false);
        //         detCust.SetRange("Loan No", "Loans Register"."Loan  No.");
        //         detCust.SetRange("Customer No.", "Loans Register"."Client Code");
        //         detCust.SetRange(detCust."Transaction Type", detCust."Transaction Type"::"Interest Paid");
        //         if detCust.FindLast() then begin
        //             intAsat:= (detCust.Amount)*-1;
        //         end;

        //         detCust.Reset();
        //         detCust.SetRange("Posting Date", disbursedDate);
        //         detCust.SetRange(Reversed, false);
        //         detCust.SetRange("Loan No", "Loans Register"."Loan  No.");
        //         detCust.SetRange("Customer No.", "Loans Register"."Client Code");
        //         detCust.SetRange(detCust."Transaction Type", detCust."Transaction Type"::"Interest Due");
        //         if detCust.FindSet() then begin
        //             intOndate:= detCust.Amount;
        //         end;

        //         deficitInt := totalInt-(intAsat+intOndate);

        //         if deficitInt > intOndate then begin
        //             intTobePaid:= intOndate + deficitInt;
        //         end else if deficitInt = intOndate then begin
        //             intTobePaid:= intOndate;
        //         end else if deficitInt < intOndate then begin
        //             intTobePaid:= intOndate - deficitInt;
        //         end;
        //         Error('The total int is %1, the int up to the cutoff date is %2, the int on the cutoff date is %3 and int to be paid is %4.', totalInt, intAsat, intOndate, intTobePaid);
        //     end;
        // }

        // dataitem("HR Leave Application";"HR Leave Application")
        // {
        //     RequestFilterFields = "Application Code";
        //     column(Application_Code;"Application Code")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         hrLeave.Reset();
        //         hrLeave.SetRange("Application Code", "HR Leave Application"."Application Code");
        //         if hrLeave.Find('-') then begin
        //             hrLeave.Posted := true;
        //             hrLeave.modify;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         loansReg.Reset();
        //         loansReg.SetRange("Loan  No.", "Loans Register"."Loan  No.");
        //         if loansReg.Find('-') then begin
        //             loansReg."Loan Disbursement Date" := regDate;
        //             loansReg.Validate("Loan Disbursement Date");
        //             loansReg.modify;
        //         end;
        //     end;
        // }


        // dataitem("Penalty Counter";"Penalty Counter")
        // {
        //     column(Loan_No_;"Loan Number")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Penalty Counter".Delete();
        //     end;
        // }

        // dataitem("Member Exit Batch";"Member Exit Batch")
        // {
        //     RequestFilterFields = "Exit Batch No.";
        //     column(Exit_Batch_No_;"Exit Batch No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Member Exit Batch".CalcFields("Total Remainder");
        //         "Member Exit Batch".Validate("Total Remainder");
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Loans Register"."Loan Status" := "Loans Register"."Loan Status"::Rejected;
        //         "Loans Register"."Approval Status" := "Loans Register"."Approval Status"::Rejected;
        //         "Loans Register".Posted := false;
        //         "Loans Register".modify;
        //     end;
        // }


        // dataitem("Detailed Vendor Ledg. Entry";"Detailed Vendor Ledg. Entry")
        // {
        //     DataItemTableView = where(Reversed = filter(false));
        //     RequestFilterFields = "Vendor No.", "Posting Date", "Document No.";
        //     column(Vendor_No_;"Vendor No.")
        //     {}
        //     column(Account_Type;"Account Type")
        //     {}
        //     trigger OnAfterGetRecord()
        //     begin
        //         "Detailed Vendor Ledg. Entry".CalcFields("Account Type");
        //         if "Detailed Vendor Ledg. Entry"."Account Type" <> '102' then CurrReport.Skip();

        //         glEntries.Reset();
        //         glEntries.SetRange("G/L Account No.", '200-000-152');
        //         glEntries.SetRange(Reversed, false);
        //         glEntries.SetRange("Document No.", "Detailed Vendor Ledg. Entry"."Document No.");
        //         if glEntries.Find('-') = false then begin
        //             Error('Transaction %1, under doc no. %2, posted on %3 through account %4.', "Detailed Vendor Ledg. Entry"."Entry No.", "Detailed Vendor Ledg. Entry"."Document No.", "Detailed Vendor Ledg. Entry"."Posting Date", "Detailed Vendor Ledg. Entry"."Vendor No.");
        //         end;
        //     end;
        // }

        // dataitem("Meeting Allowances";"Meeting Allowances")
        // {
        //     RequestFilterFields = Doc_No;

        //     column(Doc_No;Doc_No)
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Meeting Allowances".Erroneous := true;
        //         "Meeting Allowances".Modify;
        //     end;
        // }
        // dataitem("G/L Entry";"G/L Entry")
        // {
        //     DataItemTableView = where(Reversed = filter(false), "G/L Account No." = filter('200-000-152'));
        //     RequestFilterFields = "Entry No.", "Posting Date", "Document No.";
        //     column(Entry_No_;"Entry No.")
        //     {}
        //     trigger OnAfterGetRecord()
        //     begin
        //         detVend.Reset();
        //         detVend.SetRange(Reversed, false);
        //         detVend.CalcFields("Account Type");
        //         detVend.SetRange("Account Type", '102');
        //         detVend.SetRange("Document No.", "G/L Entry"."Document No.");
        //         if detVend.Find('-') = false then begin

        //             Error('Transaction %1, under doc no. %2, posted on %3 through account %4.', detVend."Entry No.", detVend."Document No.", detVend."Posting Date", detVend."Vendor No.");
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         // Error('Source: %1, Posted: %2, Approval Status: %3, Loan Product: %4, Loanee: %5.', "Loans Register".Source, "Loans Register".Posted, "Loans Register"."Approval Status", "Loans Register"."Loan Product Type", "Loans Register"."Client Name");
        //         "Loans Register".Source := "Loans Register".Source::FOSA;
        //         "Loans Register".modify;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         // gross := 0;
        //         // "Loans Register".CalcFields("Disbursed Amount");
        //         // gross := "Loans Register"."Disbursed Amount";
        //         // Error('Disbursed Amount:', gross);
        //         "Loans Register"."Approved Amount" := gross;
        //         "Loans Register".modify;
        //     end;
        // }
        // dataitem("Mpesa Withdawal Buffer";"Mpesa Withdawal Buffer")
        // {
        //     DataItemTableView = where(Posted = filter(false), Reversed = filter(false));
        //     column(Originator_ID;"Originator ID")
        //     {}
        //     trigger OnPreDataItem() begin

        //         BATCH_TEMPLATE := 'GENERAL';
        //         BATCH_NAME := 'MPESAWITH';

        //         GenBatches.Reset;
        //         GenBatches.SetRange(GenBatches."Journal Template Name", BATCH_TEMPLATE);
        //         GenBatches.SetRange(GenBatches.Name, BATCH_NAME);
        //         if GenBatches.Find('-') = false then begin
        //             GenBatches.Init;
        //             GenBatches."Journal Template Name" := BATCH_TEMPLATE;
        //             GenBatches.Name := BATCH_NAME;
        //             GenBatches.Description := 'Unposted MPESA Withdrawals';
        //             GenBatches.Insert;
        //         end;

        //         GenJournalLine.Reset();
        //         GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
        //         GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
        //         if GenJournalLine.FindSet() then begin
        //             GenJournalLine.DeleteAll();
        //         end;
        //     end;

        //     trigger OnAfterGetRecord() begin
        //         ChargeAmount := 0;
        //         GraduatedChargeb.Reset;
        //         if GraduatedChargeb.Find('-') then begin
        //             repeat
        //                 if ("Mpesa Withdawal Buffer"."Amount Requested" >= GraduatedChargeb."Min Band") and ("Mpesa Withdawal Buffer"."Amount Requested" <= GraduatedChargeb."Upper Band") then begin
        //                     VendorComm := 0;
        //                     ChargeAmount := 0;
        //                     ExciseDuty := 0;
        //                     MpesaComm := 0;
        //                     TotalAmount := 0;
        //                     ChargeAmount := GraduatedChargeb.Total;
        //                     VendorComm := GraduatedChargeb."Vendor Comm";
        //                     SaccoCommission := GraduatedChargeb."Sacco Comm";
        //                     MpesaComm := GraduatedChargeb.Mpesa;
        //                     ExciseDuty := GraduatedChargeb."Excise Duty";
        //                     TotalAmount := GraduatedChargeb.Total;
        //                     MpesaCommAccount := GraduatedChargeb."Mpesa Account";
        //                     VendorCommAccount := GraduatedChargeb."Vendor Comm G/L";
        //                     SaccoCommissionAccount := GraduatedChargeb."Sacco Comm G/L";
        //                 end;
        //             until GraduatedChargeb.Next = 0;
        //         end;                        
        //         SaccoGen.Get();
        //         DOCUMENT_NO := "Mpesa Withdawal Buffer"."Originator ID";

        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        //         GenJournalLine."Account Type"::Vendor, "Mpesa Withdawal Buffer"."Vendor No", Today, "Mpesa Withdawal Buffer"."Amount Requested", 'FOSA', DOCUMENT_NO,
        //             'Bank Transfer' + ' ' + Vend."No.", '');
        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        //         GenJournalLine."Account Type"::Vendor, "Mpesa Withdawal Buffer"."Vendor No", Today, TotalAmount, 'FOSA', DOCUMENT_NO,
        //             'Bank Transfer charges' + ' ' + Vend."No.", '');
        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        //         GenJournalLine."Account Type"::Vendor, "Mpesa Withdawal Buffer"."Vendor No", Today, ((SaccoGen."Excise Duty(%)"/100)*TotalAmount), 'FOSA', DOCUMENT_NO,
        //             'Excise Duty Comm' + ' ' + Vend."No.", '');

        //         //Balancing Account
        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        //         GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, "Mpesa Withdawal Buffer"."Amount Requested" * -1, 'FOSA', DOCUMENT_NO,
        //             'Bank Transfer' + ' ' + Vend."No.", '');

        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        //         GenJournalLine."Account Type"::"Bank Account", 'BNK00013', Today, MpesaComm * -1, 'FOSA', DOCUMENT_NO,
        //             'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        //         GenJournalLine."Account Type"::Vendor, VendorCommAccount, Today, VendorComm * -1, 'FOSA', DOCUMENT_NO,
        //          'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        //         GenJournalLine."Account Type"::"G/L Account", SaccoCommissionAccount, Today, SaccoCommission * -1, 'FOSA', DOCUMENT_NO,
        //             'Mobile Trans Mpesa Comm' + ' ' + Vend."No.", '');

        //         SaccoGen.Get();
        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
        //         GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ((SaccoGen."Excise Duty(%)"/100)*TotalAmount)*-1, 
        //         'FOSA', DOCUMENT_NO, 'Excise Duty Comm' + ' ' + Vend."No.", '');

        //     end;

        // }

        // dataitem("Paybill Transactions";"Paybill Transactions")
        // {
        //     DataItemTableView = where(Status = filter(<>Posted), MSIDN = filter('0124A062563600'));
        //     RequestFilterFields = TransID;
        //     column(TransID;TransID)
        //     {}
        //     trigger OnPreDataItem() begin
        //         if memberNo = '' then CurrReport.Skip();
        //     end;
        //     trigger OnAfterGetRecord() begin
        //         paybill.Reset();
        //         paybill.SetRange(TransID, "Paybill Transactions".TransID);
        //         if paybill.Find('-') then begin
        //             paybill.BillRefNumber := memberNo;
        //             paybill.modify;
        //         end;
        //     end;
        // }

        // dataitem("Salary Details";"Salary Details")
        // {
        //     RequestFilterFields = "Document Number";
        //     column(Document_Number;"Document Number")
        //     {}
        //     trigger OnPreDataItem() begin
        //         if memberNo = '' then CurrReport.Skip();
        //     end;
        //     trigger OnAfterGetRecord() begin
        //         "Salary Details"."Salary Type" := "Salary Details"."Salary Type"::Allowance;
        //         "Salary Details".modify;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         detCust.Reset();
        //         detCust.SetRange("Customer No.", "Loans Register"."Client Code");
        //         detCust.SetRange("Loan No", "Loans Register"."Loan  No.");
        //         detCust.SetRange("Transaction Type", detCust."Transaction Type"::Loan);
        //         detCust.SetRange(Reversed, false);
        //         if detCust.Find('-') = false then begin
        //             "Loans Register".Reversed := true;
        //             "Loans Register".modify;
        //         end else begin
        //             "Loans Register".Reversed := false;
        //             "Loans Register".modify;
        //         end;
        //     end;
        // }

        // dataitem(Vendor;Vendor)
        // {
        //     DataItemTableView = where("Creditor Type" = filter("FOSA Account"));
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}
        //     column(Name;Name)
        //     {}
        //     column(BOSA_Account_No;"BOSA Account No")
        //     {}
        //     column(Creditor_Type;"Creditor Type")
        //     {}
        //     column(ID_No_;"ID No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         // if cust.Get(Vendor."BOSA Account No") then CurrReport.Skip();
        //         vend.Reset();
        //         vend.SetRange("BOSA Account No", '002171');
        //         vend.SetRange("Account Type", '103');
        //         if vend.Find('-') then begin
        //             Vendor."BOSA Account No" := vend."BOSA Account No";
        //             Vendor."Mobile Phone No" := vend."Mobile Phone No";
        //             Vendor."Mobile Phone No." := vend."Mobile Phone No.";
        //             Vendor.Name := vend.Name;
        //             Vendor.Modify;
        //         end;
        //     end;

        // }

        // dataitem("Penalty Counter";"Penalty Counter")
        // {
        //     RequestFilterFields = "Date Entered";
        //     column(Date_Entered;"Date Entered")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Penalty Counter".Delete();
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     DataItemTableView = where(IsNormalMember = filter(true));
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         Vend.Reset();
        //         Vend.SetRange("BOSA Account No", Customer."No.");
        //         if Vend.Find('-') then begin
        //             repeat
        //                 if Vend."Account Type" = '101' then begin
        //                     Customer."Share Capital No" := Vend."No.";
        //                     Customer.Modify(true);
        //                 end else
        //                     if Vend."Account Type" = '102' then begin
        //                         Customer."Deposits Account No" := Vend."No.";
        //                         Customer.Modify(true);
        //                     end else
        //                         if Vend."Account Type" = '103' then begin
        //                             Customer."FOSA Account No." := Vend."No.";
        //                             Customer."Ordinary Savings Acc" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end else
        //                         if Vend."Account Type" = '104' then begin
        //                             Customer."School Fees Shares Account" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end else
        //                         if Vend."Account Type" = '105' then begin
        //                             Customer."Chamaa Savings Acc" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end else
        //                         if Vend."Account Type" = '106' then begin
        //                             Customer."Jibambe Savings Acc" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end else
        //                         if Vend."Account Type" = '107' then begin
        //                             Customer."Wezesha Savings Acc" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end else
        //                         if Vend."Account Type" = '108' then begin
        //                             Customer."Fixed Deposit Acc" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end else
        //                         if Vend."Account Type" = '109' then begin
        //                             Customer."Mdosi Junior Acc" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end else
        //                         if Vend."Account Type" = '110' then begin
        //                             Customer."Pension Akiba Acc" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end else
        //                         if Vend."Account Type" = '111' then begin
        //                             Customer."Business Account Acc" := Vend."No.";
        //                             Customer.Modify(true);
        //                         end 
        //             until Vend.Next() = 0;
        //         end;
        //     end;
        // }

        // dataitem("Vendor Ledger Entry";"Vendor Ledger Entry")
        // {
        //     RequestFilterFields = "Document No.", "Posting Date", "Vendor No.";
        //     DataItemTableView = where("Credit Amount" = filter(>0));

        //     column(Document_No_;"Document No.")
        //     {}

        //     trigger OnPreDataItem() begin
        //         if ageCust = '' then Error('Kindly ensure that a description is highlighted.');
        //     end;

        //     trigger OnAfterGetRecord() begin
        //         "Vendor Ledger Entry".CalcFields("Account Type");
        //         if "Vendor Ledger Entry"."Account Type" <> '103' then CurrReport.Skip();
        //         "Vendor Ledger Entry".Description := ageCust;
        //         "Vendor Ledger Entry".Modify;
        //     end;
        // }

        // dataitem("Bank Account Ledger Entry";"Bank Account Ledger Entry")
        // {
        //     RequestFilterFields = "Document No.", "Posting Date";

        //     column(Document_No_;"Document No.")
        //     {}

        //     trigger OnPreDataItem() begin
        //         if ageCust = '' then Error('Kindly ensure that a description is highlighted.');
        //     end;

        //     trigger OnAfterGetRecord() begin
        //         "Bank Account Ledger Entry".Description := ageCust;
        //         "Bank Account Ledger Entry".Modify;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.", "Client Code", "Loan Product Type", "Total Outstanding Balance", "Loan Disbursement Date";
        //     DataItemTableView = where("Total Outstanding Balance" = filter(>0));

        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         loanRepSchedule.Reset();
        //         loanRepSchedule.SetRange("Loan No.", "Loans Register"."Loan  No.");
        //         if loanRepSchedule.Find('-') then begin
        //             "Loans Register".Repayment := loanRepSchedule."Monthly Repayment";
        //             "Loans Register"."Loan Principle Repayment" := loanRepSchedule."Principal Repayment";
        //             "Loans Register"."Loan Interest Repayment" := loanRepSchedule."Monthly Interest";
        //             "Loans Register".Modify;
        //         end else begin
        //             loanProduct.Get("Loans Register"."Loan Product Type");
        //             if loanproduct."Non Recurring Interest" = false then begin
        //                 AuFactory.FnGenerateLoanRepaymentSchedule("Loans Register"."Loan  No.");
        //             end;
        //             if loanproduct."Non Recurring Interest" = true then begin
        //                 AuFactory.FnGenerateLoanRepaymentScheduleZero("Loans Register"."Loan  No.");
        //             end;
        //         end;
        //     end;
        // }

        // dataitem("ATM Log Entries3";"ATM Log Entries3")
        // {
        //     column(Trace_ID;"Trace ID")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         DOCUMENT_NO := CopyStr("ATM Log Entries3"."Trace ID", 1, 20);
        //         if DOCUMENT_NO <> '' then begin
        //             "ATM Log Entries3"."Bank Doc_No" := DOCUMENT_NO;
        //             "ATM Log Entries3".Modify;
        //         end;
        //     end;  
        // }

        // dataitem("Salary Details";"Salary Details")
        // {
        //     RequestFilterFields = "Document Number";
        //     column(Document_Number;"Document Number")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Salary Details".Validate("Posting Date");
        //         "Salary Details".modify;
        //     end;
        // }
        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields ="Loan Product Type";
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Loans Register"."Recovery Mode" := "Loans Register"."Recovery Mode"::Mobile;
        //         "Loans Register".Modify;
        //     end;
        // }


        // dataitem("G/L Entry";"G/L Entry")
        // {
        //     RequestFilterFields = "G/L Account No.";
        //     column(Document_No_;"Document No.")
        //     {}
        //     column(G_L_Account_No_;"G/L Account No.")
        //     {}
        //     column(Posting_Date;"Posting Date")
        //     {}
        //     column(Amount;Amount)
        //     {}
        //     column(missing;missing)
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         detCust.Reset();
        //         detCust.SetFilter("Transaction Type", '%1|%2', detCust."Transaction Type"::Loan, detCust."Transaction Type"::Repayment);
        //         detCust.SetRange("Document No.", "G/L Entry"."Document No.");
        //         if detCust.Find('-') = false then begin
        //             missing := true;
        //         end else CurrReport.Skip(); //missing := false;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     DataItemTableView = where("Current Shares" = filter(0), "Shares Retained" = filter(0), "Membership Status" = filter(<>"Awaiting Exit"|Exited|"Fully Exited"|Deceased|Retired));
        //     column(No_;"No.")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         if (Customer."Current Shares" = 0) and (Customer."Shares Retained" = 0) then begin
        //             Customer."Membership Status" := Customer."Membership Status"::Closed;
        //             Customer.modify;
        //         end
        //     end;
        // }

        // dataitem("Loan Recovery Header";"Loan Recovery Header")
        // {
        //     RequestFilterFields = "Document No";
        //     column(Document_No;"Document No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Loan Recovery Header".Posted := false;
        //         "Loan Recovery Header"."Loans Generated" := false;
        //         "Loan Recovery Header"."Posting Date" := 0D;
        //         "Loan Recovery Header"."Posted By" := '';
        //         "Loan Recovery Header".modify;
        //     end;
        // }

        // dataitem("Member Salary Variance Buffer";"Member Salary Variance Buffer")
        // {
        //     RequestFilterFields = "Member No", "Document No";
        //     column(Member_No;"Member No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         "Member Salary Variance Buffer".Delete;
        //     end;
        // }

        // dataitem("Salary Processing Lines";"Salary Processing Lines")
        // {
        //     RequestFilterFields = "Salary Header No.";
        //     column(Salary_Header_No_;"Salary Header No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         regDate := 0D;
        //         "Salary Processing Lines".CalcFields("Mobile Phone Number");

        //         mobilePhoneNo := "Salary Processing Lines"."Mobile Phone Number";
        //         if CopyStr("Salary Processing Lines"."Mobile Phone Number", 1, 1) = '7' then begin
        //             mobilePhoneNo := InsStr("Salary Processing Lines"."Mobile Phone Number", '254', 1);
        //         end else if CopyStr("Salary Processing Lines"."Mobile Phone Number", 1, 1) = '+' then begin
        //             mobilePhoneNo := DelChr("Salary Processing Lines"."Mobile Phone Number", '=', '+');
        //         end;

        //         if salaryHeader.Get("Salary Processing Lines"."Salary Header No.") then begin
        //             regDate:= salaryHeader."Posting date";
        //         end;

        //         smsMessages.Reset();
        //         smsMessages.SetRange(receiver, mobilePhoneNo);
        //         smsMessages.SetRange(msg_category, 'SALARY_PROCESSING');
        //         smsMessages.SetFilter("SMS Date", '%1..%2',regDate, Today);
        //         if smsMessages.Find('-') then begin
        //             "Salary Processing Lines"."SMS Received" := true;
        //             "Salary Processing Lines".Modify;
        //         end else begin
        //             "Salary Processing Lines"."SMS Received" := false;
        //             "Salary Processing Lines".Modify;
        //         end;
        //     end;

        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord()
        //     var

        //         PaybillTransactions: Record "Paybill Transactions";
        //         GenJournalLine: Record "Gen. Journal Line";
        //         SFactory: Codeunit "SURESTEP FactoryMobile";
        //         RunBal: Decimal;
        //         LoansR: Record "Loans Register";
        //         PenAmount: Decimal;
        //         IntAmount: Decimal;
        //         TotalPaid: Decimal;
        //         TotalPaidSchedule: Decimal;
        //         Schedule: Record "Loan Repayment Schedule";
        //         saccoGen: Record "Sacco General Set-Up";
        //         sto: Record "Standing Orders";
        //         LoanArrears: Decimal;
        //         LineNo: Integer;
        //         Jtemplate: Code[30];
        //         JBatch: Code[30];
        //         BATCH_NAME: Code[50];
        //         BATCH_TEMPLATE: Code[50];
        //         ObjGenSetup: Record "Sacco General Set-Up";
        //         Bname: Codeunit "Send Birthday SMS";
        //         dateCalc: Codeunit "Dates Calculation";
        //         RunningBalance: Decimal;
        //         AUSal: Codeunit "Au Factory";
        //         DOCUMENT_NO: Code[40];
        //         GenBatches: Record "Gen. Journal Batch";
        //         LoanProductType: Record "Loan Products Setup";
        //         stoLines: Record "Receipt Allocation";
        //         repaySchedule: Record "Loan Repayment Schedule";
        //         ExciseDutyP: Decimal;
        //         Vendor: Record Vendor;
        //         cust: Record Customer;
        //         salDate: Text[250];
        //         FOSAPaybillCode: Code[20];
        //         EXTERNAL_DOC_NO: Code[40];
        //         AuFactory: Codeunit "Au Factory";
        //         principleRepay : Decimal;
        //         loanProduct: Code[20];
        //     begin
        //         BATCH_TEMPLATE := 'GENERAL';
        //         BATCH_NAME := 'TEST2FOSA';
        //         DOCUMENT_NO := 'SALFOSA';

        //         GenJournalLine.RESET;
        //         GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
        //         GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
        //         if GenJournalLine.FindSet() then begin
        //             GenJournalLine.DELETEALL;
        //         end;

        //         GenBatches.Reset;
        //         GenBatches.SetRange(GenBatches."Journal Template Name", BATCH_TEMPLATE);
        //         GenBatches.SetRange(GenBatches.Name, BATCH_NAME);
        //         if GenBatches.Find('-') = false then begin
        //             GenBatches.Init;
        //             GenBatches."Journal Template Name" := BATCH_TEMPLATE;
        //             GenBatches.Name := BATCH_NAME;
        //             GenBatches.Insert;
        //         end;

        //         Vendor.Reset();
        //         if Vendor.Get(Customer."Ordinary Savings Acc") then begin
        //             LineNo := LineNo + 10000;
        //             AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //             GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, 43808 * -1, 'FOSA',
        //             EXTERNAL_DOC_NO, 'PaytoFOSA - ' + salDate, '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"1-Gross salary");

        //             ObjGenSetup.Get();
        //             if ObjGenSetup."Salary Processing Fee" > 0 then begin
        //                 LineNo := LineNo + 10000;
        //                 AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                 GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, ObjGenSetup."Salary Processing Fee", 'FOSA',
        //                 EXTERNAL_DOC_NO, 'Salary processing fee - Pay2FOSA', '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");
        //                 // RunningBalance := PaybillTransactions.TransAmount - ObjGenSetup."Salary Processing Fee";

        //                 LineNo := LineNo + 10000;
        //                 AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                 GenJournalLine."account type"::"G/L Account", ObjGenSetup."Salary Processing Fee Acc", Today, -ObjGenSetup."Salary Processing Fee", 'FOSA',
        //                 EXTERNAL_DOC_NO, 'Salary processing fee - Pay2FOSA', '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"2-Salary Processing Fee");

        //                 ExciseDutyP := ROUND((ObjGenSetup."Salary Processing Fee" * ObjGenSetup."Excise Duty(%)" / 100), 0.01, '=');
        //                 LineNo := LineNo + 10000;
        //                 AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                 GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, ExciseDutyP, 'FOSA',
        //                 EXTERNAL_DOC_NO, 'Excise Duty on salary - Pay2FOSA', '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

        //                 LineNo := LineNo + 10000;
        //                 AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                 GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Today, -ExciseDutyP, 'FOSA',
        //                 EXTERNAL_DOC_NO, 'Excise Duty on salary - Pay2FOSA', '', GenJournalLine."application source"::" ", Customer."No.", GenJournalLine."Salary Receipt Type"::"3-Excise Duty");

        //             end;

        //             LineNo := LineNo + 10000;
        //             AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."Account Type"::"Bank Account",
        //             'BNK00003', Today, 43808, 'FOSA', EXTERNAL_DOC_NO, 'PaytoFOSA-' + '', '', GenJournalLine."application source"::" ");

        //             LoansR.Reset();
        //             LoansR.SetRange("Client Code", Customer."No.");
        //             LoansR.SetFilter("Recovery Mode", '%1|%2', LoansR."Recovery Mode"::PaytoFOSA, LoansR."Recovery Mode"::Salary);
        //             LoansR.SetAutoCalcFields("Total Outstanding Balance");
        //             LoansR.SetFilter("Total Outstanding Balance", '>%1', 0);
        //             LoansR.SetRange(Posted, true);
        //             if LoansR.FindSet() then begin
        //                 repeat
        //                     repaySchedule.Reset();
        //                     repaySchedule.SetCurrentKey("Loan No.");
        //                     repaySchedule.SetAscending("Repayment Date", true);
        //                     repaySchedule.SetRange("Loan No.", LoansR."Loan  No.");
        //                     repaySchedule.SetFilter("Repayment Date", '<%1', Today);
        //                     if repaySchedule.FindLast() then begin
        //                         principleRepay := repaySchedule."Principal Repayment";
        //                     end;
        //                     LoansR.CalcFields("Total Outstanding Balance");
        //                     if RunningBalance > (principleRepay + LoansR."Outstanding Interest") then begin
        //                         EXTERNAL_DOC_NO := LoansR."Loan  No.";
        //                         LoanProductType.Reset();
        //                         if LoanProductType.Get(LoansR."Loan Product Type") then begin//
        //                             loanProduct := LoanProductType."Product Description";
        //                         end;
        //                         LoansR.CalcFields("Outstanding Balance", "Outstanding Interest");
        //                         if LoansR."Outstanding Interest" > 0 then begin
        //                             LineNo := LineNo + 10000;
        //                             AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
        //                             GenJournalLine."account type"::Customer, Customer."No.", Today, -LoansR."Outstanding Interest", 'BOSA',
        //                             EXTERNAL_DOC_NO, 'Interest Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
        //                             Customer."No.", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");
        //                             LineNo := LineNo + 10000;
        //                             AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                             GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, LoansR."Outstanding Interest", 'FOSA',
        //                             EXTERNAL_DOC_NO, 'Interest Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
        //                             Customer."No.", GenJournalLine."Salary Receipt Type"::"5-Interest Paid");
        //                         end;
        //                         if RunningBalance > principleRepay then begin
        //                             if principleRepay > LoansR."Outstanding Balance" then begin
        //                                 LineNo := LineNo + 10000;
        //                                 AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
        //                                 GenJournalLine."account type"::Customer, Customer."No.", Today, -LoansR."Outstanding Balance", 'BOSA',
        //                                 EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
        //                                 Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
        //                                 LineNo := LineNo + 10000;
        //                                 AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                                 GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, LoansR."Outstanding Balance", 'FOSA',
        //                                 EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
        //                                 Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

        //                             end else begin
        //                                 LineNo := LineNo + 10000;
        //                                 AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
        //                                 GenJournalLine."account type"::Customer, Customer."No.", Today, -principleRepay, 'BOSA',
        //                                 EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
        //                                 Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");
        //                                 LineNo := LineNo + 10000;
        //                                 AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                                 GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, principleRepay, 'FOSA',
        //                                 EXTERNAL_DOC_NO, 'Repayment ' + loanProduct, LoansR."Loan  No.", GenJournalLine."application source"::" ",
        //                                 Customer."No.", GenJournalLine."Salary Receipt Type"::"4-Loan Repayment");

        //                             end;
        //                         end;

        //                     end;
        //                 until LoansR.Next() = 0;
        //             end;
        //             sto.Reset();
        //             sto.SetRange("BOSA Account No.", Customer."No.");
        //             sto.SetRange(Status, sto.Status::Approved);
        //             sto.SetRange("Is Active", true);
        //             sto.SetRange("Standing Order Dedution Type", sto."Standing Order Dedution Type"::PaytoFOSA);
        //             sto.SetFilter("Next Run Date", '<=%1', Today);
        //             sto.SetFilter("Effective/Start Date", '<=%1', Today);
        //             if sto.Find('-') then begin
        //                 repeat
        //                     stoLines.Reset();
        //                     stoLines.SetRange("Document No", sto."No.");
        //                     if stoLines.Find('-') then begin
        //                         sto.CalcFields("Allocated Amount");
        //                         EXTERNAL_DOC_NO := sto."No.";
        //                         if sto."Allocated Amount" < RunningBalance then begin
        //                             repeat
        //                                 if stoLines."STO Account Type" = stoLines."STO Account Type"::Member then begin
        //                                     if stoLines."Transaction Type" = stoLines."Transaction Type"::"Benevolent Fund" then begin
        //                                         LineNo := LineNo + 10000;
        //                                         AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
        //                                         GenJournalLine."account type"::Member, Customer."No.", Today, -stoLines.Amount, 'BOSA',
        //                                         EXTERNAL_DOC_NO, 'BBF Contribution - Pay2FOSA', '', GenJournalLine."application source"::" ",
        //                                             Customer."No.", GenJournalLine."Salary Receipt Type"::"6-STO");
        //                                         LineNo := LineNo + 10000;
        //                                         AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                                         GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, stoLines.Amount, 'BOSA',
        //                                         EXTERNAL_DOC_NO, 'BBF Contribution - Pay2FOSA', '', GenJournalLine."application source"::" ",
        //                                             Customer."No.", GenJournalLine."Salary Receipt Type"::"6-STO");
        //                                     end;
        //                                 end else if stoLines."STO Account Type" = stoLines."STO Account Type"::"FOSA Account" then begin
        //                                     LineNo := LineNo + 10000;
        //                                     AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                                     GenJournalLine."account type"::Vendor, stoLines."Member No", Today, -stoLines.Amount, 'FOSA',
        //                                     EXTERNAL_DOC_NO, ' Contribution - Pay2FOSA', '', GenJournalLine."application source"::" ",
        //                                     Customer."No.", GenJournalLine."Salary Receipt Type"::"6-STO");
        //                                     LineNo := LineNo + 10000;
        //                                     AUFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //                                     GenJournalLine."account type"::Vendor, Customer."Ordinary Savings Acc", Today, stoLines.Amount, 'FOSA',
        //                                     EXTERNAL_DOC_NO, ' Contribution - Pay2FOSA', '', GenJournalLine."application source"::" ",
        //                                     Customer."No.", GenJournalLine."Salary Receipt Type"::"6-STO");
        //                                 end;

        //                             until stoLines.Next() = 0;
        //                         end;
        //                     end;
        //                 until sto.Next() = 0;
        //             end;
        //         end;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     DataItemTableView = where(isNormalMember = filter(true), "Mdosi Junior Acc" = filter(<>' '));
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         intAsat := 0;
        //         vend.Reset();
        //         vend.SetRange("BOSA Account No", Customer."No.");
        //         vend.SetRange("Account Type", '109');
        //         if vend.FindSet() then begin
        //             repeat
        //                 detVend.Reset();
        //                 detVend.SetRange("Vendor No.", vend."No.");
        //                 detVend.SetFilter("Posting Date", '..%1', regDate);
        //                 detVend.SetRange(Reversed, false);
        //                 if detVend.FindSet() then begin
        //                     detVend.CalcSums(Amount);
        //                     intAsat := intAsat + ((detVend.Amount)*-1);
        //                 end;
        //             until vend.Next() = 0;
        //             Customer."Total Mdosi Jr" := intAsat;
        //             Customer.Modify;
        //         end;
        //     end;
        // }

        // dataitem("Bank Account Ledger Entry";"Bank Account Ledger Entry")
        // {
        //     DataItemTableView = where(Reversed = filter(false));
        //     RequestFilterFields = "Posting Date", "Document No.", "Transaction Count";

        //     column(Document_No_;"Document No.")
        //     {}
        //     column(Posting_Date;"Posting Date")
        //     {}
        //     column(Amount;Amount)
        //     {}
        // }
        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";

        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         Customer.Status := Customer.Status::Closed;
        //         Customer."Membership Status" := Customer."Membership Status"::Closed;
        //         Customer.Validate("Membership Status");
        //         Customer.Modify;
        //     end;
        // }

        // dataitem(Customer;Customer)
        // {
        //     RequestFilterFields = "No.";
        //     column(No_;"No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         Customer."Insider Status" := Customer."Insider Status"::"Delegate Member";
        //         Customer."Member Type" := Customer."Member Type"::"Station Representative";
        //         Customer.Modify;
        //     end;
        // }

        // dataitem("Member Ledger Entries Buffer";"Member Ledger Entries Buffer")
        // {
        //     RequestFilterFields = "Member No";
        //     DataItemTableView = sorting("Member No");

        //     column(Member_No;"Member No")
        //     {}

        //     trigger OnPreDataItem() begin
        //         memberNo := '';
        //     end;

        //     trigger OnAfterGetRecord() begin

        //         if "Member Ledger Entries Buffer"."Member No" = memberNo then CurrReport.Skip();
        //         intAsat := 0;
        //         memberLedgerBuffer.Reset();
        //         memberLedgerBuffer.SetRange("Member No", "Member Ledger Entries Buffer"."Member No");
        //         if memberLedgerBuffer.FindSet() then begin
        //             memberLedgerBuffer.CalcSums(Amount);
        //             intAsat := memberLedgerBuffer.Amount;
        //         end;
        //         memberNo := "Member Ledger Entries Buffer"."Member No";
        //         if intAsat < 0 then begin
        //             finalLedgerEntries.Init();
        //             finalLedgerEntries."Entry No" := "Member Ledger Entries Buffer"."Entry No";
        //             finalLedgerEntries."Member No" := memberNo;
        //             finalLedgerEntries."Document No" := 'BBFBAL-NAV';
        //             finalLedgerEntries.Amount := intAsat;
        //             if not finalLedgerEntries.Insert() then finalLedgerEntries.Modify();
        //         end;

        //     end;
        // }

        // dataitem("Final CustLedgerEntries Buffer";"Final CustLedgerEntries Buffer")
        // {
        //     column(Entry_No;"Entry No")
        //     {}

        //     trigger OnAfterGetRecord() begin

        //     end;
        // }

        // dataitem("Detailed Cust. Ledg. Entry";"Detailed Cust. Ledg. Entry")
        // {
        //     RequestFilterFields = "Loan No";
        //     DataItemTableView = where("Transaction Type" = filter(Repayment|"Interest Paid"|"Loan Penalty Paid"), Reversed = filter(false));

        //     column(Loan_No;"Loan No")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         erroneousNo := '';
        //         accurateNo := '';

        //         vend.Reset();
        //         vend.SetRange("BOSA Account No", "Detailed Cust. Ledg. Entry"."Customer No.");
        //         vend.SetRange("Account Type", '103');
        //         if vend.Find('-') then begin
        //             erroneousNo := vend."No.";
        //         end;

        //         loansReg.Reset();
        //         loansReg.SetRange("Loan  No.", "Detailed Cust. Ledg. Entry"."Loan No");
        //         if loansReg.Find('-') then begin
        //             if loansReg."Client Code" = '' then CurrReport.Skip();
        //             if "Detailed Cust. Ledg. Entry"."Customer No." = loansReg."Client Code" then CurrReport.Skip();

        //             vend.Reset();
        //             vend.SetRange("BOSA Account No", loansReg."Client Code");
        //             vend.SetRange("Account Type", '103');
        //             if vend.Find('-') then begin
        //                 accurateNo := vend."No.";
        //             end;

        //             detVend.Reset();
        //             detVend.SetRange("Document No.", "Detailed Cust. Ledg. Entry"."Document No.");
        //             if detVend.FindSet() then begin
        //                 repeat
        //                     detVend."Vendor No." := accurateNo;
        //                     detVend.Modify;
        //                 until detVend.Next() = 0;
        //             end;

        //             "Detailed Cust. Ledg. Entry"."Customer No." := loansReg."Client Code";
        //             "Detailed Cust. Ledg. Entry".Modify;
        //         end;
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     CalcFields = "Total Outstanding Balance";
        //     RequestFilterFields = "Loan  No.";
        //     // DataItemTableView = where(Posted = filter(true), "Loan Status" = filter(Appraisal));
        //     column(Loan__No_;"Loan  No.")
        //     {}
        //     column(Loan_Disbursement_Date;"Loan Disbursement Date")
        //     {}
        //     column(Client_Code;"Client Code")
        //     {}
        //     column(Loan_Status;"Loan Status")
        //     {}
        //     column(Total_Outstanding_Balance;"Total Outstanding Balance")
        //     {}

        //     trigger OnPreDataItem() begin
        //         myInt := 0;
        //     end;

        //     trigger OnAfterGetRecord() begin
        //         Error('Posted %1, Loan Status %2, Total Outstanding Bal %3, Reversed %4.', "Loans Register".Posted, "Loans Register"."Loan Status", "Loans Register"."Total Outstanding Balance", "Loans Register".Reversed);
        //         // myInt := myInt + 1;
        //     end;

        //     trigger OnPostDataItem() begin
        //         // Error('Count %1', myInt);
        //     end;
        // }

        // dataitem("Import Buffer";"Import Buffer")
        // {
        //     column(Reference_No;"Reference No")
        //     {}
        //     trigger OnAfterGetRecord() begin
        //         "Import Buffer".Delete();
        //     end;
        // }

        // dataitem("Loans Register";"Loans Register")
        // {
        //     RequestFilterFields = "Loan  No.";
        //     column(Loan__No_;"Loan  No.")
        //     {}

        //     trigger OnAfterGetRecord() begin
        //         approvalEntry.Reset();
        //         approvalEntry.SetRange("Document No.", "Loans Register"."Loan  No.");
        //         approvalEntry.SetRange(Status, approvalEntry.Status::Approved);
        //         if approvalEntry.Find('-') then begin
        //             "Loans Register".Source := "Loans Register".Source::FOSA;
        //             "Loans Register"."Approval Status" := "Loans Register"."Approval Status"::Approved;
        //             "Loans Register"."Loan Status" := "Loans Register"."Loan Status"::Approved;
        //             "Loans Register"."Approved By" := approvalEntry."Approver ID";
        //             "Loans Register"."Approved Date" := Today;
        //             "Loans Register"."Approved Time" := DT2Time(approvalEntry."Last Date-Time Modified");
        //             "Loans Register"."Approved By Date" := Today;
        //             "Loans Register".Modify;
        //             Message('Posted %1, Source %2, Approval Status %3, Product %4', "Loans Register".Posted, "Loans Register".Source, "Loans Register"."Approval Status", "Loans Register"."Loan Product Type");
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
                    field(memberNo; memberNo)
                    {
                    ApplicationArea = All;
                        ShowMandatory = true;
                        // Visible = false;
                    }
                    field(ageCust; ageCust)
                    {
                        ShowMandatory = true;
                        Caption = 'Description';
                    ApplicationArea = All;
                        // Visible = false;
                    }
                    field(gross; gross)
                    {
                    ApplicationArea = All;
                        ShowMandatory = true;
                        // Visible = false;
                    }
                    field("Registration Date"; regDate)
                    {
                    ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field(nokNo; nokNo)
                    {
                    ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }
        }
    }


    // rendering
    // {
    //     layout(MissingLoans)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'Layouts/MissingLoans.rdlc';
    //     }
    // }
    // rendering
    // {
    //     layout(MissingLoans)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'Layouts/MissingBOSAAccounts.rdlc';
    //     }
    // }
    // rendering
    // {
    //     layout(MissingLoans)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'Layouts/DoublePostedBankTransactions.rdlc';
    //     }
    // }
    // rendering
    // {
    //     layout(ErroneousRegFee)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'Layouts/ErroneousRegFeeTransactions.rdlc';
    //     }
    // }

    trigger OnInitReport()
    begin
        saccoGen.Get();
    end;

    var
        missing: Boolean;
        myInt: Integer;
        hour: Integer;
        minute: Integer;
        nokNo: Integer;
        rectDate: Integer;
        rectMonth: Integer;
        rectYear: Integer;
        ageDec: Decimal;
        gross: Decimal;
        totalInt: Decimal;
        notice: Record "Withdrawal Notice";
        fdPlacement: Record "Fixed Deposit Placement";
        intAsat: Decimal;
        intOndate: Decimal;
        deficitInt: Decimal;
        intTobePaid: Decimal;
        text: Date;
        disbursedDate: Date;
        completionDate: Date;
        currDate: Date;
        rectifiedDate: Date;
        ageCust: Text[450];
        msg: Text[250];
        memberNo: Code[2000];
        mobilePhoneNo: Code[20];
        erroneousNo: Code[20];
        accurateNo: Code[20];
        regDate: Date;
        loginTime: Time;
        logoutTime: Time;
        retDate: Date;
        minuteDuration: Duration;
        AUFactory: Codeunit "Au Factory";
        dateCalc: Codeunit "Dates Calculation";
        mobile: Codeunit "Mobile Banking Engine";
        portal: Codeunit "Portal Engine";
        payrollProc: Codeunit "AU Payroll Processing";
        cust: Record Customer;
        custom: Record Customer;
        vend: Record Vendor;
        vendLedger: Record "Vendor Ledger Entry";
        saccoGen: Record "Sacco General Set-Up";
        loansReg: Record "Loans Register";
        loanProduct: Record "Loan Products Setup";
        loanBatch: Record "Loan Disburesment-Batching";
        userTimereg: Record "User Time Register";
        approvalEntry: Record "Approval Entry";
        fosaApp: Record "FOSA Account Applicat. Details";
        periodTrans: Record "prPeriod Transactions.";
        P9Trans: Record "Payroll Employee P9.";
        changeReq: Record "Change Request";
        payments: Record "Payments Header";
        nextofkinTable: Record "Members Next of Kin";
        loanRepSchedule: Record "Loan Repayment Schedule";
        insider: Record InsiderLending;
        transact: Record Transactions;
        detCust: Record "Detailed Cust. Ledg. Entry";
        hrLeave: Record "HR Leave Application";
        paybill: Record "Paybill Transactions";
        leaveSup: Record "Leave Supervisor Approval";
        smsMessages: Record "AU SMS Messages";
        salaryHeader: Record "Salary Processing Headerr";
        detVend: Record "Detailed Vendor Ledg. Entry";
        memberLedgerBuffer: Record "Member Ledger Entries Buffer";
        finalLedgerEntries: Record "Final CustLedgerEntries Buffer";
        bankLedger: Record "Bank Account Ledger Entry";
        glEntries: Record "G/L Entry";
        workstations: Record WorkStations;
        dutyCenter: Record "Workstation Buying Centers";
        pagee: Page 20;
        salHeader: Record "Salary Processing Headerr";
        accTypes: Record "Account Types-Saving Products";
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
        SFactory: Codeunit "SURESTEP FactoryMobile";
        LineNo: Integer;
        BATCH_TEMPLATE: Code[60];
        BATCH_NAME: Code[80];
        BName: Codeunit "Send Birthday SMS";
        DOCUMENT_NO: Code[40];
        suffix: Code[20];
        GenJournalLine: Record "Gen. Journal Line";

        GenBatches: Record "Gen. Journal Batch";
}



