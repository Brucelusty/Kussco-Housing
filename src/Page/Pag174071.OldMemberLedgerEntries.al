namespace TelepostSacco.TelepostSacco;

page 51177 "Old Member Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Old Member Ledger Entries';
    PageType = List;
    SourceTable = "Old Member Ledger Entries";
    UsageCategory = Administration;
    
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
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field(Transaction; Rec.Transaction)
                {
                    ToolTip = 'Specifies the value of the Transaction field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Reveresed; Rec.Reveresed)
                {
                    ToolTip = 'Specifies the value of the Reveresed field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
            }
        }
    }
}


