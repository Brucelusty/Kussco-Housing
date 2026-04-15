//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50181 "Budgetary Control Setup"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Budgetary Control Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Mandatory; Rec.Mandatory)
                {
                }
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {
                }
                field("Actual Source"; Rec."Actual Source")
                {
                }
                field("Budget Check Criteria"; Rec."Budget Check Criteria")
                {
                }
            }
            group(Budget)
            {
                Caption = 'Budget';
                field("Current Budget Code";Rec."Current Budget Code")
                {
                }
                field("Current Budget Start Date";Rec."Current Budget Start Date")
                {
                }
                field("Current Budget End Date";Rec."Current Budget End Date")
                {
                }
                field("Budget Dimension 1 Code";Rec."Budget Dimension 1 Code")
                {
                }
                field("Budget Dimension 2 Code";Rec."Budget Dimension 2 Code")
                {
                }
                field("Budget Dimension 3 Code";Rec."Budget Dimension 3 Code")
                {
                }
                field("Budget Dimension 4 Code";Rec."Budget Dimension 4 Code")
                {
                }
                field("Budget Dimension 5 Code";Rec."Budget Dimension 5 Code")
                {
                }
                field("Budget Dimension 6 Code";Rec."Budget Dimension 6 Code")
                {
                }
            }
            group(Actuals)
            {
                Caption = 'Actuals';
                field("Analysis View Code";Rec."Analysis View Code")
                {
                }
                field("Dimension 1 Code";Rec."Dimension 1 Code")
                {
                }
                field("Dimension 2 Code";Rec."Dimension 2 Code")
                {
                }
                field("Dimension 3 Code";Rec."Dimension 3 Code")
                {
                }
                field("Dimension 4 Code";Rec."Dimension 4 Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}






