//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50807 "Loan PayOff Details"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loans PayOff Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Source; Rec.Source)
                {
                }
                field("Loan to PayOff"; Rec."Loan to PayOff")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Loan Type"; Rec."Loan Type")
                {
                }
                field("Loan Outstanding"; Rec."Loan Outstanding")
                {
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    Editable = false;
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    Editable = false;
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    Editable = false;
                }
                field("Debt Collector Fee"; Rec."Debt Collector Fee")
                {
                    Editable = false;
                }
                field("Total PayOff"; Rec."Total PayOff")
                {
                }
            }
        }
    }

    actions
    {
    }
}






