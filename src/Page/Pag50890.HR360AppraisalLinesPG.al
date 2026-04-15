//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50890 "HR 360 Appraisal Lines - PG"
{
    ApplicationArea = All;
    Caption = 'HR Appraisal Lines - Personal Goals/Objectives';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where("Categorize As" = const("Personal Goals/Objectives"));

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
        Rec."Categorize As" := Rec."categorize as"::"Personal Goals/Objectives";
        Rec."Sub Category" := Rec."sub category"::"Personal Goals";
    end;
}






