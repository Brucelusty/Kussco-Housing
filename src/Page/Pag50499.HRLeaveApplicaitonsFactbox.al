//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50499 "HR Leave Applicaitons Factbox"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            label(Control1102755011)
            {
                CaptionClass = Text1;
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
            field("Job Title";Rec."Job Title")
            {
            }
            field(Status; Rec.Status)
            {
            }
            field("E-Mail";Rec."E-Mail")
            {
            }
            label(Control1102755005)
            {
                Style = StrongAccent;
                StyleExpr = true;
            }
            label(Control1102755012)
            {
                CaptionClass = Text2;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Allocated Leave Days";Rec."Allocated Leave Days")
            {
            }
            field("Reimbursed Leave Days 2";Rec."Reimbursed Leave Days 2")
            {
                Caption = 'Reimbursed Leave Days';
            }
            field("Total Leave Taken";Rec."Total Leave Taken")
            {
                Caption = 'Total Leave Days Taken';
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
            field("Study Leave Acc";Rec."Study Leave Acc")
            {
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Employee Details';
        Text2: label 'Employeee Leave Details';
    //Text3: ;
}






