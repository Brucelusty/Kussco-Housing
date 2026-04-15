page 51054 "BSS Businesses Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "BSS Businesses";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Business Code";Rec."Business Code")
                {
                    ShowMandatory = true;
                }
                field("Business Name";Rec."Business Name")
                {
                }
                field("Business Description";Rec."Business Description")
                {
                    MultiLine = true;
                }
                field("Business Main Sector";Rec."Business Main Sector")
                {
                }
                field("Business Sub-Sector";Rec."Business Sub-Sector")
                {
                }
                field("Business Specific Sector";Rec."Business Specific Sector")
                {
                }
                field("Business Physical Location";Rec."Business Physical Location")
                {
                }
                field("Business Year of Commence";Rec."Business Year of Commence")
                {
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            
        }
    }

    
    var
        creditRatingEditor: Boolean;
        user: Record "User Setup";
        register: Page "G/L Registers";

    trigger
    OnOpenPage()
    begin
        creditRatingEditor := false;
        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if user."Change Defaulter Status" = true
            then begin
                creditRatingEditor := true;
            end;
        end;
    end;
}


