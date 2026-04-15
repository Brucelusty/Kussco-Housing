page 51211 "Loan Income Part"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loan Income";
    Caption = 'Repayment Capacity Details';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Type of Income"; Rec."Type of Income")
                {
                }

                field("Employer/Business"; Rec."Employer/Business")
                {
                }

                field("Gross Income"; Rec."Gross Income")
                {
                }

                field("Net Income"; Rec."Net Income")
                {
                }
            }
        }
    }
}
