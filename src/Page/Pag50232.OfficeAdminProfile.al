page 50232 "Office Admin"
{
    ApplicationArea = All;
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
            part("User Tasks Activities"; "User Tasks Activities")
            {
            }
            part(Control123; "Team Member Activities")
            {
            }
            part(Control106; "My Job Queue")
            {
                Visible = false;
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
        area(Sections)
        {
            group(Membership)
            {
                action(MembershipApp)
                {
                    Caption = 'Membership Application';
                    RunObject = Page "Membership Application List";
                    RunPageView = where(Created = filter(false));
                    ToolTip = 'Apply New Members.';
                }
                
                group("Member BOSA Accounts")
                {
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
                        RunObject = report "Membership Detailed Report";
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
                group(ChangeRequest)
                {
                    Caption = 'Change Request';
                    action("Change Request")
                    {
                        Caption = 'Change Request List';
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
                }
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
                    RunPageView = where("Approval Status" = filter(<>New), updated = filter(false));
                }
                action("Posted SavingsVar")
                {
                    Caption = 'Posted Savings Variation';
                    Image = Account;
                    RunObject = page "Savings Variations List";
                    RunPageView = where(updated = filter(true));
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
            group(Loans)
            {
                action("BOSA Loan Application")
                {
                    Caption = 'Loan Application';
                    Image = CreditCard;
                    RunObject = Page "Loan Application BOSA(New)";
                    ToolTip = 'Open BOSA Loan Applications';
                }
                action("Running Loans List")
                {
                    RunObject = page "Uncleared Loans Posted List";
                }
                action("Cleared Loans List")
                {
                    RunObject = page "Cleared Loans Posted List";
                }
            }
            group(Committees)
            {
                action("Sacco Committees List")
                {
                    RunObject = page "Sacco Committees";
                }
            }
            group(Meetings)
            {
                action("Meetings List")
                {
                    RunObject = page "Sacco Meetings";
                }
                action("Uploaded Meetings List")
                {
                    RunObject = page "Sacco Meetings";
                    RunPageView = where("Allowance Expected" = filter(false));
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
            group("Petty Cash")
            {
                action("PettyCash")
                {
                    Caption = 'New Petty Cash';
                    RunObject = page "New Petty Cash Payments List";
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
            group("User Management")
            {
                action("Change Password")
                {
                    RunObject = page "Password Dialog";
                }
            }
        }
    }
}

profile OfficeAdmin
{
    Caption = 'Office Admin Profile';
    RoleCenter = "Office Admin";
    ProfileDescription = 'Role center tailored to the office administrator of the organization.';
}


