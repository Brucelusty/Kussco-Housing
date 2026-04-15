page 50207 "Key Perform Indicators Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Key Performance Indicators";
    
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Key Value Drivers";Rec."Key Value Drivers")
                {}
                field("KVD Description";Rec."KVD Description")
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


