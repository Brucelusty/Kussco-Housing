pageextension 50032 "Bank Acc. Recon Lines" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        // Add changes to page layout here
        modify("Check No.")
        {
            Visible = True;
        }
        modify("Document No.")
        {
            Visible = True;
        }
        addafter(Difference)
        {
            field(Reconciled;Rec.Reconciled)
            {
                ApplicationArea = Basic;
            }
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
    myInt: Integer;
}
