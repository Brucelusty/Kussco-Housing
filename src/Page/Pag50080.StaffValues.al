Page 50080 "Staff Values"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Staff Values";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Value; Rec.Value)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Weight;Rec.Weight)
                {
                }
            }
        }
    }

    actions
    {
    }
}



