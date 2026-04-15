pageextension 50028 "General Ledger Entry Ext" extends "General Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("DebitAmount"; Rec."Debit Amount") { ApplicationArea = all;Visible=true; }
            field("CreditAmount"; Rec."Credit Amount") { ApplicationArea = all; }
            field("SourceNo.";Rec."Source No.") { ApplicationArea = all; }
            field("Transaction Type";Rec."Transaction Types") { ApplicationArea = all; }

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
        addafter("Value Entries")
        {
            action(Correct)
            {
                ApplicationArea = All;
                Caption = 'Correct G/L Acc';
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                // Visible = false;

                trigger OnAction() begin
                    // Rec.TestField("G/L Account No.", '200-000-152');
                    if Confirm('Do you wish to rectify this gl entry?', true) = false then exit;
                    Rec."G/L Account No." := '200-000-152';
                    Rec.Modify;
                end;
            }
        }
    }

    var
        myInt: Integer;
}
    
