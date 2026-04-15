//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50740 "Atm Transaction Details"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "ATM Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trace ID";Rec."Trace ID")
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Posting S";Rec."Posting S")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Transaction Time";Rec."Transaction Time")
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Withdrawal Location";Rec."Withdrawal Location")
                {
                }
                field("ATM Card No";Rec."ATM Card No")
                {
                }
            }
        }
    }

    actions
    {
    }
}






