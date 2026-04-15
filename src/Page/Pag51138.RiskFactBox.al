page 51138 "Risk FactBox"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Risk Register";

    layout
    {
        area(content)
        {
            group("Risk Summary")
            {
                field("Risk Score"; Rec."Risk Score") { }
                field(Status; Rec.Status) { }
                field("Due Date"; Rec."Due Date") { }
                field(Escalated; Rec.Escalated) { }
            }
        }
    }
}


