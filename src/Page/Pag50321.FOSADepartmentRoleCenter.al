page 50321 "FOSA Department Role Center"
{
    ApplicationArea = All;
    PageType = RoleCenter;
    Caption = 'FOSA RC';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Headline RC Business Manager")
            {
            }
            part(ApprovalActivities; "Approvals Activities")
            {
                Visible = true;
            }
            part(Activities; "Team Member Activities")
            {
            }
            part("Help And Chart Wrapper"; "Help And Chart Wrapper")
            {
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
            }
            part("Power BI Report Spinner Part"; "Power BI Embedded Report Part")
            {
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Member Application")
            {
                RunPageMode = Create;
                Caption = 'Member FOSA Product Application';
                ToolTip = 'Add a Member''s FOSA Savings Product here';
                Image = New;
                RunObject = page "Member Account Appl. Card";
            }
        }
        area(Processing)
        {
            action("Salary Processing")
            {
                RunPageMode = Create;
                Caption = 'Sacco Members Salary Processing';
                ToolTip = 'Process Salaries here';
                Image = New;
                RunObject = page "Salary Processing Header";
            }
        }
        area(Reporting)
        {
            group("Cashier Report")
            {
                action("End Of Day Report")
                {
                    Caption = 'End Of Day Report';
                    ToolTip = 'Cashier End Of Day Report';
                    Image = Report;
                    RunObject = report "Cashier Report EOD";
                }
            }

        }
        area(Embedding)
        {
            action("ATM Transaction Details")
            {
                RunObject = page "Atm Transaction Details";
            }

        }
        area(Sections)
        {
            // group("Saving Products Management")
            // {
            //     Caption = 'Saving Products Management';
            //     Image = Bank;

            //     ToolTip = 'Manage Saving Accounts Eg. FOSA Savings and Fixed Deposits';
            
            Group("Membership")
            {
                action("Members List")
                {
                    Caption = 'Member Accounts List';
                    RunObject = Page "Members List";
                    ToolTip = 'Manage Member Accounts';
                }
            }
            group("Member FOSA Accounts")
            {
                action("Account Applications")
                {
                    Caption = 'Membership Products Application';
                    Image = Customer;
                    RunObject = page "Member Account Application";
                    ToolTip = 'Open New membership products accounts Application.';

                }
                 action("Account Opened")
                {
                    Caption = 'Opened Accounts List';
                    Image = Customer;
                    RunObject = page "Savings Accounts List";
                    ToolTip = 'Open New membership products accounts Application.';

                }
                action("Member Accounts")
                {
                    Caption = 'Member Savings Accounts';
                    Image = Customer;
                    RunObject = page "Member Accounts List";
                    ToolTip = 'Open Members'' FOSA Accounts';

                }
            }
            group("BOSA Receipt")
            {
                Caption = 'BOSA Receipts';
                Image = Receivables;
                ToolTip = 'Member Receipting Process.';

                action("BOSA Receipts")
                {
                    Caption = 'Open BOSA Receipts';
                    Image = Receipt;
                    //Visible=false;
                    RunObject = page "BOSA Receipts List";
                    ToolTip = 'New Member Receipts for payments done.';
                }
                action("FOSA Receipts")
                {
                    Caption = 'Open FOSA Receipts';
                    Image = Receipt;
                    RunObject = page "FOSA Receipts List";
                    ToolTip = 'New Member Receipts for payments done.';
                }
                action("BOSA Transfers")
                {
                    Caption = 'BOSA Transfer List';
                    Image = Receipt;
                    RunObject = page "BOSA Transfer List";
                    ToolTip = 'New Member Account Transfer for payments done.';

                }
                action("Posted BOSA Receipts")
                {
                    Caption = 'Posted BOSA Receipts';
                    Image = PostedReceipt;
                    RunObject = page "Posted BOSA Receipts List";
                    ToolTip = 'New Member Receipts for payments done.';
                }
            }
            group("Sacco Transfer")
            {
                caption = 'Sacco Transfer';
                action("Sacco Transfer List")
                {
                    Caption = 'Open Sacco Transfer List';
                    Image = Payment;
                    RunObject = page "Internal Transfer List.";
                }
                action("POsted Sacco Transfers")
                {
                    Caption = 'Posted Sacco Transfers';
                    Image = PostedPayment;
                    RunObject = page "Posted Internal Transfer List.";
                }
            }
            group("Payment Management")
            {
                Caption = 'Payment Process';
                Image = Payables;
                ToolTip = 'Payment Process.';
                action("Cheque Payment")
                {
                    Caption = 'Cheque Payment Vouchers';
                    Image = Check;
                    RunObject = page "Payment Voucher List";
                    ToolTip = 'Payment Voucher List.';
                }
                action("Cash Payment Voucher")
                {
                    Caption = 'Cash Payment Vouchers';
                    Image = CashFlow;
                    RunObject = page "Cash Payment Voucher List";
                    ToolTip = 'Cash Payment Voucher List.';
                }
                action("Posted Cheque Payment")
                {
                    Caption = 'Posted Payment Vouchers';
                    Image = Check;
                    RunObject = page "Posted Payment Vouchers";
                    ToolTip = 'All Posted Payment Vouchers';
                }
                action("Petty Cash Payment")
                {

                    Caption = 'Petty Cash Payment List';
                    Image = Check;
                    RunObject = page "New Petty Cash Payments List";
                    ToolTip = 'New Petty Cash Payments List.';
                }
                action("Posted Petty Cash Payment")
                {

                    Caption = 'Posted Petty Cash Payment';
                    Image = Check;
                    RunObject = page "Posted Petty Cash Payments";
                    ToolTip = 'Posted Cash Payment';
                }

                action("Funds Transfer List")
                {
                    Caption = 'Funds Transfer List';
                    Image = Check;
                    RunObject = page "Funds Transfer List";
                    ToolTip = 'Funds Transfer List';
                }

                action("Posted Funds Transfer List")
                {
                    Caption = 'Posted Funds Transfer List';
                    Image = Check;
                    RunObject = page "Posred Funds Transfer List";
                    ToolTip = 'Posted Funds Transfer List';
                }

                action("Receipt Header List")
                {
                    Caption = 'Receipt Header List';
                    Image = Check;
                    RunObject = page "Receipt Header List";
                    ToolTip = 'Receipt Header List';
                }

                action("Posted Receipt Header List ")
                {
                    Caption = 'Posted Receipt Header List ';
                    Image = PostedOrder;
                    RunObject = page "Posted Receipt Header List";
                    ToolTip = 'Posted Receipt Header List ';
                }
                action("Tarrif Codes")
                {
                    Caption = 'Tarrif Codes ';
                    Image = PostedOrder;
                    RunObject = page "Tarrif Codes";
                    // ToolTip = 'Posted Receipt Header List ';
                }
            }
            group("Fixed Deposits Management ")
            {
                Caption = 'Fixed Deposit Management';
                Image = Bank;
                Visible = true;
                ToolTip = 'Open Fixed Deposits Submodule';
                action("Created Fixed Deposits Acc List")
                {
                    Caption = 'Fixed Deposit List';
                    Image = Account;
                    RunObject = page "Fixed deposit list";
                    ToolTip = 'Open Fixed Deposits'' FOSA Accounts';

                }
                action("Placed Fixed Deposits Acc List")
                {
                    Caption = 'Placed Fixed Deposits Acc List';
                    Image = Account;
                    RunObject = page "Credited Fixed deposit list";
                    ToolTip = 'Open Fixed Deposits'' FOSA Accounts';

                }
                action("Matured Fixed Deposits Acc List")
                {
                    Caption = 'Matured Fixed Deposits Acc List';
                    Image = Account;
                    RunObject = page "Matured  Fixed deposit list";
                    ToolTip = 'Open Fixed Deposits'' FOSA Accounts';

                }
                action("Revoked Fixed Deposits Acc List")
                {
                    Caption = 'Revoked Fixed Deposits Acc List';
                    Image = Account;
                    RunObject = page "Revoked Fixed Deposit List";
                    ToolTip = 'Open Fixed Deposits'' FOSA Accounts';

                }
                action("Fixed Deposits Setup")
                {
                    Caption = 'Fixed Deposits Types';
                    Image = Account;
                    RunObject = page "Fixed deposit Types list";
                    ToolTip = 'Open Fixed Deposits'' Types';

                }
                action("Fixed Deposits interest")
                {
                    Caption = 'Fixed Deposits Interest';
                    Image = Account;
                    RunObject = page "Fixed Deposit Interest Rates";
                    ToolTip = 'Open Fixed Deposits'' Interest Rates';

                }
                action("Member Transaction List")
                {
                    Caption = 'Member Transaction List';
                    Image = Account;
                    RunObject = page "Member Transaction List";
                    ToolTip = 'Open Member Transaction List';

                }
            }

            group("Standing Orders ")
            {
                Caption = 'Standing Orders';
                Image = Bank;
                Visible = true;
                ToolTip = 'Open Standing Orders Submodule';

                action("Standing Order list")
                {
                    Caption = 'Standing Order list';
                    Image = Account;
                    RunObject = page "Standing Orders - List";
                    ToolTip = 'Open Standing Order List';

                }
                action("Approved Standing Order List")
                {
                    Caption = 'Approved Standing Order List';
                    Image = Account;
                    RunObject = page "Standing Orders - List Approve";
                    ToolTip = 'Open Approved STanding Order List';

                }

                action("Stopped Standing Order List")
                {
                    Caption = 'Stopped Standing Order List';
                    Image = Account;
                    RunObject = page "Standing Orders - Stopped";
                    ToolTip = 'Open Stopped Standing Order List';

                }

                action("Process Standing Order")
                {
                    Caption = 'Process Standing Order';
                    Image = Account;
                    RunObject = report "Process Standing Order Ver1";
                    ToolTip = 'Process Standing Orders';

                }
                action("Standing Order Register")
                {
                    Caption = 'Standing Order Register';
                    Image = Account;
                    RunObject = page "Standing Order Register";
                    ToolTip = 'Open Standing Order Register';

                }
                group(STOReports)
                {
                    caption = 'Standing Order Reports';

                    action(Standingorderreports)
                    {
                        Caption = 'Successful Standing Orders';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = report "Successful Standing Orders";
                    }
                }

            }

            group("Checkoff Proccessing ")
            {
                Caption = 'Checkoff';
                Image = Bank;
                Visible = true;
                ToolTip = 'Checkoff List';

                action("Checkoff Advice")
                {
                    Caption = 'Advice List';
                    Image = Account;
                    RunObject = page "Data Sheet Main";
                    ToolTip = 'Checkoff Advice List';

                }
                action("Checkoff Processing List")
                {
                    Caption = 'Checkoff Processing List';
                    Image = Account;
                    RunObject = page "Checkoff Processing-D List";
                    ToolTip = 'Checkoff Processing List';

                }


                action("Processed Checkoff List")
                {
                    Caption = 'Processed Checkoff List';
                    Image = Account;
                    // RunObject = page "Posted Checkoff Proc.-D List";
                    ToolTip = 'Checkoff Posted List';

                }

            }

            group("Salary Proccessing ")
            {
                Caption = 'Salary Processing';
                Image = Bank;
                Visible = true;
                ToolTip = 'Salary Processing List';
                action("Salary Processing List")
                {
                    Caption = 'Salary Processing List';
                    Image = Account;
                    RunObject = page "Salary Processing List";
                    ToolTip = 'Salary Processing List';
                }

                action("Delayed Payment List")
                {
                    Caption = 'Delayed Salary Processing List';
                    Image = Account;
                    RunObject = page "Delayed Payment List";
                    ToolTip = 'Delayed Salary Processing List';
                }

                action("Salary Details")
                {
                    Caption = 'Salary Details';
                    Image = Account;
                    RunObject = page "Net Salary List";
                    ToolTip = 'Delayed Salary Processing List';
                }

                action("Processed Salary List")
                {
                    Caption = 'Processed Salary List';
                    Image = Account;
                    RunObject = page "Processed Salary List";
                    ToolTip = 'Processed Salary List';
                }
                action("Posted Processed Salary List")
                {
                    Caption = 'Posted Processed Salary List';
                    Image = Account;
                    RunObject = page "Posted Processed Salary List";
                    ToolTip = 'Posted Processed Salary List';
                }

            }



            group("Teller/Treasury Management")
            {

                Caption = 'Teller/Treasury Management';
                Image = FixedAssets;
                action("Teller&Treasury List")
                {
                    Caption = 'Teller Request/Receive Funds';
                    RunObject = Page "Teller & Treasury Trans List1";
                }
                action("Tellers")
                {
                    Caption = 'Teller List';
                    RunObject = Page "Teller Till List";
                }

                action("Treasury")
                {
                    Caption = 'Treasury List';
                    RunObject = Page "Treasury List";
                }

                action("Teller/Treasury Transactions List")
                {
                    Caption = 'Teller/Treasury Transactions List';
                    RunObject = Page "Teller & Treasury Trans List";
                }

                action("Posted Transactions List")
                {
                    Caption = 'Posted Transactions List';
                    RunObject = Page "Teller & Treasury Trans List p";
                }


            }
            group("Cashier Banking")
            {

                Caption = 'Cashier-Banking';
                Image = FixedAssets;
                action(TransactionNew)
                {
                    Caption = 'Transactions List';
                    RunObject = Page "Cashier Transactions - List";
                }
                action(PostedTransactionsCashier)
                {
                    Caption = 'Posted Cashier Transactions';
                    ToolTip = 'View the posted cashier transactions.';
                    RunObject = page "Posted Cashier Transactions";


                }
                action("Cashier Transactions Authorisation")
                {
                    Caption = 'Cashier Transactions Authorisation';
                    RunObject = Page "Cashier Trans Authorisations";
                }
                action("EFT List")
                {
                    Caption = 'EFT List';
                    RunObject = Page "New EFT/RTGS List";
                }
                action("Petty Cash")
                {
                    Caption = 'Petty Cash';
                    RunObject = Page "New Petty Cash Payments List";
                }
                action("Posted Petty Cash")
                {
                    Caption = 'Posted Petty Cash';
                    RunObject = Page "Posted Petty Cash Payments";
                }
                action("Funds Transfer")
                {
                    Caption = 'Funds Transfer';
                    RunObject = Page "Funds Transfer List";
                }

                action("Cheque Clearing")
                {
                    Caption = 'Cheque Clearing List';
                    RunObject = Page "Cheque Clearing List";
                }
                action("Cheque Discounting")
                {
                    Caption = 'Cheque Discounting List';
                    RunObject = Page "Cheque Discounting List";
                }

                action("Cheque Register")
                {
                    Caption = 'Cheque Register';
                    RunObject = Page "Cheque Book Register";
                }


            }

            group("ATM Banking")
            {

                Caption = 'ATM Banking';
                action(ATMApplication)
                {
                    Caption = 'ATM Card Application';
                    RunObject = page "ATM Cards Application - New";
                }
                group("Pin Replacement")
                {
                    action(ATMPinReplacementPending)
                    {
                        Caption = 'Pending ATM Pin Replacement';
                        RunObject = page "ATM Pin Replacement Pending";
                    }
                    action(ATMPinReplacementApproved)
                    {
                        Caption = 'Approved ATM Pin Replacement';
                        RunObject = page "ATM Pin Replacement Approved";
                    }
                    action(ATMPinReplacementReceived)
                    {
                        Caption = 'Received ATM Pin Replacement';
                        RunObject = page "ATM Pin Replacement Received";
                    }
                    action(ATMPinReplacementIssued)
                    {
                        Caption = 'Issued ATM Pin Replacement';
                        RunObject = page "ATM Pin Replacement Issued";
                    }
                }
                action(ATMApplicationPending)
                {
                    Caption = 'Pending ATM Card Application';
                    RunObject = page "ATM Cards Application Pend";

                }
                action(ATMApplicationApproved)
                {
                    Caption = 'Approved ATM Card Application';
                    RunObject = page "ATM Cards Application Appr";

                }
                action(ATMRequestBatch)
                {
                    Caption = 'ATM Card Request Batch List';
                    RunObject = page "ATM Card Request Batch List";

                }
                action(ChargeATM)
                {
                    Caption = 'Charge ATM Cards';
                    RunObject = page "ATM Cards Application Charged";

                }

                action(ATMProcessed)
                {
                    Caption = 'Processed ATM Cards';
                    RunObject = page "ATM Cards Appl. - Processed";

                }

                action(ChargePosted)
                {
                    Caption = 'Posted ATM Cards';
                    RunObject = page "ATM Cards Application Posted";

                }
                action(ATMTransactionDetails)
                {
                    Caption = 'ATM Transaction Details';
                    visible = false;
                    RunObject = page "Atm Transaction Details";

                }

                action(ATMBatchReceiptsBatch)
                {
                    visible = false;
                    Caption = 'ATM Card Receipt Batch List';
                    RunObject = page "ATM Card Receipt Batch List";

                }
                action(ATMReports)
                {
                    Caption = 'Sacco Link Report';
                    RunObject = report "Sacco Link Report";

                }
            }
            group("Cheque Setup")
            {

                Caption = 'Cheque Setup';
                action(Chequesetuplist)
                {
                    Caption = 'Cheque Setup';
                    RunObject = page "Cheque Register List";

                }
            }
            group("Overdraft Loans")
            {

                Caption = 'Overdraft Loan Management';
                Image = Loan;

                action("OD Loan Setup")
                {
                    Caption = 'OD Loan Product Setup';
                    RunObject = Page "Overdraft Loan Product Setup";
                }
                action("OD Application")
                {
                    Caption = 'OD Application';
                    RunObject = Page "OD Application List";
                }
                action("OD Appraisal")
                {
                    Caption = 'OD Appraisal';
                    RunObject = Page "OD Appraisal List";
                }
                action("OD Pending Approval")
                {
                    Caption = 'OD Pending Approval';
                    RunObject = Page "Pending OD  list";
                }
                action("OD Approved")
                {
                    Caption = 'OD Approved';
                    RunObject = Page "OD Approved List";
                }
                action("OD Disbursment Batch")
                {
                    Caption = 'OD Disbursement Batch';
                    RunObject = Page "OD Disbursment Batch List";
                }

            }
            group("Periodic Interest Activities")
            {
                // Visible = false;
                caption = 'Periodic Interest Activities';
                action("Interest Transfer")
                {
                Caption =  'Interest On Savings List';
                RunObject = Page "Interest On Savings List";
                }
            }
            group("FOSA Reports")
            {
                caption = 'Reports';
                group("Accounts")
                {
                    Caption = 'Account Reports';

                    action("Savings Accounts Opening")
                    {
                        Caption = 'Member Savings Opened Accounts';
                        RunObject = report "Accounts Opened Report";
                    }
                    action("AccountBalances")
                    {
                        Caption = 'All Account Balances';
                        RunObject = report "Account Balances";
                    }
                    action("Accounts Balances")
                    {
                        Visible = false;
                        Caption = 'Accounts Balances';
                        RunObject = report "Accounts Balances";
                    }
                    action("Members Account Balance")
                    {
                        Caption = 'Full Member Account Balances';
                        RunObject = report "Member Accounts Bal Listing";
                    }
                    action("Accounts Listing")
                    {
                        Caption = 'Accounts Listing';
                        RunObject = report "Accounts Listing";
                    }
                    action("New Accounts")
                    {
                        Caption = 'New Accounts';
                        RunObject = report "New Accounts Report";
                    }
                    action("Dormant Accounts")
                    {
                        Caption = 'Dormant Accounts';
                        RunObject = report "Dormant Accounts Report";
                    }
                    action("Active Accounts with No Deposits")
                    {
                        Caption = 'Active Accounts with No Deposits';
                        RunObject = report "Active Accounts No Deposits";
                    }
                    action("Fixed Deposit Tracking")
                    {
                        Caption = 'Fixed Deposit Tracking';
                        RunObject = report "Fixed Deposits Tracking Report";
                    }
                    action("Overdrawn Accounts")
                    {
                        Caption = 'Overdrawn Accounts';
                        RunObject = report "The Overdrawn Accounts";
                    }
                    action("Negative Balances")
                    {
                        Caption = 'Negative Balances';
                        RunObject = report NegativeBalances;
                    }
                }
                group("Transactions")
                {
                    Caption = 'Transactions Reports';

                    action("Cashier Reportss")
                    {
                        Caption = 'Cashier Report';
                        RunObject = report "Cashier Report";
                    }
                    action("Daily Cashier Transactions")
                    {
                        Caption = 'Transactions Report';
                        RunObject = report "Transactions Report";
                    }
                    action("Daily Treasury Transactions")
                    {
                        Caption = 'Daily Treasury Transactions';
                        RunObject = report "Treasury Transactions Report";
                    }
                    action("Teller Excess & Shortage Accounts")
                    {
                        Caption = 'Teller Excess & Shortage Accounts';
                        RunObject = report "Teller Excess&Shortage Report";
                    }
                    action("Deposits Above 200k")
                    {
                        Caption = 'Deposits Above 200k';
                        RunObject = report "Deposits Above 200k Report";
                    }
                    action("Withdrawals Above 100k")
                    {
                        Caption = 'Withdrawals Above 100k';
                        RunObject = report "Withdrawals Above 100k Report";
                    }
                    action("Overdrawn Transactions")
                    {
                        Caption = 'Overdrawn Over the Counter Transactions';
                        RunObject = report OverdrawnOTCTransactionsReport;
                    }
                    action("Teller Closing Summary")
                    {
                        Caption = 'Teller Closing Summary';
                        RunObject = report "Teller Closing Summary";
                    }
                }
                group("Cheque")
                {
                    Caption = 'Cheque Reports';
                    action("Cheques on Processing")
                    {
                        Caption = 'Cheques on Processing';
                        RunObject = report "Cheques on Processing Report";
                    }
                    action("Cleared & Bounced Cheques")
                    {
                        Caption = 'Cleared & Bounced Cheques';
                        RunObject = report "Cleared&Bounced Cheques Report";
                    }
                }
                group("Reports Salary")
                {
                    Caption = 'Salaries Reports';
                    action("Report On new salaries")
                    {
                        Caption = 'New Salary Report';
                        RunObject = report "New Salary Report";
                    }
                    action("Report On Posted salaries")
                    {
                        Caption = 'Posted Salaries Report';
                        RunObject = report "Posted salaries Report";
                    }
                    action("Report On salary loans")
                    {
                        Caption = 'Salary Loans Report';
                        RunObject = report "Salary loans";
                    }
                    action("Report On salary summary deduction")
                    {
                        Caption = 'Summary of Salary Deduction Report';
                        RunObject = report "Summary of Salary Deductions";
                    }
                    action("Report On salary loan recovery")
                    {
                        Caption = 'Salary Loan Recovery Analysis';
                        RunObject = report "Salary Loans Recovery Analysis";
                    }
                    action("Report On missing salaries")
                    {
                        Caption = 'Missing Salaries Report';
                        RunObject = report "Missing Salaries Report";
                    }
                    action("Report On Failed salaries")
                    {
                        Caption = 'Failed Status Report';
                        RunObject = report "Failed status Report";
                    }
                    action("Report On standing order")
                    {
                        Caption = 'Salary Standing Order Report';
                        RunObject = report "Salary Standing Order Report";
                    }
                }

            }group(Action172)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                action("General Journals")
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action("G/L Budget")
                {
                    Caption = 'G/L Budget';
                    Image = GL;
                    RunObject = Page "G/L Budget Names";

                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action170)
                {
                    Caption = 'Chart of Accounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("G/L Account Categories")
                {
                    Caption = 'G/L Account Categories';
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action(Currencies)
                {
                    Caption = 'Currencies';
                    Image = Currency;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }

                action(Employees)
                {
                    Caption = 'Employees';
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Employee List";
                    ToolTip = 'View or modify employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                }
                action("Analysis Views")
                {
                    Caption = 'Analysis Views';
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action("Financial Reports")
                {
                    Caption = 'Financial Reports';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Financial Reports";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
#if not CLEAN19
#endif
#if not CLEAN19
                action(Action144)
                {
                    Caption = 'Employees';
                    Visible = false;
                    RunObject = Page "Employee List";
                    ToolTip = 'Manage employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Duplicated action use action(Employees)';
                    ObsoleteTag = '19.0';
                }
#endif                
                action("Accounting Periods")
                {
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Set up the number of accounting periods, such as 12 monthly periods, within the fiscal year and specify which period is the start of the new fiscal year.';
                }
                action("Number Series")
                {
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                    ToolTip = 'View or edit the number series that are used to organize transactions';
                }
#if not CLEAN19
                action(Action116)
                {
                    Caption = 'G/L Account Categories';
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Duplicated action use action("G/L Account Categories")';
                    ObsoleteTag = '19.0';
                }

                group("SASRA Reports.")
                {
                    action("Deposit Return.")
                    {
                        Caption = 'Deposit Return Sasra';
                        RunObject = report "Deposit return";

                    }
                    action("Insider Lending.")
                    {
                        Caption = 'Insider Lending';
                        RunObject = report InsiderLending;

                    }
                    action("Risk Provisioning Report.")
                    {
                        Caption = 'Risk Provisioning Resport';
                        RunObject = report "Risk Class Of Assets & Prov";
                    }
                    action("Statement Of Financial Position.")
                    {
                        Caption = 'Statement of Financial Position';
                        RunObject = report "STATEMENT OF FINANCIAL P";
                    }
                    action("Capital Adequacy.")

                    {
                        Caption = 'Capital Adequacy';
                        RunObject = report "CAPITAL ADEQUACY RETURN";
                    }
                    action("Statement of Comprehensive Income.")
                    {
                        RunObject = report "Form2F Statement of CompIncome";
                    }
                    action("Liquidity.")
                    {
                        RunObject = report "Liquidity Statement";
                    }
                    action("Investment Return.")
                    {
                        RunObject = report "RETURN ON INVESTMENT.";
                    }
                    action("Sectorial Lending.")
                    {
                        RunObject = report "Sectorial Lending";
                    }
                    action("Other Disclosures.")
                    {
                        RunObject = report "Other Disclosures";
                    }
                    action("Insider List.")
                    {
                        RunObject = page "Insider List";
                    }
                }
#endif

            }
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                ToolTip = 'Post financial transactions.';
                action(GeneralJournals)
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action("<Action3>")
                {
                    Caption = 'Recurring General Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                    ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                }
                action(PurchaseJournals)
                {
                    Caption = 'Purchase Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases),
                                        Recurring = CONST(false));
                    ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
                }
                action(SalesJournals)
                {
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales),
                                        Recurring = CONST(false));
                    ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
                }
                action(PostedGeneralJournals)
                {
                    Caption = 'Posted General Journals';
                    RunObject = Page "Posted General Journal";
                    ToolTip = 'Open the list of posted general journal lines.';
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                action(Action164)
                {
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action(CashReceiptJournals)
                {
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }


                action("Bank Account Posting Groups")
                {
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }
                action(PaymentJournals)
                {
                    Caption = 'Payment Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }

                action("Payment Recon. Journals")
                {
                    Caption = 'Payment Recon. Journals';
                    Image = ApplyEntries;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Bank Acc. Statements")
                {
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Cash Flow Forecasts")
                {
                    Caption = 'Cash Flow Forecasts';
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                }
                action("Chart of Cash Flow Accounts")
                {
                    Caption = 'Chart of Cash Flow Accounts';
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                }
                action("Cash Flow Manual Revenues")
                {
                    Caption = 'Cash Flow Manual Revenues';
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Flow Manual Revenues";
                    ToolTip = 'Record manual revenues, such as rental income, interest from financial assets, or new private capital to be used in cash flow forecasting.';
                }
                action("Cash Flow Manual Expenses")
                {
                    Caption = 'Cash Flow Manual Expenses';
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Flow Manual Expenses";
                    ToolTip = 'Record manual expenses, such as salaries, interest on credit, or planned investments to be used in cash flow forecasting.';
                }
                action(BankAccountReconciliations)
                {
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Acc. Reconciliation List";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
            }
            group("Loans")
            {
                action("Approved Loans")
                {
                    Caption = 'Loans Approved';
                    RunObject = Page "Loans Application List(Approv)";
                    ToolTip = 'Open the list of Approved Loans Pending Disbursement.';
                }
                action("Batch List")
                {
                    RunObject = page "Loans Disbursment Batch List";
                    Caption = 'Loan Batch List';
                }
                action("Express Batch List")
                {
                    RunObject = page "Loans Disbursment  List Exp";
                    Caption = 'Loan Batch List(Express)';
                }
                action("Posted Loans")
                {
                    Caption = 'Posted Loans';
                    RunObject = Page "Loans Posted List";
                    ToolTip = 'Open the list of the Loans Posted.';
                }
                action("Posted Batches")
                {
                    Caption = 'Posted Batches';
                    RunObject = Page "Posted Loan Batch - List";
                    ToolTip = 'Open the list of the Loans Posted.';
                }
            }
            group("ABC Channels")
            {
                group("Portal Users")
                {
                    action(Feedback)
                    {
                        Caption = 'Online Member';
                        RunObject = page "Online Member Accessibility";
                    }
                }
                action("Paybill Transactions")
                {
                    Caption = 'Paybill Transactions';
                    RunObject = page "Paybill Transactions";
                }
                action("ATM Transactions")
                {
                    Caption = 'ATM Transactions';
                    RunObject = page "ATM Log Entries";
                }
                action("MPESA Withdrawal Requests")
                {
                    Caption = 'MPESA Withdrawal Requests';
                    RunObject = page "MPESA Withdrawal Buffer";
                }
                action("MPESA Transactions")
                {
                    Caption = 'MPESA Mobile Transactions';
                    RunObject = page "MPESA Mobile Transactions";
                }
                group("Mobile Banking Applications")
                {
                    action("Mobile Application List")
                    {
                        Caption = 'Mobile Application List';
                        RunObject = page "MOBILE Applications";
                    }
                    action("Pending Mobile Applications")
                    {
                        Caption = 'Pending Mobile Applications';
                        RunObject = page "MOBILE Applications Pending";
                    }
                    action("Approved Mobile Applications")
                    {
                        Caption = 'Approved Mobile Applications';

                        RunObject = page "MOBILE Applications Approved";
                    }
                }
                group("SMS")
                {
                    action("BULK SMS")
                    {
                        Caption = 'BULK SMS';
                        RunObject = page "Bulk SMS Header List";
                    }

                    action("SMS Messages")
                    {
                        Caption = 'SMS Messages';
                        RunObject = page "SMS Messages.";
                    }

                    action("AU Messages")
                    {
                        Caption = 'AU SMS Messages';
                        RunObject = page "AU SMS Messages";
                    }

                    action("SMS Setup")
                    {
                        Caption = 'SMS Setup';
                        RunObject = page "Sms setup 2";
                    }

                    action("SMS Charges")
                    {
                        Caption = 'SMS Charges';
                        RunObject = page "SMS Charges";
                    }
                }

                group("ABC Charges")
                {
                    action("ATM Charges")
                    {
                        Caption = 'ATM Charges';
                        RunObject = page "ATM Charges";
                    }

                    action("POS Commissions.")
                    {
                        Caption = 'POS Commissions.';
                        RunObject = page "POS Commissionss";
                    }
                    action("MPESA Withdrawal")
                    {
                        Caption = 'MPESA Withdrawal Charges';
                        RunObject = page "Mpesaithraal";
                    }

                    action("MPESA Deposits")
                    {
                        Caption = 'MPESA Deposits Charges';
                        RunObject = page "MPESA Deposits";
                    }

                    action("Funds Transfer Setups")
                    {
                        Caption = 'Funds Transfer Setups';
                        RunObject = page "Funds Transfer";
                    }
                    action("External Funds Transfer")
                    {
                        Caption = 'External Funds Transfer';
                        RunObject = page "External Funds Transfer";
                    }
                    action("AIRTIME Purchase Charges")
                    {
                        Caption = 'Airtime Purchase Charges';
                        RunObject = page "Airtime Purchase";
                    }
                    action("Pesalink Commissions")
                    {
                        Caption = 'PesaLink Commissions';
                        RunObject = page "Pesalink Commissions";
                    }
                    action("POS Commissions")
                    {
                        Caption = 'POS Commissions';
                        RunObject = page "POS Commissions";
                    }
                    action("MBanking Permissions")
                    {
                        Caption = 'MBanking Permissions';
                        RunObject = page "MBanking Permissions";
                    }
                    action("Sky Mobile Setup")
                    {
                        Caption = 'Sky Mobile Setup';
                        // RunObject = page "AU Mobile Setup";
                    }
                    action("Product Factory")
                    {
                        Caption = 'Product Factory';
                        RunObject = page "Product Factory";
                    }
                    action("Sacco AU Setup")
                    {
                        Caption = 'Sacco Setup';
                        RunObject = page "Sacco Setup";
                    }
                    action("Staggered Charges")
                    {
                        Caption = 'Staggered Charges';
                        RunObject = page "Staggered Charges List";
                    }
                }
                action("Credit Rating")
                {
                    Caption = 'Credit Rating';
                    RunObject = page "Credit Ratings List";
                }
            }
            group(SaccoPayroll)
            {
                Caption = 'Payroll Management';
                Visible = true;
                group(payrollEmployees)
                {
                    Caption = 'Payroll Employees';
                    action(payrollemp)
                    {
                        Caption = 'Payroll Employees list';
                        Image = Employee;
                        RunObject = page "Payroll Employee List.";
                        tooltip = 'Open Payroll Employees list';
                    }
                    action(Bonus)
                    {
                        Caption = 'Staff Bonus';
                        Image = Employee;
                        RunObject = page "Bonus List";
                        //tooltip = 'Open Payroll Employees list';
                    }
                    action(Exitedpayrollemp)
                    {
                        Caption = 'Exited Payroll Employees list';
                        Image = Employee;
                        RunObject = page "Exited Payroll Employees";
                        tooltip = 'Open exited Payroll Employees list';
                        Visible = false;
                    }

                }
                group(PayrollEarnings)
                {
                    Caption = 'Earnings&Deductions';
                    Visible = false;
                    action(Earnings)
                    {
                        Caption = 'Payroll Earnings';
                        Image = Card;
                        RunObject = page "Payroll Earnings List.";

                    }
                    action(Deductions)
                    {
                        Caption = 'Payroll Deductions';
                        Image = Card;
                        RunObject = page "Payroll Deductions List.";

                    }
                }
                group("Payroll setup")
                {
                    action(payesetup)
                    {
                        Caption = 'PAYE SETUP';
                        RunObject = page "Payroll PAYE Setup.";
                    }
                    action(NHIF)
                    {
                        Caption = 'NHIF SETUP';
                        RunObject = page "Payroll NHIF Setup.";
                    }
                    action(NSSF)
                    {
                        Caption = 'NSSF SETUP';
                        RunObject = page "Payroll NSSF Setup.";
                    }
                    action(Payrolposting)
                    {
                        Caption = 'Payroll Posting group';
                        RunObject = page "Payroll Posting Group.";
                    }
                    action(Payrollpostingsetup)
                    {
                        caption = 'Payroll posting setup';
                        RunObject = page "Payroll Posting Setup Ver1";
                        Visible = false;
                    }
                    action("PayrollTransaction")
                    {
                        caption = 'PayrollTransaction';
                        RunObject = page "Payroll Transaction List.";
                    }
                    action(PayrollGeneralsetup)
                    {
                        caption = 'Payroll General setup List';
                        RunObject = page "Payroll General Setup LIST.";
                    }
                    action("Control-Info")
                    {
                        caption = 'Control Information ';
                        RunObject = page controlInfor;
                    }


                }
                group(payrollperiodicactivities)
                {
                    Caption = 'Payroll Periodic Activities';
                    action(payrollperiods)
                    {
                        Caption = 'Payroll Periods';
                        RunObject = page "Payroll Periods.";
                    }
                    action(Transfertojournal)
                    {
                        Caption = 'Payroll Journal Transfer';
                        RunObject = report "Payroll JournalTransfer.";

                    }
                    action(Payrolnettransfer)
                    {
                        Caption = 'Payroll Net Transfer';
                        RunObject = report "Payroll Net Pay Transfer Ver1";
                    }

                }
                group("Payroll Reports ")
                {
                    action("Payroll Summary New")
                    {
                        Caption = 'Payroll Summary';
                        RunObject = report "Payroll Summary New";
                    }
                    action("Bank Schedule")
                    {
                        Caption = 'Bank Schedule';
                        RunObject = report "Bank Schedule..";
                    }
                    action("Payroll Summary")
                    {
                        Caption = 'Payroll Summary';
                        RunObject = report PayrollSummary;
                        Visible = false;
                    }
                    action("Send Payslips")
                    {
                        Caption = 'Send Payslip via Mail';
                        RunObject = report "Send Payslips Via Mail";
                    }
                    action("P9 Report")
                    {
                        Caption = 'P9 Report';
                        RunObject = report P9Report;
                    }
                    action("NHIF Report")
                    {
                        Caption = 'NHIF Report';
                        RunObject = report "NHIF Schedule W..";
                    }
                    action("NSSF Report")
                    {
                        Caption = 'NSSF Report';
                        RunObject = report "NSSF Schedule W..";
                    }
                }
            }

            group("User Management")
            {
                action("Leave Application")
                {
                    Caption = 'User Leave Application';
                    RunObject = page "HR Leave Application Card";
                }
                action("Leave Applications(Approved)")
                {
                    Caption = 'Leave Applications(Approved)';
                    RunObject = page "HR Leave Applications History";

                }
                action("Leave Applications(Posted)")
                {
                    Caption = 'Leave Applications(Posted)';
                    RunObject = page "Posted Leave Applications";
                }

                action("Change Password")
                {
                    Caption = 'Change Password';
                    ToolTip = 'Change User Business Central Client Password';
                    RunObject = page "User Card";
                }
            }
        }
    }
    var
    

}
profile "FOSA Profile" 
{
    Caption = 'FOSA Department Role Center';
    RoleCenter = "FOSA Department Role Center";
    ProfileDescription = 'FOSA Role Center';
    //Customizations = Customizations;
}



