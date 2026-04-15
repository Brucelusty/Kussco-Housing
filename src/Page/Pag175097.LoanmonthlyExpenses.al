namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 51184 "Loan monthly Expenses"
{
    ApplicationArea = All;
    Caption = 'Loan monthly Expenses';
    PageType = ListPart;
    SourceTable = "Loan Monthy Expense Summary";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Lender; Rec.Lender)
                {
                }
                field("Type Of Loan"; Rec."Type Of Loan")
                {
                }

                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    Caption = 'Repayment';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Caption = 'Balance';
                }

            }
        }
    }
}


