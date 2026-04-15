pageextension 50009 "G/L Entries Part" extends "G/L Entries Part"
{
    layout
    {
        addafter(CredAmt)
        {
            field("Debit Amount"; Rec."Debit Amount") { ApplicationArea = all; }
            field("Credit Amount"; Rec."Credit Amount") { ApplicationArea = all; }
            field(Description; Rec.Description) { ApplicationArea = all; }
            field("User ID"; Rec."User ID") { ApplicationArea = all; }
            field("Source No."; Rec."Source No.") { ApplicationArea = all; }
            field(SystemCreatedAt; Rec.SystemCreatedAt) { ApplicationArea = all; }
            field(SystemModifiedAt; Rec.SystemModifiedAt) { ApplicationArea = all; }
            field(Reversed; Rec.Reversed) { ApplicationArea = all; }
            field("Reversal Date"; Rec."Reversal Date") { ApplicationArea = all; }
            field("Transaction No.";Rec."Transaction No.") { ApplicationArea = all; }
        }

        /*       addafter(kk)
                        {
                    field("Debit Amount";Rec."Debit Amount") { ApplicationArea = all; }
                    field("Credit Amount";Rec."Credit Amount") { ApplicationArea = all; }
                }  */
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
