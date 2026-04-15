//************************************************************************
pageextension 50020 "UserSetupExtension" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
       addafter("Allow Posting To")       
         {
            field(Department;Rec.Department)
            {
                ApplicationArea = all;
            }
        }
        addlast(Control1)
        {

            field("Branch Code"; Rec."Branch Code") { ApplicationArea = all; }
            field("Allow FA Posting From"; Rec."Allow FA Posting From")
            {
                applicationarea = all;

            }
            field("Allow FA Posting To"; Rec."Allow FA Posting To")
            {
                applicationarea = all;

            }
            field("Archiving User"; Rec."Archiving User")
            {
                applicationarea = all;

            }
            field("Is Manager"; Rec."Is Manager")
            {
                applicationarea = all;

            }
            field("Password Does Not Expire";Rec."Password Does Not Expire")
            {
                applicationarea = all;

            }
            field("Internal Auditor";Rec."Internal Auditor")
            {
                applicationarea = all;

            }
            field("Allow Process Payroll"; Rec."Allow Process Payroll")
            {
                applicationarea = all;

            }
            field("Member Registration"; Rec."Member Registration")
            {
                applicationarea = all;

            }

            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                applicationarea = all;

            }
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                applicationarea = all;

            }
            field("Petty C Amount Approval Limit"; Rec."Petty C Amount Approval Limit")
            {
                applicationarea = all;

            }
            field("View Payroll"; Rec."View Payroll")
            {
                applicationarea = all;

            }
            field("Post Pv"; Rec."Post Pv")
            {
                ApplicationArea = all;
            }
            field("Loan Product Setup"; Rec."Loan Product Setup")
            {
                ApplicationArea = all;
            }
            field(Overdraft;Rec.Overdraft)
            {
                ApplicationArea = All;
            }
            field("Change account status"; Rec."Change account status")
            {
                ApplicationArea = all;
            }
            field("Change Defaulter Status"; Rec."Change Defaulter Status")
            {
                ApplicationArea = all;
            }
            field("Can edit recovery mode"; Rec."Can edit recovery mode")
            {
                ApplicationArea = all;
            }
           
            field("Add Employers"; Rec."Add Employers")
            {
                ApplicationArea = All;
            }
            field("Loan Porfolio Manager";Rec."Loan Porfolio Manager")
            {
                ApplicationArea = All;
            }
            field("Debt Collector";Rec."Debt Collector")
            {
                ApplicationArea = All;
            }
            field("Bulk SMS";Rec."Bulk SMS")
            {
                ApplicationArea = All;
            }
            field(Leave;Rec.Leave)
            {
                ApplicationArea = All;
                Caption = 'Post Leave';
            }
            field("Can View Staff Accounts";Rec."Can View Staff Accounts")
            {
                ApplicationArea = All;
            }
            field("Can Edit Chart Of Accounts";Rec."Can Edit Chart Of Accounts")
            {
                ApplicationArea = All;
            }
            field("Lock Change Profile & Company"; Rec."Lock Change Profile & Company")
            {
                ApplicationArea = All;
            }
            field("Freeze Amount"; Rec."Freeze Amount")
            {
                ApplicationArea = All;
            }
            field("Send Red Flagged SMS"; Rec."Send Red Flagged SMS")
            {
                ApplicationArea = All;
            }
            field("Can Capture Multiple Loans";Rec."Can Capture Multiple Loans")
            {
                ApplicationArea = All;
            }
            field("Can Process Allowances";Rec."Can Process Allowances")
            {
                ApplicationArea = All;
            }
            field("Can Rectify Penalty";Rec."Can Rectify Penalty")
            {
                ApplicationArea = All;
            }
            field("Post Pending ABC";Rec."Post Pending ABC")
            {
                ApplicationArea = All;
            }
            field("Phone Number"; Rec."Phone Number")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
