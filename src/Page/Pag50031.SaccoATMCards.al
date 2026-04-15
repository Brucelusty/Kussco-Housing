page 50031 "Sacco ATM Cards"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Vendor;
    SourceTableView = where("ATM No." = filter(<> ''));
    CardPageId = "Sacco ATM Cards Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                {
                }
                field(Name;Rec.Name)
                {
                }
                field("ATM No.";Rec."ATM No.")
                {
                }
                field("Personal No.";Rec."Personal No.")
                {
                    Caption = 'Payroll No.';
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("ATM Enabled";Rec."ATM Enabled")
                {
                }
                field("ATM Expiry Date";Rec."ATM Expiry Date")
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


