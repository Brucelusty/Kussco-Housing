namespace TelepostSacco.TelepostSacco;

page 51173 "Register Member Salary List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Register Salary Accounts";
    UsageCategory = Lists;
    CardPageId = "Register Member Salary";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.', Comment = '%';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.', Comment = '%';
                }
                field("Salary Account"; Rec."Salary Account")
                {
                    ToolTip = 'Specifies the value of the Salary Account field.', Comment = '%';
                }
                field("Salary Account Holder"; Rec."Salary Account Holder")
                {
                    ToolTip = 'Specifies the value of the Salary Account Holder field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
            }
        }
    }
}


