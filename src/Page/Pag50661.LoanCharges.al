//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50661 "Loan Charges"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                }
                field("Use Perc"; Rec."Use Perc")
                {
                }
                field("Charge Excise"; Rec."Charge Excise")
                {
                }
                field("Charge Type"; Rec."Charge Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}






