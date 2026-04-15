//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50524 "HR Training Application List"
{
    ApplicationArea = All;
    CardPageID = "HR Training Application Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Application No";Rec."Application No")
                {
                }
                field("Course Title";Rec."Course Title")
                {
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Description; Rec.Description)
                {
                }
                field("Purpose of Training";Rec."Purpose of Training")
                {
                }
                field("From Date";Rec."From Date")
                {
                }
                field("To Date";Rec."To Date")
                {
                }
                field("Cost Of Training";Rec."Cost Of Training")
                {
                    Caption = 'Estimated Cost';
                }
                field("Approved Cost";Rec."Approved Cost")
                {
                }
                field(Provider; Rec."Provider Name")
                {
                }
                field("No. of Participant";Rec."No. of Participant")
                {
                }
                field(Status; Rec.Status)
                {
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Trainings Factbox")
            {
                SubPageLink = "Application No" = field("Application No");
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Training Applications List")
            {
                Caption = 'Training Applications List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "HR Training Applications List";
            }
            action("Training Applications")
            {
                Caption = 'Training Applications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "HR Training ApplicationsS";
            }
        }
    }
}






