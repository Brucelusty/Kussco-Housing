//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50731 "Loan Calc. Loans to Offset"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Calc. Loans to Offset";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Client Code";Rec."Client Code")
                {
                }
                field("Loan Top Up";Rec."Loan Top Up")
                {
                }
                field("Loan Type";Rec."Loan Type")
                {
                }
                field("Principle Top Up";Rec."Principle Top Up")
                {
                }
                field("Interest Top Up";Rec."Interest Top Up")
                {
                }
                field("Total Top Up";Rec."Total Top Up")
                {
                }
                field("Monthly Repayment";Rec."Monthly Repayment")
                {
                }
                field("Interest Paid";Rec."Interest Paid")
                {
                }
                field("Outstanding Balance";Rec."Outstanding Balance")
                {
                }
                field("Interest Rate";Rec."Interest Rate")
                {
                }
                field("ID. NO";Rec."ID. NO")
                {
                }
                field(Commision; Rec.Commision)
                {
                }
                field("Partial Bridged";Rec."Partial Bridged")
                {
                }
                field("Remaining Installments";Rec."Remaining Installments")
                {
                }
                field("Finale Instalment";Rec."Finale Instalment")
                {
                }
                field("Penalty Charged";Rec."Penalty Charged")
                {
                }
                field("Staff No";Rec."Staff No")
                {
                }
            }
        }
    }

    actions
    {
    }
}






