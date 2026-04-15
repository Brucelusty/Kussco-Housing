//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50402 "Finance KPI Buffer"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Finance KPI Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Entry No"; Rec."Entry No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Base G/L Account"; Rec."Base G/L Account")
                {
                }
                field("Denominator G/L Account"; Rec."Denominator G/L Account")
                {
                }
                field("KSACCO Targets"; Rec."KSACCO Targets")
                {
                }
                field(BenchMarks; Rec.BenchMarks)
                {
                }
                field("Base G/L Account to Sum"; Rec."Base G/L Account to Sum")
                {
                }
                field("Base G/L Account to Less"; Rec."Base G/L Account to Less")
                {
                }
                field("Denominator G/L Account to Sum"; Rec."Denominator G/L Account to Sum")
                {
                }
                field("Denominator G/L Account to Les"; Rec."Denominator G/L Account to Les")
                {
                }
            }
        }
    }

    actions
    {
    }
}






