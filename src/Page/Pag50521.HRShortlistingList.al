//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50521 "HR Shortlisting List"
{
    ApplicationArea = All;
    CardPageID = "HR Shortlisting Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = where(Status = const(Approved),
                            Closed = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition No.";Rec."Requisition No.")
                {
                }
                field("Job Description";Rec."Job Description")
                {
                }
                field("Requisition Date";Rec."Requisition Date")
                {
                }
                field(Requestor; Rec.Requestor)
                {
                }
                field("Reason For Request";Rec."Reason For Request")
                {
                }
                field(Closed; Rec.Closed)
                {
                }
                field("Closing Date";Rec."Closing Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755005; Outlook)
            {
            }
        }
    }

    actions
    {
    }
}






