page 50033 "Registered Notice List"
{
    ApplicationArea = All;
    PageType = List;
    CardPageId = "Registered Notice Card";
    UsageCategory = Lists;
    SourceTable = "Withdrawal Notice";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    SourceTableView = where("Notice Status" = Filter(Registered|Matured));
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Withdrawal Type";Rec."Withdrawal Type")
                {
                }
                field("Registration Date";Rec."Registration Date")
                {
                }
                field("Reason for Exit";Rec."Reason for Exit")
                {
                }
                
                field("Notice Date";Rec."Notice Date")
                {
                }
                field("Maturity Date";Rec."Maturity Date")
                {
                }

            }
        }
        area(FactBoxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction();
                begin

                end;
            }
        }
    }
}


