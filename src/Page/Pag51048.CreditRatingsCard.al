page 51048 "Credit Ratings Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Credit Rating";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Loan No.";Rec."Loan No.")
                {
                    Editable = false;
                }
                field("Document Date";Rec."Document Date")
                {
                    Editable = false;
                }
                field("Loan Amount";Rec."Loan Amount")
                {
                    Editable = false;
                }
                field("Loan Limit";Rec."Loan Limit")
                {
                    // Editable = creditRatingEditor;
                    Editable = false;
                }
                field("New Limit";Rec."New Limit")
                {
                    // Editable = creditRatingEditor;
                    Editable = false;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Account No";Rec."Account No")
                {
                    Editable = false;
                }
                field("Member No";Rec."Member No")
                {
                    Editable = false;
                }
                field("Customer Name";Rec."Customer Name")
                {
                    Editable = false;
                }
                field("Staff No.";Rec."Staff No.")
                {
                    Editable = false;
                }
                field("Telephone No";Rec."Telephone No")
                {
                    Editable = false;
                }
                field("Date Entered";Rec."Date Entered")
                {
                    Editable = false;
                }
                field("Time Entered";Rec."Time Entered")
                {
                    Editable = false;
                }
                field("Entered By";Rec."Entered By")
                {
                    Editable = false;
                }
                field(Comments;Rec.Comments)
                {
                    Editable = false;
                }
                field("Entry No";Rec."Entry No")
                {
                    Editable = false;
                }
                field("Next Loan Application Date";Rec."Next Loan Application Date")
                {
                    Editable = false;
                }
                field(Penalized;Rec.Penalized)
                {
                    Editable = false;
                }
                field("Penalty Date";Rec."Penalty Date")
                {
                    Editable = false;
                }
                field("Last Notification";Rec."Last Notification")
                {
                    Editable = false;
                }
                field("Next Notification";Rec."Next Notification")
                {
                    Editable = false;
                }
            }
            part("Member A03 Loans"; "Loans Sub-Page List")
            {
                SubPageLink = "Client Code" = field("Member No"), "Loan Product Type" = filter('A03');
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


