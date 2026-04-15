//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50275 "HR Leave Types"
{
    ApplicationArea = All;
    CardPageID = "HR Leave Types Card";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field("Code"; Rec.Code)
                {
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field(Description; Rec.Description)
                {
                }
                field(Days; Rec.Days)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                }
                field("Inclusive of Non Working Days"; Rec."Inclusive of Non Working Days")
                {
                }
                field("Inclusive of Saturday"; Rec."Inclusive of Saturday")
                {
                }
                field("Inclusive of Sunday"; Rec."Inclusive of Sunday")
                {
                }
                field("Inclusive of Holidays"; Rec."Inclusive of Holidays")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755003; Outlook)
            {
            }
            systempart(Control1102755004; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}






