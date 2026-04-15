page 50001 "Custodians Setup"
{
    ApplicationArea = All;
    Caption = 'PageName';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Safe Custody Custodians";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                }
                field("Permision Type"; Rec."Permision Type")
                {
                }
                field("Custodian Of"; Rec."Custodian Of")
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


