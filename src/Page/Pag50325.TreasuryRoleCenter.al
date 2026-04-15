Page 50325 "Treasury Role Center"
{
    ApplicationArea = All;
    // CurrPage."Help And Setup List".ShowFeatured;

    Caption = 'Treasury Role Center', Comment = '{Dependency=Match,"ProfileDescription_SMALLBUSINESS"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
        //     part(DashbordVisualizationCardPar; "Dashbord Visualization CardPar")
        //     {
        //         Visible = true;
        //         //Caption='Navigate';
        //     }

            part(Control139; "Headline RC Business Manager")
            {
                Visible = false;
            }
            part(ApprovalActivities; "Approvals Activities")
            {
                Visible = true;
            }

            part(EmailActivities; "Email Activities")
            {
                Visible = true;
            }

            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                //AccessByPermission = TableData financecue = 1;
                Visible = false;
            }
            part(Control55; "Help And Chart Wrapper")
            {
                //AccessByPermission = TableData UnknownTableData1803=I;
                Caption = '';
                Visible = false;
            }
            part(Control98; "Power BI Embedded Report Part")
            {
                AccessByPermission = TableData "Power BI User Configuration" = I;
            }
            part(Control46; "Team Member Activities No Msgs")
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(creation)
        {


        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New';
                Image = New;
                action(Vendor)
                {
                    AccessByPermission = TableData Vendor = IMD;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new vendor.';
                }
            }

        }
        area(embedding)
        {
            action(Vendors)
            {
                Caption = 'Vendors';
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Items)
            {
                Caption = 'Items';
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }

        }
        area(sections)
        {
            group("Member Accounts")
            {
                Caption = 'Membership Management';
                Image = Marketing;

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
                action(GroupList)
                {
                    Caption = 'Group Accounts List';
                    RunObject = Page "Group List";
                    ToolTip = 'Manage Group Member Accounts';
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
                    action(updatedchangereqslist)
                    {
                        Caption = 'Updated Change Requests';
                        RunObject = page "Updated Change Request List";
                    }
                    action(StatusChangeRequest)
                    {
                        Caption = 'Updated Change Requests Report';
                        RunObject = report "Member Status Change Request";
                    }
                }
            }
            
            group("Loans Management")
            {
                action("Running Loans List")
                {
                    RunObject = page "Uncleared Loans Posted List";
                }
                action("Cleared Loans List")
                {
                    RunObject = page "Cleared Loans Posted List";
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
            group("FOSA Acc")
            {
                Caption = 'Savings Management';
                Image = Marketing;
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
                }
                group("Standing Orders")
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
                group("Fixed Deposits Management ")
                {
                    Caption = 'Fixed Deposit Management';
                    ToolTip = 'Open Fixed Deposit''s Submodule';
                    action("Created Fixed Deposits Acc List")
                    {
                        Caption = 'Create Fixed Deposit';
                        RunObject = page "Fixed deposit list";
                        ToolTip = 'Open New Fixed Deposits';
                    }
                    action("Placed Fixed Deposits Acc List")
                    {
                        Caption = 'Placed Fixed Deposits Acc List';
                        RunObject = page "Credited Fixed deposit list";
                        ToolTip = 'Open Credited Fixed Deposits';
                    }
                    action("Matured Fixed Deposits Acc List")
                    {
                        Caption = 'Matured Fixed Deposits Acc List';
                        RunObject = page "Matured  Fixed deposit list";
                        ToolTip = 'Open Matured Fixed Deposits';
                    }
                    action("Revoked Fixed Deposits Acc List")
                    {
                        Caption = 'Revoked Fixed Deposits Acc List';
                        RunObject = page "Revoked Fixed Deposit List";
                        ToolTip = 'Open Revoked Fixed Deposits';
                    }
                }
                group(Call)
                {
                    Caption = 'Call Deposit Management';
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

            }
            group("Cashier Banking")
            {
                group("Treasury Management")
                {
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
                }
                group("Treasury Transactions")
                {
                    action("Teller&Treasury List")
                    {
                        Caption = 'Teller Request/Receive Funds';
                        RunObject = Page "Teller & Treasury Trans List1";
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

            }
            group("Petty Cash")
            {
                action(PettyCashRequest)
                {
                    Caption = 'Petty Cash Requisition';
                    RunObject = Page "Teller & Treasury Trans List1";
                }
                action("New PettyCash")
                {
                    Caption = 'New Petty Cash';
                    RunObject = Page "New Petty Cash Payments List";
                }
                action("Posted Petty Cash")
                {
                    Caption = 'Posted Petty Cash';
                    RunObject = Page "Posted Petty Cash Payments";
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
                // action("Member Transaction List")
                // {
                //     Caption = 'Member Transaction List';
                //     Image = Account;
                //     RunObject = page "Member Transaction List";
                //     ToolTip = 'Open Member Transaction List';
                // }
            
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

            group("FOSA Reports")
            {
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
                    RunPageView = where(Status = filter(<>Approved), Posted = filter(false));
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
            group("Change User Password")
            {
                Caption = 'User Management';
                action("Change Password")
                {
                    Caption = 'Change Password';
                    RunObject = page "Password Dialog";
                } 
            }

        }
    }
}
profile "Treasury Role Center"
{
    Caption = 'Teller Profile';
    RoleCenter = "Treasury Role Center";
    ProfileDescription = 'Role Center customized to facilitate the funtions of the FOSA Teller.';
}


