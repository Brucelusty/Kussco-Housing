page 50320 "Credit Department Role Center"
{
    ApplicationArea = All;
    PageType = RoleCenter;
    Caption = 'Credit Dept RC';

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
        area(Creation)
        {
            action("loan Application")
            {
                RunPageMode = Create;
                Caption = 'Loan Application';
                ToolTip = 'Apply for a new loan here';
                Image = New;
                RunObject = page "Loan Application Card(BOSA)";
            }
        }
        area(Processing)
        {
            group("All Loans")
            {
                action("Loans posted")
                {
                    RunPageMode = view;
                    Caption = 'Loans posted';
                    ToolTip = 'All Loans posted';
                    RunObject = page "Loans Posted List";
                    Image = DataEntry;
                }
            }
            group("Loans Report")
            {
                action("Loans Disbursed")
                {
                    Caption = 'Loans Disbursed Per Product';
                    ToolTip = 'Loans Disbursed Per Product';
                    Image = Report;
                    RunObject = report "Loans Disbursed Per Product";
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
        area(Sections)
        {
            Group("Membership")
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
                group("ChangeRequest")
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
                    action(StatusChangeRequest)
                    {
                        Caption = 'Status Change Request';
                        RunObject = report "Member Status Change Request";
                    }
                }
            }
            group("BOSA Loans Management")
            {
                Caption = 'Loan Management';
                ToolTip = 'BOSA Loans'' Management Module';
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
                action("Pending BOSA Loan Application")
                {
                    Caption = 'Loans Pending Approval';
                    Image = CreditCard;
                    RunObject = Page "Loans  List- pending approval";
                    ToolTip = 'Open the list of Pending BOSA Loan Applications.';
                }
                action("Pending Mobile Loans")
                {
                    Caption = 'Pending Mobile Loans';
                    Image = CreditCard;
                    RunObject = Page "Mobile Loans Pending";
                    RunPageView = where(Posted = filter(false), "Approval Status" = filter(Pending),"Requires Guarantors Mobile"=filter(true),"Archive Loan"=filter(false));
                    ToolTip = 'Pending Mobile Loans';
                }
                action("Portal Loans")
                {
                    Caption = 'Portal Loans';
                    Image = CreditCard;
                    RunObject = Page "Mobile Loans Pending";
                    RunPageLink = "Loan Application Mode" = filter(Portal);
                    ToolTip = 'All Portal Applied Loans';
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
                action("Express Batch List")
                {
                    RunObject = page "Loans Disbursment  List Exp";
                    Caption = 'Loan Batch List(Express)';
                }
                action("Archived Loans")
                {
                    Caption = 'Archived Loans';
                    RunObject = Page "Loans Archived List";
                    ToolTip = 'Open the list of the Loans Archived.';
                }
                group("Posted Loans")
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

                action("Data Sheet Main")
                {
                    Caption = 'Data Sheet Main';
                    RunObject = Page "Data Sheet Main";
                    ToolTip = 'Data Sheet Main';
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
                action("Loans Repayment")
                {
                    Caption = 'Loans Repayment';
                    RunObject = report "Loans Repayment";
                }
                action("Posted Loans List")
                {
                    Caption = 'Posted Loans List';
                    RunObject = report "Posted Loans List";
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
                action("Loan Aging Report")
                {
                    Caption = 'Loan Aging Report';
                    RunObject = report "Loans Defaulter Aging Display";
                }//
                action("Loan Classification Process")
                {
                    Caption = 'Loan Aging Report As At';
                    RunObject = report "Loans Defaulter Aging CPY";
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
                action("Loan Classification")
                {
                    Caption = 'Loan Classification';
                    RunObject = report "Loans Defaulter Aging - SASRA";
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
                        Caption = 'WrittenOff Loans List';
                        RunObject = page "WrittenOff Loans List";
                    }
                    action(SmsNotificatioDebt)
                    {
                        Caption = 'Defaulter Sms Notification';
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
                    action(PostedGuarantorSubstitution)
                    {
                        Caption = 'Posted Guarantor Substitution List';
                        RunObject = page "Processed Guarantor Sub List";
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
            group("SMS Management")
            {
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

profile "Credit Department Profile"
{
    Caption = 'Credit Department Profile';
    RoleCenter = "Credit Department Role Center";
    ProfileDescription = 'Role Center tailored to the credit department.';
    //Customizations = Customizations;
}



