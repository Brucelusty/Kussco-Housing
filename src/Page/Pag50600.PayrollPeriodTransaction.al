//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50600 "Payroll Period Transaction."
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "prPeriod Transactions.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field("Employee Code";Rec."Employee Code")
                {
                }
                field("Group Text";Rec."Group Text")
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
                field("Group Order";Rec."Group Order")
                {
                }
                field("Sub Group Order";Rec."Sub Group Order")
                {
                }
                field("Period Month";Rec."Period Month")
                {
                }
                field("Period Year";Rec."Period Year")
                {
                }
                field("Period Filter";Rec."Period Filter")
                {
                }
                field("Payroll Period";Rec."Payroll Period")
                {
                }
                field(Membership; Rec.Membership)
                {
                }
                field("Reference No";Rec."Reference No")
                {
                }
                field("Department Code";Rec."Department Code")
                {
                }
                field(Lumpsumitems; Rec.Lumpsumitems)
                {
                }
                field(TravelAllowance; Rec.TravelAllowance)
                {
                }
                field("GL Account";Rec."GL Account")
                {
                }
                field("Company Deduction";Rec."Company Deduction")
                {
                }
                field("Emp Amount";Rec."Emp Amount")
                {
                }
                field("Emp Balance";Rec."Emp Balance")
                {
                }
                field("Journal Account Code";Rec."Journal Account Code")
                {
                }
                field("Journal Account Type";Rec."Journal Account Type")
                {
                }
                field("Post As";Rec."Post As")
                {
                }
                field("Loan Number";Rec."Loan Number")
                {
                }
                field("coop parameters";Rec."coop parameters")
                {
                }
                field("Payroll Code";Rec."Payroll Code")
                {
                }
                field("Payment Mode";Rec."Payment Mode")
                {
                }
            }
        }
    }

    actions
    {
    }
}






