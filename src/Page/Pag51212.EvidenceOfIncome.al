page 51212 "Evidence Of Income Part"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Evidence Of Income";
    Caption = 'Evidence Of Income';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Evidence Of Income"; Rec."Evidence Of Income")
                {
                }

                field("Period Covered"; Rec."Period Covered")
                {
                }

                field(Observations; Rec.Observations)
                {
                }
            }
        }
    }
}
