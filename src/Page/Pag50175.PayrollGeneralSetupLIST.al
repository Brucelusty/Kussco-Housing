//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50175 "Payroll General Setup LIST."
{
    ApplicationArea = All;
    CardPageID = "Payroll General Setup.";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll General Setup.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tax Relief";Rec."Tax Relief")
                {
                }
                field("Insurance Relief";Rec."Insurance Relief")
                {
                }
                field("Max Relief";Rec."Max Relief")
                {
                }
                field("Zakayo Levy";Rec."Zakayo Levy")
                {
                    Caption = 'Housing levy %';
                }
                field("Mortgage Relief";Rec."Mortgage Relief")
                {
                }
                field("Max Pension Contribution";Rec."Max Pension Contribution")
                {
                }
                field("Tax On Excess Pension";Rec."Tax On Excess Pension")
                {
                }
                field("Loan Market Rate";Rec."Loan Market Rate")
                {
                }
                field("Loan Corporate Rate";Rec."Loan Corporate Rate")
                {
                }
                field("Taxable Pay (Normal)";Rec."Taxable Pay (Normal)")
                {
                }
                field("Staff Net Pay G/L Account";Rec."Staff Net Pay G/L Account")
                {
                }
                field(SHIF;Rec.SHIF)
                {
                }
                field("Min SHIF";Rec."Min SHIF")
                {
                }
                field("SHIF Relief";Rec."SHIF Relief")
                {
                }
                field("Max SHIF Relief";Rec."Max SHIF Relief")
                {
                }
            }
        }
    }

    actions
    {
    }
}






