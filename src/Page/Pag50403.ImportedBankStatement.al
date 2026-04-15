//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50403 "Imported Bank Statement"
{
    ApplicationArea = All;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Imported Bank Statement..";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Reference No";Rec."Reference No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Bank; Rec.Bank)
                {
                }
                field(Receipted; Rec.Receipted)
                {
                }
                field(ReceiptNo; Rec.ReceiptNo)
                {
                }
                field("Receipting Date";Rec."Receipting Date")
                {
                }
                field(Reconciled; Rec.Reconciled)
                {
                }
                field("Reconciliation Doc No";Rec."Reconciliation Doc No")
                {
                }
                field("Reconciliation Date";Rec."Reconciliation Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}






