namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 51199 "KPI Setup List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "KPI Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("KPI Code"; Rec."KPI Code") { }
                field(Description; Rec.Description) { }
                field("KPI Type"; Rec."KPI Type") { }
                field(Weight; Rec.Weight) { }
                field(Target; Rec.Target) { }
                field("Reverse Score"; Rec."Reverse Score") { }
        
            }
        }
    }
}



