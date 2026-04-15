//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50492 "HR Job Requirement Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "HR Job Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Qualification Type";Rec."Qualification Type")
                {
                    Importance = Promoted;
                }
                field("Qualification Code";Rec."Qualification Code")
                {
                    Importance = Promoted;
                }
                field("Qualification Description";Rec."Qualification Description")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field(Priority; Rec.Priority)
                {
                }
                field("Desired Score";Rec."Desired Score")
                {
                }
                field("Total (Stage)Desired Score";Rec."Total (Stage)Desired Score")
                {
                    Visible = false;
                }
                field(Mandatory; Rec.Mandatory)
                {
                }
            }
        }
    }

    actions
    {
    }
}






