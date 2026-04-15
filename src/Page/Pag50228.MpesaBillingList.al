//************************************************************************
page 50228 "Mpesa Billing List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = MpesaBillings;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Billing No"; Rec.BillingNo)
                {

                }
                field("Bill Account Type"; Rec."Bill Account Type")
                {

                }
                field("Bill Account No."; Rec."Bill Account No.")
                {

                }
                field("Bill Status"; Rec."Bill Status")
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




