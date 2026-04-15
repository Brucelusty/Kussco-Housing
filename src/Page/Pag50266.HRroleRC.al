page 50266 "HR role RC"
{
    ApplicationArea = All;

    Caption = 'Resource Mobilization', Comment = '{Dependency=Match,"Resource mobilization"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
                Visible = false;
            }
            part(ApprovalActivities; "Approvals Activities")
            {
                Visible = true;
            }
            part(OtherDocActivities; "staff Dashboard Cue")
            {
                // Visible = false;
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
            part(Control98; "Power BI Embedded Report Part")
            {
                // AccessByPermission = TableData "Power BI User Configuration" = I;
            }
            part(Control46; "Team Member Activities No Msgs")
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(sections)
        {
            
            group("HR Base")
            {
                action("Hr Departments List")
                {
                    Caption = 'HR Departments List';
                    Image = Employee;
                    RunObject = page "Responsibility Center List";
                }
                action("HR Employee List")
                {
                    Caption = 'Active Employees';
                    RunObject = Page "HR Employee List";
                }
                action("HR Employee List(Inactive)")
                {
                    Caption = 'InActive Employees';
                    RunObject = Page "Inactive Employees";
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
                        RunObject = Report  "HR Leave Balance Report";
                    }
                }
            }

            group("Employee Management")
            {
                action("Employee List")
                {
                    Caption = 'Active Employees';
                    RunObject = Page "HR Employee List";
                }
                action("Employee List(Inactive)")
                {
                    Caption = 'InActive Employees';
                    RunObject = Page "Inactive Employees";
                }
            }
            group("Performance Appraisal")
            {
                action(KVDs)
                {
                    Caption = 'Key Value Drivers';
                    RunObject = Page "Key Value Drivers";
                }
                action(KPIs)
                {
                    Caption = 'Key Performance Indicators';
                    RunObject = Page "Key Performance Indicators";
                }
                action(Behavioral)
                {
                    Caption = 'Behavioral Objectives';
                    RunObject = Page "Staff Values";
                }
                
                action("Appraisal Setup")
                {
                    Caption = 'Appraisal Periods';
                    RunObject = page "Appraisal Periods";
                }
                action("New Appraisee Appraisal List")
                {
                    Caption = 'New Staff Appraisal';
                    RunObject = page "Appraissal List";
                    RunPageView = where(/*"Appraisal Status" = filter(Appraisee), */"Appraisal Stage" = filter(" "));
                }
                action("Appraisee Appraisal List")
                {
                    Caption = 'Target Setting (Appraisee)';
                    RunObject = page "Appraissal List";
                    RunPageView = where("Appraisal Status" = filter(Appraisee), "Appraisal Stage" = filter("Target Setting"));
                }
                action("Appraisal List")
                {
                    Caption = 'Achieved Targets (Appraisee)';
                    RunObject = page "Appraissal List";
                    RunPageView = where("Appraisal Status" = filter(Appraisee), "Appraisal Stage" = filter("Achieved Target"));
                    // RunPageLink = "Appraisal Status" = filter(Appraisee);
                }
                action("Supervisor Appraisal List")
                {
                    RunObject = page "Appraissal List";
                    RunPageView = where("Appraisal Status" = filter(Supervisor), "Appraisal Stage" = filter("Supervisor Evaluation"));
                    // RunPageLink = "Appraisal Stage" = filter("Target Approval");
                    Caption = 'Target Approval (Supervisor)';
                }
                // action("Appraisee's Evaluation List")
                // {
                //     RunObject = page "Appraissal List";
                //     // RunPageLink = "Appraisal Stage" = filter("End Year Evaluation");
                //     Caption = 'Appraisee Evaluation List';
                // }
                action("Supervisor Evaluation List")
                {
                    RunObject = page "Appraissal List";
                    RunPageView = where("Appraisal Stage" = filter("Appraisal Completed"));
                    // RunPageLink = "Appraisal Stage" = filter("Supervisor Evaluation");
                    Caption = 'Completed Appraisals';
                }

                // action("HR Completed Appraisal List")
                // {
                //     RunObject = page "Appraissal List";
                //     RunPageLink = "Appraisal Stage" = filter("Appraisal Completed");
                //     Caption = 'HR Completed Appraisal List';
                // }
            }
            group("Leave Management")
            {
                action("Leave Period List")
                {
                    RunObject = page "HR Leave Period List";
                    Caption = 'Leave Period List';
                }
                action("Leave Types")
                {
                    Caption = 'Leave Types';
                    RunObject = Page "HR Leave Types";
                }
                action("Leave Application")
                {
                    Caption = 'Leave Applications';
                    RunObject = page "HR Leave Applications List";
                    RunPageView = where(Status = filter(<>Approved), Posted = filter(false));
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
                action("Leave Journal Lines")
                {
                    Caption = 'HR Leave Journal Lines';
                    RunObject = Page "HR Leave Journal Lines";
                }
            }

            group(Recruitment)
            {
                action("Hr Job List")
                {
                    Caption = 'HR Jobs List';
                    Image = Employee;
                    RunObject = page "HR Jobs List";
                }
                action("Employee Requisition")
                {
                    Caption = 'Employee Requisition';
                    Image = Employee;
                    RunObject = page "HR Employee Requisitions List";
                }
                action("Job Application")
                {
                    Caption = 'Job Application';
                    Image = Employee;
                    RunObject = page "HR Job Applications List";
                }
                action("Short Listed")
                {
                    Caption = 'Short Listed';
                    Image = Employee;
                    RunObject = page "HR Shortlisting List";
                }
                action("Qualified")
                {
                    Caption = 'Qualified Listed';
                    Image = Employee;
                    RunObject = page "HR Job Applicants Qualified";
                }
                action("Un-Qualified")
                {
                    Caption = 'Un-Qualified Listed';
                    Image = Employee;
                    RunObject = page "HR Applicants UnQualified List";
                }
            }
            
            Group(SaccoPayroll)
            {
                Caption = 'Payroll Management';
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
                group("Payroll Reports ")
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
                    action("Payroll Summary")
                    {
                        Caption = 'Payroll Summary';
                        RunObject = report PayrollSummary;
                        Visible = false;
                    }
                    action("Send Payslips")
                    {
                        Caption = 'Send Payslip via Mail';
                        RunObject = report "Send Payslips Via Mail";
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
            group("HR Setups")
            {
                action("HR Setup")
                {
                    Caption = 'HR Setups';
                    RunObject = Page "HR Setup";
                }
                action("Performance Setup")
                {
                    Caption = 'Appraisal Setups';
                    RunObject = Page Perfomacesetup;
                }
                action("Appraisal Period")
                {
                    Caption = 'Appraisal Period';
                    RunObject = Page "Appraisal Periods";
                }
                action("HR Leave journal Template")
                {
                    Caption = 'HR Leave Journal Template';
                    RunObject = Page "HR Leave journal Template";
                }
                action("HR Lookup Values List")
                {
                    Caption = 'HR Lookup Values List';
                    RunObject = page "HR Lookup Values List";
                }
                action("Bank Codes List")
                {
                    Caption = 'Bank Codes List';
                    RunObject = page "Bank Codes Listing";
                }
                action("Base calendar")
                {
                    Caption = 'Base Calendar';
                    RunObject = page "Base Calendar List";
                }
            }
            group("Staff Introductory Commission")
            {
                action(SalaryRegister)
                {
                    Caption = 'Register Salary Accounts';
                    RunObject = Page "Register Member Salary List";
                }
                action(StaffBonusPayment)
                {
                    Caption = 'Pay Staff';
                    RunObject = page "Pay Staff Marketing List";
                }
            }
            group("Member Accounts")
            {
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
                group("Member FOSA Accounts")
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
            }
            group("ChangeRequest")
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

            group("Loan Mananagement")
            {
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
profile "Human Resource Role Center"
{
    Caption = 'HR Profile';
    RoleCenter = "HR Role RC";
    ProfileDescription = 'Role Center tailored to the Human Resource Department';
}


