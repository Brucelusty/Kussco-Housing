//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50852 "Loan Insurance Accrual Periods"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Insurance Accrual Period";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Insurance Due Date";Rec."Insurance Due Date")
                {
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field("New Fiscal Year";Rec."New Fiscal Year")
                {
                    Editable = false;
                }
                field(Closed; Rec.Closed)
                {
                    Editable = true;
                }
                field("Date Locked";Rec."Date Locked")
                {
                    Editable = false;
                }
                field("Closed by User";Rec."Closed by User")
                {
                    Editable = false;
                }
                field("Closing Date Time";Rec."Closing Date Time")
                {
                    Editable = false;
                }
                field("Insurance Calcuation Date";Rec."Insurance Calcuation Date")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            separator(Action15)
            {
            }
            action("Create Period")
            {
                Image = AccountingPeriods;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Report.run(172917)
                end;
            }
        }
    }

    var
        InvtPeriod: Record "Inventory Period";
        date: DateFormula;
        InterestPeriod: Record "Loan Insurance Accrual Period";
}






