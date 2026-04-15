//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50594 "hr job responsibilities card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HR Job Responsiblities";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job ID";Rec."Job ID")
                {
                }
                field("Responsibility Code";Rec."Responsibility Code")
                {
                }
                field("Responsibility Description";Rec."Responsibility Description")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}






