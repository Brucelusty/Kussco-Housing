//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50739 "ATM Transactions Info"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Account Name";Rec."Account Name")
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
                field(Posted; Rec.Posted)
                {
                }
                field("Unit ID";Rec."Unit ID")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Trans Time";Rec."Trans Time")
                {
                }
                field("Transaction Time";Rec."Transaction Time")
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field(Source; Rec.Source)
                {
                }
                field(Reversed; Rec.Reversed)
                {
                }
                field("Reversed Posted";Rec."Reversed Posted")
                {
                }
                field("Reversal Trace ID";Rec."Reversal Trace ID")
                {
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                }
                field("Withdrawal Location";Rec."Withdrawal Location")
                {
                }
                field("Entry No";Rec."Entry No")
                {
                }
                field("Transaction Type Charges";Rec."Transaction Type Charges")
                {
                }
                field("Card Acceptor Terminal ID";Rec."Card Acceptor Terminal ID")
                {
                }
                field("ATM Card No";Rec."ATM Card No")
                {
                }
                field("Customer Names";Rec."Customer Names")
                {
                }
                field("Process Code";Rec."Process Code")
                {
                }
                field("Reference No";Rec."Reference No")
                {
                }
                field("Is Coop Bank";Rec."Is Coop Bank")
                {
                }
                field("POS Vendor";Rec."POS Vendor")
                {
                }
            }
        }
    }

    actions
    {
    }
}






