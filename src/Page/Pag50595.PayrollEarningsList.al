//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50595 "Payroll Earnings List."
{
    ApplicationArea = All;
    CardPageID = "HR Employee Requisitions List";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll Transaction Code.";
    SourceTableView = where("Transaction Type" = const(Income));

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field(Taxable; Rec.Taxable)
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






