//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50603 "prList Transactions"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "prEmployee Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code";Rec."Employee Code")
                {
                }
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field("Transaction Name";Rec."Transaction Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Original Amount";Rec."Original Amount")
                {
                }
                field("Period Month";Rec."Period Month")
                {
                }
                field("Period Year";Rec."Period Year")
                {
                }
                field("Payroll Period";Rec."Payroll Period")
                {
                }
                field("#of Repayments";Rec."#of Repayments")
                {
                }
                field(Membership; Rec.Membership)
                {
                }
                field("Reference No";Rec."Reference No")
                {
                }
                field(integera; Rec.integera)
                {
                }
                field("Employer Amount";Rec."Employer Amount")
                {
                }
                field("Employer Balance";Rec."Employer Balance")
                {
                }
                field("Stop for Next Period";Rec."Stop for Next Period")
                {
                }
                field("Amortized Loan Total Repay Amt";Rec."Amortized Loan Total Repay Amt")
                {
                }
                field("Start Date";Rec."Start Date")
                {
                }
                field("End Date";Rec."End Date")
                {
                }
                field("Loan Number";Rec."Loan Number")
                {
                }
                field("Payroll Code";Rec."Payroll Code")
                {
                }
                field("No of Units";Rec."No of Units")
                {
                }
                field(Suspended; Rec.Suspended)
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Loan Account No";Rec."Loan Account No")
                {
                }
                field("Emp Count";Rec."Emp Count")
                {
                }
                field("PV Filter";Rec."PV Filter")
                {
                }
                field("Emp Status";Rec."Emp Status")
                {
                }
            }
        }
    }

    actions
    {
    }
}






