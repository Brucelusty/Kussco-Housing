page 51044 "DebtManagement Role Center" //Role center for marketing department
{
    ApplicationArea = All;
    Caption = 'DebtManagement ';
    PageType = RoleCenter;
    
    layout
    {
        area(RoleCenter)
        {
            // part(DashbordVisualizationCardPar; "Dashbord Visualization CardPar")
            // {
            //     Visible = true;
            //     //Caption='Navigate';
            // }
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
            group(Action84)
            {
                Caption = 'Membership Management';
                
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
            group("Saving Products Management")
            {
                Caption = 'Saving Products Management';
                Image = Bank;
                ToolTip = 'Manage Saving Accounts Eg. FOSA Savings and Fixed Deposits';

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
            group("Loan Mananagement")
            {
                action("BOSA Loan Application")
                {
                    Caption = 'Loan Application';
                    Image = CreditCard;
                    RunObject = Page "Loan Application BOSA(New)";
                    ToolTip = 'Open BOSA Loan Applications';
                }
                action("Loans Under Appraisal")
                {
                    Caption = 'Loans Under Appraisal';
                    Image = CreditCard;
                    RunObject = Page "Loan Appraisal List";
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
            }
            group("CRB List")
            {
                action("CRB List2")
                {
                    Caption = 'CRB List';
                    RunObject = page "CRBA List";
                }
            }
            group("Recon Reports")
            {
                Visible = true;
                action("Checkoff Processing List")
                {
                    Caption = 'Checkoff Processing List';
                    Image = Account;
                    RunObject = page "Checkoff Processing-D List";
                    ToolTip = 'Checkoff Processing List';
                }
                
                action("Processed Salary List")
                {
                    Caption = 'Processed Salary List';
                    Image = Account;
                    RunObject = page "Processed Salary List";
                    ToolTip = 'Processed Salary List';
                }

            }
            group("Loan Reports")
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
                   // RunObject = report "Loans Under Recovery Report";
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
            group("Defaulter Management")
            {
                group("DebtManagement")
                {
                    Caption = 'Debt Portfolio Management';
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
                    action(WrittedOffLoans)
                    {
                        Caption = 'Written-Off Loans List';
                        RunObject = page "WrittenOff Loans List";
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
                    action(GuarantorSubstitution)
                    {
                        Caption = 'Guarantor Substitution List';
                        RunObject = page "Guarantorship Sub List";
                    }
                    action(PostedGuarantorSubstitution)
                    {
                        Caption = 'Posted Guarantor Substitution List';
                        RunObject = page "Processed Guarantor Sub List";
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
profile "DebtManagement Role Center"
{
    Caption = 'Debt Management Profile';
    RoleCenter = "DebtManagement Role Center";
    ProfileDescription = 'Role Center customized to facilitate the funtions of the Debt-Management team.';
}


