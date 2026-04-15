page 51088 "Sacco Committee Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Sacco Committee Members";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("ID No";Rec."ID No")
                {
                }
                field("Position Name";Rec."Position Name")
                {
                    Style = StrongAccent;
                }
                field("Is Active";Rec."Is Active")
                {
                } 
                field("Sitting Allowance";Rec."Sitting Allowance")
                {
                }
                field("Transport Allowance";Rec."Transport Allowance")
                {
                }
                field("Sitting Allowance Special";Rec."Sitting Allowance Special")
                {
                }
                field("Transport Allowance Special";Rec."Transport Allowance Special")
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


