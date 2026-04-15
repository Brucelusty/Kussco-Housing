//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50657 "Paybill Processing Line"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Paybill Processing Lines";

    layout
    {
        area(content)
        {
            repeater(Control21)
            {
                Editable = true;
                field("Document No.";Rec."Document No.")
                {
                    Caption = 'Receipt Number';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Trans Date';
                    Editable = false;
                }
                field("Mobile Phone Number";Rec."Mobile Phone Number")
                {
                    Caption = 'Phone Number';
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    Caption = 'Depositor Name';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Account No.";Rec."Account No.")
                {
                    Caption = 'Invalid Account';
                    Editable = false;
                    //Image = Person;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Correct Account No";Rec."Correct Account No")
                {
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Account Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetStyles;
    end;

    trigger OnAfterGetRecord()
    begin
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        SetStyles;
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Correct Account No" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Correct Account No" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}






