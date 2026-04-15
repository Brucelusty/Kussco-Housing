namespace TelepostSacco.TelepostSacco;

page 51174 "Member Pin Reset"
{
    ApplicationArea = All;
    Caption = 'Member Pin Reset';
    PageType = List;
    SourceTable = "Member Pin Reset";
    UsageCategory = Lists;
    CardPageId = "Member Pin Reset Card";
    DeleteAllowed = false;
    Editable = false;
    
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
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("ID No"; Rec."ID No")
                {
                    ToolTip = 'Specifies the value of the ID No field.', Comment = '%';
                }
                field("Member Banking"; Rec."Member Banking")
                {
                    ToolTip = 'Specifies the value of the Member Banking field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.', Comment = '%';
                }
            }
        }
    }
}


