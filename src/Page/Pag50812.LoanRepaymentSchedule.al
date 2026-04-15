//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50812 "Loan Repayment Schedule"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Repay Schedule-Calc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Instalment No";Rec."Instalment No")
                {
                }
                field("Loan Balance";Rec."Loan Balance")
                {
                }
                field("Principal Repayment";Rec."Principal Repayment")
                {
                }
                field("Monthly Interest";Rec."Monthly Interest")
                {
                }
                field("Monthly Insurance";Rec."Monthly Insurance")
                {
                }
                field("Monthly Repayment";Rec."Monthly Repayment")
                {
                }
                field("Repayment Date";Rec."Repayment Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}






