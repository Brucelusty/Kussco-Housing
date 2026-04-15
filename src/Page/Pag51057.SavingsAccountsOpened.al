page 51057 "Savings Accounts Opened"
{
    ApplicationArea = All;
    Caption = 'Savings Product Opened Accounts';
    PageType = Card;
    // DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Administration;
    SourceTable = "FOSA Account Applicat. Details";
    SourceTableView = sorting(Name);
    
    layout
    {
        area(Content)
        {
            group(General)
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
                field("ID No.";Rec."ID No.")
                {
                }
                field("Mobile Phone No";Rec."Mobile Phone No")
                {
                }
                field("Staff No";Rec."Staff No")
                {
                }
                field("Account Type";Rec."Account Type")
                {
                }
                field("Account Category";Rec."Account Category")
                {
                    Visible = false;
                }
                field("Account Type Name";Rec."Account Type Name")
                {
                }
                field("Account Balance";Rec."Account Balance")
                {
                    Visible = false;
                }
                field("Monthly Contribution";Rec."Monthly Contribution")
                {
                }
                field("Employer Code";Rec."Employer Code")
                {
                }
                field(Status;Rec.Status)
                {
                }
                field("Created By";Rec."Created By")
                {
                }
                field("Recruited By";Rec."Recruited By")
                {
                }
                field("No.";Rec."No.")
                {
                    Caption = 'Applicant No.';
                }         
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {
                
            //     trigger OnAction()
            //     begin
                    
            //     end;
            // }
        }
    }
    
    var
        myInt: Integer;
}


