namespace TelepostSacco.TelepostSacco;

page 51172 "Uploaded Portal Notices"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Portal Notice Board";
    UsageCategory = Administration;
    CardPageId = "Manage Portal Notice Board";
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Upload Title";Rec."Upload Title")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Upload Description";Rec."Upload Description")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Upload Type";Rec."Upload Type")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    Style = StrongAccent;
                }
                field("Upload Status";Rec."Upload Status")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field(Uploaded;Rec.Uploaded)
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field(Removed;Rec.Removed)
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                // field()
                // {
                //     ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                // }
            }
        }
    }
}


