page 50206 "Key Performance Indicators"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Key Performance Indicators";
    CardPageId = "Key Perform Indicators Card";
    
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Key Value Drivers";Rec."Key Value Drivers")
                {}
                field(Indicator;Rec.Indicator)
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


