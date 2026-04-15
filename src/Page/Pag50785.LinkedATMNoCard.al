//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50785 "Linked ATM No Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "ATM Card Nos Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Card No";Rec."ATM Card No")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Name";Rec."Account Name")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("ID No";Rec."ID No")
                {
                }
            }
            group("Delink ATM Details")
            {
                field("Reason For Delink";Rec."Reason For Delink")
                {
                }
                field("Delink ATM Card";Rec."Delink ATM Card")
                {
                }
                field("Delinked By";Rec."Delinked By")
                {
                }
                field("Delinked On";Rec."Delinked On")
                {
                }
            }
        }
    }

    actions
    {
    }
}






