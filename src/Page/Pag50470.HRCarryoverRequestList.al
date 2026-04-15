//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50470 "HR Carryover Request List"
{
    ApplicationArea = All;
    CardPageID = "HR Leave Carryover Request";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Carry Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; Rec."Application Code")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Applicant Comments"; Rec."Applicant Comments")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Attachments; Rec.Attachments)
                {
                }
            }
        }
    }

    actions
    {
    }
}






