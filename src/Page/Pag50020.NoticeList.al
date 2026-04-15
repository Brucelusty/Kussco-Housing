page 50020 "Notice List"
{
    ApplicationArea = All;
    Caption = 'Notice List';
    PageType = List;
    CardPageId = "Notice Card";
    UsageCategory = Lists;
    SourceTable = "Withdrawal Notice";
    SourceTableView = where("Approval Status"=filter(New));
    
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
                field("Payroll No";Rec."Payroll No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Registration Date";Rec."Registration Date")
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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}


