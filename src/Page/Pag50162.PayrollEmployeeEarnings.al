//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50162 "Payroll Employee Earnings."
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll Employee Transactions.";
    SourceTableView = where("Transaction Type" = const(Income));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                    TableRelation = "Payroll Transaction Code."."Transaction Code" where("Transaction Type" = const(Income));
                }
                field("Transaction Name";Rec."Transaction Name")
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount(LCY)";Rec."Amount(LCY)")
                {
                }
                field("Original Deduction Amount";Rec."Original Deduction Amount")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Balance(LCY)";Rec."Balance(LCY)")
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






