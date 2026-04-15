//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50371 "Funds Tax Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Funds Tax Codes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Tax Code";Rec."Tax Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Liability Account";Rec."Liability Account")
                {
                }
                field("Meeting Tax";Rec."Meeting Tax")
                {
                }
            }
        }
    }

    actions
    {
    }
}






