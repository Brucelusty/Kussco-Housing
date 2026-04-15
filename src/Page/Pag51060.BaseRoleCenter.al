page 51060 "Base Role Center"//Customer care
{
    ApplicationArea = All;
    PageType = RoleCenter;
    Caption = 'CustomerCare ';
    
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
            }
            Group(ChangeRequest)
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
                    Caption = 'Updated Change requests';
                    RunObject = page "Updated Change Request List";
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
            group("FOSA Accounts")
            {
                Caption = 'FOSA Accounts List';
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
            group("Loans Management")
            {
                Caption = 'Loan Management';
                ToolTip = 'Loans'' Management Module';
                
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
                        Caption = 'Cleared Loans';
                        RunObject = Page "Cleared Loans Posted List";
                        ToolTip = 'Open the list of the Loans Posted.';
                    }
                }
            }
            group("ABC Channels")
            {
                action("AU Messages")
                {
                    Caption = 'AU SMS Messages';
                    RunObject = page "AU SMS Messages";
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

            // }
        }
    }
}
profile "CustomerCare Role Center"
{
    Caption = 'Base User Profile';
    RoleCenter = "Base Role Center";
    ProfileDescription = 'Role Center customized to a base users''s needs and can be customized for use.';
}


