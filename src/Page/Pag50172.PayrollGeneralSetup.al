//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50172 "Payroll General Setup."
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Payroll General Setup.";

    layout
    {
        area(content)
        {
            group(Relief)
            {
                field("Tax Relief"; Rec."Tax Relief")
                {
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                }
                field("Max Relief"; Rec."Max Relief")
                {
                }
                field("Mortgage Relief"; Rec."Mortgage Relief")
                {
                }
            }
            group(NHIF)
            {
                field("NHIF Based on"; Rec."NHIF Based on")
                {
                }
            }

            group("Housing Levy")
            {
                field("Zakayo Levy"; Rec."Zakayo Levy")
                {
                    Caption = 'Housing Levy';
                }
            }
            group(NSSF)
            {
                field("NSSF Employee"; Rec."NSSF Employee")
                {
                }
                field("NSSF Employer Factor"; Rec."NSSF Employer Factor")
                {
                }
                field("NSSF Based on"; Rec."NSSF Based on")
                {
                }
            }
            group(Pension)
            {
                field("Max Pension Contribution"; Rec."Max Pension Contribution")
                {
                }
                field("Tax On Excess Pension"; Rec."Tax On Excess Pension")
                {
                }
            }
            group("Staff Loan")
            {
                field("Loan Market Rate"; Rec."Loan Market Rate")
                {
                }
                field("Loan Corporate Rate"; Rec."Loan Corporate Rate")
                {
                }
            }
            group(Mortgage)
            {
            }
            group("Owner Occupier Interest")
            {
                field("OOI Deduction"; Rec."OOI Deduction")
                {
                }
                field("OOI December"; Rec."OOI December")
                {
                }
            }
        }
    }

    actions
    {
    }
}






