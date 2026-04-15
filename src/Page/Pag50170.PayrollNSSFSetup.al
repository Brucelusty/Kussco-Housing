//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50170 "Payroll NSSF Setup."
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll NSSF Setup.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tier Code";Rec."Tier Code")
                {
                }
                field(Earnings; Rec.Earnings)
                {
                }
                field("Pensionable Earnings";Rec."Pensionable Earnings")
                {
                }
                field("Tier 1 earnings";Rec."Tier 1 earnings")
                {
                }
                field("Tier 1 Employee Deduction";Rec."Tier 1 Employee Deduction")
                {
                }
                field("Tier 1 Employer Contribution";Rec."Tier 1 Employer Contribution")
                {
                }
                field("Tier 2 earnings";Rec."Tier 2 earnings")
                {
                }
                field("Tier 2 Employee Deduction";Rec."Tier 2 Employee Deduction")
                {
                }
                field("Tier 2 Employer Contribution";Rec."Tier 2 Employer Contribution")
                {
                }
                field("Lower Limit";Rec."Lower Limit")
                {
                }
                field("Upper Limit";Rec."Upper Limit")
                {
                }
            }
        }
    }

    actions
    {
    }
}






