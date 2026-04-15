page 51126 "Marketing Event List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Marketing Event";
    UsageCategory = Lists;
    Caption = 'Marketing Events';
    CardPageId = "Marketing Event Card";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Event ID"; Rec."Event ID") { }
                field("Campaign ID"; Rec."Campaign ID") { }
                field("Event Type"; Rec."Event Type") { }
                field("Event Date"; Rec."Event Date") { }
                field("Location"; Rec."Location") { }
                field("Status"; Rec."Status") { }
                field("Budget Amount"; Rec."Budget Amount") { }
                field("Actual Expenses"; Rec."Actual Expenses") { }
                field("Total Attendees"; Rec."Total Attendees") { }
                field("Converted Members"; Rec."Converted Members") { }
            }
        }
    }
}


