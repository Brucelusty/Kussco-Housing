namespace TelepostSacco.TelepostSacco;

page 51182 "Insurance Claims"
{
    ApplicationArea = All;
    Caption = 'Insurance Claims';
    PageType = List;
    SourceTable = "Insurance Claims";
    UsageCategory = Lists;
    CardPageId = "Insurance Claim Card";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Claim No."; Rec."Claim No.")
                {
                    ToolTip = 'Specifies the value of the Claim No. field.', Comment = '%';
                }
                field("Bank No."; Rec."Bank No.")
                {
                    ToolTip = 'Specifies the value of the Bank No. field.', Comment = '%';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Reason For Claim"; Rec."Reason For Claim")
                {
                    ToolTip = 'Specifies the value of the Reason For Claim field.', Comment = '%';
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ToolTip = 'Specifies the value of the Claim Date field.', Comment = '%';
                }
                field("Claim Description"; Rec."Claim Description")
                {
                    ToolTip = 'Specifies the value of the Claim Description field.', Comment = '%';
                }
                field("Expected Amount"; Rec."Expected Amount")
                {
                    ToolTip = 'Specifies the value of the Expected Amount field.', Comment = '%';
                }
                field(Status;Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Initiated By field.', Comment = '%';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ToolTip = 'Specifies the value of the Cheque No field.', Comment = '%';
                }
            }
        }
    }
}


