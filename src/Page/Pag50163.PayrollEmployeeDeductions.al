//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50163 "Payroll Employee Deductions."
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll Employee Transactions.";
    SourceTableView = where("Transaction Type" = const(Deduction));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    TableRelation = "Payroll Transaction Code."."Transaction Code" where("Transaction Type" = const(Deduction));
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Loan Number"; Rec."Loan Number")
                {
                }
                field("Original Deduction Amount"; Rec."Original Deduction Amount")
                {
                }
                field("Interest Charged"; Rec."Interest Charged")
                {
                    Editable = false;
                }
                field("Is Redundant";Rec."Is Redundant")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                }
                field("Amtzd Loan Repay Amt"; Rec."Amtzd Loan Repay Amt")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Balance(LCY)"; Rec."Balance(LCY)")
                {
                }
                field("Period Month"; Rec."Period Month")
                {
                }
                field("Period Year"; Rec."Period Year")
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Original Amount"; Rec."Original Amount")
                {
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                }
                field("Sacco Membership No."; Rec."Sacco Membership No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
        end;

        Rec.SetFilter("Payroll Period", '%1', VarOpenPeriod);
    end;

    var
        ObjPayrollCalender: Record "Payroll Calender.";
        VarOpenPeriod: Date;
}






