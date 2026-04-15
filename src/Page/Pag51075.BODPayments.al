page 51075 "BOD Payments"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "BOD Honoraria";
    CardPageId = "BOD Payments Card";
    DeleteAllowed = false;
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Honoraria No";Rec."Honoraria No")
                {
                }
                field(Description;Rec.Description)
                {
                }
                field("Initiated On";Rec."Initiated On")
                {
                }
                field("Posted On";Rec."Posted On")
                {
                }
                field("Total Amount";Rec."Total Amount")
                {
                }
                field(Paid;Rec.Paid)
                {
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            
        }
    }
}


