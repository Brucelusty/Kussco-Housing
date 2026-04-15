pageextension 50034 "Bank Acc. Stmt Line" extends "Bank Account Statement Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter(Difference)
        {
            field(Reconcile; Rec.Reconciled)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

    }

    var
        myInt: Integer;
        bankRec: Record "Bank Account Statement";
}
