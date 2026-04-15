//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50878 "Posted Funds Transfer Lines"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receiving Bank Account";Rec."Receiving Bank Account")
                {
                }
                field("Bank Name";Rec."Bank Name")
                {
                }
                field("Bank Balance";Rec."Bank Balance")
                {
                }
                field("Bank Balance(LCY)";Rec."Bank Balance(LCY)")
                {
                }
                field("Bank Account No.";Rec."Bank Account No.")
                {
                }
                field("Currency Code";Rec."Currency Code")
                {
                }
                field("Currency Factor";Rec."Currency Factor")
                {
                }
                field("Amount to Receive";Rec."Amount to Receive")
                {
                }
                field("Amount to Receive (LCY)";Rec."Amount to Receive (LCY)")
                {
                }
                field("External Doc No.";Rec."External Doc No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}






