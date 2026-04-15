page 51026 "WrittenOff Loans  Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Loans Register";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    Editable = false;
                }
                field("Client Code";Rec."Client Code")
                {
                    Editable = false;
                }
                field("Client Name";Rec."Client Name")
                {
                }
                field("Staff No";Rec."Staff No")
                {
                    Editable = false;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Type Name";Rec."Loan Product Type Name")
                {
                    Editable = false;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    Editable = false;
                }
                field("Write Off Amount";Rec."Write Off Amount")
                {
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    Editable = false;
                }
                field("Loans Category";Rec."Loans Category")
                {
                    Editable = false;
                }
                field("Loans Category-SASRA";Rec."Loans Category-SASRA")
                {
                    Editable = false;
                }
                field("Oustanding Interest";Rec."Outstanding Interest")
                {
                }
                field("Outstanding Balance";Rec."Outstanding Balance")
                {
                }
                field("Issued Date";Rec."Issued Date")
                {
                    Editable = false;
                }
                field("Defaulted Balance";Rec."Defaulted Balance")
                {
                    Editable = false;
                }
                field("Debtor Collection Status";Rec."Debtor Collection Status")
                {
                }
                field("Loan Debt Collector";Rec."Loan Debt Collector")
                {
                }
                field("Debt Collectors Name";Rec."Debt Collector Name")
                {
                }
                field("Agreed Instalments";Rec."Agreed Instalments")
                {
                }
                field("Payment Date";Rec."Payment Date")
                {
                    Caption = 'Agreed Payment Start Date';
                }
                field("Agreed Amount";Rec."Agreed Amount")
                {
                }
                field("Notification Date";Rec."Notification Date")
                {
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

