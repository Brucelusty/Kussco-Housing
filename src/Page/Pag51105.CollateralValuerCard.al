page 51105 "Collateral Valuer Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Collateral Valuer";
    Caption = 'Collateral Valuer';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Valuer Code"; Rec."Valuer Code") { }
                field("Valuer Name"; Rec."Valuer Name") { }
                field("Active"; Rec."Active") { }
            }

            group(Contact)
            {
                field("Phone No."; Rec."Phone No.") { }
                field("Email"; Rec."Email") { }
                field("Physical Address"; Rec."Physical Address") { }
                field("Town"; Rec."Town") { }
            }

            group("Notes.")
            {
                field("Notes"; Rec."Notes") { }
            }
        }
    }
}


