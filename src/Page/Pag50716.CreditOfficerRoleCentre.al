//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50716 "Credit Officer Role Centre"
{
    ApplicationArea = All;
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1000000012)
            {
                part("Member Processor"; "Membership Processor")
                {
                }
                part("Credit Processor"; "Credit Processor Role")
                {
                }
                group(Control1000000008)
                {
                }
                systempart(Control1000000007; Outlook)
                {
                }
            }
            group(Control1000000006)
            {
            }
            group(Control1000000005)
            {
                systempart(Control1000000004; MyNotes)
                {
                }
                group(Control1000000003)
                {
                }

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
                //   RunObject = Report "Member Accounts  balances";
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
                //  RunObject = Report "Loans Register";
            }
            action("Loans Guaranteed")
            {
                Caption = 'Loans Guaranteed';
                Image = "Report";
                //   RunObject = Report "Member Loans Guaranteed";
            }
            action("Loans Repayment Schedule")
            {
                Caption = 'Loans Repayment Schedule';
                Image = "Report";
                //    RunObject = Report "Loans Repayment Schedule";
            }
            action("Loans Batch Schedule")
            {
                Caption = 'Loans Batch Schedule';
                Image = "Report";
                //  RunObject = Report "Loans Batch Schedule";
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
                //   RunObject = Report "Loan Balances FOSA";
            }
            action("Loans Defaulter Aging")
            {
                Caption = 'Loans Defaulter Aging';
                Image = "Report";
                //   RunObject = Report "Loans Defaulter Aging - SASRA";
            }
            separator(Action1000000048)
            {
                Caption = 'Dividends';
            }
            action("Prorated Dividends Processing")
            {
                Caption = 'Prorated Dividends Processing';
                Image = "Report";
                //   RunObject = Report "Dividend Processing-Prorated";
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
                //  RunObject = Report "Dividend Register";
            }
            action("Dividends Progression")
            {
                Caption = 'Dividends Progression';
                Image = "Report";
                //   RunObject = Report "Dividends Progressionslip";
            }
            separator(Action1000000043)
            {
            }
            action("Checkoff Main")
            {
                Caption = 'Checkoff Main';
                //   RunObject = Report "Data Sheet Main";
            }
        }
        area(creation)
        {
            action("Recover Defaulted Loan From Loanee Deposit")
            {
                Caption = 'Recover Defaulted Loan From Loanee Deposit';
                Image = "Report";
                //  RunObject = Report "Recover Defaulted Loans-Share";
            }
            action("Attatch Defaulted Loan to Guarantors")
            {
                Caption = 'Attatch Defaulted Loan to Guarantors';
                Image = "Report";
                //   RunObject = Report "Recover Defaulted Loans-Guara";
            }
            action("Recover Defaulted Loan From Guarantors Deposit")
            {
                Caption = 'Recover Defaulted Loan From Guarantors Deposit';
                Image = "Report";
                //   RunObject = Report "Rec Default Loans-Guara_Dep";
            }
            action("Loan Defaulter 1st Notice")
            {
                Caption = 'Loan Defaulter 1st Notice';
                Image = "Report";
                // RunObject = Report "Loan Defaulter 1st Notice";
            }
            action("Loan Defaulter 2nd Notice")
            {
                Caption = 'Loan Defaulter 2nd Notice';
                Image = "Report";
                //   RunObject = Report "Loan Defaulter 2st Notice";
            }
            action("Defaulter Final Notice")
            {
                Caption = 'Defaulter Final Notice';
                Image = "Report";
                //  RunObject = Report "Defaulter Final Notice";
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
                action(eee)
                {
                    Caption = 'Self Employed Applicants';
                   // RunObject = Page "Membership App Unemployed";
                }
            }
            group(Loans)
            {
                Caption = 'Loans';
                Image = Journals;
                action("Loans Applied BOSA")
                {
                    Caption = 'Loans Applied BOSA';
                    RunObject = Page "Loans Applied  List";
                    RunPageView = where("Approval Status" = const(Open));
                }
                action("Loans Applied FOSA")
                {
                    Caption = 'Loans Applied FOSA';
                    RunObject = Page "Loan Application FOSA(New)";
                    RunPageView = where("Approval Status" = const(Open));
                }
                action("Loans Pending Approval BOSA")
                {
                    Caption = 'Loans Pending Approval BOSA';
                    RunObject = Page "Loans  List- pending approval";
                    RunPageView = where("Approval Status" = const(Pending));
                }
                action("Loans Pending Approval FOSA")
                {
                    Caption = 'Loans Pending Approval FOSA';
                    RunObject = Page "Loan Application FOSA(Pending)";
                    RunPageView = where("Approval Status" = const(Pending));
                }
                action("Loans PayOff List")
                {
                    Caption = 'Loans PayOff List';
                    RunObject = Page "Loan PayOff List";
                }
                action("Approved Loans")
                {
                    Caption = 'Approved Loans';
                    Image = Journals;
                    RunObject = Page "Loans Application List(Approv)";
                    RunPageView = where("Approval Status" = const(Approved));
                }
                action("Loan Batches")
                {
                    Caption = 'Loan Batches';
                    Image = Journals;
                    RunObject = Page "Loans Disbursment Batch List";
                    RunPageView = where(Posted = filter(false));
                }
                action("Posted Loans BOSA")
                {
                    Caption = 'Posted Loans BOSA';
                    RunObject = Page "Loans Posted List";
                }
                action("Posted Loans FOSA")
                {
                    Caption = 'Posted Loans FOSA';
                    RunObject = Page "Loan Application FOSA(Posted)";
                }
                action(Action1000000029)
                {
                    Caption = 'Posted Loans FOSA';
                    RunObject = Page "Posted Loan PayOff List";
                }
                action("Posted Loan Batches")
                {
                    Caption = 'Posted Loan Batches';
                    RunObject = Page "Posted Loan Batch - List";
                }
                action(Action1000000031)
                {
                    Caption = 'Posted Loan Batches';
                    RunObject = Page "Loans Rejected List";
                }
            }
            group("CheckOff Processing")
            {
                Caption = 'CheckOff Processing';
                action("Checkoff Processing Distributed")
                {
                    Caption = 'Checkoff Processing Distributed';
                   // RunObject = Page "Checkoff Processing-D List";
                }
                action("Checkoff Processing Block")
                {
                    Caption = 'Checkoff Processing Block';
                    RunObject = Page "Bosa Receipts H List-Checkoff";
                }
            }
            group("Membership Withdrawal")
            {
                Caption = 'Membership Withdrawal';
                action(Action1000000073)
                {
                    Caption = 'Membership Withdrawal';
                    RunObject = Page "Membership Exit List";
                }
                action("Posted Member Withdrawal")
                {
                    Caption = 'Posted Member Withdrawal';
                    RunObject = Page "Posted Member Withdrawal List";
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
                action("Medical Claims")
                {
                    Caption = 'Medical Claims';
                    RunObject = Page "HR Medical Claims List";
                }
                action("Store Requisitions")
                {
                    Caption = 'Store Requisitions';
                    RunObject = Page "Open Store Requisitions List";
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




