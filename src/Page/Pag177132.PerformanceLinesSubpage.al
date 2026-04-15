namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 51210 "Performance Lines Subpage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Performance Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("KPI Code"; Rec."KPI Code") { }
                field(Target; Rec.Target) { }
                field(Actual; Rec.Actual) { }
                field(Weight; Rec.Weight) { }
                field(Score; Rec.Score) { Editable = false; }
                field("Weighted Score"; Rec."Weighted Score") { Editable = false; }
            }
        }
    }
}




