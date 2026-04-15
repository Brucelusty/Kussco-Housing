//************************************************************************
// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50000 "customerLookupExtension" extends "Customer Lookup"
{
    layout
    {
        addafter(Name)
        {
            field("Payroll No";Rec."Payroll No")
            {
                ApplicationArea = All;
                Caption='PF Number';
            }
            field(ISNormalMember; Rec.ISNormalMember)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        ///Rec.SetRange(ISNormalMember, false);
    end;



}


