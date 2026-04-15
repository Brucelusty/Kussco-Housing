pageextension 50035 "Requests to Approve Ext" extends "Requests to Approve"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Comment)
        {
            field("Document No."; Rec."Document No.")
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
}
