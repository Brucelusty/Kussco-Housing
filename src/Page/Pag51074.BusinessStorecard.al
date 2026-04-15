page 51074 "Business Store card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = Vendor;
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group("FOSA Details")
            {
                field("No.";Rec."No.")
                {
                    Editable = false;
                }
                field("Account Type";Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account Type Name";Rec."Account Type Name")
                {
                    Editable = false;
                }
                field(Name;Rec.Name)
                {
                    Editable = false;
                }
            }
            Group("Child Details")
            {
                field("Child Name";Rec."Child Name")
                {
                    Editable = true;
                }
                field("Child Birth certificate";Rec."Child Birth certificate")
                {
                    Editable = true;
                }
                field("Child DOB";Rec."Child DOB")
                {
                    Editable = true;
                }
                field("Childs Gender";Rec."Childs Gender")
                {
                    Editable = true;
                }
                field("Child ID";Rec."Child ID")
                {
                    Editable = true;
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
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}


