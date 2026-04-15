//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50515 "HR Employee Qualification Line"
{
    ApplicationArea = All;
    Caption = 'Employee Qualification Lines';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Qualification Type";Rec."Qualification Type")
                {
                }
                field("Qualification Code";Rec."Qualification Code")
                {
                }
                field("Qualification Description";Rec."Qualification Description")
                {
                }
                field("Course of Study";Rec."Course of Study")
                {
                }
                field("From Date";Rec."From Date")
                {
                }
                field("To Date";Rec."To Date")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Institution/Company";Rec."Institution/Company")
                {
                }
                field("Course Grade";Rec."Course Grade")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const("Employee Qualification"),
                                  "No." = field("Employee No."),
                                  "Table Line No." = field("Line No.");
                }
                separator(Action1102755021)
                {
                }
                action("Q&ualification Overview")
                {
                    Caption = 'Q&ualification Overview';
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}






