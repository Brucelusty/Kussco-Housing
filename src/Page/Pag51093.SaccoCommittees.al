page 51093 "Sacco Committees"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Sacco Committees";
    CardPageId = "Sacco Committees Card";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Committee No.";Rec."Committee No.")
                {
                    Editable = false;
                }
                field("Committee Name";Rec."Committee Name")
                {
                }
                field(Members;Rec.Members)
                {
                    Style = StrongAccent;
                }
                field("Is Board";Rec."Is Board")
                {
                }
                field("Is Supervisory";Rec."Is Supervisory")
                {
                }
                field("Is Joint Board";Rec."Is Joint Board")
                {
                }
                field("Is Other Committee";Rec."Is Other Committee")
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


