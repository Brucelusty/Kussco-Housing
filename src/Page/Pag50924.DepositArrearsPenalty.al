//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50924 "Deposit Arrears Penalty"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Deposit Arrears Penalty Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No.";Rec."Entry No.")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Document Type";Rec."Document Type")
                {
                }
                field("Document No.";Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Currency Code";Rec."Currency Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                }
                field("Salesperson Code";Rec."Salesperson Code")
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                }
                field(Settled; Rec.Settled)
                {
                }
                field("Settled On";Rec."Settled On")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}






