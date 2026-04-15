page 50085 "Appraisal Periods"
{
    ApplicationArea = All;
    Caption = 'Appraisal Periods';
    PageType = List;
    SourceTable = "Appraisal Periods";
    UsageCategory = Administration;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Open; Rec.Open)
                {
                    ToolTip = 'Specifies the value of the Open field.';
                }
                field("Opened By"; Rec."Opened By")
                {
                    ToolTip = 'Specifies the value of the Opened By field.';
                    Enabled = false;
                }
                field("Period Start Date"; Rec."Period Start Date")
                {
                    ToolTip = 'Specifies the value of the Period Start Date field.';
                }
                field("Period End Date"; Rec."Period End Date")
                {
                    ToolTip = 'Specifies the value of the Period End Date field.';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Close By"; Rec."Close By")
                {
                    ToolTip = 'Specifies the value of the Close By field.';
                    Enabled = false;
                }
            }
        }
    }
}


