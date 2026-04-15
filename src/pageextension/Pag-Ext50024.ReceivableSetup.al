pageextension 50024 "ReceivableSetup" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Stockout Warning")
        {
            field("Allow MultiplePosting Groups"; Rec."Allow Multiple Posting Groups") { ApplicationArea = all; }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
