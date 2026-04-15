//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50697 "Front Office Charges"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Charges;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                }
                field("Charge Type"; Rec."Charge Type")
                {
                }
                field("Use Percentage";Rec."Use Percentage")
                {
                }
                field("Percentage of Amount";Rec."Percentage of Amount")
                {
                }
                field(Minimum; Rec.Minimum)
                {
                }
                field(Maximum; Rec.Maximum)
                {
                }
                field("GL Account";Rec."GL Account")
                {
                }
                field("Sacco Amount";Rec."Sacco Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}






