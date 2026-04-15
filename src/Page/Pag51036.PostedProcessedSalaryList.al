page 51036 "Posted Processed Salary List"
{
    ApplicationArea = All;
    Caption = 'Posted Processed Salary List';
    PageType = List;
    SourceTable = "Delayed Payment";
    CardPageId="Posted Processed Salary Card";
    SourceTableView=where(Posted = filter(true));
    
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
                field("Posting date";Rec."Posting date")
                {
                    ToolTip = 'Specifies the date the document was posted';
                }
                field(Region;Rec.Region)
                {}
                field(Grade;Rec.Grade)
                {}
                field("Scheduled Amount";Rec."Scheduled Amount")
                {
                    
                }
            }
        }
    }
}


