page 50036 "Funeral Rider Processing"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Funeral Rider Processing";
    CardPageId = "Funeral Rider Processing Card";
    SourceTableView = where("Approval Status" = filter(<>Approved));
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("FR No.";Rec."FR No.")
                {
                }
                field("Member No.";Rec."Member No.")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Member Deceased";Rec."Member Deceased")
                {
                }
                field("Next of Kin Deceased";Rec."Next of Kin Deceased")
                {
                }
                field("NoK Name";Rec."NoK Name")
                {
                }
                field("NoK is Member";Rec."NoK is Member")
                {
                }
                field("Captured On";Rec."Captured On")
                {
                }
                field("Processing Status";Rec."Processing Status")
                {
                }
                field("Approval Status";Rec."Approval Status")
                {
                }
                // field()
                // {
                // }
            }
        }
        area(Factboxes)
        {
            // part(Control1000000052; "Member Statistics FactBox")
            // {
            //     Caption = 'Member Statistics FactBox';
            //     SubPageLink = "No." = field("Member No.");
            // }
        }
    }
    
    actions
    {
        // area(Processing)
        // {
        //     action(ActionName)
        //     {
                
        //         trigger OnAction()
        //         begin
                    
        //         end;
        //     }
        // }
    }
}


