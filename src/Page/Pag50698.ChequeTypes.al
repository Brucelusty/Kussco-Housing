//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50698 "Cheque Types"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Cheque Types";

    layout
    {
        area(content)
        {
            repeater(Control14)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Clearing Days";Rec."Clearing Days")
                {
                }
                field("Clearing  Days";Rec."Clearing  Days")
                {
                }
                field("Use %";Rec."Use %")
                {
                }
                field("% Of Amount";Rec."% Of Amount")
                {
                }
                field("Clearing Charges";Rec."Clearing Charges")
                {
                }
                field("Bounced Charges";Rec."Bounced Charges")
                {
                }
                field("Clearing Bank Account";Rec."Clearing Bank Account")
                {
                }
                field("Bank Name";Rec."Bank Name")
                {
                }
                field("Bounced Charges GL Account";Rec."Bounced Charges GL Account")
                {
                }
                field("Clearing Charges GL Account";Rec."Clearing Charges GL Account")
                {
                }
                field("Bankers Cheque Fee";Rec."Bankers Cheque Fee")
                {
                }
                field("Bankers Cheque Fee Account";Rec."Bankers Cheque Fee Account")
                {
                }
                field("Bounced Cheque Sacco Income";Rec."Bounced Cheque Sacco Income")
                {
                }
            }
        }
    }

    actions
    {
    }
}






