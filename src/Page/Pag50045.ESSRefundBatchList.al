page 50045 "ESS Refund Batch List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "ESS Refund Batch";
    CardPageId = "ESS Refund Batch Card";
    SourceTableView = where(Posted = filter(false));
    DeleteAllowed = false;
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("ESSRef Batch No.";Rec."ESSRef Batch No.")
                {
                }
                field("Captured On";Rec."Captured On")
                {
                    
                }
                field("Captured By";Rec."Captured By")
                {
                }
                field("Total Disbursed";Rec."Total Disbursed")
                {
                }
                field("Posted On";Rec."Posted On")
                {
                    Caption = 'Posting Date';
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            
        }
    }
}


