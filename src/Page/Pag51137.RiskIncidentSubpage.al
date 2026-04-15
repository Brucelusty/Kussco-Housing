page 51137 "Risk Incident Subpage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Risk Incident Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Date"; Rec."Incident Date") { }
                field(Description; Rec.Description) { }
                field("Reported By"; Rec."Reported By") { }
            }
        }
    }
}


