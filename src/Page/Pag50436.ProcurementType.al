//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50436 "Procurement Type"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Treasury Transactions";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field(No; Rec.No)
                {
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("From Account";Rec."From Account")
                {
                }
                field("To Account";Rec."To Account")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}






