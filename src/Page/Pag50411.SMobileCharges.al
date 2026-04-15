//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50411 "S-Mobile Charges"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "S-Mobile Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field(Source; Rec.Source)
                {
                }
                field(Tiered; Rec.Tiered)
                {
                }
            }
        }
    }

    actions
    {
    }
}






