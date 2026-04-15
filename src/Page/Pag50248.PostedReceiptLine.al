//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50248 "Posted Receipt Line"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Receipt Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Default Grouping";Rec."Default Grouping")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account Code";Rec."Account Code")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Pay Mode";Rec."Pay Mode")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount(LCY)";Rec."Amount(LCY)")
                {
                }
                field("Cheque No";Rec."Cheque No")
                {
                }
                field("Applies-To Doc No.";Rec."Applies-To Doc No.")
                {
                }
                field("Applies-To ID";Rec."Applies-To ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}






