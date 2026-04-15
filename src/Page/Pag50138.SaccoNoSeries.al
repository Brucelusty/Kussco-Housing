//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50138 "Sacco No. Series"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    SourceTable = "Sacco No. Series";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Primary Key"; Rec."Primary Key")
                {
                    Editable = false;
                }
                field("SMS Request Series"; Rec."SMS Request Series")
                {
                }
            }
            group(Marketing)
            {
                field("BD Partner Nos."; Rec."BD Partner Nos.") { }
                field("BD Opportunity Nos."; Rec."BD Opportunity Nos.") { }
                field("BD Activity Nos."; Rec."BD Activity Nos.") { }
                field("Contact Nos"; Rec."Contact Nos")
                {

                }
                field("Member Application Nos"; Rec."Member Application Nos")
                {
                }
                field("Applicants Nos."; Rec."Applicants Nos.")
                {
                    Caption = 'Junior Applications';
                }
                field("Group Application Nos"; Rec."Group Application Nos")
                {
                }
                field("Commission Nos"; Rec."Commission Nos")
                {
                }
            }
            group(Credit)
            {
                Caption = 'Credit';


                field("Business Comp Payroll Nos"; Rec."Business Comp Payroll Nos")
                {
                    Visible = false;
                }
                field("Prime Tech Payroll Nos"; Rec."Prime Tech Payroll Nos")
                {
                    Visible = false;
                }
                field("Reat Security Payroll Nos"; Rec."Reat Security Payroll Nos")
                {
                    Visible = false;
                }
                field("Micro Loans"; Rec."Micro Loans")
                {
                    Visible = false;
                }

                field("Members Nos"; Rec."Members Nos")
                {
                }
                field("Debenture Nos"; Rec."Debenture Nos")
                {
                }
                field("Junior Account Nos"; Rec."Junior Account Nos")
                {
                }
                field("New Fixed Deposits"; Rec."New Fixed Deposits")
                {
                }
                field("Fixed Deposit Placement"; Rec."Fixed Deposit Placement")
                {
                }
                field("Call Deposit Placement"; Rec."Call Deposit Placement")
                {
                }
                field("Signatories Application Doc No"; Rec."Signatories Application Doc No")
                {

                }
                field("Signatories Document No"; Rec."Signatories Document No")
                {
                }
                field("BOSA Loans Nos"; Rec."BOSA Loans Nos")
                {
                    Caption = 'Loan Numbers';
                }
                field("E-Loan Nos"; Rec."E-Loan Nos")
                {
                    Visible = false;
                }
                field("Loans Batch Nos"; Rec."Loans Batch Nos")
                {
                    Caption = 'Loan Batch Numbers';
                }
                field("Exit Batch Nos"; Rec."Exit Batch Nos")
                {
                }
                field("Loan Restructure"; Rec."Loan Restructure")
                {
                }
                field("BOSA Receipts Nos"; Rec."BOSA Receipts Nos")
                {
                    Caption = 'Receipt Numbers';
                }
                field("FOSA Receipts Nos"; Rec."FOSA Receipts Nos")
                {
                    Visible = false;
                }
                field("BOSA Transfer Nos"; Rec."Account Transfer Nos")
                {
                    Caption = 'Transfer Numbers';
                }
                field("Defaulter Case No"; Rec."Defaulter Case No")
                {
                    Caption = 'Defaulter Case No';
                }
                field("CLosure Notice Nos"; Rec."CLosure Notice Nos")
                {
                }
                field("Closure  Nos"; Rec."Closure  Nos")
                {
                }
                field("Bosa Transaction Nos"; Rec."Bosa Transaction Nos")
                {
                    Caption = 'Transaction Numbers';
                }
                field("Paybill Processing"; Rec."Paybill Processing")
                {
                    Visible = false;
                }
                field("Checkoff-Proc Distributed Nos"; Rec."Checkoff-Proc Distributed Nos")
                {
                    Visible = false;
                }
                field("Checkoff Proc Block Nos"; Rec."Checkoff Proc Block Nos")
                {
                    Visible = false;
                }
                field(BosaNumber; rec.BosaNumber)
                {
                    Visible = false;
                    Caption = 'Member No Used';
                }
                field("Loan PayOff Nos"; Rec."Loan PayOff Nos")
                {
                    Visible = false;
                }
                field("Microfinance Last No Used"; Rec."Microfinance Last No Used")
                {
                    Visible = false;
                }
                field("MicroFinance Account Prefix"; Rec."MicroFinance Account Prefix")
                {
                    Visible = false;
                }
                field("Micro Transactions"; Rec."Micro Transactions")
                {
                    Visible = false;
                }
                field("Micro Finance Transactions"; Rec."Micro Finance Transactions")
                {
                    Visible = false;
                }
                field("Collateral Register No"; Rec."Collateral Register No")
                {
                }
                field("Cloudpesa Reg No."; Rec."Cloudpesa Reg No.")
                {
                    Visible = false;
                }
                field("Safe Custody Package Nos"; Rec."Safe Custody Package Nos")
                {
                }
                field("Safe Custody Agent Nos"; Rec."Safe Custody Agent Nos")
                {
                }
                field("Safe Custody Item Nos"; Rec."Safe Custody Item Nos")
                {
                }
                field("Package Retrieval Nos"; Rec."Package Retrieval Nos")
                {
                }
                field("Member Cell Group Nos"; Rec."Member Cell Group Nos")
                {
                    Visible = false;
                }
                field("Risk Nos"; Rec."Risk Nos")
                {
                    // Visible = false;
                }
                field("House Change Request No"; Rec."House Change Request No")
                {
                    Visible = false;
                }
                field("BD Training Nos"; Rec."BD Training Nos")
                {
                }

                field("Member Agent/NOK Change"; Rec."Member Agent/NOK Change")
                {
                }
                field("House Group Application"; Rec."House Group Application")
                {
                    Visible = false;
                }
                field("House Group Nos"; Rec."House Group Nos")
                {
                    Visible = false;
                }
                field("CRB Charge"; Rec."CRB Charge")
                {
                    Caption = 'CRB Check Charge No';
                }
                field("Over Draft Application No"; Rec."Over Draft Application No")
                {
                    Visible = false;
                }

                field("Collateral Movement No"; Rec."Collateral Movement No")
                {
                    Visible = false;
                }
                field("Sweeping Instructions"; Rec."Sweeping Instructions")
                {
                    Visible = false;
                }
                field("Employers Nos"; Rec."Employers Nos")
                {
                    Visible = false;
                }
                field("Scheduled Statements"; Rec."Scheduled Statements")
                {
                    Visible = false;
                }
                field("Payroll Document No"; Rec."Payroll Document No")
                {
                }
                field("Audit issue Tracker"; Rec."Audit issue Tracker")
                {
                    Visible = false;
                }
                field("Guarantor Sub No."; Rec."Guarantor Sub No.")
                {
                    Visible = false;
                }

                field("Standing Order Members Nos"; Rec."Standing Order Members Nos")
                {
                    Visible = false;
                }
                field("Change Request No"; Rec."Change Request No")
                {
                }
                field("Funeral Rider Nos"; Rec."Funeral Rider Nos")
                {
                    Visible = false;
                }
                field("ESS Refund Nos"; Rec."ESS Refund Nos")
                {
                    Visible = false;
                }
                field("ESS Refund Batch Nos"; Rec."ESS Refund Batch Nos")
                {
                    Visible = false;
                }
                field("Savings Variation Nos"; Rec."Savings Variation Nos")
                {
                    Visible = false;
                }
                field("Meeting Nos"; Rec."Meeting Nos")
                {
                    Visible = false;
                }
                field("Delegate Allowance Nos"; Rec."Delegate Allowance Nos")
                {
                    Visible = false;
                }
                field("File Movement Nos"; Rec."File Movement Nos")
                {

                }
                field("File Return Nos"; Rec."File Return Nos")
                {
                }
                field("NOK Application Nos"; Rec."NOK Application Nos")
                {
                    Visible = false;
                }
                field("Sacco Correspondence Nos"; Rec."Sacco Correspondence Nos")
                {
                    Visible = false;
                }
                field("Coop Dividends"; Rec."Coop Dividends")
                {
                    Visible = false;
                }
                field("Tranche Nos"; Rec."Tranche Nos")
                {
                }
                field("Performance Header No"; Rec."Performance Header No")
                {
                }

            }
            group("Banking Services")
            {
                Visible = false;
                Caption = 'Banking Services';

                field("FOSA Loans Nos"; Rec."FOSA Loans Nos")
                {
                }
                field("Transaction Nos."; Rec."Transaction Nos.")
                {
                }
                field("Treasury Nos."; Rec."Treasury Nos.")
                {
                }
                field("Standing Orders Nos."; Rec."Standing Orders Nos.")
                {
                }
                field("FOSA Current Account"; Rec."FOSA Current Account")
                {
                }
                field("BOSA Current Account"; Rec."BOSA Current Account")
                {
                }
                field("Teller Transactions No"; Rec."Teller Transactions No")
                {
                }
                field("Treasury Transactions No"; Rec."Treasury Transactions No")
                {
                }

                field("STO Register No"; Rec."STO Register No")
                {
                }
                field("EFT Header Nos."; Rec."EFT Header Nos.")
                {
                }
                field("RTGS Header Nos."; Rec."RTGS Header Nos.")
                {
                }
                field("EFT Details Nos."; Rec."EFT Details Nos.")
                {
                }
                field("Salary Processing Nos"; Rec."Salary Processing Nos")
                {
                }
                field("Delayed Salary No"; Rec."Delayed Salary No")
                {
                }
                field("Salaries Nos."; Rec."Salaries Nos.")
                {
                }
                field("ATM Applications"; Rec."ATM Applications")
                {
                }
                field("Cheque Clearing Nos"; Rec."Cheque Clearing Nos")
                {
                }
                field("Cheque Application Nos"; Rec."Cheque Application Nos")
                {
                }
                field("Cheque Receipts Nos"; Rec."Cheque Receipts Nos")
                {
                }
                field("Customer Care Log Nos"; Rec."Customer Care Log Nos")
                {
                }
                field("S_Mobile Registration Nos"; Rec."S_Mobile Registration Nos")
                {
                }
                field("Trunch Disbursment Nos"; Rec."Trunch Disbursment Nos")
                {
                }

                field("Agent Serial Nos"; Rec."Agent Serial Nos")
                {
                }
                field("ATM Card Batch Nos"; Rec."ATM Card Batch Nos")
                {
                }
                field("Cheque Book Batch Nos"; Rec."Cheque Book Batch Nos")
                {
                }
                field("Demand Notice Nos"; Rec."Demand Notice Nos")
                {
                }

                field("Cheque Book Account Nos"; Rec."Cheque Book Account Nos")
                {
                }


                field("Member Account Agent App"; Rec."Member Account Agent App")
                {
                    Caption = 'Account Agent Document No';
                }
                field("Member Account Agent"; Rec."Member Account Agent")
                {
                    Caption = 'Account Agent Document No';
                }
                field("Account Freezing No"; Rec."Account Freezing No")
                {
                }
                field("Internal PV Document"; Rec."Internal PV Document")
                {
                }
                field("Journal Batch Doc. No"; Rec."Journal Batch Doc. No")
                {
                }
                field("Piggy Bank No"; Rec."Piggy Bank No")
                {
                }
                field("Petty Cash Requisition Nos"; Rec."Petty Cash Requisition Nos")
                {
                }

            }
            group("Finance/Others")
            {
                Caption = 'Finance/Others';
                field("Finance UpLoads"; Rec."Finance UpLoads")
                {
                }
                field("Requisition No"; Rec."Requisition No")
                {
                }
                field("Internal Requisition No."; Rec."Internal Requisition No.")
                {
                }
                field("Internal Purchase No."; Rec."Internal Purchase No.")
                {
                }
                field("Quatation Request No"; Rec."Quatation Request No")
                {
                }
                field("Stores Requisition No"; Rec."Stores Requisition No")
                {
                }
                field("Requisition Default Vendor"; Rec."Requisition Default Vendor")
                {
                }
                field("Use Procurement limits"; Rec."Use Procurement limits")
                {
                }
                field("Request for Quotation Nos"; Rec."Request for Quotation Nos")
                {
                }
                field("Investors Nos"; Rec."Investors Nos")
                {
                }
                field("Property Nos"; Rec."Property Nos")
                {
                }
                field("Investment Project Nos"; Rec."Investment Project Nos")
                {
                }
                field("Withholding Tax %"; Rec."Withholding Tax %")
                {
                }
                field("Withholding Tax Account"; Rec."Withholding Tax Account")
                {
                }
                field("VAT %"; Rec."VAT %")
                {
                }
                field("VAT Account"; Rec."VAT Account")
                {
                }
            }
            group(Investor)
            {
                Caption = 'Investor';
                field("Investor Application Nos"; Rec."Investor Application Nos")
                {
                }
                field("Investor Nos"; Rec."Investor Nos")
                {
                }
                field("Paybill No."; Rec."Paybill No.")
                {
                }

            }
        }
    }

    actions
    {
    }
}




