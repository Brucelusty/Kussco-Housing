//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50889 "HR 360 Appraisal Lines - JS"
{
    ApplicationArea = All;
    Caption = 'HR Appraisal Lines - Job Specific';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where("Categorize As" = const("Job Specific"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub Category";Rec."Sub Category")
                {
                }
                field("Perfomance Goals and Targets";Rec."Perfomance Goals and Targets")
                {
                }
                field("Min. Target Score";Rec."Min. Target Score")
                {
                }
                field("Max Target Score";Rec."Max Target Score")
                {
                }
                field("Self Rating";Rec."Self Rating")
                {
                }
                field("Employee Comments";Rec."Employee Comments")
                {
                }
                field("Supervisor Rating";Rec."Supervisor Rating")
                {
                }
                field("Supervisor Comments";Rec."Supervisor Comments")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Categorize As" := Rec."categorize as"::"Job Specific";
    end;
}






