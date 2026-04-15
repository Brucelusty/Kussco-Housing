page 50319 "Auditor Role Center"
{
    ApplicationArea = All;
    PageType = RoleCenter;
    Caption = 'Auditor RC';

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
        // area(Creation)
        // {
        //     action("Member Application")
        //     {
        //         RunPageMode = Create;
        //         Caption = 'Member Application';
        //         ToolTip = 'Add a Member here';
        //         Image = New;
        //         RunObject = page "Membership Application Card";
        //     }
        // }
        area(Processing)
        {
            group(Loans)
            {
                action("Loans posted")
                {
                    RunPageMode = View;
                    Caption = 'Loans posted';
                    ToolTip = 'Register Loans posted';
                    RunObject = page "Loans Posted List";
                    Image = DataEntry;
                }
            }
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
        area(Reporting)
        {
            action("Member Deposit Contributions")
            {
                Caption = 'Member Deposit';
                ToolTip = 'Member Deposit Contribution';
                Image = Report;
                RunObject = report "Deposits Details";
            }

        }
        area(Embedding)
        {
            action("ATM Transaction Details")
            {
                RunObject = Page "ATM Log Entries";
            }
            action("Over-Guaranteed Members")
            {
                RunObject = Report "Over-Guaranteed Members";
            }

        }
        area(Sections)
        {
            group(Action84)
            {
                Caption = 'Membership Management';
                action(MembersList)
                {
                    Caption = 'Member Accounts List';
                    RunObject = Page "Members List";
                    ToolTip = 'Manage Member Accounts';
                }
                
                action(GroupList)
                {
                    Caption = 'Group Accounts List';
                    RunObject = Page "Group List";
                    ToolTip = 'Manage Group Member Accounts';
                }

            }
            group("Saving Products Management")
            {
                Caption = 'Saving Products Management';
                Image = Bank;

                ToolTip = 'Manage Saving Accounts Eg. FOSA Savings and Fixed Deposits';
                action("Member FOSA Accounts")
                {
                    Caption = 'Member Savings Accounts';
                    Image = Customer;
                    RunObject = page "Member Accounts List";
                    ToolTip = 'Open Members'' FOSA Accounts';
                }
            }
            group("Loan Mananagement")
            {
                action("Portal Loans")
                {
                    Caption = 'Portal Loans';
                    Image = CreditCard;
                    RunObject = Page "Mobile Loans Pending";
                    RunPageLink = "Loan Application Mode" = filter(Portal);
                    ToolTip = 'All Portal Applied Loans';
                }
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

                action("Effected Changes")
                {
                    Caption = 'Effected Changes';
                    RunObject = page "Updated Change Request List";
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
                group("Audit Trail Reports")
                {
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

            
            group("SMS Management")
            {
                action("BULK SMS")
                {
                    Caption = 'BULK SMS';
                    RunObject = page "Bulk SMS Header List";
                }
                action("AU Messages")
                {
                    Caption = 'AU SMS Messages';
                    RunObject = page "AU SMS Messages";
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
            group("Petty Cash")
            {
                action("PettyCash")
                {
                    Caption = 'New Petty Cash';
                    RunObject = page "New Petty Cash Payments List";
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
profile "Auditor Profile" 
{
    Caption = 'Internal Auditor Profile';
    RoleCenter = "Auditor Role Center";
    ProfileDescription = 'Role Center customized to the needs of the Internal Auditor';
}



