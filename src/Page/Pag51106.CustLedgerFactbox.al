
page 51106 CustLedgerFactbox
{
    ApplicationArea = All;
    Caption = 'Customer Ledger Factbox';
    PageType = CardPart;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Loan No"; Rec."Loan No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
}
page 51207 BankLedgerFactbox
{
    ApplicationArea = All;
    Caption = 'Bank Ledger Factbox';
    PageType = CardPart;
    SourceTable = "Bank Account Ledger Entry";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Bank Account No.";Rec."Bank Account No.")
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
}

page 51164 VendLedgerFactbox
{
    ApplicationArea = All;
    Caption = 'Vendor Ledger Factbox';
    PageType = CardPart;
    SourceTable = "Vendor Ledger Entry";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Vendor No.";Rec."Vendor No.")
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }


        }
    }
}


page 51208 GLLedgerFactbox
{
    ApplicationArea = All;
    Caption = 'G/L Ledger Factbox';
    PageType = CardPart;
    SourceTable = "G/L Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("G/L Account No.";Rec."G/L Account No.")
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Entry No.";Rec."Entry No.")
                {
                }
                field("Document No.";Rec."Document No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}




