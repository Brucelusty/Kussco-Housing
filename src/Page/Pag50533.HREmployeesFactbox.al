//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50533 "HR Employees Factbox"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            field(PersonalDetails; PersonalDetails)
            {
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("No.";Rec."No.")
            {
            }
            field("First Name";Rec."First Name")
            {
            }
            field("Middle Name";Rec."Middle Name")
            {
            }
            field("Last Name";Rec."Last Name")
            {
            }
            field("E-Mail";Rec."E-Mail")
            {
            }
            field("Company E-Mail";Rec."Company E-Mail")
            {
            }
            field(Status; Rec.Status)
            {
            }
            field(JobDetails; JobDetails)
            {
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Job Title";Rec."Job Title")
            {
            }
            field(Grade; Rec.Grade)
            {
            }
            field("Leave Details"; "Leave Details")
            {
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Annual Leave Account";Rec."Annual Leave Account")
            {
            }
            field("Compassionate Leave Acc.";Rec."Compassionate Leave Acc.")
            {
            }
            field("Maternity Leave Acc.";Rec."Maternity Leave Acc.")
            {
            }
            field("Paternity Leave Acc.";Rec."Paternity Leave Acc.")
            {
            }
            field("Sick Leave Acc.";Rec."Sick Leave Acc.")
            {
            }
        }
    }

    actions
    {
    }

    var
        PersonalDetails: label 'Personal Details';
        BankDetails: label 'Bank Details';
        JobDetails: label 'Job Details';
        "Leave Details": label 'Leave Details';
}






