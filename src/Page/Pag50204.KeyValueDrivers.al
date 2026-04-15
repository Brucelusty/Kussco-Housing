page 50204 "Key Value Drivers"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Key Value Drivers";
    CardPageId = "Key Value Drivers Card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
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


