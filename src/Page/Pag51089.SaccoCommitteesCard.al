page 51089 "Sacco Committees Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "Sacco Committees";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
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
            part("CommitteeMembers"; "Sacco Committee Lines")
            {
                Caption = 'Committee Members';
                SubPageLink = "Committee" = field("Committee No.");
            }
        }
    }
    
    actions
    {
        
    }
    var
    cust: Record Customer;
}


