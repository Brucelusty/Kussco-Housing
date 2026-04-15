page 51140 "Tranche Register List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Tranche Register";
    Caption = 'Tranche Register';
    CardPageId = "Tranche Register Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                }

                field("Loan No"; Rec."Loan No")
                {
                }

                field("Document Date"; Rec."Document Date")
                {
                }

                field("Client Code"; Rec."Client Code")
                {
                }

                field("Client Name"; Rec."Client Name")
                {
                }


            }
        }
    }
}


