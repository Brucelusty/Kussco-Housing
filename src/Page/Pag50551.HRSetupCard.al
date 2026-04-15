//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50551 "HR Setup Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            group("Leave Period")
            {
                Caption = 'Leave Period';
                field("Leave Posting Period[FROM]";Rec."Leave Posting Period[FROM]")
                {
                }
                field("Leave Posting Period[TO]";Rec."Leave Posting Period[TO]")
                {
                }
                field("Leave Template";Rec."Leave Template")
                {
                }
                field("Leave Batch";Rec."Leave Batch")
                {
                }
            }
            group("HR Number Series")
            {
                Caption = 'HR Number Series';
                field("Employee Nos.";Rec."Employee Nos.")
                {
                }
                field("Training Application Nos.";Rec."Training Application Nos.")
                {
                }
                field("Leave Application Nos.";Rec."Leave Application Nos.")
                {
                }
                field("Disciplinary Cases Nos.";Rec."Disciplinary Cases Nos.")
                {
                }
                field("Transport Req Nos";Rec."Transport Req Nos")
                {
                }
                field("Employee Requisition Nos.";Rec."Employee Requisition Nos.")
                {
                }
                field("Job Application Nos";Rec."Job Application Nos")
                {
                }
                field("Exit Interview Nos";Rec."Exit Interview Nos")
                {
                }
                field("Appraisal Nos";Rec."Appraisal Nos")
                {
                }
                field("Company Activities";Rec."Company Activities")
                {
                }
                field("Default Leave Posting Template";Rec."Default Leave Posting Template")
                {
                }
                field(s; Rec."Positive Leave Posting Batch")
                {
                }
            }
        }
    }

    actions
    {
    }
}






