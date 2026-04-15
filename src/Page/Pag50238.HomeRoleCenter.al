//************************************************************************
page 50238 "Home Role Center" // default role center change to comapny name
{
    ApplicationArea = All;
    Caption = 'Home ';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(MembershipDashboard; "Membership Processor")
            {
                Caption = 'Membership';
                Visible = true;
                //Caption='Navigate';
            }

            part(CreditDashboard; "Credit Processor Role")
            {
                Visible = true;
                //Caption='Navigate';
            }
            //"Credit Processor Role"
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
            part(EmailActivities; "Email Activities")
            {
                Visible = true;
            }
            //Membership Cue//
            part("User Tasks Activities"; "User Tasks Activities")
            {
            }
            // part("Emails"; "Email Activities")
            // {
            // }
            part(Control123; "Team Member Activities")
            {
            }
            part(Control1907692008; "My Accounts")
            {
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                Visible = false;
            }
            part(Control106; "My Job Queue")
            {
                // Visible = false;
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
            systempart(Control1901377608; MyNotes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("Membership Reports")
            {
                action("Member Application Report")
                {
                    Caption = 'Member Application Report';
                    Image = "Report";
                    RunObject = Report "Members Applications List";
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("Member Status Report")
                {
                    Caption = 'Member Status Report';
                    Image = "Report";
                    // RunObject = Report CustomerDormantAccounts;
                    ToolTip = 'View, print, or send a report that shows the membership statuses.';
                }
                action("Member List Report")
                {
                    Caption = 'Member List Report';
                    Image = "Report";
                    RunObject = Report "Member List Report";
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("Member Savings Report")
                {
                    Caption = 'Member Savings Report';
                    Image = "Report";
                    RunObject = Report MemberSavings;
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
            }
            group("G/L Reports")
            {
                Caption = 'G/L Reports';
                action("&G/L Trial Balance")
                {
                    Caption = '&G/L Trial Balance';
                    Image = "Report";
                    RunObject = Report "Trial Balance";
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("&Bank Detail Trial Balance")
                {
                    Caption = '&Bank Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("&Account Schedule")
                {
                    Caption = '&Account Schedule';
                    Image = "Report";
                    RunObject = Report "Account Schedule";
                    ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
                }
                action("Bu&dget")
                {
                    Caption = 'Bu&dget';
                    Image = "Report";
                    RunObject = Report Budget;
                    ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
                }
                action("Trial Bala&nce/Budget")
                {
                    Caption = 'Trial Bala&nce/Budget';
                    Image = "Report";
                    RunObject = Report "Trial Balance/Budget";
                    ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("Trial Balance by &Period")
                {
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report "Trial Balance by Period";
                    ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
                }
                action("&Fiscal Year Balance")
                {
                    Caption = '&Fiscal Year Balance';
                    Image = "Report";
                    RunObject = Report "Fiscal Year Balance";
                    ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
                }
                action("Balance Comp. - Prev. Y&ear")
                {
                    Caption = 'Balance Comp. - Prev. Y&ear';
                    Image = "Report";
                    RunObject = Report "Balance Comp. - Prev. Year";
                    ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
                }
                action("&Closing Trial Balance")
                {
                    Caption = '&Closing Trial Balance';
                    Image = "Report";
                    RunObject = Report "Closing Trial Balance";
                    ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
                }
                action("Dimensions - Total")
                {
                    Caption = 'Dimensions - Total';
                    Image = "Report";
                    RunObject = Report "Dimensions - Total";
                    ToolTip = 'View how dimensions or dimension sets are used on entries based on total amounts over a specified period and for a specified analysis view.';
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';
                action("Cash Flow Date List")
                {
                    Caption = 'Cash Flow Date List';
                    Image = "Report";
                    RunObject = Report "Cash Flow Date List";
                    ToolTip = 'View forecast entries for a period of time that you specify. The registered cash flow forecast entries are organized by source types, such as receivables, sales orders, payables, and purchase orders. You specify the number of periods and their length.';
                }
            }
            group("Member Accounts")
            {
                Caption = 'Members Accounts';
                action("Member List")
                {
                    Caption = 'Members List';
                    Image = "Report";
                    RunObject = Report "Member List";
                    ToolTip = 'View an overview of Member Accounts';
                }
                action("Loan Balances")
                {
                    Caption = 'Loan Balances';
                    Image = "Report";
                    RunObject = Report "Loans Register";
                    ToolTip = 'View an overview of loans';
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                action("Cost Accounting P/L Statement")
                {
                    Caption = 'Cost Accounting P/L Statement';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement";
                    ToolTip = 'View the credit and debit balances per cost type, together with the chart of cost types.';
                }
                action("CA P/L Statement per Period")
                {
                    Caption = 'CA P/L Statement per Period';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Stmt. per Period";
                    ToolTip = 'View profit and loss for cost types over two periods with the comparison as a percentage.';
                }
                action("CA P/L Statement with Budget")
                {
                    Caption = 'CA P/L Statement with Budget';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement/Budget";
                    ToolTip = 'View a comparison of the balance to the budget figures and calculates the variance and the percent variance in the current accounting period, the accumulated accounting period, and the fiscal year.';
                }
                action("Cost Accounting Analysis")
                {
                    Caption = 'Cost Accounting Analysis';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Analysis";
                    ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
                }
            }
        }
        area(embedding)
        {
            //Import Members
            //"Member Data Update"
            //"Update Member Data"
            //Import FOSA
            action("Import Member Ledger")
            {
                // RunObject = xmlport "Import Member Ledger Entries";/*005894*/
                RunObject = xmlport "Import Mobile Banking Members";
                Visible = false;
            }
            action("Import FOSA")
            {
                Caption = 'Import FOSA';
                RunObject = xmlport "Import FOSA";
                ToolTip = 'Open the chart of accounts.';
                Visible = false;
            }
            action("Import Vendor")
            {
                // Caption = 'Import FOSA';
                RunObject = xmlport "Import New Vendor";
                ToolTip = 'Open the chart of accounts.';
                Visible = false;
            }
            action("Import Vendor Ledger")
            {
                // Caption = 'Import FOSA';
                RunObject = xmlport ExportnondetVendLedg;
                ToolTip = 'Open the chart of accounts.';
                Visible = false;
            }
            action("Import Det Vendor Ledger")
            {
                // Caption = 'Import FOSA';
                RunObject = xmlport ExportDetVendLedg;
                ToolTip = 'Open the chart of accounts.';
                Visible = false;
            }
            action("Import Loan WriteOffs")
            {
                // Caption = 'Import FOSA';
                RunObject = xmlport "Import Written Off Loans";
                ToolTip = 'Open the chart of accounts.';
                Visible = false;
            }
            action("Import Members")
            {
                Caption = 'Import Members';
                RunObject = xmlport "Import Members";
                ToolTip = 'Open the chart of accounts.';
            }
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
            }
            action("Bank Accounts")
            {
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action(Members)
            {
                Caption = 'Members';
                Image = Customer;
                RunObject = Page "Members List";
                ToolTip = 'View or edit detailed information for the Members.';
            }
            action(FOSAAccounts)
            {

                Caption = 'FOSA Accounts';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the FOSA Savings Accounts.';
                Visible = false;
            }
            action(FOSAAccountsBalance)
            {

                Caption = 'FOSA Account Balances';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
                Visible = false;
            }
            action(OutstandingLoans)
            {
                Caption = 'Outstanding Loan Balances';
                Image = Balance;
                RunObject = Page "Loans  List All";
                RunPageView = WHERE("Outstanding Balance" = FILTER(<> 0));
                ToolTip = 'View a summary of the Outstanding Loan Balances In The Sacco.';
            }
            action("Receipts List")
            {
                Caption = 'View Posted Receipts';
                Image = Documents;
                RunObject = Page "Posted BOSA Receipts List";
                ToolTip = 'View Posted BOSA Receipts';
            }
        }
        area(sections)
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
                    Visible = false;
                    action("Deposit Return.")
                    {
                        Caption = 'Deposit Return SASRA';
                        RunObject = report "Deposit return";

                    }
                    action("Insider Lending.")
                    {
                        Caption = 'Insider Lending';
                        RunObject = report InsiderLending;

                    }
                    action("Risk Provisioning Report.")
                    {
                        Caption = 'Risk Provisioning Report';
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
                action(BankAccountReconciliations)
                {
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    RunObject = page "Bank Acc. Recon List Conv";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
                action("Bank Acc. Statements")
                {
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Bank Account Posting Groups")
                {
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }
                action(CashReceiptJournals)
                {
                    Caption = 'Cash Receipt Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
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
            }

            group(Marketing)
            {
                Caption = 'Marketing';

                action(CampaignList)
                {
                    Caption = 'Marketing Campaign List';
                    RunObject = Page "Marketing Campaign List";
                    ToolTip = 'Campaign List.';
                }

                action(EventList)
                {
                    Caption = 'Marketing Event List';
                    RunObject = Page "Marketing Event List";
                    ToolTip = 'Event List.';
                }
                action(MarketersCommissionList)
                {
                    Caption = 'Marketers Commission List';
                    RunObject = Page "Marketers Commission List";
                    ToolTip = 'Event List.';
                }



            }

            group(BusinessDevelopment)
            {
                Caption = 'Business Development';

                action(BDPartnerList)
                {
                    Caption = 'BD Partner List';
                    RunObject = Page "BD Partner List";
                    ToolTip = 'BD Partner List.';
                }
                action(BDOpportunityList)
                {
                    Caption = 'BD Opportunity List';
                    RunObject = Page "BD Opportunity List";
                    ToolTip = 'BD Opportunity List.';
                    Visible = false;
                }
                action(BDActivityLog)
                {
                    Caption = 'BD Activity Log';
                    RunObject = Page "BD Activity Log";
                    ToolTip = 'BD Activity Log.';
                }

            }
            group(Action994)
            {
                Caption = 'CRM';

                action("LeadsList(Portal)")
                {
                    Caption = 'Portal Leads';
                    RunObject = Page "Customer Contact List";
                    ToolTip = 'Portal Leads List.';
                }
                action(LeadsList)
                {
                    Caption = 'Assigned Leads List';
                    RunObject = Page "Customer Contact List";
                    ToolTip = 'Assigned Leads List.';
                }
                group("Case Management.")
                {
                    action("Case Registration.")
                    {
                        Caption = 'Case Enquiry Registration List';
                        Image = Capacity;
                        RunObject = page "Crm Log List";
                        ToolTip = 'Book a New Case enquiry';

                    }
                    action("Assigned Cases.")
                    {
                        Caption = 'Cases List';
                        Image = Capacity;
                        RunObject = page "Case Assigned  list";
                        ToolTip = 'New Cases';

                    }
                    action("Resolved Case Enquiries.")
                    {
                        Caption = 'Resolved Cases Enquiries';
                        Image = Capacity;
                        //RunObject = page resolved;
                        ToolTip = 'Resolved Cases Enquiries';

                    }
                    action("Resolved Cases.")
                    {
                        Caption = 'Resolved Cases';
                        Image = Capacity;
                        RunObject = page "Case Assigned  solved";
                        ToolTip = 'Resolved Cases';

                    }
                }
                group("CRM Gen Setup.")
                {
                    action("CRM General setup.")
                    {
                        Caption = 'CRM General Setup';
                        Image = Capacity;
                        RunObject = page "Crm Nos series Card";
                        ToolTip = 'CRM Setup';

                    }
                    action("CRM Case types.")
                    {
                        Caption = 'CRM Case types';
                        Image = Capacity;
                        RunObject = page "CRM Case Types";
                        ToolTip = 'CRM Case Types';

                    }
                }
            }
            group(Action84)
            {
                Caption = 'Membership Management';


                action(MembershipApp)
                {
                    Caption = 'Membership Application';
                    RunObject = Page "Membership Application List";
                    RunPageView = where(Created = filter(false));
                    ToolTip = 'Apply New Members.';
                }
                action(GroupApp)
                {
                    Caption = 'Group Application';
                    RunObject = Page "Group Applic List";
                    ToolTip = 'Apply New Members.';
                }
                action("Junior Account Application")
                {
                    Caption = 'Account Application';
                    Image = Customer;
                    RunObject = page "Member Account Application";
                    ToolTip = 'Open New membership products accounts Application.';

                }
                group("Member Accounts.")
                {
                    action(MembersList)
                    {
                        Caption = 'Member Accounts List';
                        RunObject = Page "Members List";
                        RunPageView = where(ISNormalMember = filter(true), "Employer Code" = filter(<> 'STAFF'));
                        ToolTip = 'Manage Member Accounts';
                    }
                    action(GroupList)
                    {
                        Caption = 'Group Accounts List';
                        RunObject = Page "Group List";
                        ToolTip = 'Manage Member Accounts';
                    }
                    action("Savings Accounts")
                    {
                        Caption = 'Junior Accounts';
                        Image = Customer;
                        RunObject = page "All Member Accounts List";
                        ToolTip = 'Open Members Saving Accounts';
                    }

                }


                group(ReportsMembership)
                {
                    caption = 'Membership Reports';

                    action(CreatedMembershipApp)
                    {
                        Caption = 'Created Membership Application';
                        RunObject = Page "Membership Application List";
                        RunPageView = where(Created = filter(true));
                    }
                    action(MemberListReport)
                    {
                        Caption = 'Membership Report';
                        RunObject = report "Membership Report";
                    }
                    action(MemberDetListReport)
                    {
                        Caption = 'Membership Detailed Report';
                        RunObject = report "Membership Detailed Report";
                    }
                    action(MemberReport)
                    {
                        Caption = 'Member list Report';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = report MemberDimensions;
                        Visible = false;
                    }
                    action(MemberStatusReport)
                    {
                        Caption = 'Member Status Report';
                        RunObject = report CustomerDormantAccounts;
                    }
                    action(ESSAndFosaSavingsAccount)
                    {
                        Caption = 'ESS & FOSA Savings Accs Report';
                        RunObject = report "ESS and Fosa Savings Account";
                        Visible = false;
                    }
                    action(NewMemberRegFee)
                    {
                        Caption = 'New Members';
                        RunObject = report "Members Paid Registration Fee";
                    }
                    action(MemberSavings)
                    {
                        Caption = 'Withdrawn Members';
                        Visible = false;
                        //  RunObject = report "Withdrawn Members";
                    }

                    action(MemberApplicationsList)
                    {
                        Caption = 'Member Application List';
                        Promoted = true;
                        PromotedCategory = Process;
                        Visible = false;

                        //  RunObject = report "Members Applications List";
                    }

                    action(MemberStatus)
                    {
                        Caption = 'Member Summary By Status';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = report "Member Summary By Status";
                        Visible = false;

                    }

                    action("Send Member Statement")
                    {
                        Caption = 'Send Member Statement';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = report "Send Member Statement";
                        Visible = false;

                    }

                }
                action(NOK)
                {
                    Caption = 'NOK Application List';
                    RunObject = Page "NOK Application List";
                    ToolTip = 'NOK Application List';
                    Visible = False;
                }
                action("Member Regions")
                {
                    RunObject = Page "Member Delegate Zones";
                }
                action(Designation)
                {
                    Caption = 'Designation List';
                    RunObject = Page "Designation List";
                    ToolTip = 'Designation List';
                    Visible = false;
                }

                action(Workstation)
                {
                    Caption = 'Workstation List';
                    RunObject = Page "WorkStation List";
                    ToolTip = 'Workstation';
                    Visible = false;
                }
                action(InsiderLending)
                {
                    Caption = 'Insider Lending';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Insider List";
                    ToolTip = 'Insider Lending members';
                    Visible = false;
                }
                action("Member Receipts List")
                {
                    Caption = 'Member Receipts List';
                    Image = Documents;
                    RunObject = Page "BOSA Receipts List";
                    ToolTip = 'View Member Receipts';
                }
                group(ChangeRequest)
                {
                    Caption = 'Change Request';
                    action("Change Request")
                    {
                        Caption = 'Change Request List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Change Request List";
                        ToolTip = 'Change Member Details';
                    }

                    group(EffectedChangeReqs)
                    {
                        Caption = 'Effected Change Requests';
                        action(updatedchangereqslist)
                        {
                            Caption = 'Updated Change requests';
                            RunObject = page "Updated Change Request List";
                        }
                    }
                    group(ReportsChangereq)
                    {
                        caption = 'Reports Change Request';
                        action(StatusChangeRequest)
                        {
                            Caption = 'Status Change Request';
                            RunObject = report "Member Status Change Request";
                        }
                    }
                }
                group("Membership Closure")
                {
                    Caption = 'Membership Exit';
                    group(ESSRefundProcess)
                    {
                        Caption = 'ESS Refund';
                        Visible = false;
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
                        }
                        action(ESSRefundBatch)
                        {
                            Caption = 'ESS Refund Batch';
                            RunObject = page "ESS Refund Batch List";
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
                        Visible = false;

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
                    action("Notice List")
                    {
                        Caption = 'New Exits List';
                        RunObject = page "Notice List";
                    }
                    action("Registered Exits List")
                    {
                        Caption = 'Registered Exits';
                        RunObject = page "Registered Notice List";
                    }
                    action("Matured Notice List")
                    {
                        Caption = 'Matured Exits List';
                        RunObject = page "Matured Notice List";
                        Visible = False;
                    }
                    action("Membership Exit")
                    {
                        Caption = 'Membership Exit';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Membership Exit List";
                    }
                    action("Exit Member Batch List")
                    {
                        Caption = 'Member Exit Batch List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Member Exit Batch List";
                    }
                    action("Membership Exit(Posted)")
                    {
                        Caption = 'Posted Membership Exits';
                        RunObject = page "Posted Membership Exit List";
                    }
                    action("Exit Refund Report")
                    {
                        Caption = 'Member Refund Progress';
                        RunObject = report "Member Deposit Refund Progress";
                    }
                }
                group("BOSA Receipt")
                {
                    Caption = 'Members Receipts';
                    Image = Receivables;
                    ToolTip = 'Member Receipting Process.';

                    action("BOSA Receipts")
                    {
                        Caption = 'New Receipts';
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
                        Visible = false;
                    }

                    action("Account Transfers")
                    {
                        Caption = 'Account Transfer List';
                        Image = Receipt;
                        RunObject = page "BOSA Transfer List";
                        ToolTip = 'New Member Account Transfer for payments done.';

                    }
                    action("Posted Member Receipts")
                    {
                        Caption = 'Posted Member Receipts';
                        Image = PostedReceipt;
                        RunObject = page "Posted BOSA Receipts List";
                        ToolTip = 'New Member Receipts for payments done.';

                    }
                }
                group("Sacco Transfer")
                {
                    caption = 'Sacco Transfer';
                    Visible = false;
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
                group(UFAA)
                {
                    Caption = 'UFAA';
                    Visible = false;
                    action("UFAA List")
                    {
                        caption = 'UFAA List';
                        Image = List;
                        RunObject = page "UFAA List";
                    }
                }

                action("Employers")
                {
                    caption = 'Employers List';
                    Image = List;
                    Visible = false;
                    RunObject = page "Employers List";
                }
            }

            group("Saving Products Management")
            {
                Caption = 'Saving Products Management';
                Image = Bank;
                Visible = false;

                ToolTip = 'Manage Saving Accounts Eg. FOSA Savings and Fixed Deposits';
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
                group("FOSA Accounts")
                {
                    Caption = 'Accounts List';
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
                    action("Mdosi Jr Accounts")
                    {
                        // Caption = 'Non-Active Member Savings Accounts';
                        Image = BusinessRelation;
                        RunObject = page "Business Stores";
                        Visible = false;
                        // ToolTip = 'Open Members'' FOSA Accounts';
                    }

                }

                group("Standing Orders ")
                {
                    Caption = 'Standing Orders';
                    Visible = false;
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
                group("Checkoff Proccessing ")
                {
                    Caption = 'Checkoff';
                    Visible = false;
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
                    group("Savings Variation")
                    {
                        action("NewSavingsVar")
                        {
                            Caption = 'New Savings Variation';
                            Image = Account;
                            RunObject = page "Savings Variations List";
                            RunPageView = where("Approval Status" = filter(New));
                        }
                        action("SavingsVar")
                        {
                            Caption = 'Savings Variation - Approval';
                            Image = Account;
                            RunObject = page "Savings Variations List";
                            RunPageView = where("Approval Status" = filter(<> New), updated = filter(false));
                        }
                        action("Posted SavingsVar")
                        {
                            Caption = 'Posted Savings Variation';
                            Image = Account;
                            RunObject = page "Savings Variations List";
                            RunPageView = where(updated = filter(true));
                        }
                    }
                }

                group("Salary Proccessing ")
                {
                    Caption = 'Salary Processing';
                    Visible = false;
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
                    Visible = false;
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
                    Visible = false;
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
                        RunObject = Page "Cheque Register";
                    }

                }
                group("Piggy Banks")
                {
                    Caption = 'Piggy Bank Issuing';
                    Visible = false;
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
                    Visible = false;
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
                group("Cheque Setup")
                {

                    Caption = 'Cheque Setup';
                    Visible = false;
                    action(Chequesetuplist)
                    {
                        Caption = 'Cheque Setup';
                        RunObject = page "Cheque Register List";

                    }
                }
                group("Overdraft Loans")
                {
                    Caption = 'Overdraft Loan Management';
                    Visible = false;
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
                    Visible = false;
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
                    //Visible=false;
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
                            Caption = 'Account Balances';
                            RunObject = report "FOSA Savings Accounts Balances";
                        }
                        action("Accounts Balances")
                        {
                            // Visible = false;
                            Caption = 'All Accounts Balances';
                            RunObject = report "Account Balances";
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
                        action("MDOSI Junior Listing")
                        {
                            // Caption = 'Accounts Listing';
                            RunObject = report "Accounts Listing";
                            Visible = false;
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
                        action(SalEarnersNoDeposits)
                        {
                            Visible = false;
                            Caption = 'Salary Earners with No Deposits';
                            RunObject = report "Dormant Members With Salary";
                        }
                        action("Active Accounts with No Deposits")
                        {
                            Visible = false;
                            Caption = 'Active Accounts with No Deposits';
                            RunObject = report "Active Accounts No Deposits";
                        }
                        action("Fixed Deposit Tracking")
                        {
                            Visible = false;
                            Caption = 'Fixed Deposit Tracking';
                            RunObject = report "Fixed Deposits Tracking Report";
                        }
                        action("Overdrawn Accounts")
                        {
                            Visible = false;
                            Caption = 'Overdrawn Accounts';
                            RunObject = report "The Overdrawn Accounts";
                        }
                        action("Negative Balances")
                        {
                            Visible = false;
                            Caption = 'Negative Balances';
                            RunObject = report NegativeBalances;
                        }
                    }
                    group("Transactions")
                    {
                        Caption = 'Transactions Reports';
                        Visible = false;
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
                        Visible = false;
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
                        Visible = false;
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

            group("Loans Management")
            {
                Caption = 'Loans Management';
                Image = CreditCard;
                ToolTip = 'Loans'' Management Module';
                group("BOSA Loans Management")
                {
                    Caption = 'Loan Management';
                    ToolTip = 'Loans Management Module';
                    action("BOSA Loan Application")
                    {
                        Caption = 'Loan Application';
                        Image = CreditCard;
                        RunObject = Page "Loan Application BOSA(New)";
                        ToolTip = 'Open Loan Applications';//
                    }
                    action("Loans Under Appraisal")
                    {
                        Caption = 'Loans Pre-Appraisal';
                        Image = CreditCard;
                        RunObject = Page "Loan Appraisal List";
                        ToolTip = 'Loans Under Pre-Appraisal List';
                    }
                    action("Loans Under Valuation")
                    {
                        Caption = 'Valuation Stage';
                        Image = CreditCard;
                        RunObject = Page "Loans Under Valuation";
                        ToolTip = 'Loans in Valuation Stage';
                    }
                    action("Loans In Credit Committee")
                    {
                        Caption = 'Technical Credit Committee';
                        Image = CreditCard;
                        RunObject = Page "Credit Committee List";
                        ToolTip = 'Loans In Credit Committee List';
                    }
                    action("Pending BOSA Loan Application")
                    {
                        Caption = 'Loans Pending Approval';
                        Image = CreditCard;
                        RunObject = Page "Loans  List- pending approval";
                        ToolTip = 'Open the list of Loans Pending Approval.';
                    }
                    action("TCC Approved Loans")
                    {
                        Caption = 'Approved Loans';
                        Image = CreditCard;
                        RunObject = Page "Approved TCC List";
                        ToolTip = 'Open the list of Approved Loans.';
                    }
                    action("Loans Under Charging Process")
                    {
                        Caption = 'Loans Under Charging Process';
                        Image = CreditCard;
                        RunObject = Page "Legal List";
                        ToolTip = 'Loans Under Charging Process List';
                    }

                    action("Pending Mobile Loans")
                    {
                        Caption = 'Pending Mobile Loans';
                        Visible = false;
                        Image = CreditCard;
                        RunObject = Page "Mobile Loans Pending";
                        RunPageView = where(Posted = filter(false), "Approval Status" = filter(Pending), "Requires Guarantors Mobile" = filter(true), "Archive Loan" = filter(false));
                        ToolTip = 'Pending Mobile Loans';
                    }
                    action("Portal Loans")
                    {
                        Caption = 'Portal Loans';
                        Image = CreditCard;
                        Visible = false;
                        RunObject = Page "Mobile Loans Pending";
                        RunPageLink = "Loan Application Mode" = filter(Portal);
                        ToolTip = 'All Portal Applied Loans';
                    }
                    action("Approved Loans")
                    {
                        Caption = 'Loans In Finance';
                        RunObject = Page "Loans Application List(Approv)";
                        ToolTip = 'Open the list of Approved Loans Pending Disbursement.';
                    }
                    action("Tranche List")
                    {
                        Caption = 'Tranche Disbursement List';
                        RunObject = Page "Tranche Register List";
                        ToolTip = 'Open the list of Tranche Disbursement.';
                    }
                    action("Express Batch List")
                    {
                        Visible = false;
                        RunObject = page "Loans Disbursment  List Exp";
                        Caption = 'Loan Batch List(Express)';

                    }
                    action("Canceled Loans")
                    {
                        Caption = 'Canceled Loans';
                        RunObject = Page "Canceled Loans";
                        ToolTip = 'Open the list of the Loans Canceled.';
                    }
                    action("Disapproved Loans")
                    {
                        Caption = 'Disapproved Loans';
                        RunObject = Page "Rejected Loans";
                        ToolTip = 'Open the list of the Loans Disapproved.';
                    }


                    group("Posted Loans")
                    {
                        Caption = 'Posted Loans';
                        action(RunningLoans)
                        {
                            Caption = 'Running Loans';
                            RunObject = Page "Uncleared Loans Posted List";
                            ToolTip = 'Open the list of the Loans Posted.';
                        }
                        action(ClearedLoans)
                        {
                            Caption = 'All Loans';
                            RunObject = Page "Cleared Loans Posted List";
                            ToolTip = 'Open the list of the Loans Posted.';
                        }
                        action(loansPerformance)
                        {
                            Caption = 'Loans Performance List';
                            RunObject = Page "Performance List";
                            ToolTip = 'Open the Performance List.';
                            Visible = false;
                        }


                    }
                    action("Posted Batches")
                    {
                        Caption = 'Posted Batches';
                        RunObject = Page "Posted Loan Batch - List";
                        ToolTip = 'Open the list of the Loans Posted.';
                        Visible = false;
                    }
                    action("Rejected Batch List")
                    {
                        RunObject = page "Rejected Loans Disburse Batch";
                        Caption = 'Rejected Loan Batch List';
                        Visible = false;
                    }
                    action("Collateral Register")
                    {
                        Caption = 'Collateral Register';
                        RunObject = Page "Loan Collateral Register List";
                        ToolTip = 'Open Collaterals.';
                        Visible = false;
                    }
                    action("Data Sheet Main")
                    {
                        Caption = 'Data Sheet Main';
                        RunObject = Page "Data Sheet Main";
                        ToolTip = 'Data Sheet Main';
                        Visible = false;
                    }
                }
                group("CRB List")
                {
                    Visible = false;
                    action("CRB List2")
                    {
                        Caption = 'CRB List';
                        RunObject = page "CRBA List";
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
                    action("Loan Defaulted List Guar")
                    {
                        Caption = 'Loan Defaulted List Report-Guarantors';
                        RunObject = report "Loan Defaulters List2";
                    }
                    action("Loan Defaulted List")
                    {
                        Caption = 'Loan Defaulted List Report';
                        RunObject = report "Loan Defaulters List NonGuar";
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
                        Visible = false;
                    }
                    action("Portfolio At Risk")
                    {
                        Caption = 'Portfolio At Risk';
                        RunObject = page "Portfolio at Risk";
                        Visible = false;
                    }
                    action("Loans Member Registration")
                    {
                        Caption = 'Loans Member Registration Report';
                        RunObject = report "Loans Member Registration";
                        Visible = false;
                    }

                    action("Loans Variances")
                    {
                        Caption = 'Loans Variances';
                        RunObject = report "Loans Variances";
                        Visible = false;
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
                        Visible = false;
                    }
                    action("Loan Expectation Monthly")
                    {
                        Caption = 'Loan Expectation Monthly';
                        RunObject = report "Loans Monthly Expectation Ver1";
                    }
                    action("Loans Under Recovery")
                    {
                        Caption = 'Loans Under Recovery Report';
                        // RunObject = report "Loans Under Recovery Report";
                        Visible = false;
                    }
                    action("PRD Report")
                    {
                        Caption = 'PRD Report';
                        RunObject = report "PRD Report";
                        Visible = false;
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
                        Visible = false;
                    }
                    group("CIC")

                    {
                        Visible = false;
                        action("Loan Guard Details")
                        {
                            Caption = 'Loans Guard Report';
                            RunObject = report "Loans Guard Report";
                        }
                        action("Next of Kin Details")
                        {
                            Caption = 'Next of Kin Report';
                            RunObject = report "Next of Kin Details";
                        }
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
                        Visible = false;
                    }
                    action("Membership Exit Report")
                    {
                        Caption = 'Membership Exit Report';
                        RunObject = report "Membership Exit Report";
                    }
                    action("Update Loans")
                    {
                        Caption = 'Update Loans';
                        Image = "Report";
                        Visible = false;
                        RunObject = Report UpdateLoanStatus;
                        //  ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
                    }
                    group("SASRA Reports")
                    {
                        Visible = false;
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
                    action("Loan Classification Process")
                    {
                        Caption = 'Loan Classification As At';
                        RunObject = report "Loans Defaulter Aging CPY";
                    }
                }
                group("FOSA Loans MAnagement")
                {

                    Caption = 'FOSA Loan Management';
                    Visible = false;
                    ToolTip = 'FOSA Loans'' Management Module';

                    action("New FOSA Loans")
                    {
                        Caption = 'New FOSA Loans.';
                        RunObject = Page "Loan Application FOSA(New)";
                        ToolTip = 'Open new FOSA Loan Applications';
                    }

                    action("Pending FOSA Loans")
                    {
                        Caption = 'Pending FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Pending)";
                        ToolTip = 'Open Pending FOSA Loan Applications';
                    }
                    action("Approved FOSA Loans")
                    {
                        Caption = 'Approved FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Approv)";
                        ToolTip = 'Approved Pending FOSA Loan Applications';
                    }
                    action("Posted FOSA Loans")
                    {
                        Caption = 'Posted FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Posted)";
                        ToolTip = 'Open Posted FOSA Loan Applications';
                    }
                }
                group(loanssetup)
                {
                    Caption = 'Loans Setup';
                    action(LoansproductSetup)
                    {
                        Caption = 'Loans Product Setup';
                        Image = Setup;
                        RunObject = page "Loan Products Setup List";
                    }
                    action(kpiperformanceSetup)
                    {
                        Caption = 'Performance Setup';
                        Image = Setup;
                        RunObject = page "KPI Setup List";
                    }
                    action(LoanStages)
                    {
                        Caption = 'Loan Stages';
                        Image = Setup;
                        RunObject = page "Loan Stages";
                        Visible = false;
                    }
                    action(CreditOfficers)
                    {
                        Caption = 'Credit Officers';
                        Image = Setup;
                        RunObject = page "Credit/Field Officers";
                        Visible = false;
                    }
                }
                group(Collateralmgmt)
                {
                    Caption = 'Collateral Management';
                    action(CollateralSetup)
                    {
                        Caption = 'Loan Collateral Setup';
                        Image = Register;
                        RunObject = page "Loan Collateral Setup";
                    }
                    action(Collateralreg)
                    {
                        Caption = 'Loan Collateral Register';
                        Image = Register;
                        RunObject = page "Loan Collateral Register List";
                    }
                    action(Collateralmvmt)
                    {
                        Caption = 'Loan Collateral Movement';
                        RunObject = page "Collateral Movement List";
                    }
                    group(CollateralReports)
                    {
                        Caption = 'Collateral Movement';
                        action(ColateralsReport)
                        {
                            Caption = 'Collateral Report';
                            //  RunObject = report "Collaterals Report";
                        }

                    }
                    group(ArchiveCollateral)
                    {
                        Caption = 'Archive';
                        action(Effectedcollatmvmt)
                        {
                            Caption = 'Effective Collateral Movement';
                            RunObject = page "Effected Collateral Movement";
                        }
                    }
                }

                group(DebtPortfolioManagement)
                {
                    Caption = 'Debt Portfolio Management';
                    action(Caselist)
                    {
                        Caption = 'Un-Assigned Portfolios';
                        Image = Register;
                        RunObject = page "Defaulter Case List";
                    }
                    action(MyPortfolio)
                    {
                        Caption = 'My Portfolio';
                        Image = Register;
                        RunObject = page "My Loan Portflolio";
                    }
                    action(MyFollowUp)
                    {
                        Caption = 'My Follow Up';
                        Image = Register;
                        RunObject = page "Followup List";
                    }
                }
                group("Defaulter Management")
                {
                    Visible = false;
                    group("DebtManagement")
                    {
                        Caption = 'Debt Portfolio Management';
                        Visible = false;
                        action(PostedLoans)
                        {
                            Caption = 'Loans Posted List';
                            RunObject = page "Loans Posted List";
                        }
                        action(DefaultedLoans)
                        {
                            Caption = 'Defaulted Loans List';
                            RunObject = page "Loan Defaulted List";
                        }
                        action(DefaultCaselistEnd)
                        {
                            Caption = 'Defaulter Case List';
                            RunObject = page "Defaulter Case List";
                        }
                        action(WrittedOffLoans)
                        {
                            Caption = 'Written-Off Loans List';
                            RunObject = page "WrittenOff Loans List";
                        }
                        action(LoanRescheduling)
                        {
                            Caption = 'Loan Rescheduling';
                            RunObject = page "Loan Reschedule List";
                        }
                        action(SmsNotificatioDebt)
                        {
                            Caption = 'Defaulter SMS Notification';
                            RunObject = page "Defaulter SMS Notification";
                        }

                        group(DebtAdministration)
                        {
                            caption = 'Administration';
                            action(CollectorsAdministration)
                            {
                                Caption = 'Debt Collectors List';
                                RunObject = page "Debt Collectors List";
                            }
                        }
                    }
                    group(loanRecovery)
                    {
                        Caption = 'Loan Recovery';
                        Visible = false;
                        action(GuarantorSubstitution)
                        {
                            Caption = 'Guarantor Substitution List';
                            RunObject = page "Guarantorship Sub List";
                            RunPageView = where(Substituted = filter(false));
                            Visible = false;
                        }
                        action(PostedGuarantorSubstitution)
                        {
                            Caption = 'Posted Guarantor Substitution List';
                            RunObject = page "Guarantorship Sub List";
                            RunPageView = where(Substituted = filter(true));
                            Visible = false;
                        }
                        action(LoanRecovList)
                        {
                            Caption = 'Loan Recovery List';
                            RunObject = page "Loan Recovery List";
                        }
                        action(LoanRecoveryApprov)
                        {
                            Caption = 'Approved Loan Recovery';
                            runobject = page "Loan Recovery - Approved";
                        }
                        action(LoanRecoveryPosted)
                        {
                            Caption = 'Posted Loan Recovery';
                            RunObject = page "Posted Guar Recovery List";
                        }
                    }
                    group(demandnotices)
                    {
                        caption = 'Demand Notices';
                        action(LoanDemandnoticeslist)
                        {
                            caption = 'Loan Demand Notices List';
                            RunObject = page "Loan Demand Notices List";
                        }
                        group(DemnandTask)
                        {
                            Caption = 'Create Demand Notices';
                            action(CreateDemand)
                            {
                                Caption = 'Create Demand';
                                //   RunObject = report "Create Demand Notices";
                                Image = Report2;
                            }
                        }
                        group(DemandReports)
                        {
                            action(Ldemandnotice)
                            {
                                Caption = 'Loan Demand Notice';
                                //   RunObject = report "Loan Demand Notice";
                                Image = Report;
                            }
                            action(LcrbNotice)
                            {
                                Caption = 'Loan CRB Notice';
                                //    RunObject = report "Loan CRB Notice";
                                Image = Report;
                            }
                        }
                    }
                }

            }

            group("Debentures")
            {
                Caption = 'Debenture Management';
                ToolTip = 'Open Fixed Deposit''s Submodule';
                //Visible = false;

                // Caption = 'Fixed Deposit';
                action("Created Debenture Acc List")
                {
                    Caption = 'Debenture Accounts List';
                    RunObject = page "Debenture Accounts List";
                    ToolTip = 'Open Debenture Accounts List';
                }
                action("Created Fixed Deposits Acc List")
                {
                    Caption = 'Create Debenture';
                    RunObject = page "Fixed deposit list";
                    ToolTip = 'Open New Debentures';
                }
                action("Placed Fixed Deposits Acc List")
                {
                    Caption = 'Placed Debentures List';
                    RunObject = page "Credited Fixed deposit list";
                    ToolTip = 'Open Credited Debentures';
                }
                action("Matured Fixed Deposits Acc List")
                {
                    Caption = 'Matured Debentures List';
                    RunObject = page "Matured  Fixed deposit list";
                    ToolTip = 'Open Matured Debentures';
                }
                action("Revoked Fixed Deposits Acc List")
                {
                    Caption = 'Revoked Debentures';
                    RunObject = page "Revoked Fixed Deposit List";
                    ToolTip = 'Open Revoked Debentures';
                }

                action("Placed FD Acc List")
                {
                    Caption = 'Debenture Register';
                    RunObject = page "Fixed Deposit Placement List";
                    ToolTip = 'Open Already Placed Debentures, acting as a registry of sorts.';
                }

                group(Call)
                {
                    Caption = 'Call Deposit';
                    Visible = false;
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

                action("Fixed Deposits Setup")
                {
                    Caption = 'Debenture Types';
                    Image = Account;
                    // Visible = false;
                    RunObject = page "Fixed deposit Types list";
                    ToolTip = 'Open Fixed Deposits'' Types';

                }
                action("Fixed Deposits interest")
                {
                    Caption = 'Debenture Interest';
                    Image = Account;
                    RunObject = page "Fixed Deposit Interest Rates";
                    Visible = false;
                    ToolTip = 'Open Fixed Deposits'' Interest Rates';
                }
                action("Member Transaction List")
                {
                    Caption = 'Member Transaction List';
                    Image = Account;
                    Visible = false;
                    RunObject = page "Member Transaction List";
                    ToolTip = 'Open Member Transaction List';
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
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Fixed Assets G/L Journals")
                {
                    Caption = 'Fixed Assets G/L Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                }
                action("Fixed Assets Journals")
                {
                    Caption = 'Fixed Assets Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
                action("Fixed Assets Reclass. Journals")
                {
                    Caption = 'Fixed Assets Reclass. Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                }
                action(Insurance)
                {
                    Caption = 'Insurance';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                }
                action("Insurance Journals")
                {
                    Caption = 'Insurance Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                }
                action("Recurring Fixed Asset Journals")
                {
                    Caption = 'Recurring Fixed Asset Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
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
                // action("Posted Cash Payment")
                // {

                //     Caption = 'Posted Cash Payment Vouchers';
                //     Image = Check;
                //     RunObject = page "Posted Cash Payment Vouchers";
                //     ToolTip = 'Posted Cheque Payment';
                // }
                // action("FOSA Payment")
                // {

                //     Caption = 'FOSA Payment Vouchers ';
                //     Image = Check;
                //     RunObject = page "FOSA Payment Voucher List";
                //     ToolTip = 'Payment Voucher List.';
                // }
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
                action("BOD Honoraria")
                {
                    Image = PostedOrder;
                    RunObject = page "BOD Payments";
                    Visible = false;
                }
                action("Delegate Allowance")
                {
                    Image = PostedOrder;
                    RunObject = page "Sacco Meetings Allow Expected";
                    Visible = false;
                }
                action("Tarrif Codes")
                {
                    Caption = 'Tarrif Codes ';
                    Image = PostedOrder;
                    RunObject = page "Tarrif Codes";
                    Visible = false;
                    // ToolTip = 'Posted Receipt Header List ';
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
                action("Funds User Setup")
                {

                    Caption = 'Funds User Setup ';
                    Image = Check;
                    RunObject = page "Funds User Setup";
                    ToolTip = 'Funds User Setup';
                }
                action("Receipt and Payment Types List")
                {

                    Caption = 'Receipt and Payment Types List';
                    Image = Setup;
                    RunObject = page "Receipt and Payment Types List";
                    ToolTip = 'Receipt and Payment Types List';
                }
            }

            group("Banking Services")
            {
                Visible = false;
                action("Cashier Transactions")
                {
                    Caption = 'cashier transactions';
                    Image = Payment;
                    RunObject = page "Cashier Transactions - List";
                    ToolTip = 'cashier transaction list';
                }
                action("banking Setup")
                {
                    Caption = 'Transaction Type - List';
                    Image = Setup;
                    RunObject = page "Transaction Type - List";
                    ToolTip = 'Transaction Type - List';
                }
            }
            group(SaccoCRM)
            {
                Caption = 'SACCO CRM';
                Visible = false;
                group("Case Management")
                {
                    action("Case Registration")
                    {
                        Caption = 'Case Enquiry Registration List';
                        Image = Capacity;
                        RunObject = page "Crm Log List";
                        ToolTip = 'Book a New Case enquiry';

                    }
                    action("Assigned Cases")
                    {
                        Caption = 'Cases List';
                        Image = Capacity;
                        RunObject = page "Case Assigned  list";
                        ToolTip = 'New Cases';

                    }
                    action("Resolved Case Enquiries")
                    {
                        Caption = 'Resolved Cases Enquiries';
                        Image = Capacity;
                        //RunObject = page resolved;
                        ToolTip = 'Resolved Cases Enquiries';

                    }
                    action("Resolved Cases")
                    {
                        Caption = 'Resolved Cases';
                        Image = Capacity;
                        RunObject = page "Case Assigned  solved";
                        ToolTip = 'Resolved Cases';

                    }
                }
                group("CRM Gen Setup")
                {
                    action("CRM General setup")
                    {
                        Caption = 'CRM General Setup';
                        Image = Capacity;
                        RunObject = page "Crm Nos series Card";
                        ToolTip = 'CRM Setup';

                    }
                    action("CRM Case types")
                    {
                        Caption = 'CRM Case types';
                        Image = Capacity;
                        RunObject = page "CRM Case Types";
                        ToolTip = 'CRM Case Types';

                    }
                }

            }

            group("Dividends Processing")
            {
                action("Process Dividends")
                {
                    Caption = 'Process Dividends';
                    //  Visible = false;
                    RunObject = report "Generate Dividend Prorated Kit";
                }

                action("Process Dividends PCK")
                {
                    Caption = 'Process Dividends PCK';
                    Visible = false;
                    RunObject = report "Generate Dividend Prorated PCL";
                }
                action("Process Dividends Pensioner")
                {
                    Caption = 'Process Dividends Pensioner';
                    Visible = false;
                    RunObject = report "Generate Dividend Penpc";
                }
                action("Generate Dividend Prorated")
                {
                    Caption = 'Generate Dividend Prorated';
                    RunObject = report "Dividend Prorated New";
                    Visible = false;
                }

                action("Generate Dividend Flatrate")
                {
                    Caption = 'Generate Dividend Flatrate';
                    RunObject = report "Generate Dividend FlatRate";
                    Visible = false;
                }
                action("Dividends Register")
                {
                    Caption = 'Dividends Register List';
                    RunObject = page "Dividend Register";
                }
                action("Coop Dividends")
                {
                    Caption = 'Coop Dividend';
                    RunObject = page "Coop Dividends List";
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
                    Visible = false;
                }
                action("Send  Dividend SMS")
                {
                    Caption = 'Send  Dividend SMS';
                    RunObject = report "Generate Dividend SMS";

                }
                action("Dividends Register Report ")
                {
                    Caption = 'Dividends Register Report';
                    RunObject = report "Dividends Register";
                    // Visible = false;
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
                    action(PendingPaybill)
                    {
                        Caption = 'Pending Paybill Transactions';
                        RunObject = page "Paybill Transactions";
                        RunPageView = where(Status = filter(Pending));
                    }
                    action(UnpostedPaybill)
                    {
                        Caption = 'Failed Paybill Transactions';
                        RunObject = page "Paybill Transactions";
                        RunPageView = where(Status = filter(Failed));
                    }
                    action(PostedPaybill)
                    {
                        Caption = 'Posted Paybill Transactions';
                        RunObject = page "Posted Paybill Transactions";
                    }
                }
                Group("PaytoFOSA Transactions")
                {
                    Visible = false;
                    action(PendingPaytoFOSA)
                    {
                        Caption = 'Pending PaytoFOSA Transactions';
                        RunObject = page "PaytoFOSA Transactions";
                        RunPageView = where(Status = filter(Pending));
                    }
                    action(UnpostedPaytoFOSA)
                    {
                        Caption = 'Failed PaytoFOSA Transactions';
                        RunObject = page "PaytoFOSA Transactions";
                        RunPageView = where(Status = filter(Failed));
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
                    action("Investment AU Setup")
                    {
                        Caption = 'Investment Setup';
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
                    // action()
                    // {
                    //     RunObject = report 
                    // }
                }

            }

            group("Audit Trail")
            {
                group("User Trail")
                {
                    action("Audit Trail List")
                    {
                        Caption = 'User Trail List';
                        RunObject = page "Audit Trail Entries";
                    }
                    action("User System Trail")
                    {
                        Caption = 'User''s Access to the System';
                        RunObject = page "User Time Registers";
                    }
                }
                action("Changelog Entries")
                {
                    Caption = 'Changelog Entries';
                    RunObject = page "Change Log Entries";
                }

                Group("Effected Changes")
                {
                    action("Effected Changes List")
                    {
                        Caption = 'Effected Changes';
                        RunObject = page "Updated Change Request List";
                    }
                    action("Effected Changes Report")
                    {
                        Caption = 'Effected Changes Report';
                        RunObject = report "Member Status Change Request";
                    }
                }

                action("Posted Internal Transfer List")
                {
                    Caption = 'Posted Internal Transfer List';
                    RunObject = page "Posted Internal Transfer List.";
                }

                action("Posted Receipts")
                {
                    Caption = 'Posted Receipts';
                    RunObject = page "Posted BOSA Receipts List";
                }

                action("Posted Cashier Transactions")
                {
                    Caption = 'Posted Cashier Transactions';
                    RunObject = page "Posted Cashier Transactions";
                }
                action("Posted Loans.")
                {
                    Caption = 'Posted Loans';
                    RunObject = page "Loans Posted List";
                }
                action("Posted Loan Batches.")
                {
                    Caption = 'Posted Loan Batches.';
                    RunObject = page "Posted Loan Batch - List";
                }

                action("Posted Membership Withdrawals")
                {
                    Caption = 'Posted Membership Withdrawals';
                    RunObject = page "Posted Member Withdrawal List";
                }
                action("Full Member List")
                {
                    Caption = 'Full Member List';
                    RunObject = report "Full Member Listing";
                }
                action("Full Loan List")
                {
                    Caption = 'Full Loan List';
                    RunObject = report "Full Loans Register Listing";
                }
                group("Audit Trail Reports")
                {
                    action("LoansIntVarReport")
                    {
                        Caption = 'Interest Variance on Loans Report';
                        RunObject = report "Interest on Loans Variance";
                    }
                    action("Over Guaranteed Members")
                    {
                        Caption = 'Over Guaranteed Members';
                        Image = "Report";
                        RunObject = Report "Over-Guaranteed Members";
                    }
                    action("Members Below Min Shares")
                    {
                        Caption = 'Members Below Min. Share Capital';
                        Image = "Report";
                        RunObject = Report "Members Below Min. Share Cap";
                    }
                    action("Members No Active Loans")
                    {
                        Caption = 'Members with no currently servicing loans';
                        Image = "Report";
                        RunObject = Report "Members with no Running Loans";
                    }
                    action("Under-Guaranteed Loans")
                    {
                        Caption = 'Under-guaranteed Loans';
                        Image = "Report";
                        RunObject = Report "Under-Guaranteed Loans";
                    }
                }
            }

            group("Human Resource Management")
            {
                action("Hr Employee List")
                {
                    Caption = 'Hr Employee List';
                    Image = Employee;
                    RunObject = page "HR Employee List";
                }
                action("Hr Setup")
                {
                    caption = 'HR setup';
                    RunObject = page "HR Setup";
                }
                action("HR Leave Journal")
                {
                    Caption = 'HR Leave Journal';
                    RunObject = page "HR Leave Journal Lines";
                }
                action("HR Leave Types")
                {
                    Caption = 'HR Leave Types';
                    RunObject = page "HR Leave Types";
                }
                action("Leave Period List")
                {
                    RunObject = page "HR Leave Period List";
                    Caption = 'Leave Period List';
                }

                group("HR Reports")
                {
                    action("HR Employees")
                    {
                        Caption = 'Employees List';
                        RunObject = Report "HR Employee List";
                    }
                    action("HR Leave Summary")
                    {
                        Caption = 'Employees Leave Summary';
                        RunObject = Report "HR Leave Balance Report";
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
                        RunPageLink = Posted = filter(false);
                        //tooltip = 'Open Payroll Employees list';
                    }
                    action(Posted_Bonus)
                    {
                        Caption = 'Posted Staff Bonus';
                        Image = Employee;
                        RunObject = page "Bonus List";
                        RunPageLink = Posted = filter(true);
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
                group("Payroll Reports ")
                {
                    action("Send Payslips")
                    {
                        Caption = 'Send Payslip via Mail';
                        RunObject = report "Send Payslips Via Mail";
                    }
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

            group("Investment Setup")
            {
                action("No series")
                {
                    Caption = 'No series';
                    RunObject = page "Sacco No. Series";
                }
                action("Investment General Set-Up")
                {
                    Caption = 'Investment General Set-Up';
                    RunObject = page "Sacco General Set-Up";
                }
                action("Cue Setup")
                {
                    Caption = 'Cue Setup';
                    RunObject = page "Cue Setup";
                }
                action("MLM Level Setup")
                {
                    Caption = 'MLM Level Setup';
                    RunObject = page "MLM Level Setup";
                }
                action("Counties")
                {
                    Caption = 'Counties';
                    RunObject = page "County List";
                }
                action("Banks")
                {
                    Caption = 'Banks';
                    RunObject = page "Banks";
                }
                action("Loan Product Setup")
                {
                    Caption = 'Loan Product Setup';
                    RunObject = page "Loan Products Setup List";
                }
                action("Account Types List")
                {
                    Caption = 'Account Types List';
                    RunObject = page "Account Types List";
                }
                action("Transaction Types Setup")
                {
                    Caption = 'Transaction Types Setup';
                    RunObject = page "TransactionTypePosting Setup";
                }
                action("Transaction Types FOSA")
                {
                    Caption = 'Transaction Types FOSA';
                    Visible = false;
                    RunObject = page "Transaction Type - List";
                }
                action("Graduated Charges")
                {
                    Caption = 'Cash Withdrawal Graduated Charges';
                    RunObject = page "CWithdrawal Graduated Charges";
                }

                action("Mpesa Withdrawal Bands")
                {
                    Caption = 'Mpesa Withdrawal Bands';
                    RunObject = page "Mpesa Withdrawal Bands";
                    Visible = false;
                }
                action("Defined Transaction Types")
                {
                    Caption = 'Defined Transaction Types';
                    RunObject = page "Defined Transaction Type";
                }
                action("Defined Account Types")
                {
                    Caption = 'Defined Account Types';
                    RunObject = page "Defined Account Type";
                }
                action("Cheque Types")
                {
                    Caption = 'Cheque Types';
                    RunObject = page "Cheque Types";
                    Visible = false;
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
                    // RunObject = page "HR Leave Applications History";
                    // RunPageView = where(Status = filter(Approved), Posted = filter(false));
                    RunObject = page "HR Leave Applications List";
                    RunPageView = where(Status = filter(Approved), Posted = filter(false));
                }
                action("Leave Applications(Posted)")
                {
                    Caption = 'Leave Applications(Posted)';
                    RunObject = page "Posted Leave Applications";
                    // RunPageView = where(Status = filter(Approved),);
                }
            }
            group("File Movement")
            {

                action(fileMovement)
                {
                    Caption = 'File Movement';
                    RunObject = page "File Movement List";
                }
                action(fileReturn)
                {
                    Caption = 'File Return';
                    RunObject = page "File Return List";
                }
                action(fileLocation)
                {
                    Caption = 'File Location Setup';
                    RunObject = page "File Movement SetUp";
                }
                action(fileTypes)
                {
                    Caption = 'File Types Setup';
                    RunObject = page "File Types Setup";
                }
            }

            group("Change User Password")
            {
                Caption = 'User Management';
                action("Change Password")
                {
                    Caption = 'Change Password';
                    RunObject = page "Password Dialog";
                }
            }
            group(Procurement)
            {
                action("List of Vendors")
                {
                    RunObject = page "Vendor List";
                    Caption = 'Vendor List';
                }
                action("New Purchase Requisition")
                {
                    RunObject = page "Task Order";
                    Caption = 'New Purchase Requisition';
                }
                action("Pending Purchase Requisition")
                {
                    RunObject = page "Pending Purchase Requisition3";
                    Caption = 'Pending Purchase Requisition';
                }
                action("Approved Purchase Requisition")
                {
                    RunObject = page "Approved Purchase Requisition";
                    Caption = 'Approved Purchase Requisition';
                }
                action("Completed Purchase Requisition")
                {
                    RunObject = page "CompletedPurchase Req.";
                    Caption = 'Completed Purchase Requisition';
                }
                action("Purchase Quotes")
                {
                    RunObject = page "Purchase Quotes List";
                    Caption = 'Purchase Quotes';//Request For Quotes List
                }
                action("Request For Quotes List")
                {
                    RunObject = page "Request For Quotes List";
                    Caption = 'Request For Quotes List';//Request For Quotes List
                }
                action("LPO/LSO List")
                {
                    RunObject = page "LPO/LSO List";
                    Caption = 'LPO/LSO List';
                }
                action("Purchase Quote Awarded")
                {
                    RunObject = page "PQ Awarded List";
                    Caption = 'Purchase Quote Awarded';
                }
                action("Purchase Quote Not Awarded")
                {

                    RunObject = page "PQ Not Awarded List";
                    Caption = 'Purchase Not Quote Awarded';//Purchase Quotes Lis
                }

            }
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;
                ToolTip = 'Check the administration services';
                action("Portal Notice Board")
                {
                    RunObject = Page "Portal Notice Board";
                }
                action("ICT Setup")
                {
                    RunObject = Page "ICT Setup";
                }
                action("Password History")
                {
                    RunObject = Page PasswordChangeDate;
                }
                action("OTP Logs")
                {
                    RunObject = Page "OTP Logs";
                }
                action("Database Locks")
                {
                    RunObject = Page "Database Locks";
                }
                action("Workflow")
                {
                    Caption = 'Change Workflow ';
                    RunObject = Page "Workflow User Groups";
                }
                action("User Setup")
                {
                    Caption = 'User Setup';
                    RunObject = Page "User Setup";
                }
                action("Users")
                {
                    Caption = 'Add user';
                    RunObject = Page Users;
                }
                action("Profiles")
                {
                    Caption = 'Change User Profile';
                    RunObject = Page "User Settings List";
                }
                action("Email Acc")
                {
                    Caption = 'Email Accounts';
                    RunObject = Page "Email Accounts";
                }
                action("Email Logs")
                {
                    RunObject = Page "Email Logs";
                }
            }
            group(AllManagerialReports)
            {
                Caption = 'Managerial Reports';
                Visible = false;
                group(ManagerialReports)
                {
                    Caption = 'Managerial Reports';
                    action("MembershipExit")
                    {
                        Caption = 'Membership Exit Report';
                        RunObject = Report "Membership Exit Report";
                    }
                    action("NoK Details")
                    {
                        Caption = 'Next of Kin Report';
                        RunObject = report "Next of Kin Details";
                    }
                    action("Summary Loans Disbursement Per Product")
                    {
                        Caption = 'Summary Loans Disbursement Per Product';
                        RunObject = report "AllLoans Disbursed Per Product";
                    }
                    action("InsiderLending.")
                    {
                        Caption = 'Insider Lending';
                        RunObject = report InsiderLending;

                    }
                    action("Loan GuardDetails")
                    {
                        Caption = 'Loans Guard Report';
                        RunObject = report "Loans Guard Report";
                    }
                    action("MemberShip Reports To CIC")
                    {
                        Caption = 'Memebership Reports To CIC';
                        RunObject = report "Membership Reports To CIC";
                    }
                    action("Loans Disbursed To CIC")
                    {
                        Caption = 'Loans Disbursed To CIC';
                        RunObject = report "Loans Disbursed To CIC";
                    }
                    action("Loans Disbursed Per Entity")
                    {
                        Caption = 'Loans Disbursed Per Entity';
                        RunObject = report "Disbursed Per Entity Report";
                    }
                }
                // group(MarketingMonthlyReports)
                // {
                //     Caption = 'Marketing Monthly Reports';

                // }
                // group(MonthlyReports)
                // {
                //     Caption = 'Monthly Reports';
                //     action(TheMonthlyReports)
                //     {
                //         Caption = 'Monthly Reports';

                //     }
                // }
                group(SalariesReports)
                {
                    Caption = 'Salaries Reports';
                    action(TDepositsandSavingsReport)
                    {
                        Caption = 'Deposits and Savings Report';
                        RunObject = report "Deposits and Savings Report";

                    }
                    action(LoanArrearsReports)
                    {
                        Caption = 'Loan Arrears Report';
                        RunObject = report "Loan Arrears Report";

                    }
                }
                // group(CopyofCashAnalysisReports)
                // {
                //     Caption = 'Copy Of Cash Analysis Reports';
                //     action(TheCopyofCashAnalysisReports)
                //     {
                //         Caption = 'Copy of Cash Analysis Reports';

                //     }
                // }
                group(AprilReports)
                {
                    Caption = 'April Reports';
                    Visible = false;
                    action(TheSummaryofSalariesandDeductionsof2023)
                    {
                        Caption = 'Summary of Salaries and Deductions of 2023';

                    }
                    action("ReportOnnewsalaries")
                    {
                        Caption = 'New Salary Report';
                        RunObject = report "New Salary Report";
                    }
                    action("ReportOnmissingsalaries")
                    {
                        Caption = 'Missing Salaries Report';
                        RunObject = report "Missing Salaries Report";
                    }
                }
            }
            group("Compliance Management")
            {
                Caption = 'Compliance Management';
                Image = ResourcePlanning;

                action("Compliance KPI Entries")
                {
                    Caption = 'Compliance KPI Entries';
                    RunObject = page "Compliance KPI Entries";
                }

                action("Compliance Task Log")
                {
                    Caption = 'Compliance Task Log';
                    RunObject = page "Compliance Task Log";
                }
                action("Compliance KPI Setup")
                {
                    Caption = 'Compliance KPI Setup';
                    RunObject = page "Compliance KPI Setup";
                }
            }
            group("Risk Management")
            {
                Caption = 'Risk Management';
                Image = ResourcePlanning;

                action("Risk List")
                {
                    Caption = 'Risk List';
                    RunObject = page "Risk List";
                }

                action("Risk Incidence List")
                {
                    Caption = 'Risk Incidence List';
                    RunObject = page "Risk Incident List";
                }
            }


#if not CLEAN18
            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                ObsoleteTag = '18.0';
                action("Assisted Setup")
                {
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Manual Setup")
                {
                    Caption = 'Manual Setup';
                    RunObject = Page "Manual Setup";
                    ToolTip = 'Define your company policies for business departments and for general activities.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Service Connections")
                {
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page "Service Connections";
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Extensions)
                {
                    Caption = 'Extensions';
                    Image = NonStockItemSetup;
                    RunObject = Page "Extension Management";
                    ToolTip = 'Install Extensions for greater functionality of the system.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Workflows)
                {
                    Caption = 'Workflows';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Workflows;
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
            }
#endif
        }
        area(creation)
        {
            action("Process checkoff")
            {
                AccessByPermission = TableData "Checkoff Header-Distributed" = IMD;
                Caption = 'Process Checkoff Distributed';
                // RunObject = Page "Checkoff Processing Header-D";
                RunPageMode = Create;
                ToolTip = 'Create new distributed checkoff';
            }
            action("Process Interest")
            {
                AccessByPermission = TableData "Loans Register" = IMD;
                Caption = 'Process Loan Monthly Interest';
                // RunObject = report "Process Loan Monthly Interest";
                RunPageMode = Create;
                ToolTip = 'Charge Monthly Loan Interest.';
            }
            action("Salary Processing")
            {
                AccessByPermission = TableData "Salary Processing Headerr" = IMD;
                Caption = 'Salary Processing ';
                RunObject = Page "Salary Processing List";
                ToolTip = 'Prepare Salaries.';
                Visible=false;
            }
            action("Payment Journal Entry")
            {
                AccessByPermission = TableData "Gen. Journal Batch" = IMD;
                Caption = 'Payment Journal Entry';
                RunObject = Page "Payment Journal";
                ToolTip = 'Pay your vendors by filling the payment journal automatically according to payments due, and potentially export all payment to your bank for automatic processing.';
            }
        }
        area(processing)
        {
            group(Payments)
            {
                Caption = 'Payments';
                action("Cas&h Receipt Journal")
                {
                    Caption = 'Cas&h Receipt Journal';
                    Image = CashReceiptJournal;
                    RunObject = Page "Cash Receipt Journal";
                    ToolTip = 'Apply received payments to the related non-posted sales documents.';
                }
                action("Pa&yment Journal")
                {
                    Caption = 'Pa&yment Journal';
                    Image = PaymentJournal;
                    RunObject = Page "Payment Journal";
                    ToolTip = 'Make payments to vendors.';
                }
            }
            group(Analysis)
            {
                Caption = 'Analysis';
                action("Analysis &Views")
                {
                    Caption = 'Analysis &Views';
                    Image = AnalysisView;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Analysis by &Dimensions")
                {
                    Caption = 'Analysis by &Dimensions';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Analysis by Dimensions";
                    ToolTip = 'Analyze activities using dimensions information.';
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'This functionality runs correctly from the Analysis View List page';
                    ObsoleteTag = '18.0';
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';
                action("Calculate Deprec&iation")
                {
                    Caption = 'Calculate Deprec&iation';
                    Ellipsis = true;
                    Image = CalculateDepreciation;
                    RunObject = Report "Calculate Depreciation";
                    ToolTip = 'Calculate depreciation according to the conditions that you define. If the fixed assets that are included in the batch job are integrated with the general ledger (defined in the depreciation book that is used in the batch job), the resulting entries are transferred to the fixed assets general ledger journal. Otherwise, the batch job transfers the entries to the fixed asset journal. You can then post the journal or adjust the entries before posting, if necessary.';
                }
                action("Import Co&nsolidation from Database")
                {
                    Caption = 'Import Co&nsolidation from Database';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Import entries from the business units that will be included in a consolidation. You can use the batch job if the business unit comes from the same database in Business Central as the consolidated company.';
                }
                action("Bank Account R&econciliation")
                {
                    Caption = 'Bank Account R&econciliation';
                    Image = BankAccountRec;
                    RunObject = Page "Bank Acc. Reconciliation";
                    ToolTip = 'View the entries and the balance on your bank accounts against a statement from the bank.';
                }
                action("Payment Reconciliation Journals")
                {
                    Caption = 'Payment Reconciliation Journals';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    RunPageMode = View;
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Adjust E&xchange Rates")
                {
                    Caption = 'Adjust E&xchange Rates';
                    Ellipsis = true;
                    Image = AdjustExchangeRates;
                    RunObject = Codeunit "Exch. Rate Adjmt. Run Handler";
                    ToolTip = 'Adjust general ledger, customer, vendor, and bank account entries to reflect a more updated balance if the exchange rate has changed since the entries were posted.';
                }
                action("P&ost Inventory Cost to G/L")
                {
                    Caption = 'P&ost Inventory Cost to G/L';
                    Image = PostInventoryToGL;
                    RunObject = Report "Post Inventory Cost to G/L";
                    ToolTip = 'Record the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.';
                }

                action("Calc. and Pos&t VAT Settlement")
                {
                    Caption = 'Calc. and Pos&t VAT Settlement';
                    Image = SettleOpenTransactions;
                    RunObject = Report "Calc. and Post VAT Settlement";
                    ToolTip = 'Close open VAT entries and transfers purchase and sales VAT amounts to the VAT settlement account. For every VAT posting group, the batch job finds all the VAT entries in the VAT Entry table that are included in the filters in the definition window.';
                }
            }
            group(Create)
            {
                Caption = 'Create';
                action("C&reate Reminders")
                {
                    Caption = 'C&reate Reminders';
                    Ellipsis = true;
                    Image = CreateReminders;
                    RunObject = Report "Create Reminders";
                    ToolTip = 'Create reminders for one or more customers with overdue payments.';
                }
                action("Create Finance Charge &Memos")
                {
                    Caption = 'Create Finance Charge &Memos';
                    Ellipsis = true;
                    Image = CreateFinanceChargememo;
                    RunObject = Report "Create Finance Charge Memos";
                    ToolTip = 'Create finance charge memos for one or more customers with overdue payments.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = ReferenceData;
                    action("Balance Sheet")
                    {
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View a report that shows your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        Caption = 'Income Statement';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Income Statement";
                        ToolTip = 'View a report that shows your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Retained Earnings Statement";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                }
                group("Excel Reports")
                {
                    Caption = 'Excel Reports';
                    Image = Excel;
                    action(ExcelTemplatesBalanceSheet)
                    {
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Balance Sheet";
                        ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                    }
                    action(ExcelTemplateIncomeStmt)
                    {
                        Caption = 'Income Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Income Stmt.";
                        ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                    }
                    action(ExcelTemplateCashFlowStmt)
                    {
                        Caption = 'Cash Flow Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template CashFlow Stmt.";
                        ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                    }
                    action(ExcelTemplateRetainedEarn)
                    {
                        Caption = 'Retained Earnings Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Retained Earn.";
                        ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                    }
                    action(ExcelTemplateTrialBalance)
                    {
                        Caption = 'Trial Balance';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Trial Balance";
                        ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                    }
                    action(ExcelTemplateAgedAccPay)
                    {
                        Caption = 'Aged Accounts Payable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Pay.";
                        ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                    }
                    action(ExcelTemplateAgedAccRec)
                    {
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Rec.";
                        ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                    }
                }
                action("Run Consolidation")
                {
                    Caption = 'Run Consolidation';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Run the Consolidation report.';
                }
            }
#if not CLEAN19
            group(Setup)
            {
                Caption = 'Setup';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Setup is no longer shown in this page.';
                ObsoleteTag = '19.0';

                action(Action112)
                {
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("General &Ledger Setup")
                {
                    Caption = 'General &Ledger Setup';
                    Image = Setup;
                    RunObject = Page "General Ledger Setup";
                    ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Sales && Receivables Setup")
                {
                    Caption = '&Sales && Receivables Setup';
                    Image = Setup;
                    RunObject = Page "Sales & Receivables Setup";
                    ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Purchases && Payables Setup")
                {
                    Caption = '&Purchases && Payables Setup';
                    Image = Setup;
                    RunObject = Page "Purchases & Payables Setup";
                    ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Fixed Asset Setup")
                {
                    Caption = '&Fixed Asset Setup';
                    Image = Setup;
                    RunObject = Page "Fixed Asset Setup";
                    ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Cash Flow Setup")
                {
                    Caption = 'Cash Flow Setup';
                    Image = CashFlowSetup;
                    RunObject = Page "Cash Flow Setup";
                    ToolTip = 'Set up the accounts where cash flow figures for sales, purchase, and fixed-asset transactions are stored.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Cost Accounting Setup")
                {
                    Caption = 'Cost Accounting Setup';
                    Image = CostAccountingSetup;
                    RunObject = Page "Cost Accounting Setup";
                    ToolTip = 'Specify how you transfer general ledger entries to cost accounting, how you link dimensions to cost centers and cost objects, and how you handle the allocation ID and allocation document number.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Business Units")
                {
                    Caption = 'Business Units';
                    Image = Setup;
                    RunObject = Page "Business Unit List";
                    ToolTip = 'Set up Business Units that you need to consolidate into this company.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
            }
#endif
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    Caption = 'Find entries...';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                }
            }
            group("Load Disbursement")
            {
                Caption = 'Loan disbursement';
                action("Loan disbursement batch list")
                {
                    Caption = 'Loan disbursement batch list';
                    Image = Navigate;
                    Visible = false;
                    RunObject = Page "Loans Disbursment Batch List";

                }
            }

        }
    }
}
profile Myprofile
{
    Caption = 'System Administrator Profile';
    RoleCenter = "Home Role Center";
    ProfileDescription = 'Parent role center containing all of the modules';
}


