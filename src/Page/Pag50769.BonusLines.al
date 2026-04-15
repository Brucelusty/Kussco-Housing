//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50769 "Bonus Lines"
{
    ApplicationArea = All;
    // DelayedInsert = false;

    //Editable = false;
    // InsertAllowed = false;
    //ModifyAllowed = false;
    //DeleteAllowed=false;
    PageType = ListPart;
    SourceTable = "Bonus Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
  
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
                field(Region; Rec.Region)
                {
                }
                field(Grade; Rec.Grade)
                {
                }
                field(Name; Rec.Name)
                {
                    Visible = false;
                }
                field("Credit Narration"; Rec."Credit Narration")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Branch Reff."; Rec."Branch Reff.")
                {
                    Visible = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    Visible = false;
                }
                field("Original Account No."; Rec."Original Account No.")
                {
                    Visible = false;
                }
                field("Account Not Found"; Rec."Account Not Found")
                {
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    Visible = false;
                }
                field("BOSA Schedule"; Rec."BOSA Schedule")
                {
                    Visible = false;
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Multiple Salary"; Rec."Multiple Salary")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Salary Header No."; Rec."Salary Header No.")
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




