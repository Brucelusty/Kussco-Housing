//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50395 "Teller Role Centre"
{
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1)
            {
                Caption = 'Members';
                part(Control3; "Members Only")
                {
                }
            }
            part(Control1000000018; "Members Only")
            {
                Caption = 'All Members';
            }
            group(Control1000000015)
            {
            }
            // part(Control1000000001)
            // {
            // }
            systempart(Control1000000000; MyNotes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Member Balances")
            {
                Caption = 'Member Balances';
                Image = "Report";
                //     RunObject = Report "Member Accounts  balances";
            }
            action("Member Statement")
            {
                Caption = 'Member Statement';
                Image = "Report";
                // RunObject = Report "Member Account Statement-New";
            }
            action("Member Guarantors")
            {
                Caption = 'Member Guarantors';
                Image = "Report";
                //  RunObject = Report "Loans Guarantors Details";
            }
            action("Credit Loans Register-CFC")
            {
                Caption = 'Credit Loans Register-CFC';
                Image = Register;
                //  RunObject = Report "Loans Guard Report";
            }
            action("Credit Loans Register-Board")
            {
                Caption = 'Credit Loans Register-Board';
                Image = Register;
                //   RunObject = Report "Update E-Loan Qualification";
            }
            action("Members Loan Register")
            {
                Caption = 'Members Loan Register';
                Image = "Report";
                // RunObject = Report "Loans Register";
            }
            action("Loans Guaranteed")
            {
                Caption = 'Loans Guaranteed';
                Image = "Report";
                // RunObject = Report "Member Loans Guaranteed";
            }
            action("Loans Repayment Schedule")
            {
                Caption = 'Loans Repayment Schedule';
                Image = "Report";
                //   RunObject = Report "Loans Repayment Schedule";
            }
            action("Loans Batch Schedule")
            {
                Caption = 'Loans Batch Schedule';
                Image = "Report";
                //   RunObject = Report "Loans Batch Schedule";
            }
            action("Loans Appraisal")
            {
                Caption = 'Loans Appraisal';
                Image = "Report";
                //   RunObject = Report "Loan Appraisal Ver1";
            }
            action("Loan Balances")
            {
                Caption = 'Loan Balances';
                Image = "Report";
                //  RunObject = Report "Loan Balances FOSA";
            }
            action("Loans Defaulter Aging")
            {
                Caption = 'Loans Defaulter Aging';
                Image = "Report";
                //   RunObject = Report "Loans Defaulter Aging - SASRA";
            }
            separator(Action1000000009)
            {
                Caption = 'Dividends';
            }
            action("Prorated Dividends Processing")
            {
                Caption = 'Prorated Dividends Processing';
                Image = "Report";
                //  RunObject = Report "Dividend Processing-Prorated";
            }
            action("Flat Rate Dividends Processing")
            {
                Caption = 'Flat Rate Dividends Processing';
                Image = "Report";
                //   RunObject = Report "Dividend Processing-Flat Rate";
            }
            action("Dividends Register")
            {
                Caption = 'Dividends Register';
                Image = "Report";
                //   RunObject = Report "Dividend Register";
            }
            action("Dividends Progression")
            {
                Caption = 'Dividends Progression';
                Image = "Report";
                //   RunObject = Report "Dividends Progressionslip";
            }
            separator(Action1000000019)
            {
            }
            action("Checkoff Main")
            {
                Caption = 'Checkoff Main';
                //  RunObject = Report "Data Sheet Main";
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Balance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
            }
        }
        area(sections)
        {
            group(Members)
            {
                Caption = 'Members';
                Image = Journals;
                action("Member List")
                {
                    Caption = 'Member List';
                    RunObject = Page "Members List";
                }
            }
            group("Members Regiatration")
            {
                Caption = 'Members Regiatration';
                Image = Journals;
                action(jjj)
                {
                    Caption = 'Individual/Joint Application list';
                    RunObject = Page "Membership Application List";
                }
            }
            group("FOSA Savings Product")
            {
                Caption = 'FOSA Savings Product';
                Image = Journals;
                action("FOSA Product Applications")
                {
                    Caption = 'FOSA Product Applications';
                    RunObject = Page "Member Account Application";
                }
                action("Savings product list")
                {
                    Caption = 'Savings product list';
                    RunObject = Page "Member Accounts List";
                }
            }
            group("Common Requisitions")
            {
                Caption = 'Common Requisitions';
                Image = FixedAssets;
                action("Leave Application")
                {
                    Caption = 'Leave Application';
                    RunObject = Page "HR Leave Applications List";
                }
                action("Imprest Requisition")
                {
                    Caption = 'Imprest Requisition';
                    RunObject = Page "Imprest List";
                }
                action("Store Requisitions")
                {
                    Caption = 'Store Requisitions';
                    RunObject = Page "Open Store Requisitions List";
                }
            }
            group("Cashier Transactions")
            {
                Caption = 'Cashier Transactions';
                action("Cashier Transactions - List")
                {
                    Caption = 'Cashier Transactions - List';
                    RunObject = Page "Cashier Transactions - List";
                }
                action("<Page Cashier Transactions - Lis")
                {
                    Caption = 'Posted Cashier Transactions - List';
                    RunObject = Page "Posted Cashier Transactions";
                }
            }
            group("Teller/Treasury Management")
            {
                Caption = 'Teller/Treasury Management';
                action("Teller & Treasury Trans List")
                {
                    Caption = 'Teller & Treasury Trans List';
                    RunObject = Page "Teller & Treasury Trans List";
                }
                action(Action1000000004)
                {
                    Caption = 'Teller & Treasury Trans List';
                    RunObject = Page "Teller Till List";
                }
            }
            group("Document Approvals")
            {
                Caption = 'Document Approvals';
                action("Approval Request")
                {
                    Caption = 'Approval Request';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                }
            }
        }
    }
}




