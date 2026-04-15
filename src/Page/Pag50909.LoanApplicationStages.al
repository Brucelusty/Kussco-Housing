//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50909 "Loan Application Stages"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loan Application Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Stage";Rec."Loan Stage")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Loan Stage Description";Rec."Loan Stage Description")
                {
                    Editable = false;
                }
                field("Stage Status";Rec."Stage Status")
                {
                }
                field("Date Upated";Rec."Date Upated")
                {
                    Editable = false;
                }
                field("Updated By";Rec."Updated By")
                {
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    Width = 10;
                }
            }
        }
    }

    actions
    {
    }
}






