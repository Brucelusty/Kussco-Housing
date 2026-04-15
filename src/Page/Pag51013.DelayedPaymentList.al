page 51013 "Delayed Payment List"
{
    ApplicationArea = All;
    Caption = 'Delayed Payment List';
    PageType = List;
    SourceTable = "Delayed Payment";
    CardPageId="Delayed Payment Card";
    SourceTableView=where(Posted = filter(false));
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ToolTip = 'Specifies the value of the Transaction Description field.';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
            }
        }
    }
}


