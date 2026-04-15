//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51109 "Recruitment Lines"
{
    ApplicationArea = All;
    DelayedInsert = false;

    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Recruitment Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;//

                field("Member No"; Rec."Member No")
                {
                    Caption = 'Member Number';
                }
                field("No."; Rec."No.")
                {
                    Editable = true;
                    Visible = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    // Visible = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    //     Image = Person;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("Mobile Phone Number"; Rec."Mobile Phone Number")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Person Recruited"; Rec."Person Recruited")
                {
                }
                field("Recruited Name"; Rec."Recruited Name")
                {
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

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Account Name" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Account Name" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}




