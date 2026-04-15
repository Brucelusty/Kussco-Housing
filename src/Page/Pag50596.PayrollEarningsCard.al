//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50596 "Payroll Earnings Card."
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Payroll Transaction Code.";
    SourceTableView = where("Transaction Type" = const(Income));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field("Transaction Name";Rec."Transaction Name")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field("Balance Type";Rec."Balance Type")
                {
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field(Taxable; Rec.Taxable)
                {
                }
                field("Is Cash";Rec."Is Cash")
                {
                }
                field("Is Formulae";Rec."Is Formulae")
                {
                }
                field(Formulae; Rec.Formulae)
                {
                }
                field("G/L Account";Rec."G/L Account")
                {
                }
                field("G/L Account Name";Rec."G/L Account Name")
                {
                }
                field(SubLedger; Rec.SubLedger)
                {
                }
                field("Customer Posting Group";Rec."Customer Posting Group")
                {
                }
            }
            group("Loan Details")
            {
                field("Deduct Premium";Rec."Deduct Premium")
                {
                }
                field("Interest Rate";Rec."Interest Rate")
                {
                }
                field("Repayment Method";Rec."Repayment Method")
                {
                }
                field("IsCo-Op/LnRep";Rec."IsCo-Op/LnRep")
                {
                }
                field("Deduct Mortgage";Rec."Deduct Mortgage")
                {
                }
            }
            group("Other Setup")
            {
                field("Special Transaction";Rec."Special Transaction")
                {
                }
                field("Amount Preference";Rec."Amount Preference")
                {
                }
                field("Fringe Benefit";Rec."Fringe Benefit")
                {
                }
                field(IsHouseAllowance; Rec.IsHouseAllowance)
                {
                }
                field("Employer Deduction";Rec."Employer Deduction")
                {
                }
                field("Include Employer Deduction";Rec."Include Employer Deduction")
                {
                }
                field("Formulae for Employer";Rec."Formulae for Employer")
                {
                }
                field("Co-Op Parameters";Rec."Co-Op Parameters")
                {
                }
                field(Welfare; Rec.Welfare)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Income;
    end;
}






