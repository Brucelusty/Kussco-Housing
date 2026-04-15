page 50205 "Key Value Drivers Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Key Value Drivers";
    
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Key Value Driver";Rec."Key Value Driver")
                {}
                field(Description;Rec.Description)
                {}
            }
        }
    }
    
    actions
    {
    }
    
    var
        myInt: Integer;
}


