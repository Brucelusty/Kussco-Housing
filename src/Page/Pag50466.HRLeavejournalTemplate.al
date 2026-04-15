//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50466 "HR Leave journal Template"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Journal Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Test Report ID";Rec."Test Report ID")
                {
                }
                field("Form ID";Rec."Form ID")
                {
                }
                field("Posting Report ID";Rec."Posting Report ID")
                {
                }
                field("Force Posting Report";Rec."Force Posting Report")
                {
                }
                field("Source Code";Rec."Source Code")
                {
                }
                field("Reason Code";Rec."Reason Code")
                {
                }
                field("Test Report Name";Rec."Test Report Name")
                {
                }
                field("Form Name";Rec."Form Name")
                {
                }
                field("Posting Report Name";Rec."Posting Report Name")
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Posting No. Series";Rec."Posting No. Series")
                {
                }
            }
        }
    }

    actions
    {
    }
}






