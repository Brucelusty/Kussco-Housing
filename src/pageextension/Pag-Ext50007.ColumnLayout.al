pageextension 50007 "ColumnLayout" extends "Column Layout"
{
    layout
    {
        addafter("Comparison Date Formula")
        {
            field(ComparisonPeriodFormula; rec."Comparison Period Formula") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
