//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50404 "Account Types Interest Rates"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Account Types Interest Rates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                }
                field("Maximum Balance"; Rec."Maximum Balance")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
            }
        }
    }

    actions
    {
    }
}






