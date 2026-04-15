namespace TelepostSacco.TelepostSacco;

page 51175 "Member Pin Reset Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Caption = 'Member Pin Reset Card';
    PageType = Card;
    SourceTable = "Member Pin Reset";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Member Banking"; Rec."Member Banking")
                {
                    ToolTip = 'Specifies the value of the Member Banking field.', Comment = '%';
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.', Comment = '%';
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ToolTip = 'Specifies the value of the Date Requested field.', Comment = '%';
                }
                field("Changed By"; Rec."Changed By")
                {
                    ToolTip = 'Specifies the value of the Changed By field.', Comment = '%';
                }
                field("Date Changed"; Rec."Date Changed")
                {
                    ToolTip = 'Specifies the value of the Date Changed field.', Comment = '%';
                }
            }
        }
    }
}


