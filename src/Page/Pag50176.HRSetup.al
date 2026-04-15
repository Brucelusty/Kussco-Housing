//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50176 "HR Setup"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Leave Posting Period[FROM]";Rec."Leave Posting Period[FROM]")
                {
                }
                field("Leave Posting Period[TO]";Rec."Leave Posting Period[TO]")
                {
                }
                field("Default Leave Posting Template";Rec."Default Leave Posting Template")
                {
                    Visible = false;
                }
                field("Leave Template";Rec."Leave Template")
                {
                }
                field("Leave Batch";Rec."Leave Batch")
                {
                }

                field("Positive Leave Posting Batch";Rec."Positive Leave Posting Batch")
                {
                    Visible = false;
                }
                field("Negative Leave Posting Batch";Rec."Negative Leave Posting Batch")
                {
                    Visible = false;
                }
                field("Max Appraisal Rating";Rec."Max Appraisal Rating")
                {
                }
                field("Scheme Name";Rec."Scheme Name")
                {
                }
                field("Renewal Date";Rec."Renewal Date")
                {
                }
                field("Policy No.";Rec."Policy No.")
                {
                }
                field("Weekday Hourly Rate";Rec."Weekday Hourly Rate")
                {
                }
                field("Weekend Hourly Rate";Rec."Weekend Hourly Rate")
                {
                }
                field("Employer Pin";Rec."Employer Pin")
                {
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Base Calendar";Rec."Base Calendar")
                {
                }
                field("Employee Nos.";Rec."Employee Nos.")
                {
                }
                field("Training Application Nos.";Rec."Training Application Nos.")
                {
                }
                field("Performance Numbers";Rec."Performance Numbers")
                {
                }
                field("Leave Application Nos.";Rec."Leave Application Nos.")
                {
                }
                field("Disciplinary Cases Nos.";Rec."Disciplinary Cases Nos.")
                {
                }
                field("Employee Requisition Nos.";Rec."Employee Requisition Nos.")
                {
                }
                field("Medical Claims Nos";Rec."Medical Claims Nos")
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
                field("Job Nos";Rec."Job Nos")
                {
                }
                field("Job Interview Nos";Rec."Job Interview Nos")
                {
                }
                field("Notice Board Nos.";Rec."Notice Board Nos.")
                {
                }
                field("Transport Req Nos";Rec."Transport Req Nos")
                {
                }
                field("HR Policies";Rec."HR Policies")
                {
                }
                field("Leave Reimbursment Nos.";Rec."Leave Reimbursment Nos.")
                {
                }
                field("Leave Carry Over App Nos.";Rec."Leave Carry Over App Nos.")
                {
                }
                field("Pay-change No.";Rec."Pay-change No.")
                {
                }
                field("Employee Transfer Nos.";Rec."Employee Transfer Nos.")
                {
                }
                field("Leave Planner Nos.";Rec."Leave Planner Nos.")
                {
                }
                field("Committee Nos";Rec."Committee Nos")
                {
                }
                field("Meeting Nos";Rec."Meeting Nos")
                {
                }
            }
            group(Leave)
            {
                Caption = 'Leave';
                field("Min. Leave App. Day";Rec."Min. Leave App. Day")
                {
                }
                field("Probation Period";Rec."Probation Period")
                {
                }
                field("Days Before Leave";Rec."Days Before Leave")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}




