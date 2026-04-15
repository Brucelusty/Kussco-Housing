page 51124 "Marketing Campaign List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Marketing Campaign";
    UsageCategory = Lists;
    Caption = 'Marketing Campaigns';
    CardPageId = "Marketing Campaign Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Campaign ID"; Rec."Campaign ID") { }
                field("Description"; Rec."Description") { }
                field("Status"; Rec."Status") { }
                field("Start Date"; Rec."Start Date") { }
                field("End Date"; Rec."End Date") { }
                field("Budget Amount"; Rec."Budget Amount") { }
                field("Actual Expenses"; Rec."Actual Expenses") { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(NewCampaign)
            {
                Caption = 'New Campaign';
                Image = New;
                RunObject = page "Marketing Campaign Card";
            }
        }
    }
}


