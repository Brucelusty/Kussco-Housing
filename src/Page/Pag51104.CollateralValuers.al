page 51104 "Collateral Valuers"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Collateral Valuer";
    Caption = 'Collateral Valuers';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Valuer Code"; Rec."Valuer Code") { }
                field("Valuer Name"; Rec."Valuer Name") { }
                field("Phone No."; Rec."Phone No.") { }
                field("Email"; Rec."Email") { }
                field("Town"; Rec."Town") { }
                field("Active"; Rec."Active") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewCard)
            {
                Caption = 'View';
                Image = View;

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"Collateral Valuer Card", Rec);
                end;
            }
        }
    }
}


