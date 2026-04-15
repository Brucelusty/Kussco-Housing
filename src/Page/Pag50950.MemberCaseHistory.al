//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50950 "Member Case History"
{
    ApplicationArea = All;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Cases Management";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number";Rec."Case Number")
                {
                }
                field("Date of Complaint";Rec."Date of Complaint")
                {
                }
                field("Type of cases";Rec."Type of cases")
                {
                }
                field("Recommended Action";Rec."Recommended Action")
                {
                }
                field("Case Description";Rec."Case Description")
                {
                }
                field("Action Taken";Rec."Action Taken")
                {
                }
                field("Solution Remarks";Rec."Solution Remarks")
                {
                }
                field("Case Resolution Details";Rec."Case Resolution Details")
                {
                }
                field("Caller Reffered To";Rec."Caller Reffered To")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Resolved User";Rec."Resolved User")
                {
                    Caption = 'Resolved By';
                }
                field("Date Resolved";Rec."Date Resolved")
                {
                }
                field("Time Resolved";Rec."Time Resolved")
                {
                }
            }
        }
    }

    actions
    {
    }
}






