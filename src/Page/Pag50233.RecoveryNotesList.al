page 50233 "Recovery Notes List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Recovery Notes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Recovery Notes";Rec."Recovery Notes")
                {
                }
                field(Date;Rec.Date)
                {
                }
                field(Times;Rec.Times)
                {
                }
            }
        }
    }

    actions
    {
    }
}




