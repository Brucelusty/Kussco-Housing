//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50929 "Member Accounts"
{
    ApplicationArea = All;
    CardPageID = "Member Account Card View";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account Type Name";Rec."Account Type Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Balance; Rec.Balance)
                {
                    StyleExpr = CoveragePercentStyle;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup11)
            {
                action("Account Statement")
                {
                    Caption = 'Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        ObjAccount.Reset;
                        ObjAccount.SetRange(ObjAccount."No.", Rec."No.");
                        if ObjAccount.Find('-') then
                            Report.run(172890, true, false, ObjAccount)
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Status, '<>%1', Rec.Status::Closed);
    end;

    var
        CoveragePercentStyle: Text;
        MinimumBalance: Decimal;
        ObjAccount: Record Vendor;

    local procedure SetStyles()
    begin
        MinimumBalance := 1000;
        if Rec.Balance = 0 then
            CoveragePercentStyle := 'Strong'
        else
            if Rec.Balance < MinimumBalance then
                CoveragePercentStyle := 'Unfavorable'
            else
                CoveragePercentStyle := 'Favorable';
    end;
}




