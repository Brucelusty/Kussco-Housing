//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50556 "HR Setup List"
{
    ApplicationArea = All;
    CardPageID = "HR Setup";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Administration';
    RefreshOnActivate = false;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Leave Posting Period[FROM]";Rec."Leave Posting Period[FROM]")
                {
                }
                field("Leave Posting Period[TO]";Rec."Leave Posting Period[TO]")
                {
                }
                field("Default Leave Posting Template";Rec."Default Leave Posting Template")
                {
                }
                field("Positive Leave Posting Batch";Rec."Positive Leave Posting Batch")
                {
                }
                field("Base Calendar";Rec."Base Calendar")
                {
                }
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
                field("Job Interview Nos";Rec."Job Interview Nos")
                {
                }
                field("Leave Reimbursment Nos.";Rec."Leave Reimbursment Nos.")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("HR Policies")
            {
                Caption = 'HR Policies';
                Image = Planning;
                Promoted = true;
                PromotedCategory = Category4;
                ///RunObject = Page "HR Policies";
            }
            action("E-Mail Parameters")
            {
                Caption = 'E-Mail Parameters';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR E-Mail Parameters";
            }
            action(Calendar)
            {
                Caption = 'Calendar';
                Image = Calendar;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Base Calendar Card";
            }
            action("Leave Allocation")
            {
                Caption = 'Leave Allocation';
                Image = AccountingPeriods;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Leave Journal Lines";
            }
        }
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






