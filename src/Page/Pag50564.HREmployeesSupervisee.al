//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50564 "HR Employees Supervisee"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employees Supervisees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supervisor No.";Rec."Supervisor No.")
                {
                }
                field("Supervisee No.";Rec."Supervisee No.")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Job Title";Rec."Job Title")
                {
                }
                field("Key Experience";Rec."Key Experience")
                {
                }
                field(From; Rec.From)
                {
                }
                field("To";Rec."To")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Number of Supervisees";Rec."Number of Supervisees")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755011; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*HREmployeeSupervisees.RESET;
        HREmployeeSupervisees.SETRANGE(HREmployeeSupervisees."Supervisor No.","Supervisor No.");
        IF HREmployeeSupervisees.GET THEN
        SETRANGE("Supervisor No.",HREmployeeSupervisees."Supervisor No.")
        ELSE
        //user id may not be the creator of the doc
        SETRANGE("Supervisor No.","Supervisor No.");
         */

    end;
}






