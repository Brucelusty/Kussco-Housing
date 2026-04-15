//************************************************************************
page 50229 "Member Transaction List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Member Transactions";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Member No";Rec."Member No")
                {

                }
                field("FOSA Account No";Rec."FOSA Account No")
                {

                }
                field("Posting Date";Rec."Posting Date")
                {

                }
                field("Document Number";Rec."Document Number")
                {

                }
                field("Transaction Description";Rec."Transaction Description")
                {

                }
                field(Amount;Rec.Amount)
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




