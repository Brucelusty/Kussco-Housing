pageextension 50008 "Companyinfo" extends "Company Information"
{
    layout
    {
        addafter("Phone No.")
        {
            field(Motto; Rec.Motto) { ApplicationArea = all; }
        }
        addafter(Picture)
        {
            field("CEO Signature";Rec."CEO Signature")
            {
                ApplicationArea = all;
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
