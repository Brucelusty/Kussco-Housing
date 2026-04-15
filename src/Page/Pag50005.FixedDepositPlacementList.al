page 50005 "Fixed Deposit Placement List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Fixed Deposit Placement";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Fixed Deposit Account No";Rec."Fixed Deposit Account No")
                {
                }
                field("Fixed Deposit Type";Rec."Fixed Deposit Type")
                {
                }
                field("Fixed Duration";Rec."Fixed Duration")
                {
                }
                field("Amount to Fix";Rec."Amount to Fix")
                {
                }
                field("Application Date";Rec."Application Date")
                {
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
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}


