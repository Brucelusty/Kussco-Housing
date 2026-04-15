pageextension 50037 "Departments List" extends "Responsibility Center List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Department Head Name"; Rec."Department Head Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Staff; Rec.Staff)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

        modify("Location Code")
        {
            Visible = false;
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
