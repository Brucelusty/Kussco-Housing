page 51125 "Marketing Campaign Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Marketing Campaign";
    Caption = 'Marketing Campaign';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Campaign ID"; Rec."Campaign ID") { }
                field("Description"; Rec."Description") { }
                field("Status"; Rec."Status") { }
                field("Owner User ID"; Rec."Owner User ID") { }
            }

            group(Timeline)
            {
                field("Start Date"; Rec."Start Date") { }
                field("End Date"; Rec."End Date") { }
            }

            group(Budget)
            {
                field("Budget Amount"; Rec."Budget Amount") { }
                field("Actual Expenses"; Rec."Actual Expenses")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Events)
            {
                Caption = 'Events / Forums';
                Image = Event;
                Promoted=true;
                PromotedCategory=Process;
                RunObject = page "Marketing Event List";
                RunPageLink = "Campaign ID" = field("Campaign ID");
            }
        }
    }
}


