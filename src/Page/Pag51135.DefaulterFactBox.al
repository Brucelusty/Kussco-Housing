page 51135 "Defaulter FactBox"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Defaulter Case";

    layout
    {
        area(Content)
        {
            group("Quick Stats")
            {
                field("Outstanding Amount"; Rec."Outstanding Amount") { }
                field("Days in Arrears"; Rec."Days in Arrears") { }
                field("Recovery Stage"; Rec."Recovery Stage") { }
                field("Loan Status"; Rec."Loan Status") { }
            }
        }
    }
}


