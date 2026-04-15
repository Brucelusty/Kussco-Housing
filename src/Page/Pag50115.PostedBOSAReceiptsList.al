//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50115 "Posted BOSA Receipts List"
{
    ApplicationArea = All;
    CardPageID = "Posted BOSA Receipt Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No.";Rec."Transaction No.")
                {
                }
                field("Account No.";Rec."Account No.")
                {
                }
                field(Name; rec.Name)
                {
                }
                field("Cheque No.";Rec."Cheque No.")
                {
                }
                field("Employer No.";Rec."Employer No.")
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field(Amount; rec.Amount)
                {
                }
                field(Posted; rec.Posted)
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Cheque Date";Rec."Cheque Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}






