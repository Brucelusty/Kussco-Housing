page 51139 "Risk Incident List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Risk Incident Log";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Risk ID"; Rec."Risk ID") { }
                field("Incident Date"; Rec."Incident Date") { }
                field(Description; Rec.Description) { }
                field("Reported By"; Rec."Reported By") { }
            }
        }
    }
}


