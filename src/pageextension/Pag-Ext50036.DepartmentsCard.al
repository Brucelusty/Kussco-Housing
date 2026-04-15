pageextension 50036 "Departments Card" extends "Responsibility Center Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Department Head"; Rec."Department Head")
            {
                ApplicationArea = All;
                // LookupPageId = 50072;
            }
            field("Department Head Name"; Rec."Department Head Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Department Head UserId"; Rec."Department Head UserId")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Is Finance"; Rec."Is Finance")
            {
                ApplicationArea = All;
            }
        }
        addafter("Global Dimension 2 Code")
        {
            field("Total KVD Weights"; Rec."Total KVD Weights")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

        modify("Location Code")
        {
            Visible = false;
        }
        modify(Address)
        {
            Visible = false;
        }
        modify("Address 2")
        {
            Visible = false;
        }
        modify("Global Dimension 1 Code")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }

        modify(Communication)
        {
            Visible = false;
        }
        addafter(Communication)
        {
            part("Key Value Drivers"; "Departmental KVDs")
            {
                ApplicationArea = All;
                SubPageLink = "Department code" = field(Code);
            }
            // part("Key Performance Indicators"; "Departmental KPIs")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Department code" = field(Code);
            // }
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
