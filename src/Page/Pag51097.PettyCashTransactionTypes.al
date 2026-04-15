page 51097 "Petty Cash Transaction Types"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Petty Cash Transaction Types";
    
    layout
    {
        area(Content)
        {
            Repeater(General)
            {
                field(Code;Rec.Code)
                {
                }
                field(Description;Rec.Description)
                {
                }
                field("Destination Account";Rec."Destination Account")
                {
                }
            }
        }
    }
    
    actions
    {
        
    }
    
    var
        myInt: Integer;
}


