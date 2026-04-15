//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50397 "Finance Role Centre"
{
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1000000041; "SO Processor Activities")
            {
                Caption = 'Finance Activities';
            }
            group(Control1000000015)
            {
            }
            systempart(Control1000000000; MyNotes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Member Statement")
            {
                Caption = 'Member Statement';
                Image = "Report";
                //  RunObject = Report "Member Account Statement-New";
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
            action("Bank Account List")
            {
                Caption = 'Bank Account List';
                RunObject = Page "Bank Account List";
            }
            action("Bank Acc. Reconciliation List")
            {
                Caption = 'Bank Acc. Reconciliation List';
                RunObject = Page "Bank Acc. Reconciliation List";
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
                action("memeber list editable")
                {
                    Caption = 'Member List-Editable';
                    RunObject = Page "Member List-Editable";
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
                    Caption = 'Group/Corporate Applications List';
                    RunObject = Page "Group Applic List";
                }
                action("51516554")
                {
                    Caption = 'Church  Applications List';
                    RunObject = Page "Loans  List- pending approval";
                }
                action("Membership Application List")
                {
                    RunObject = Page "Membership Application List";
                }
                action("Group/Corporate Applic List")
                {
                    RunObject = Page "Group Applic List";
                }
            }
            group("FOSA Membership")
            {
                Caption = 'FOSA Membership';
                Image = Journals;
                action("51516430")
                {
                    Caption = 'FOSA Product Applications';
                    RunObject = Page "Member Account Application";
                }
                action("51516435")
                {
                    Caption = 'Savings product list';
                    RunObject = Page "Member Accounts List";
                }
                action("Fixed Deposit Acc. List")
                {
                    Caption = 'Fixed Deposit Acc. List';
                    RunObject = Page "Fixed Deposit Acc. List";
                }
            }
            group("Teller/Tresury Management")
            {
                Caption = 'Teller/Tresury Management';
                Image = Journals;
                action(Treasury)
                {
                    RunObject = Page "Treasury List";
                }
                action("Teller Till List")
                {
                    RunObject = Page "Teller Till List";
                }
                action("Teller/Treasury Transactions")
                {
                    RunObject = Page "Teller & Treasury Trans List";
                }
            }
            group(Loans)
            {
                Caption = 'Loans';
                Image = Journals;
                action("Loans Applications BOSA")
                {
                    Caption = 'Loans Applications BOSA';
                    RunObject = Page "Loans Applied  List";
                }
                action("Loans Applications FOSA")
                {
                    Caption = 'Loans Applications FOSA';
                    RunObject = Page "Loan Application FOSA(New)";
                }
                action("Loans Disbursment Batch List")
                {
                    Caption = 'Loans Disbursment Batch List';
                    RunObject = Page "Loans Disbursment Batch List";
                }
                action("Loan Trunch Disburesment List")
                {
                    Caption = 'Loan Trunch Disburesment List';
                    RunObject = Page "Loan Trunch Disburesment List";
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
                action("Posted Loan Batch - List")
                {
                    Caption = 'Posted Loan Batch - List';
                    RunObject = Page "Posted Loan Batch - List";
                }
            }
            group(Procurement)
            {
                Caption = 'Procurement';
                action("Item List")
                {
                    Caption = 'Item List';
                    RunObject = Page "Item List";
                }
                action(Suppliers)
                {
                    Caption = 'Suppliers';
                    RunObject = Page "Vendor List";
                }
                action("Purchase Order")
                {
                    Caption = 'Purchase Order';
                    RunObject = Page "Purchase Order List";
                }
                action("Purchase Invoices")
                {
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Stores Order List")
                {
                    Caption = 'Stores Order List';
                    RunObject = Page "Stores Order List";
                }
                action("Purchase Order Archives")
                {
                    Caption = 'Purchase Order Archives';
                    RunObject = Page "Purchase Order Archives";
                }
                action("Requisitions to Dispatch")
                {
                    Caption = 'Requisitions to Dispatch';
                    RunObject = Page "Store Requisitions List-App";
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
            group("Payment Processes")
            {
                Caption = 'Payment Processes';
                action("Payment Voucher Payment")
                {
                    Caption = 'Payment Voucher Payment';
                    RunObject = Page "Payment Voucher List";
                }
                action("Petty Cash Payments")
                {
                    Caption = 'Petty Cash Payments';
                    RunObject = Page "New Petty Cash Payments List";
                }
                action("Funds Transfer List")
                {
                    Caption = 'Funds Transfer List';
                    RunObject = Page "Funds Transfer List";
                }
                action("Cheque Book Application List")
                {
                    Caption = 'Cheque Book Application List';
                    RunObject = Page "Cheque Book Application - New";
                }
                action("Salary Processing List")
                {
                    Caption = 'Salary Processing List';
                    RunObject = Page "Salary Processing List";
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
                action("Sacco Transfer")
                {
                    Caption = 'Sacco Transfer List';
                    //RunObject = Page Sacco tr;
                }
                action("EFT List")
                {
                    Caption = 'EFT List';
                    RunObject = Page "New EFT/RTGS List";
                }
                action("Paybill Processing List")
                {
                    Caption = 'Paybill Processing List';
                    RunObject = Page "Paybill Processing List";
                }
                action("Inhouse Cheque Clearing List")
                {
                    Caption = 'Inhouse Cheque Clearing List';
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
        area(processing)
        {
            action("General Journals")
            {
                Caption = 'General Journals';
                Image = Journal;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "General Journal";
            }
            action("Payment &Journal")
            {
                Caption = 'Payment &Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
            }
            action("P&urchase Journal")
            {
                Caption = 'P&urchase Journal';
                Image = Journals;
                RunObject = Page "Purchase Journal";
            }
            separator(Action22)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("Import Sacco Jnl")
            {
                Caption = 'Import Sacco Jnl';
                Image = Allocate;
                RunObject = XMLport "Import Sacco Jnl";
            }
            action("Purchases && Payables &Setup")
            {
                Caption = 'Purchases && Payables &Setup';
                Image = Setup;
                RunObject = Page "Purchases & Payables Setup";
            }
            separator(Action20)
            {
                Caption = 'History';
                IsHeader = true;
            }

        }
    }
}




