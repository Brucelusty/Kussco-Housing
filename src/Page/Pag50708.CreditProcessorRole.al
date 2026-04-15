//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50708 "Credit Processor Role"
{
    ApplicationArea = All;
    Caption = 'Credit ';
    PageType = CardPart;
    SourceTable = "Cue Sacco Roles";

    layout
    {
        area(content)
        {
            cuegroup("Loan Activities")
            {
                Caption = 'Loan Activities';
                field("Application Loans"; Rec."Application Loans")
                {
                    DrillDownPageID = "Employee Common Activities";
                }
                field("Loans in Pre-Appraissal"; Rec."Appraisal Loans")
                {
                }
                field("Loans In Valuation"; Rec."Loans In Valuation")
                {
                }
                field("Loans In Credit Committeee"; Rec."Loans In Credit Committeee")
                {
                }
                field("Loans being Charged"; Rec."Loans being Charged")
                {
                }
                field("Loans In Finance"; Rec."Approved Loans")
                {
                }
                field("Running Loans"; Rec."Running Loans")
                {
                }
                field("Total Loan Book"; Rec."Total Loan Book")
                {
                }
                field("Interest Due"; Rec."Total Interest")
                {
                }

            }
        }
    }

    /*     actions
        {
            area(processing)
            {
                action("Loans Calculator")
                {
                    //     RunObject = Page UnknownPage172026;
                }
                action("Members  List")
                {
                    RunObject = Page "Scheduled Statements Card";
                }
                action("Bosa Loans")
                {
                    RunObject = Page "HR Job Responsibilities";
                }
            }
        } */
}
// Page "HR Applicant Referees";
// Page ""HR ;""






