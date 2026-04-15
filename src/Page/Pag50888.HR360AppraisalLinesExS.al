//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50888 "HR 360 Appraisal Lines - ExS"
{
    ApplicationArea = All;
    Caption = 'HR Appraisal Lines - External Sources (Customers,Vendors)';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where("Categorize As" = const("External Sources"));

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
                field("External Source Rating";Rec."External Source Rating")
                {
                }
                field("External Source Comments";Rec."External Source Comments")
                {
                }
                field("Employee Comments";Rec."Employee Comments")
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
        Rec."Categorize As" := Rec."categorize as"::"External Sources";
    end;
}






