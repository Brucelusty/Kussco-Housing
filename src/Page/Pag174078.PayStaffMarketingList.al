namespace TelepostSacco.TelepostSacco;

page 51180"Pay Staff Marketing List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Staff Marketing Payment";
    UsageCategory = Lists;
    CardPageId = "Pay Staff Marketing";
    PromotedActionCategories = 'New,Report,Process,Approvals';
    
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
                field("Payment Date";Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Payment By";Rec."Payment By")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Membership Rate";Rec."Membership Rate")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Salary Rate";Rec."Salary Rate")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
            }
        }
    }
}


