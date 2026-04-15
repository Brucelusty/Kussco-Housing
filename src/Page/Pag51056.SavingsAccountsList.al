page 51056 "Savings Accounts List"
{
    ApplicationArea = All;
    Caption = 'Savings Product Accounts List';
    CardPageId = "Savings Accounts Opened";
    // DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "FOSA Account Applicat. Details";
    SourceTableView = sorting(Name) WHERE( "Account Type" = filter('104'|'105'|'106'|'107'|'108'|'109'|'110'|'111'), created = filter(true));
    // Status=FILTER(Approved),
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("New FOSA No.";Rec."New FOSA No.")
                {
                    Caption = 'FOSA Account';
                }
                field("BOSA Account No";Rec."BOSA Account No")
                {
                    Caption = 'Member No.';
                }
                field(Name;Rec.Name)
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account Type Name";Rec."Account Type Name")
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field("Staff No";Rec."Staff No")
                {
                }
                field("Mobile Phone No";Rec."Mobile Phone No")
                {
                }
                field("Monthly Contribution";Rec."Monthly Contribution")
                {
                }
                field(Status;Rec.Status)
                {
                }
                field("Registration Date";Rec."Registration Date")
                {
                }
                field("No.";Rec."No.")
                {
                    Caption = 'Applicant No.';
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
            // action(ActionName)
            // {
                
            //     trigger OnAction();
            //     begin
                    
            //     end;
            // }
        }
    }
}


