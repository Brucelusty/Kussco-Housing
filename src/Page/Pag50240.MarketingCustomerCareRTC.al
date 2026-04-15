//************************************************************************
page 50240 "Marketing/Customer Care RTC" // default role center change to comapny name
{
    ApplicationArea = All;
    Caption = 'Marketing/Customer Care RTC';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
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
            part(EmailActivities; "Email Activities")
            {
                Visible = true;
            }

            part(Control75; "Headline RC Accountant")
            {
            }

            // part("Logo Cue"; "SaccoLogo")
            //  {
            //      Caption = '';
            //  } 
            part(Control99; "Finance Performance")
            {
                Visible = false;
            }
            part(Control1902304208; "Membership Cue")
            {

            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
            }
            part("Emails"; "Email Activities")
            {
            }
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
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
            }
            part(Control10; "Product Video Topics")
            {
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced with Assisted Setup.';
                Visible = false;
                ObsoleteTag = '17.0';
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
                Visible = false;
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
            group("ShortCut Reports")
            {
                Caption = 'ShortCut Reports';
                
               
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
        }
        area(embedding)
        {
           
            action(Members)
            {
                Caption = 'Members';
                Image = Customer;
                RunObject = Page "Members List";
                ToolTip = 'View or edit detailed information for the Members.';
            }
            action(FOSAAccounts)
            {
                Visible = true;
                Caption = 'FOSA Accounts';
                Image = Vendor;
                RunObject = Page "Member Accounts List";
                ToolTip = 'View or edit detailed information for the FOSA Savings Accounts.';
            }
            action(FOSAAccountsBalance)
            {

                Caption = 'FOSA Account Balances';
                Image = Balance;
                RunObject = Page "Member Accounts List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
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

           
            
            group(Action84)
            {
                Caption = 'Membership Management';
                action(MembershipApp)
                {
                    Caption = 'Membership Application';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership Application List";
                    ToolTip = 'Apply New Members.';
                }
                action(GroupApp)
                {
                    Caption = 'Group Application';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Group Applic List";
                    ToolTip = 'Apply New Members.';
                }
                action(MembersList)
                {
                    Caption = 'Member Accounts List';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members List";
                    ToolTip = 'Manage Member Accounts';
                }
                action(GroupList)
                {
                    Caption = 'Group Accounts List';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Group List";
                    ToolTip = 'Manage Member Accounts';
                }

                action(InsiderLending)
                {
                    Caption = 'Insider Lending';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Insider List";
                    ToolTip = 'Insider Lending members';
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
                    action(AgentNOKSignatoriesChange)
                    {
                        Caption = 'Agent/NOK/Signatories Change';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "New Agent/NOK/Sign Change List";
                    }
                    group(ReportsChangereq)
                    {
                        caption = 'Reports Change Request';
                        action(ChangeReqMobile)
                        {
                            Caption = 'Change Req(mobile)';
                            Promoted = true;
                            PromotedCategory = Process;
                            //RunObject = report "Change Request Report(Mobile)";
                        }
                        action(ChangeReqAcc)
                        {
                            Caption = 'Change Req(Account)';
                            Promoted = true;
                            PromotedCategory = Process;
                            // RunObject = report "Change Request Report(Account)";
                        }

                    }
                    group(EffectedChangeReqs)

                    {
                        Caption = 'Effected Change Requests';
                        action(updatedchangereqslist)
                        {
                            Caption = 'Updated Change requests';
                            Promoted = true;
                            PromotedCategory = Process;
                            RunObject = page "Updated Change Request List";
                        }

                        action(updatedNOKAgentSign)
                        {
                            Caption = 'Updated NOK/Agent & Signatories';
                            RunObject = page "Agent/NOK Change - Effected";
                        }
                    }

                }
                group("Membership Closure")
                {
                    Caption = 'Membership Exit';
                    action("MeMbership Exit")
                    {
                        Caption = 'Membership Exit';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Membership Exit List";
                    }
                    action("Membership Exit(Posted)")
                    {
                        Caption = 'Membership Exit';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Posted Member Withdrawal List";
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
                        RunObject = page "BOSA Receipts List";
                        ToolTip = 'New Member Receipts for payments done.';

                    }
                    action("FOSA Receipts")
                    {
                        Caption = 'Open BOSA Receipts';
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
                action("Account Applications")
                {
                    Caption = 'Membership Products Application';
                    Image = Customer;
                    RunObject = page "Member Account Application";
                    ToolTip = 'Open New membership products accounts Application.';

                }
                action("Member FOSA Accounts")
                {
                    Caption = 'Member Savings Accounts';
                    Image = Customer;
                    RunObject = page "Member Accounts List";
                    ToolTip = 'Open Members'' FOSA Accounts';

                }
                group("Fixed Deposits Mgmt ")
                {
                    Caption = 'Fixed Deposits Mgmt';
                    Image = Bank;
                    Visible = true;
                    ToolTip = 'Open Fixed Deposits Submodule';
                    action("Fixed Deposits List")
                    {
                        Caption = 'Fixed Deposits Savings Accounts';
                        Image = Account;
                        RunObject = page "Fixed Deposit Acc. List";
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
                }

                group("Standing Orders ")
                {
                    Caption = 'Standing Orders';
                    Image = Bank;
                    Visible = true;
                    ToolTip = 'Open Standing Orders Submodule';
                    action("Standing Order Register")
                    {
                        Caption = 'Standing Order Register';
                        Image = Account;
                        RunObject = page "Standing Order Register";
                        ToolTip = 'Open Standing Order Register';

                    }
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
                }

                group("Checkoff Proccessing ")
                {
                    Caption = 'Checkoff';
                    Image = Bank;
                    Visible = true;
                    ToolTip = 'Checkoff List';
                    action("Checkoff Processing List")
                    {
                        Caption = 'Checkoff Processing List';
                        Image = Account;
                       // RunObject = page "Checkoff Processing-D List";
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

                    action("Processed Salary List")
                    {
                        Caption = 'Processed Salary List';
                        Image = Account;
                        RunObject = page "Processed Salary List";
                        ToolTip = 'Processed Salary List';

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
                    action(ATMProcessed)
                    {
                        Caption = 'Processed ATM Cards';
                        RunObject = page "ATM Cards Appl. - Processed";

                    }
                    action(ATMTransactionDetails)
                    {
                        Caption = 'ATM Transaction Details';
                        RunObject = page "Atm Transaction Details";

                    }
                    action(ATMRequestBatch)
                    {
                        Caption = 'ATM Card Request Batch List';
                        RunObject = page "ATM Card Request Batch List";

                    }
                    action(ATMBatchReceiptsBatch)
                    {
                        Caption = 'ATM Card Receipt Batch List';
                        RunObject = page "ATM Card Receipt Batch List";

                    }
                    action(ATMReports)
                    {
                        Caption = 'Sacco Link Report';
                        RunObject = report "Sacco Link Report";

                    }
                }
                

            }

            group("Loans Management")
            {
                Caption = 'Loan Management';
                Image = CreditCard;
                ToolTip = 'Loans'' Management Module';
                group("BOSA Loans Management")
                {
                    Caption = 'Loan Management';
                    Image = CreditCard;
                    ToolTip = 'BOSA Loans'' Management Module';
                    action("BOSA Loan Application")
                    {
                        Caption = 'Loan Application';
                        Image = CreditCard;
                        RunObject = Page "Loan Application BOSA(New)";
                        ToolTip = 'Open BOSA Loan Applications';
                    }
                    action("Pending BOSA Loan Application")
                    {
                        Caption = 'Loans Pending Approval';
                        Image = CreditCard;
                        RunObject = Page "Loans  List- pending approval";
                        ToolTip = 'Open the list of Pending BOSA Loan Applications.';
                    }
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
                    action("Collateral Register")
                    {
                        Caption = 'Collateral Register';
                        RunObject = Page "Loan Collateral Register List";
                        ToolTip = 'Open Collaterals.';
                    }
                    action("Loan Calculator")
                    {
                        Caption = 'Loan Calculator';
                        RunObject = Page "Loan Calculator";
                        ToolTip = 'Open Loan Calculator.';
                    }

                }

                group("CRB List")
                {
                    action("CRB List2")
                    {
                        Caption = 'CRB List';
                        RunObject = page "CRBA List";
                    }
                }
                group("Loans Reports")
                {
                    action("Loan Expectation Monthly")
                    {
                        Caption = 'Loan Expectation Monthly';
                        RunObject = report "Loans Monthly Expectation Ver1";
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

                    action("Loans Balances Report CIC")
                    {
                        Caption = 'Loans Balances Report CIC';
                        RunObject = report "Loans Balances Report CIC";
                    }
                    action("Loan Aging Report")
                    {
                        Caption = 'Loan Aging Report';
                        RunObject = report "Loans Defaulter Aging - SASRA";
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
                    action("CheckoffProcessing List")
                    {
                        Caption = 'Checkoff Processing List';
                        Image = Account;
                      //  RunObject = page "Checkoff Processing-D List";
                        ToolTip = 'Checkoff Processing List';

                    }
                    action("Clear Buffer Interest")
                    {
                        Caption = 'Clear Buffer Interest';
                        RunObject = report ClearBuffer;
                    }
                    action("Checkoff Processing Distributed")
                    {
                        Caption = 'Distributed Checkoff';
                       // RunObject = page "Checkoff Processing-D List";
                    }
                    action("Posted Checkoffs")
                    {
                        Caption = 'Posted Checkoff';
                       // RunObject = page "Posted Checkoff Proc.-D List";
                    }
                    /*                    action("Generate Prd")
                                       {
                                           Caption = 'Generate PRD Invoice';
                                           RunObject = report CheckoffAdvice;
                                       } */
                    action("Process Holiday Interest")
                    {
                        Caption = 'Process Holiday Savings Interest';
                        RunObject = report "Holiday Savings Interest";

                    }




                    group("Checkoff Pocessing")
                    {

                    }
                    group("Guarantor Substitution")
                    {
                        action("Gurantor Substitution")
                        {
                            RunObject = page "Guarantorship Sub List";

                        }
                        action("Posted Guarantor Substitution")
                        {
                            RunObject = page "Processed Guarantor Sub List";
                        }
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
                group(DefaulterManagement)
                {
                    group(loanRecovery)
                    {
                        Caption = 'Loan Recovery';
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
                            RunObject = page "Posted Loan Recovery Header";
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
                    Visible=false;
                    RunObject = report "Dividend Processing Ver1";
                }
                action("Generate Dividend Prorated")
                {
                    Caption = 'Generate Dividend Prorated';
                    RunObject = report "Generate Dividend Prorated";
                }

                action("Generate Dividend Flatrate")
                {
                    Caption = 'Generate Dividend Flatrate';
                    RunObject = report "Generate Dividend FlatRate";
                }
                action("Transfer Dividends")
                {
                    Caption = 'Transfer Dividends';
                    RunObject = report "TransferDividend-Prorated";

                }
                action("Dividends Register")
                {
                    Caption = 'Dividends Register List';
                    RunObject = page "Dividend Register";
                }
                action("Dividends Register Report ")
                {
                    Caption = 'Dividends Register Report';
                    RunObject = report "Dividends Register";
                }
                action("Post Dividends")
                {
                    Caption = 'Post Dividends';
                    RunObject = report "Post Dividends";
                }
            }

            group("Portal Users")
            {
                action(Feedback)
                {
                    Caption = 'Online Member';
                    RunObject = page "Online Member Accessibility";
                }
            }
            
            


            group("Leave Management")
            {

                action("Leave Application")
                {
                    Caption = 'Leave Applications';
                    RunObject = page "HR Leave Applications List";

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

                group("Hr Leave Setup")
                {

                }
            }
            group(Procurement)
            {
               
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
                

            }
            

#if not CLEAN18
           
#endif
        }
        area(creation)
        {
           
           
        }
        area(processing)
        {
            
            
           
            group(Create)
            {
                Caption = 'Create';
                
            }
          
#if not CLEAN19
            
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
                    RunObject = Page "Loans Disbursment Batch List";

                }
            }

        }
    }
}
profile "Marketing/Customer Care RTC"
{
    Caption = 'Marketing/Customer Care RTC';
    RoleCenter = "Marketing/Customer Care RTC";
    ProfileDescription = 'Marketing/Customer Care RTC';
}





