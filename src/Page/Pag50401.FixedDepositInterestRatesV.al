//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50401 "Fixed Deposit Interest Rates V"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "FD Interest Calculation Crite";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Minimum Amount";Rec."Minimum Amount")
                {
                }
                field("Maximum Amount";Rec."Maximum Amount")
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Interest Rate";Rec."Interest Rate")
                {
                }
                field("On Call Interest Rate";Rec."On Call Interest Rate")
                {
                }
                field("No of Months";Rec."No of Months")
                {
                }
            }
        }
    }

    actions
    {
    }
}






