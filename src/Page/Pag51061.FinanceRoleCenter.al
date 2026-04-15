page 51061 "Finance Role Center"//Role center for finance department
{
    ApplicationArea = All;
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(DashbordVisualizationCardPar; "Dashbord Visualization CardPar")
            {
                Visible = true;
                //Caption='Navigate';
            }
            part(Control139; "Headline RC Business Manager")
            {
                Visible = true;
            }
            part(ApprovalActivities; "Approvals Activities")
            {
                Visible = true;
            }
            part("Emails"; "Email Activities")
            {
            }
            part(Control1907692008; "My Accounts")
            {
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                Visible = false;
            }
            part(Control122; "Power BI Embedded Report Part")
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            // action(ActionBarAction)
            // {
            //     // RunObject = Page ObjectName;
            // }
        }
        area(Sections)
        {
            group(Action172)
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
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("G/L Account Categories")
                {
                    Caption = 'G/L Account Categories';
                    Visible = false;
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action(Currencies)
                {
                    Caption = 'Currencies';
                    Image = Currency;
                    Visible = false;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }

                action(Employees)
                {
                    Caption = 'Employees';
                    Visible = false;
                    RunObject = Page "Employee List";
                    ToolTip = 'View or modify employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                }
                action("Analysis Views")
                {
                    Caption = 'Analysis Views';
                    Visible = false;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action("Financial Reports")
                {
                    Caption = 'Financial Reports';
                    RunObject = Page "Financial Reports";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
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
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action("<Action3>")
                {
                    Caption = 'Recurring General Journals';
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
                action(PaymentsJournals)
                {
                    Caption = 'Payments Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
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
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action(CashReceiptJournals)
                {
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
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
                    RunObject = Page "Pmt. Reconciliation Journals";
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Bank Acc. Statements")
                {
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Cash Flow Forecasts")
                {
                    Caption = 'Cash Flow Forecasts';
                    Visible = false;
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                }
                action("Chart of Cash Flow Accounts")
                {
                    Caption = 'Chart of Cash Flow Accounts';
                    Visible = false;
                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                }
                action("Cash Flow Manual Revenues")
                {
                    Caption = 'Cash Flow Manual Revenues';
                    Visible = false;
                    RunObject = Page "Cash Flow Manual Revenues";
                    ToolTip = 'Record manual revenues, such as rental income, interest from financial assets, or new private capital to be used in cash flow forecasting.';
                }
                action("Cash Flow Manual Expenses")
                {
                    Caption = 'Cash Flow Manual Expenses';
                    Visible = false;
                    RunObject = Page "Cash Flow Manual Expenses";
                    ToolTip = 'Record manual expenses, such as salaries, interest on credit, or planned investments to be used in cash flow forecasting.';
                }
                action(BankAccountReconciliations)
                {
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    RunObject = page "Bank Acc. Recon List Conv";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
            }
            group(Action16)
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                ToolTip = 'Manage depreciation and insurance of your fixed assets.';
                action(Action17)
                {
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Fixed Assets G/L Journals")
                {
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                }
                action("Fixed Assets Journals")
                {
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
                action("Fixed Assets Reclass. Journals")
                {
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                }
                action(Insurance)
                {
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                }
                action("Insurance Journals")
                {
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                }
                action("Recurring Fixed Asset Journals")
                {
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
            }
            group(Action84)
            {
                Caption = 'Membership Management';
                group("Member BOSA Accounts")
                {
                    action(MembersList)
                    {
                        Caption = 'Member Accounts List';
                        RunObject = Page "Members List";
                        RunPageView = where(ISNormalMember = filter(true), "Employer Code" = filter(<>'STAFF'));
                        ToolTip = 'Manage Member Accounts';
                    }
                    action(StaffMembersList)
                    {
                        Caption = 'Staff Member Accounts List';
                        RunObject = Page "Staff Members List";
                        ToolTip = 'Manage Staff Member Accounts';
                    }
                }
                group(ChangeRequest)
                {
                    Caption = 'Change Request';
                    action("Change Request")
                    {
                        Caption = 'Change Request List';
                        RunObject = Page "Change Request List";
                        ToolTip = 'Change Member Details';
                    }
                    action(StatusChangeRequest)
                    {
                        Caption = 'Status Change Request';
                        RunObject = report "Member Status Change Request";
                    }
                }
                group(ESSRefundProcess)
                {
                    Caption = 'ESS Refund';
                    action(ESSRefund)
                    {
                        Caption = 'New ESS Refunds';
                        RunObject = page "ESS Refund List";
                    }
                    action(RegESSRefund)
                    {
                        Caption = 'Registered ESS Refunds';
                        RunObject = page "Registered ESS Refund List";
                    }
                    action(MatESSRefund)
                    {
                        Caption = 'Matured ESS Refunds';
                        RunObject = page "Matured ESS Refund List";
                        RunPageView = where(Registered = filter(true), Matured = filter(True), Refunded = filter(false));
                    }
                    action(ESSRefundBatch)
                    {
                        Caption = 'ESS Refund Batch';
                        RunObject = page "ESS Refund Batch List";
                    }
                    action(PostedESSRefunds)
                    {
                        Caption = 'Posted ESS Refunds';
                        RunObject = page "Matured ESS Refund List";
                        RunPageView = where(Registered = filter(true), Matured = filter(True), Refunded = filter(true));
                    }
                    action(PostedESSRefundBatch)
                    {
                        Caption = 'Posted ESS Refund Batches';
                        RunObject = page "Posted ESS Refund Batches";
                    }
                }
                group(Funeral)
                {
                    Caption = 'Funeral Rider Processing';
                    action("Funeral Rider")
                    {
                        Caption = 'Funeral Rider List';
                        RunObject = page "Funeral Rider Processing";
                    }
                    action("Funeral Rider Appr")
                    {
                        Caption = 'Approved Funeral Rider';
                        RunObject = page "Approved Funeral Rider Process";
                    }
                    action("Funeral Rider Paid")
                    {
                        Caption = 'Paid Funeral Rider';
                        RunObject = page "Paid Funeral Rider";
                    }
                }

                group("Membership Closure")
                {
                    Caption = 'Membership Exit';
                    action("Notice List")
                    {
                        Caption = 'Notice List';
                        RunObject = page "Notice List";
                    }
                    action("Matured Notice List")
                    {
                        Caption = 'Registered Notice List';
                        RunObject = page "Registered Notice List";
                    }
                    action("MeMbership Exit")
                    {
                        Caption = 'Membership Exit';
                        RunObject = page "Membership Exit List";
                    }
                    action("Membership Exit(Posted)")
                    {
                        Caption = 'Posted Membership Exit';
                        RunObject = page "Posted Member Withdrawal List";
                    }
                    action("Exit Member Batch List")
                    {
                        Caption = 'Member Exit Batch List';
                        RunObject = page "Member Exit Batch List";
                    }
                    action("Exit Refund Report")
                    {
                        Caption = 'Member Refund Progress';
                        RunObject = report "Member Deposit Refund Progress";
                    }
                }
                group("BOSA Receipt")
                {
                    Caption = 'BOSA Receipts';
                    ToolTip = 'Member Receipting Process.';

                    action("BOSA Receipts")
                    {
                        Caption = 'Open BOSA Receipts';
                        Image = Receipt;
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
            }
            group("Saving Products Management")
            {
                Caption = 'Saving Products Management';
                Image = Bank;
                ToolTip = 'Manage Saving Accounts Eg. FOSA Savings and Fixed Deposits';

                group("Savings Accounts Creation")
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
                }
                group("FOSA Accounts")
                {
                    action("Active Member FOSA Accounts")
                    {
                        Caption = 'Active Member Savings Accounts';
                        Image = Customer;
                        RunObject = page "Member Accounts List";
                        ToolTip = 'Open Members'' FOSA Accounts';
                    }
                    action("Active Staff FOSA Accounts")
                    {
                        Caption = 'Active Staff Savings Accounts';
                        Image = Customer;
                        RunObject = page "Staff Member Accounts List";
                        ToolTip = 'Open Staff Members'' FOSA Accounts';
                    }
                    action("Other Member FOSA Accounts")
                    {
                        Caption = 'Non-Active Member Savings Accounts';
                        Image = Customer;
                        RunObject = page "Non-Active Member Accounts";
                        ToolTip = 'Open Members'' FOSA Accounts';
                    }
                    action("All Member FOSA Accounts")
                    {
                        Caption = 'All Member Savings Accounts';
                        Image = Customer;
                        RunObject = page "All Member Accounts List";
                        ToolTip = 'Open Members'' FOSA Accounts';
                    }

                }

                group("Standing Orders ")
                {
                    Caption = 'Standing Orders';
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
                            RunObject = report "Successful Standing Orders";
                        }
                    }
                }

                group("Fixed Deposits Management")
                {
                    Caption = 'Fixed Deposit Management';
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
                group("Call Deposit Management")
                {
                    action("NewCall")
                    {
                        Caption = 'New Call Deposit';
                        RunObject = page "Call Deposit list";
                    }
                    action("CreditedCall")
                    {
                        Caption = 'Credited Call Deposit';
                        RunObject = page "Credited Call Deposit list";
                    }
                    action("MaturedCall")
                    {
                        Caption = 'Matured Call Deposit';
                        RunObject = page "Matured Call Deposit list";
                    }
                    action("RevokedCall")
                    {
                        Caption = 'Revoked Call Deposit';
                        RunObject = page "Revoked Call Deposit list";
                    }
                }
                group("Checkoff Proccessing")
                {
                    Caption = 'Checkoff Processing';
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
                }
                group("Salary Proccessing ")
                {
                    Caption = 'Salary Processing';
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
                    action("Recruitment Processing List")
                    {
                        Caption = 'Recruitment Processing List';
                        Image = Account;
                        RunObject = page "Recruitment Processing List";
                        ToolTip = 'Recruitment Processing List';
                    } 
                }
                group("Piggy Banks")
                {
                    Caption = 'Piggy Bank Issuing';
                    action("Piggy Bank Issuing")
                    {
                        RunObject = page "Piggy Bank Issuance List";
                    }
                    action("Piggy Bank Issued")
                    {
                        RunObject = page "Issued Piggy Bank Issuance";
                    }
                }
                group("ATM Banking")
                {

                    Caption = 'ATM Banking';
                    action(ATMApplication)
                    {
                        Caption = 'ATM Application';
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
                        Visible = false;
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
                    action("Sacco ATMs")
                    {
                        Caption = 'Sacco ATM Cards';
                        ToolTip = 'A list of all members with ATM cards linked to their FOSA accounts.';
                        RunObject = page "Sacco ATM Cards";
                    }
                }
                group("Overdraft Loans")
                {
                    Caption = 'Overdraft Loan Management';
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
                    caption = 'Periodic Interest Activities';
                    action("Interest Transfer")
                    {
                        Caption = 'Interest On Savings List';
                        RunObject = Page "Interest On Savings List";
                        RunPageView = where(Posted = filter(false));
                    }
                    action("Posted Interest Transfer")
                    {
                        Caption = 'Posted Interest On Savings';
                        RunObject = Page "Interest On Savings List";
                        RunPageView = where(Posted = filter(true));
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
                            Caption = 'Savings Accounts Opened';
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
                        action("Mdosi Junior Listing")
                        {
                            // Caption = 'Accounts Listing';
                            RunObject = report "MDOSI Junior Report";
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
                        action("Employer Summary")
                        {
                            Caption = 'Employer Remmittance Summary';
                            RunObject = report "Remmittance Summary";
                        }

                        action("Treasury Report")
                        {
                            Caption = 'Treasury Report';
                            RunObject = report "Treasury Register";
                        }

                        action("Loan Variance")
                        {
                            Caption = 'Loan Variance';
                            RunObject = report "Loans Variances";
                        }
                        action("Members Transactional Summary")
                        {
                            RunObject = report "Members Transactional Summary";
                        }
                        action("Placed Fixed Deposits")
                        {
                            RunObject = report "Fixed Deposit Placements";
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
                }
            }
            group("Teller/Treasury Management")
            {
                Caption = 'Teller-Treasury Management';
                action("Treasury")
                {
                    Caption = 'Treasury List';
                    RunObject = Page "Treasury List";
                }
                action("Tellers")
                {
                    Caption = 'Teller List';
                    RunObject = Page "Teller Till List";
                }
                action("Teller&Treasury List")
                {
                    Caption = 'Teller Request/Receive Funds';
                    RunObject = Page "Teller & Treasury Trans List1";
                }
                action("Teller/Treasury Transactions List")
                {
                    Caption = 'Teller-Treasury Transactions List';
                    RunObject = Page "Teller & Treasury Trans List";
                }
                action("Posted Transactions List")
                {
                    Caption = 'Posted Teller-Treasury Transactions List';
                    RunObject = Page "Teller & Treasury Trans List p";
                }
            }
            group("Cashier Banking")
            {

                Caption = 'Cashier Banking';
                group("Cashier Transactions")
                {
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
                }
                group("EFT/RTGS Transactions")
                {
                    action("EFT List")
                    {
                        Caption = 'EFT/RTGS List';
                        RunObject = Page "New EFT/RTGS List";
                        RunPageView = where(Transferred = filter(false));
                    }
                    action("EFT-Posted List")
                    {
                        Caption = 'Posted EFT/RTGS List';
                        RunObject = Page "New EFT/RTGS List";
                        RunPageView = where(Transferred = filter(true));
                    }
                    action("EFT Charges List")
                    {
                        Caption = 'EFT/RTGS Charges List';
                        RunObject = Page "EFT/RTGS Charges";
                    }
                }
                group("Petty Cash Transactions")
                {
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
                }
                group("Cheque Management")
                {
                    action(Chequesetuplist)
                    {
                        Caption = 'Cheque Setup';
                        RunObject = page "Cheque Register List";
                    }
                    action("Cheque Register")
                    {
                        Caption = 'Cheque Register';
                        RunObject = Page "Cheque Register";
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
                }
            }

            group("Loans Processes")
            {
                group("BOSA Loans Management")
                {
                    Caption = 'Loan Management';
                    ToolTip = 'BOSA Loans'' Management Module';
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
                    group("Posted Loans")
                    {
                        Caption = 'Posted Loans';
                        action(ClearedLoans)
                        {
                            Caption = 'Running Loans';
                            RunObject = Page "Uncleared Loans Posted List";
                            ToolTip = 'Open the list of the Loans Posted.';
                        }
                        action(RunningLoans)
                        {
                            Caption = 'Cleared Loans';
                            RunObject = Page "Cleared Loans Posted List";
                            ToolTip = 'Open the list of the Loans Posted.';
                        }
                    }
                    action("Posted Batches")
                    {
                        Caption = 'Posted Batches';
                        RunObject = Page "Posted Loan Batch - List";
                        ToolTip = 'Open the list of the Loans Posted.';
                    }
                }
                group("Loans Reports")
                {
                    action("Loans Repayment")
                    {
                        Caption = 'Loan Repayment';
                        RunObject = report "Loans Repayment";
                    }
                    action("Loan Repayment List")
                    {
                        Caption = 'Loans Repayment List';
                        RunObject = report "Loan Repayment List";
                    }
                    action("Posted Loans List")
                    {
                        Caption = 'Posted Loans List';
                        RunObject = report "Posted Loans List";
                    }
                    action("Loan Defaulted List")
                    {
                        Caption = 'Loan Defaulted List Report';
                        RunObject = report "Loan Defaulters List2";
                    }
                    action("Loan Disbursed by product List")
                    {
                        Caption = 'Loan Disbursed Per Product';
                        RunObject = report "Loans Disbursed Per Product";
                    }
                    action("Loan Portfolio At Risk")
                    {
                        Caption = 'Loans Portfolio At Risk';
                        RunObject = report "Loan Portfolio At Risk";
                    }
                    action("Portfolio At Risk")
                    {
                        Caption = 'Portfolio At Risk';
                        RunObject = page "Portfolio at Risk";
                    }
                    action("Loans Member Registration")
                    {
                        Caption = 'Loans Member Registration Report';
                        RunObject = report "Loans Member Registration";
                    }
                    action("Loans Variance")
                    {
                        Caption = 'Loans Variance';
                        RunObject = report "Loans Variance";
                    }
                    action("NegativeBalances")
                    {
                        Caption = 'Negative Balances';
                        RunObject = report NegativeBalances;
                    }

                    action("Loan Expectation Monthly")
                    {
                        Caption = 'Loan Expectation Monthly';
                        RunObject = report "Loans Monthly Expectation Ver1";
                    }
                    action("Loans Under Recovery")
                    {
                        Caption = 'Loans Under Recovery Report';
                        //RunObject = report "Loans Under Recovery Report";
                    }

                    action("PRD Report")
                    {
                        Caption = 'PRD Report';
                        RunObject = report "PRD Report";
                    }
                    action("Loans Balances Report")
                    {
                        Caption = 'Loans Balances Report';
                        RunObject = report "Loans Balances Report";

                    }
                    action("Loans TAT Report")
                    {
                        Caption = 'Loans TAT Report';
                        RunObject = report "Loans Turn Around Time";
                    }
                    action("Loans Int Var Report")
                    {
                        Caption = 'Interest Variance on Loans Report';
                        RunObject = report "Interest on Loans Variance";
                    }

                    group("CIC")
                    {
                        action("Deposit Details")
                        {
                            Caption = 'Deposits Report';
                            RunObject = report "Deposits Details";
                        }
                    }

                    action("Member No Active Loans")
                    {
                        Caption = 'Members currently servicing no loans';
                        Image = "Report";
                        RunObject = Report "Members with no Running Loans";
                    }

                    action("Loan Aging Report")
                    {
                        Caption = 'Loan Aging Report';
                        RunObject = report "Loans Defaulter Aging Display";
                    }
                    // action("Loan Aging Report")
                    // {
                    //     Caption = 'Loan Aging Report';
                    //     RunObject = report "Classified Running Loans";
                    // }
                    action("Update Loans")
                    {
                        Caption = 'Update Loans';
                        Image = "Report";
                        RunObject = Report UpdateLoanStatus;
                        //  ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
                    }
                    group("SASRA Reports")
                    {
                        action("Deposit Return")
                        {
                            Caption = 'Deposit Return Sasra';
                            RunObject = report "Deposit return";

                        }
                        action("Insider Lending")
                        {
                            Caption = 'Insider Lending';
                            RunObject = report InsiderLending;

                        }
                        action("Risk Provisioning Report")
                        {
                            Caption = 'Risk Provisioning Resport';
                            RunObject = report "Risk Class Of Assets & Prov";
                        }
                        action("Statement Of Financial Position")
                        {
                            Caption = 'Statement of Financial Position';
                            RunObject = report "STATEMENT OF FINANCIAL P";
                        }
                        action("Capital Adequacy")
                        {
                            Caption = 'Capital Adequacy';
                            RunObject = report "CAPITAL ADEQUACY RETURN";
                        }
                        action("Statement of Comprehensive Income")
                        {
                            RunObject = report "Form2F Statement of CompIncome";
                        }
                        action(Liquidity)
                        {
                            RunObject = report "Liquidity Statement";
                        }
                        action("Investment Return")
                        {
                            RunObject = report "RETURN ON INVESTMENT.";
                        }
                        action("Sectorial Lending")
                        {
                            RunObject = report "Sectorial Lending";
                        }
                        action("Other Disclosures")
                        {
                            RunObject = report "Other Disclosures";
                        }
                        action("Insider List")
                        {
                            RunObject = page "Insider List";
                        }
                    }
                }
                group("Periodic Activities")
                {
                    action("Process Monthly Interest")
                    {
                        Caption = 'Tranfer Interest To Journal';
                        RunObject = report TransferBufferInterest;
                    }
                    action("Clear Buffer Interest")
                    {
                        Caption = 'Clear Buffer Interest';
                        RunObject = report ClearBuffer;
                    }
                    action("Loan Classification")
                    {
                        Caption = 'Loan Classification';
                        RunObject = report "Loans Defaulter Aging - SASRA";
                    }
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
                action("Member Insurance")
                {
                    Caption = 'Member Insurance Claims';
                    RunObject = page "Insurance Claims";
                }
                action("BOD Honoraria")
                {
                    Image = PostedOrder;
                    RunObject = page "BOD Payments";
                }
                action("Delegate Allowance")
                {
                    Image = PostedOrder;
                    RunObject = page "Sacco Meetings Allow Expected";
                }

            }
            group("Payments Setup")
            {
                Caption = 'Payment Setup';
                Image = Setup;
                ToolTip = 'Payment Setup.';
                action("Funds Genral Setup")
                {
                    Caption = 'Funds General Setup. ';
                    Image = Check;
                    RunObject = page "Funds General Setup";
                    ToolTip = 'Funds General Setup.';
                }
                action("Funds User Setup")
                {
                    Caption = 'Funds User Setup ';
                    Image = Check;
                    RunObject = page "Funds User Setup";
                    ToolTip = 'Funds User Setup';
                }
                action("Payment Tax Setup")
                {
                    Caption = 'Payment Tax Setup. ';
                    Image = Check;
                    RunObject = page "Payment Taxes Setup";
                    ToolTip = 'Payment Taxes Setup';
                }

                action("Budgetary Control Setup")
                {
                    Caption = 'Budgetary Control Setup ';
                    Image = Check;
                    RunObject = page "Budgetary Control Setup";
                    ToolTip = 'Budgetary Control Setup';
                }
                action("Receipt and Payment Types List")
                {
                    Caption = 'Receipt and Payment Types List';
                    Image = Setup;
                    RunObject = page "Receipt and Payment Types List";//
                    ToolTip = 'Receipt and Payment Types List';
                }
                action("Tarrif Codes")
                {
                    Caption = 'Tarrif Codes';
                    Image = PostedOrder;
                    RunObject = page "Tarrif Codes";
                }
            }
            group("Dividends Processing")
            {
                action("Coop Dividends")
                {
                    Caption = 'Coop Dividend';
                    RunObject = page "Coop Dividends List";
                }
                action("Process Dividends")
                {
                    Caption = 'Process Dividends';
                    Visible = false;
                    RunObject = report "Dividend Processing Ver1";
                }
                action("Generate Dividend Prorated")
                {
                    Caption = 'Generate Dividend Prorated';
                    RunObject = report "Dividend Prorated New";
                }

                action("Generate Dividend Flatrate")
                {
                    Caption = 'Generate Dividend Flatrate';
                    RunObject = report "Generate Dividend FlatRate";
                }
                action("Dividends Register")
                {
                    Caption = 'Dividends Register List';
                    RunObject = page "Dividend Register";
                }
                action("Post Dividends")
                {
                    Caption = 'Post Dividends';
                    RunObject = report "Post Dividends";
                }
                action("Transfer Dividends")
                {
                    Caption = 'Transfer Dividends';
                    RunObject = report "TransferDividend-Prorated";
                }
                action("Dividends Register Report ")
                {
                    Caption = 'Dividends Register Report';
                    RunObject = report "Dividends Register";
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
                Group("Paybill Transactions")
                {
                    action(UnpostedPaybill)
                    {
                        Caption = 'Paybill Transactions';
                        RunObject = page "Paybill Transactions";
                    }
                    action(PostedPaybill)
                    {
                        Caption = 'Posted Paybill Transactions';
                        RunObject = page "Posted Paybill Transactions";
                    }
                }
                Group("PaytoFOSA Transactions")
                {
                    action(UnpostedPaytoFOSA)
                    {
                        Caption = 'PaytoFOSA Transactions';
                        RunObject = page "PaytoFOSA Transactions";
                    }
                    action(PostedPaytoFOSA)
                    {
                        Caption = 'Posted Pay-to-FOSA Transactions';
                        RunObject = page "Posted PaytoFOSA Transactions";
                    }
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
                    RunPageView = where(Posted = filter(false), Reversed = filter(false));
                }
                action("MPESA Transactions")
                {
                    Caption = 'MPESA Mobile Transactions';
                    RunObject = page "MPESA Mobile Transactions";
                }
                action("Mobile")
                {
                    Caption = 'Mobile Banking Members';
                    RunObject = page "Mobile Banking Members List";
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
                group("Pin Reset Applications")
                {
                    action("Pin Reset Application List")
                    {
                        RunObject = page "Member Pin Reset";
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
                        Caption = 'Bio Data Update SMS';
                        // RunObject = page "SMS Messages.";
                        RunObject = report "Member Specific SMS";
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
                    action("SMSUncharged")
                    {
                        Caption = 'Uncharged SMS Charges';
                        RunObject = report "SMS not Charged";
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
                group("Mobile Loan Advance")
                {
                    action("Credit Rating")
                    {
                        Caption = 'Credit Rating';
                        RunObject = page "Credit Ratings List";
                    }
                    action("Penalty Counter")
                    {
                        Caption = 'Penalty Counter';
                        RunObject = page "Penalty Counter List";
                    }
                }

                group(ABCReports)
                {
                    Caption = 'ABC Reports';
                    action(atmTrans)
                    {
                        Caption = 'ATM Transactions';
                        RunObject = report "ATM Transactions";
                    }
                    action(revATMtrans)
                    {
                        Caption = 'Reversed ATM Transactions';
                        RunObject = report "Reversed ATM Transactions";
                    }
                    action(pay2FOSA)
                    {
                        Caption = 'PaytoFOSA Transactions';
                        RunObject = report "PaytoFOSA Transactions";
                    }
                    action(paybillTrans)
                    {
                        Caption = 'Paybill Transactions';
                        RunObject = report "Paybill Transactions";
                    }
                    action(revPaybilltrans)
                    {
                        Caption = 'Reversed Paybill Transactions';
                        RunObject = report "Reversed Paybill Transactions";
                    }
                    action(mpesaWithdrawal)
                    {
                        Caption = 'Mpesa Withdrawals';
                        RunObject = report "Mobile Transactions";
                    }
                }
            }
            Group(SaccoPayroll)
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
                    action(PayrollDed)
                    {
                        Caption = 'Payroll Deductions';
                        RunObject = page "Payroll Deductions List.";
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
                group("Payroll Reports")
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
                    action("Send Payslips")
                    {
                        Caption = 'Send Payslip via Mail';
                        RunObject = report "Send Payslips Via Mail";
                    }
                }
            }
            group("File Movement")
            {
                action("FileMovement")
                {
                    Caption = 'New File Movement';
                    RunObject = page "File Movement List";
                }
            }
            group("Leave Management")
            {
                action("Leave Application")
                {
                    Caption = 'Leave Applications';
                    RunObject = page "HR Leave Applications List";
                    RunPageView = where(Status = filter(<> Approved), Posted = filter(false));
                }
                action("Leave Applications(Approved)")
                {
                    Caption = 'Leave Applications(Approved)';
                    RunObject = page "HR Leave Applications List";
                    RunPageView = where(Status = filter(Approved), Posted = filter(false));
                }
                action("Leave Applications(Posted)")
                {
                    Caption = 'Leave Applications(Posted)';
                    RunObject = page "Posted Leave Applications";
                }
            }
            group("Purchase Requisitions")
            {
                Caption = 'Purchase Requisitions';
                Image = Purchasing;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Requisitions)
                {
                    Caption = 'New Purchase Requisition';
                    RunObject = Page "Task Order";
                }
                action("Pending Purchase Requisition")
                {
                    Caption = 'Pending Purchase Requisition';
                    RunObject = Page "Pending Purchase Requisition";
                }
                action("Approved Purchase Requisition")
                {
                    Caption = 'Approved Purchase Requisition';
                    RunObject = Page "Posted Purchase Requisitions";
                }
                action("Completed Purchase Requisition")
                {
                    Caption = 'Completed Purchase Requisition';
                    RunObject = Page "Completed  Purchase Req.";
                }
            }
            group("User Management")
            {
                action("Change Password")
                {
                    RunObject = page "Password Dialog";
                }
            }
        }
        area(Embedding)
        {
            // action(EmbeddingAction)
            // {
            //     // RunObject = Page ObjectName;
            // }
        }
    }
}
profile "Finance Role Center"
{
    Caption = 'Accounts Profile';
    RoleCenter = "Finance Role Center";
    ProfileDescription = 'Role Center tailored to the Finance and Accounts Department';
}


