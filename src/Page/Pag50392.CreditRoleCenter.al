//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50392 "Credit Role Center"
{
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            // part(Control1000000018; "Members List")
            // {
            // }
            group(Control1000000015)
            {
            }
            // part(Control1000000001)
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
            action("Member Balances")
            {
                Caption = 'Member Balances';
                Image = "Report";
                // RunObject = Report "Member Accounts  balances";
            }
            action("Member Statement")
            {
                Caption = 'Member Statement';
                Image = "Report";
                //RunObject = Report "Member Account Statement-New";
            }
            action("Member Guarantors")
            {
                Caption = 'Member Guarantors';
                Image = "Report";
                //  RunObject = Report "Loans Guarantors Details";
            }
            action("Credit Loans Register-CFC")
            {
                Caption = 'Credit Loans Register-CFC';
                Image = Register;
                //RunObject = Report "Loans Guard Report";
            }
            action("Credit Loans Register-Board")
            {
                Caption = 'Credit Loans Register-Board';
                Image = Register;
                // RunObject = Report "Update E-Loan Qualification";
            }
            action("Members Loan Register")
            {
                Caption = 'Members Loan Register';
                Image = "Report";
                // RunObject = Report "Loans Register";
            }
            action("Loans Guaranteed")
            {
                Caption = 'Loans Guaranteed';
                Image = "Report";
                //  RunObject = Report "Member Loans Guaranteed";
            }
            action("Loans Repayment Schedule")
            {
                Caption = 'Loans Repayment Schedule';
                Image = "Report";
                // RunObject = Report "Loans Repayment Schedule";
            }
            action("Loans Batch Schedule")
            {
                Caption = 'Loans Batch Schedule';
                Image = "Report";
                // RunObject = Report "Loans Batch Schedule";
            }
            action("Loans Appraisal")
            {
                Caption = 'Loans Appraisal';
                Image = "Report";
                //RunObject = Report "Loan Appraisal Ver1";
            }
            action("Loan Balances")
            {
                Caption = 'Loan Balances';
                Image = "Report";
                // RunObject = Report "Loan Balances FOSA";
            }
            action("Loans Defaulter Aging")
            {
                Caption = 'Loans Defaulter Aging';
                Image = "Report";
                //RunObject = Report "Loans Defaulter Aging - SASRA";
            }
            separator(Action1000000009)
            {
                Caption = 'Dividends';
            }
            action("Prorated Dividends Processing")
            {
                Caption = 'Prorated Dividends Processing';
                Image = "Report";
                //  RunObject = Report "Dividend Processing-Prorated";
            }
            action("Flat Rate Dividends Processing")
            {
                Caption = 'Flat Rate Dividends Processing';
                Image = "Report";
                //  RunObject = Report "Dividend Processing-Flat Rate";
            }
            action("Dividends Register")
            {
                Caption = 'Dividends Register';
                Image = "Report";
                //   RunObject = Report "Dividend Register";
            }
            action("Dividends Progression")
            {
                Caption = 'Dividends Progression';
                Image = "Report";
                //   RunObject = Report "Dividends Progressionslip";
            }
            separator(Action1000000019)
            {
            }
            action("Checkoff Main")
            {
                Caption = 'Checkoff Main';
                //  RunObject = Report "Data Sheet Main";
            }
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
            group(Members)
            {
                Caption = 'Members';
                Image = Journals;
                action("Member List")
                {
                    Caption = 'Member List';
                    RunObject = Page "Members List";
                }
                action("Member List Editable")
                {
                    Caption = 'Member List Editable';
                    RunObject = Page "Member List-Editable";
                }
            }
            group(Loans)
            {
                Caption = 'Loans';
                Image = Journals;
                action("Open Loans")
                {
                    Caption = 'Open Loans';
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Open));
                }
                action("Pending Loans")
                {
                    Caption = 'Pending Loans';
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Pending));
                }
                action("Approved Loans")
                {
                    Caption = 'Approved Loans';
                    Image = Journals;
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Approved));
                }
                action("Issued Loans")
                {
                    Caption = 'Issued Loans';
                    Image = Journals;
                    RunObject = Page "Loans Posted List";
                }
                action("Rejected Loans")
                {
                    Caption = 'Rejected Loans';
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Rejected));
                }
            }
            group("Credit Processing")
            {
                Caption = 'Credit Processing';
                Image = FixedAssets;
                action("All Loans")
                {
                    Caption = 'All Loans';
                    RunObject = Page "Loans Applied  List";
                }
                action("Loans Disbursement Batch")
                {
                    Caption = 'Loans Disbursement Batch';
                    RunObject = Page "Loans Disbursment Batch List";
                }
            }
            group("Processed Credits")
            {
                Caption = 'Processed Credits';
                action("Posted Credit List")
                {
                    Caption = 'Posted Credit List';
                    RunObject = Page "Loans Posted List";
                }
                action("Posted Loan Batch")
                {
                    Caption = 'Posted Loan Batch';
                    RunObject = Page "Posted Loan Batch - List";
                }
            }
            group("Checkoff Processing-Distributed")
            {
                Caption = 'Checkoff Processing-Distributed';
                action("Check-Off Distributed")
                {
                    Caption = 'Check-Off Distributed';
                   // RunObject = Page "Checkoff Processing-D List";
                }
                action("Posted Checkoff")
                {
                    Caption = 'Posted Checkoff';
                    RunObject = Page "Posted Bosa Rcpt List-Checkof";
                }
                action("Employer Checkoff Remitance")
                {
                    Caption = 'Employer Checkoff Remitance';
                    RunObject = Page "Bosa Receipts H List-Checkoff";
                }
                action("Posted Employer Checkoff")
                {
                    Caption = 'Posted Employer Checkoff';
                    RunObject = Page "Posted Bosa Rcpt List-Checkof";
                }
                action("Paybill Processing")
                {
                    Caption = 'Paybill Processing';
                    RunObject = Page "Paybill Processing List";
                }
                action("Posted Paybill Processing")
                {
                    Caption = 'Posted Paybill Processing';
                    RunObject = Page "Posted Paybill Processing Lis";
                }
                action("Interest Due Periods")
                {
                    Caption = 'Interest Due Periods';
                    RunObject = Page "Interest Due Periods";
                }
                action("Checkoff Advice Datasheet")
                {
                    Caption = 'Checkoff Advice Datasheet';
                    RunObject = Page "Data Sheet Main";
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Administration;
                action("Loans Products Setup")
                {
                    Caption = 'Loans Products Setup';
                    Image = AccountingPeriods;
                    RunObject = Page "Loan Products Setup List";
                }
                action(Action41)
                {
                    Caption = 'Interest Due Periods';
                    RunObject = Page "Interest Due Periods";
                }
                action("Deposits Tier Setup")
                {
                    Caption = 'Deposits Tier Setup';
                    RunObject = Page "Deposits tier Setups";
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                action(Action1400017)
                {
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                }
                action(Deposit)
                {
                    Caption = 'Deposit';
                    Image = DepositSlip;
                }
                action("Bank Rec.")
                {
                    Caption = 'Bank Rec.';
                    RunObject = Page "Bank Acc. Reconciliation List";
                }
            }
            group("Document Approvals")
            {
                Caption = 'Document Approvals';
                action("Approval Request")
                {
                    Caption = 'Approval Request';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                }
            }
        }
        area(creation)
        {
            action("Sales &Credit Memo")
            {
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
            }
            action("P&urchase Credit Memo")
            {
                Caption = 'P&urchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
            }
            action("Bank Account Reconciliation")
            {
                Caption = 'Bank Account Reconciliation';
                Image = BankAccountRec;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Bank Acc. Reconciliation List";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            action("Sacco General Setup")
            {
                Caption = 'Sacco General Setup';
                Image = Setup;
                RunObject = Page "Posted Petty Cash Payments";
            }
            action("Sacco No Series")
            {
                Caption = 'Sacco No Series';
                Image = Setup;
                RunObject = Page "HR Employee Course of Study";
            }
            action("Import Members")
            {
                Caption = 'Import Members';
                Image = Import;
                RunObject = XMLport "Import Members";
            }
            action("Import FOSA Accounts")
            {
                Caption = 'Import FOSA Accounts';
                Image = Import;
                RunObject = XMLport "Import Fosa Accounts";
            }
            action("Import Checkoff Distributed")
            {
                Caption = 'Import Checkoff Distributed';
                Ellipsis = true;
                Image = Import;
                RunObject = XMLport "Import Checkoff Distributed";
            }
            action("Import Checkoff Block")
            {
                Caption = 'Import Checkoff Block';
                Ellipsis = true;
                Image = Import;
                RunObject = XMLport "Import Checkoff Block";
            }
            action("Import Salaries")
            {
                Caption = 'Import Salaries';
                Ellipsis = true;
                Image = Import;
                RunObject = XMLport "Import Salaries";
            }
        }
    }
}




