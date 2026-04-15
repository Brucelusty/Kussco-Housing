//************************************************************************
page 50267 "Marketing Profile" // default role center change to comapny name
{
    ApplicationArea = All;
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(ApprovalActivities; "Approvals Activities")
            {
                Visible = true;
            }
            part("Emails"; "Email Activities")
            {
            }
        }
    }

    actions
    {
        area(sections)
        {
            group(Action84)
            {
                Caption = 'Membership Management';
                group("Membership Applications")
                {
                    action(MembershipApp)
                    {
                        Caption = 'Membership Application';
                        RunObject = Page "Membership Application List";
                        ToolTip = 'Apply New Members.';
                    }
                    action(GroupApp)
                    {
                        Caption = 'Group Application';
                        RunObject = Page "Group Applic List";
                        ToolTip = 'Apply New Group Members.';
                    }
                }
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
                    action(GroupList)
                    {
                        Caption = 'Group Accounts List';
                        RunObject = Page "Group List";
                        ToolTip = 'Manage Group Member Accounts';
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
                    action(updatedchangereqslist)
                    {
                        Caption = 'Updated Change Requests';
                        RunObject = page "Updated Change Request List";
                    }
                    action(StatusChangeRequest)
                    {
                        Caption = 'Change Requests Report';
                        RunObject = report "Member Status Change Request";
                    }
                }
            }
            group("Saving Products Management")
            {
                Caption = 'Saving Products Management';
                Image = Bank;
                ToolTip = 'Manage Saving Accounts Eg. FOSA Savings';
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
                // action("MDOSI Junior Listing")
                // {
                //     // Caption = 'Accounts Listing';
                //     RunObject = report "Accounts Listing";
                // }

            }
            group("Loans Management")
            {
                Caption = 'Loan Management';
                ToolTip = 'Loans'' Management Module';
                action("BOSA Loan Application")
                {
                    Caption = 'Loan Application';
                    Image = CreditCard;
                    RunObject = Page "Loan Application BOSA(New)";
                    ToolTip = 'Open BOSA Loan Applications';
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

                group("Loans Reports")
                {
                    group("CIC")
                    {
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
                        RunObject = report "Loans Defaulter Aging - SASRA";
                    }
                    action("Loan Expectation Monthly")
                    {
                        Caption = 'Loan Expectation Monthly';
                        RunObject = report "Loans Monthly Expectation Ver1";
                    }
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

            group("User Management")
            {
                action("Change Password")
                {
                    RunObject = page "Password Dialog";
                }
            }
            
            group("HR Info")
            {
                action("Hr Employee List")
                {
                    Caption = 'Employee Details';
                    Image = Employee;
                    RunObject = page "HR Employee List";
                }
                action(payrollemp)
                {
                    Caption = 'Payroll Details';
                    Image = Employee;
                    RunObject = page "Payroll Employee List.";
                    tooltip = 'Open Payroll Employees list';
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

        }
    }
}
profile Marketing
{
    Caption = 'Marketing Profile';
    RoleCenter = "Marketing Profile";
    ProfileDescription = 'Role center tailored to the marketing users of the organization.';
}


