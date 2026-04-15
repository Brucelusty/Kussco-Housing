page 51123 "MLM Level Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "MLM Level Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Level Code"; Rec."Level Code") { }
                field("Level No."; Rec."Level No.") { }
                field(Description; Rec.Description) { }
                field("Bonus Type"; Rec."Bonus Type") { }
                field("Commission %"; Rec."Commission %") { }
                field("Fixed Amount"; Rec."Fixed Amount") { }
                field("Min Contribution Amount"; Rec."Min Contribution Amount") { }
                field(Eligible; Rec.Eligible) { }
                field(Active; Rec.Active) { }
            }
        }
    }
}


