//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50826 "Interest Earned Buffer"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Interest Buffer Savings";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Account No";Rec."Account No")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Interest Date";Rec."Interest Date")
                {
                }
                field("Interest Amount";Rec."Interest Amount")
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field("Account Matured";Rec."Account Matured")
                {
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Late Interest";Rec."Late Interest")
                {
                }
                field(Transferred; Rec.Transferred)
                {
                }
                field("Mark For Deletion";Rec."Mark For Deletion")
                {
                }
            }
        }
    }

    actions
    {
    }
}






