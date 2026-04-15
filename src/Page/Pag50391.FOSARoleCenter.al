//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50391 "FOSA Role Center"
{
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            // part(Control1000000018; "HR Emp Transfer List")
            // {
            //     Caption = 'FOSA Account Holders';
            // }
            group(Control1000000015)
            {
            }
            // part(Control1000000001; "Copy Profile")
            // {
            // }
            systempart(Control1000000000; MyNotes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            // action("Process Cheque Clearing")
            // {
            //     Caption = 'Process Cheque Clearing';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516271;
            // }
            // action("Process Standing Orders")
            // {
            //     Caption = 'Process Standing Orders';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516272;
            // }
            // action("Generate FOSA Interest")
            // {
            //     Caption = 'Generate FOSA Interest';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516273;
            // }
            // action("Transfer FOSA Interest")
            // {
            //     Caption = 'Transfer FOSA Interest';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516274;
            // }
            // action("Calculate Fixed Int")
            // {
            //     Caption = 'Calculate Fixed Int';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516275;
            // }
            // action("Accounts Status")
            // {
            //     Caption = 'Accounts Status';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516276;
            // }
            // action("Accounts Balances")
            // {
            //     Caption = 'Accounts Balances';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516277;
            // }
            // action("Generate Dormant Accounts")
            // {
            //     Caption = 'Generate Dormant Accounts';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516278;
            // }
            // action("Loans Register")
            // {
            //     Caption = 'Loans Register';
            //     Image = "Report";
            //     RunObject = Report UnknownReport51516227;
            // }
            // action("Cashier Report")
            // {
            //     Caption = 'Cashier Report';
            //     Image = "Report";
            //     Promoted = true;
            //     RunObject = Report UnknownReport51516270;
            // }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Balance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action(Budgets)
            {
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
            }
            action("Bank Accounts")
            {
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
            }
            action("Tax Statements")
            {
                Caption = 'Tax Statements';
                RunObject = Page "VAT Statement Names";
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(Action13)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action(Reminders)
            {
                Caption = 'Reminders';
                Image = Reminder;
                RunObject = Page "Reminder List";
            }
            action("Finance Charge Memos")
            {
                Caption = 'Finance Charge Memos';
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo List";
            }
            action("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
            }
        }
        area(sections)
        {
            group("Account Opening")
            {
                Caption = 'Account Opening';
                Image = Journals;
                action("Accounts Application List")
                {
                    Caption = 'Accounts Application List';
                    // RunObject = Page "HR Medical Scheme Members Card";
                }
                action("Accounts Application History")
                {
                    Caption = 'Accounts Application History';
                    RunObject = Page "HR Medical Scheme Members List";
                }
            }
            group("Accounts Holders")
            {
                Caption = 'Accounts Holders';
                Image = Journals;
                action("Member Accounts List")
                {
                    Caption = 'Member Accounts List';
                    RunObject = Page "HR Emp Transfer List";
                }
            }
            group(Banking)
            {
                Caption = 'Banking';
                Image = FixedAssets;
                action("Cashier Transactions")
                {
                    Caption = 'Cashier Transactions';
                    RunObject = Page "Hr ApprovedAsset Transfer List";
                }
                action("Cashier Transactions Authorisation")
                {
                    Caption = 'Cashier Transactions Authorisation';
                    RunObject = Page "Hr Asset Transfer List";
                }
                action("ATM Log Entries")
                {
                    Caption = 'ATM Log Entries';
                    RunObject = Page "Pension Processing Header";
                }
                action("ATM Transactions")
                {
                    Caption = 'ATM Transactions';
                    //    RunObject = Page "Cheque Transactions Card.";
                }
                action("EFT List")
                {
                    Caption = 'EFT List';
                    RunObject = Page "Payroll Employee Card.";
                }
                action("Petty Cash")
                {
                    Caption = 'Petty Cash';
                    RunObject = Page "Cheque Book Request Batch List";
                }
                action("Posted Petty Cash")
                {
                    Caption = 'Posted Petty Cash';
                    //RunObject = Page "Cheque Book Receipt Batch List";
                }
                action("Funds Transfer")
                {
                    Caption = 'Funds Transfer';
                    RunObject = Page "Funds Transfer List";
                }
                action("Receipts list-BOSA")
                {
                    Caption = 'Receipts list-BOSA';
                    RunObject = Page "Account AgenSignatory-Uploaded";
                }
                action("Posted BOSA Receipts List")
                {
                    Caption = 'Posted BOSA Receipts List';
                    //RunObject = Page "HR Appraisal Agreement HD";
                }
                action("ATM Cards Application")
                {
                    Caption = 'ATM Cards Application';
                    RunObject = Page "Payroll General Setup.";
                }
                action("Bank Account List")
                {
                    Caption = 'Bank Account List';
                    RunObject = Page "Bank Account List";
                }
                action("GENERAL RECEIPTS")
                {
                    Caption = 'GENERAL RECEIPTS';
                    RunObject = Page "Receipt Header List";
                }
            }
            group("Treasury & Teller Mgt")
            {
                Caption = 'Treasury & Teller Mgt';
                action("Treasury List")
                {
                    Caption = 'Treasury List';
                    //  RunObject = Page "Membership App card 2";
                }
                action("Teller List")
                {
                    Caption = 'Teller List';
                    RunObject = Page "HR Medical Claims List-posted";
                }
                action("Teller & Treasury Transactions")
                {
                    Caption = 'Teller & Treasury Transactions';
                    RunObject = Page "Hr Leave Planner Lines";
                }
            }
            group("Credit Processing")
            {
                Caption = 'Credit Processing';
                Image = FixedAssets;
                action("Fosa Loans")
                {
                    Caption = 'Fosa Loans';
                    RunObject = Page "Payroll NHIF Setup.";
                }
                action("All Loans")
                {
                    Caption = 'All Loans';
                    RunObject = Page "Employee Common Activities";
                }
                action("Loans Disbursement Batch")
                {
                    Caption = 'Loans Disbursement Batch';
                    RunObject = Page "HR Setup Card";
                }
                action("Posted Loans")
                {
                    Caption = 'Posted Loans';
                    RunObject = Page "HR Job Applications Card";
                }
                action("Posted Batches")
                {
                    Caption = 'Posted Batches';
                    RunObject = Page "Group/Corporate Appl. Created";
                }
            }
            group("Cheque Management")
            {
                Caption = 'Cheque Management';
                action("Banking Cheque Schedule")
                {
                    Caption = 'Banking Cheque Schedule';
                    RunObject = Page "Payroll Earnings List.";
                }
                action("Bankers Cheque Schedule")
                {
                    Caption = 'Bankers Cheque Schedule';
                    RunObject = Page "HR Leave Family Groups List";
                }
                action("Bankers Cheque Register")
                {
                    Caption = 'Bankers Cheque Register';
                    RunObject = Page "Payroll Earnings Card.";
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                Image = Administration;
                action("Standing Orders  List")
                {
                    Caption = 'Standing Orders  List';
                    Image = Currency;
                    RunObject = Page "HR Leave Planner Card";
                }
                action("Standing Order Register")
                {
                    Caption = 'Standing Order Register';
                    Image = AccountingPeriods;
                    RunObject = Page "Hr Leave Planner List";
                }
                action("Salaries Buffer")
                {
                    Caption = 'Salaries Buffer';
                    RunObject = Page "Pension Processing List";
                }
                action("Deposits Tier Setup")
                {
                    Caption = 'Deposits Tier Setup';
                    RunObject = Page "HR Employees Supervisee";
                }
            }
            group("FOSA Setups")
            {
                Caption = 'FOSA Setups';
                action("Account Types List")
                {
                    Caption = 'Account Types List';
                    Image = BankAccount;
                    RunObject = Page "Payroll Employee Assignments.";
                }
                action("FOSA Charges")
                {
                    Caption = 'FOSA Charges';
                    Image = DepositSlip;
                    RunObject = Page "Cheque Transactions Card";
                }
                action("Transaction Type  List")
                {
                    Caption = 'Transaction Type  List';
                    RunObject = Page "prPayroll Periods";
                }
                action("Supervisor Approvals Levels")
                {
                    Caption = 'Supervisor Approvals Levels';
                    //     RunObject = Page "Pr Salary Card ListXX";
                }
                action("ATM Charges")
                {
                    Caption = 'ATM Charges';
                    //     RunObject = Page "prHeader Salary CardXX";
                }
                action("Status Change Permisions")
                {
                    Caption = 'Status Change Permisions';
                    RunObject = Page "Fixed Deposit Acc. List";
                }
                action("Account Details-editable")
                {
                    Caption = 'Account Details-editable';
                    RunObject = Page "Member Account Signatory Card";
                }
                action("User Branch Set Up")
                {
                    Caption = 'User Branch Set Up';
                    RunObject = Page "Cheque Truncation Card";
                }
            }
        }
    }
}




