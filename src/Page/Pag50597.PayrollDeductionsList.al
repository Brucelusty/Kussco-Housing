//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50597 "Payroll Deductions List."
{
    ApplicationArea = All;
    CardPageID = "Payroll Deductions Card.";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll Transaction Code.";
    SourceTableView = where("Transaction Type" = const(Deduction));

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
                field("Is Contribution";Rec."Is Contribution")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage() 
    var
    userSetup: Record "User Setup";
    begin
        if userSetup.Get(UserId) then begin
            if userSetup."View Payroll" = false then Error('This user %1 cannot view this page.', UserId);
        end;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Deduction;

    end;
}






