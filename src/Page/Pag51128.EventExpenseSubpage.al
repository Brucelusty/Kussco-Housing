page 51128 "Event Expense Subpage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Event Expense";
    Caption = 'Event Expenses';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Category"; Rec."Expense Category") { }
                field("Description"; Rec."Description") { }
                field("Amount"; Rec."Amount") { }
                field("Posting Date"; Rec."Posting Date") { }
            }
        }
    }
}


