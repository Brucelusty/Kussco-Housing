//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50638 "Member Departments List"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Member Departments";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("No."; Rec."No.")
                {
                }
                field(Department; Rec.Department)
                {
                }
            }
        }
    }

    actions
    {
    }
}






