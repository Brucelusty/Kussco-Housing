page 51073 "Business Stores"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    CardPageId = "Business Store card";
    SourceTable = Vendor;
    SourceTableView = where("Account Type" = filter('109'));
    DeleteAllowed = false;
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No.";Rec."No.")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field(Name;Rec.Name)
                {
                }
                field("Child Name";Rec."Child Name")
                {
                    //Editable = false;
                }
                field("Child DOB";Rec."Child DOB")
                {
                    //Editable = false;
                }
                // field(Balance;Rec.Balance)
                // {

                // }
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
    trigger OnOpenPage()
    var
    user: Record "User Setup";
    begin

        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if not user.Overdraft = true then begin
                Error('This user, %1, is not authorized to view this card.', UserId);
            end
        end;
    end;
}


