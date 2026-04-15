//************************************************************************
pageextension 50015 "DetailedVendorledgerentry" extends "Detailed Vendor Ledg. Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Vendor No"; Rec."Vendor No.")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }

            field(DocumentNo; Rec."Document No.")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

            }
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field(Amounts; Rec.Amount)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }

            field(Reversed; Rec.Reversed)
            {
                ApplicationArea = basic;
            }
            field("UserID"; Rec."User ID") { ApplicationArea = All; }
            field(SystemCreatedAt; Rec.SystemCreatedAt) { ApplicationArea = All; }
            // field("Loan No";"Loan No"){}
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}


