page 65721 "Staggered Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = //Table51516708
    "AU Safcom Corporate Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Minimum;rec.Minimum)
                {
                }
                field(Maximum;rec.Maximum)
                {
                }
                field(Charge;rec.Charge)
                {
                }
                field("Use Percentage";rec."Use Percentage")
                {
                }
                field(Percentage;rec.Percentage)
                {
                }
                field(VAT;rec.VAT)
                {
                }
            }
        }
    }

    actions
    {
    }
}



