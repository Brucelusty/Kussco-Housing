//************************************************************************
pageextension 50026 "CustomerCard" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Employer Code"; Rec."Employer Code") { ApplicationArea = All; }
            field("Checkoff Account"; Rec."Checkoff Account") { ApplicationArea = All; }
            field("Salary Account"; Rec."Salary Account") { ApplicationArea = All; }
            field("Insurance Account"; Rec."Insurance Account") { ApplicationArea = All; }
        }



    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}


