//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50704 "Transaction Type - List"
{
    ApplicationArea = All;
    CardPageID = "Transaction Type Card";
    // Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Transaction Types";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Transaction Category"; Rec."Transaction Category")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Legible For All";Rec."Legible For All")
                {
                }
                field(Type; Rec.Type)
                {
                }
            }
        }
    }

    actions
    {
    }
}






