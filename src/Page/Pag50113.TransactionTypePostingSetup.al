//************************************************************************
page 50113 "TransactionTypePosting Setup"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Transaction Types Table";
    Caption = 'Transaction Types Posting Setup';

    layout
    {
        area(Content)
        {
            repeater(control1)
            {
                field("Transaction Type"; rec."Transaction Type")
                {

                }
                field("Posting Group Code"; rec."Posting Group Code")
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




