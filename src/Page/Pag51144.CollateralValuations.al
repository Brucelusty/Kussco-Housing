page 51144 "Collateral Valuations"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Collateral Valuation";
    Caption = 'Valuations';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Valued By"; Rec."Valued By") { }
                field("Valuer Name"; Rec."Valuer Name")
                {
                    Editable = false;
                }
                field("Valuation Date"; Rec."Valuation Date") { }

                field("Market Value"; Rec."Market Value") { }
                 field("Forced Sale Value"; Rec."Forced Sale Value") { }

                field("Valuation Description"; Rec."Valuation Description") { }
                field("Current Valuation"; Rec."Current Valuation") { }


            }
        }
    }
}


