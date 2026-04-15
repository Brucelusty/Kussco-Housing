//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50477 "HR Job Responsiblities Lines"
{
    ApplicationArea = All;
    CardPageID = "hr job responsibilities card";
    PageType = ListPart;
    SourceTable = "HR Job Responsiblities";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Responsibility Code";Rec."Responsibility Code")
                {
                   // Editable = false;
                }
                field("Responsibility Description";Rec."Responsibility Description")
                {
                    //Enabled = false;
                }
                field(Remarks; Rec.Remarks)
                {
                   // Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}






