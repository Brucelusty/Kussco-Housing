//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50591 "Hr Leave Planner Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "HR Leave Planner Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Type";Rec."Leave Type")
                {
                }
                field("Days Applied";Rec."Days Applied")
                {
                }
                field("Start Date";Rec."Start Date")
                {
                }
                field("End Date";Rec."End Date")
                {
                }
                field("Return Date";Rec."Return Date")
                {
                }
                field("Applicant Comments";Rec."Applicant Comments")
                {
                }
                field("Request Leave Allowance";Rec."Request Leave Allowance")
                {
                }
                field(Reliever; Rec.Reliever)
                {
                }
                field("Reliever Name";Rec."Reliever Name")
                {
                }
                field("Approved days";Rec."Approved days")
                {
                }
                field("Date of Exam";Rec."Date of Exam")
                {
                }
                field("Details of Examination";Rec."Details of Examination")
                {
                }
            }
        }
    }

    actions
    {
    }
}






