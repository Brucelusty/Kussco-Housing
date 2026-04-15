page 51062 "Marketing Role Center" //Role center for marketing department
{
    ApplicationArea = All;
    Caption = 'Marketing ';
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
            part(EmailActivities; "Email Activities")
            {
                Visible = true;
            }


            // part(Control1902304208; "Membership Cue")
            // {

            // }
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
                Visible = true;
            }
            systempart(Control1901377608; MyNotes)
            {
            }
        }  
}
    actions
    {
        area(Creation)
        {
            // action(ActionBarAction)
            // {
            // }
        }
        area(Sections)
        {
            group(Action84)
            {
                Caption = 'Membership Management';
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
                    ToolTip = 'Apply New Members.';
                }
                action(MembersList)
                {
                    Caption = 'Member Accounts List';
                    RunObject = Page "Members List";
                    ToolTip = 'Manage Member Accounts';
                }
                action(StaffMembersList)
                {
                    Caption = 'Staff Member Accounts List';
                    RunObject = Page "Staff Members List";
                    ToolTip = 'Manage Staff Member Accounts';
                }
                group(ReportsMembership)
                {
                    caption = 'Membership Reports';

                    action(MemberListReport)
                    {
                        Caption = 'Membership Report';
                        RunObject = report "Membership Detailed Report";
                    }
                    action(MemberReport)
                    {
                        Caption = 'Member list Report';
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
                    }
                    action(NewMemberRegFee)
                    {
                        Caption = 'New Members';
                        RunObject = report "Members Paid Registration Fee";
                    }

                }
                action(Designation)
                {
                    Caption = 'Designation List';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Designation List";
                    ToolTip = 'Designation List';
                }

                action(Workstation)
                {
                    Caption = 'Workstation List';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "WorkStation List";
                    ToolTip = 'Workstation';
                }
                action(GroupList)
                {
                    Caption = 'Group Accounts List';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Group List";
                    ToolTip = 'Manage Member Accounts';
                }

                group("Membership Closure")
                {
                    Caption = 'Membership Exit';
                    
                    // Visible = false;
                    action("Notice List")
                    {
                        Caption = 'Notice List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Notice List";
                    }
                    action("Matured Notice List")
                    {
                        Caption = 'Matured Notice List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Matured Notice List";
                    }
                    action("MeMbership Exit")
                    {
                        Caption = 'Membership Exit';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Membership Exit List";
                    }
                    action("Membership Exit(Posted)")
                    {
                        Caption = 'Posted Membership Exit';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Posted Member Withdrawal List";
                    }
                }
                action("Change Request")
                {
                    Caption = 'Change Request List';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Change Request List";
                    ToolTip = 'Change Member Details';
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
                action("Account Opened")
                {
                    Caption = 'Opened Accounts List';
                    Image = Customer;
                    RunObject = page "Savings Accounts List";
                    ToolTip = 'Open New membership products accounts Application.';
                }
                action("Member FOSA Accounts")
                {
                    Caption = 'Member Savings Accounts';
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
            group("Loan Mananagement")
            {
                action("Posted Loans")
                {
                    Caption = 'Posted Loans';
                    RunObject = Page "Loans Posted List";
                    ToolTip = 'Open the list of the Loans Posted.';
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
                action("SMS Charges")
                {
                    Caption = 'SMS Charges';
                    RunObject = page "SMS Charges";
                    Visible = false;
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
                Caption = 'Change Password';
                action("Change Password")
                {
                    Caption = 'Change Password';
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
profile "Marketing Role Center"
{
    Caption = 'Marketing Role Center ';
    RoleCenter = "Marketing Role Center";
    ProfileDescription = 'Marketing Role Center';
}


