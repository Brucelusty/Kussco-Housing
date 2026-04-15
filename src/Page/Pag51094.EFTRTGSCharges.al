page 51094 "EFT/RTGS Charges"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "EFT - RTGS Charges";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lower Limit";Rec."Lower Limit")
                {
                }
                field("Upper Limit";Rec."Upper Limit")
                {
                }
                field("Charge Amount";Rec."Charge Amount")
                {
                }
                field("Charge Account";Rec."Charge Account")
                {
                }
                field("Bank Account";Rec."Bank Account")
                {
                }
            }
        }
    }
    
    actions
    {
        
    }
    var
    cust: Record Customer;
}


