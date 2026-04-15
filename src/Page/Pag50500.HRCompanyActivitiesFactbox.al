//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50500 "HR Company Activities Factbox"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "HR Company Activities";

    layout
    {
        area(content)
        {
            group(Control1102755018)
            {
                label(Control1102755019)
                {
                    CaptionClass = Text1;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Code";Rec.Code)
                {
                }
                field(Description;Rec.Description)
                {
                }
                field(Date;Rec.Date)
                {
                }
                field(Venue;Rec.Venue)
                {
                }
                field("Employee Name";Rec."Employee Name")
                {
                    Caption = 'Employee Responsible';
                }
                field("Email Message";Rec."Email Message")
                {
                }
                label(Control1102755020)
                {
                    CaptionClass = Text2;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Costs;Rec.Costs)
                {
                }
                field("Contribution Amount (If Any)";Rec."Contribution Amount (If Any)")
                {
                }
                field("G/L Account No";Rec."G/L Account No")
                {
                }
                field("G/L Account Name";Rec."G/L Account Name")
                {
                }
                field("Bal. Account Type";Rec."Bal. Account Type")
                {
                }
                field("Bal. Account No";Rec."Bal. Account No")
                {
                }
                field(Posted;Rec.Posted)
                {
                }
                label(Control1102755012)
                {
                    CaptionClass = Text3;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Closed;Rec.Closed)
                {
                }
                field(Status;Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Activity Description';
        Text2: label 'Activity Cost';
        Text3: label 'Activity Status';
}






