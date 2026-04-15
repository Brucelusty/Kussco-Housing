namespace TelepostSacco.TelepostSacco;

page 51176"File Types Setup"
{
    ApplicationArea = All;
    Caption = 'File Types Setup';
    PageType = List;
    SourceTable = "File Types SetUp";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Member Type";Rec."Member Type")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}


