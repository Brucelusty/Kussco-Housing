//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50738 "PAYE Tax Brackets Credit"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "PAYE Brackets Credit";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tax Band";Rec."Tax Band")
                {
                }
                field("Lower Limit";Rec."Lower Limit")
                {
                }
                field("Upper Limit";Rec."Upper Limit")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("Taxable Amount";Rec."Taxable Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}






