//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50706 "Status Change Permisions"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Status Change Permision";

    layout
    {
        area(content)
        {
            repeater(Control3)
            {
                field("Function"; Rec."Function")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}






