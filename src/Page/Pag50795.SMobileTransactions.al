//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50795 "S-Mobile Transactions"
{
    ApplicationArea = All;
    CardPageID = "S-Mobile Applications";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Mobile Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Telephone Number"; Rec."Telephone Number")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Date Posted"; Rec."Date Posted")
                {
                }
                field("Account 2"; Rec."Account 2")
                {
                }
                field("Loan No"; Rec."Loan No")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Charge; Rec.Charge)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Entry; Rec.Entry)
                {
                }
                field(Client; Rec.Client)
                {
                }
            }
        }
    }

    actions
    {
    }
}






