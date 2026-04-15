//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51160 "Coop Dividends Lines"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Coop Dividends Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No"; Rec."Payroll No")
                {
                    StyleExpr = CoveragePercentStyle;
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    Visible=false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }

                field("Source Account No"; Rec."Source Account No")
                {
                    Visible = false;
                }

                field("Source Account Name"; Rec."Source Account Name")
                {
                    Visible = false;
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    Visible = false;
                }

                field("Checkoff No"; Rec."Checkoff No")
                {
                    Visible = false;
                }

                field(TOTAL_DISTRIBUTED; Rec.TOTAL_DISTRIBUTED)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member No" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member No" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}






