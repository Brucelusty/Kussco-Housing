pageextension 50002 "Vendor Lookup EXT" extends "Vendor Lookup"
{
    layout
    {
        addafter(Name)
        {
            field(availableBal; availableBal)
            {
                ApplicationArea = All;
                Caption = 'Available Balance';
                Style = StrongAccent;
            }
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = All;
               // Caption = 'PF Number';
            }
            field("Member No"; Rec."BOSA Account No")
            {
                ApplicationArea = All;
            }
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = All;
            }
            field("Mobile Phone No"; Rec."Mobile Phone No")
            {
                ApplicationArea = All;
            }
        }


    }

    var
    availableBal: Decimal;

    trigger OnAfterGetCurrRecord() begin
        availableBal := Rec.GetAvailableBalance();
    end;
}
