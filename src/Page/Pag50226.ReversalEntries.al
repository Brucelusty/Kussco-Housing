//************************************************************************
page 50226 "Reversal Entries"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Reversal Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No.";Rec."Entry No.")
                {

                }
                field("Entry Type";Rec."Entry Type")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field("Document Type";Rec."Document Type")
                {
                }
                field("Source Type";Rec."Source Type")
                {
                }
                field("Source No.";Rec."Source No.")
                {
                }
                field("Source Code";Rec."Source Code")
                {
                }
                field("Transaction No.";Rec."Transaction No.")
                {
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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}


