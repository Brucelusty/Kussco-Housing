//************************************************************************
// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50010 "customerListExtension" extends "Customer List"
{
    layout
    {
        addafter("Customer Posting Group")
        {

        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(ISNormalMember, false);
    end;



}


