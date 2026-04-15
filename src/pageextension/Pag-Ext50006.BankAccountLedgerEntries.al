pageextension 50006 "Bank Account Ledger Entries" extends "Bank Account Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Amount (LCY)")
        {
            field(Reversedk; Rec.Reversed) { ApplicationArea = All; }
            field(SystemModifiedBy; Rec.SystemModifiedBy) { ApplicationArea = All; }
            field(SystemModifiedAt; Rec.SystemModifiedAt) { ApplicationArea = All; }
            field("Entry No"; Rec."Entry No.") { ApplicationArea = All; }
            field("Done By"; Rec."User ID") { ApplicationArea = All; }
            field("Reversed Entry No"; Rec."Reversed Entry No.") { ApplicationArea = All; }
            field("Account Affected"; Rec."Account Affected") { ApplicationArea = All; }
        }
        addafter(Description)
        {
            field("Account ATM"; Rec."Account ATM")
            { ApplicationArea = All; }
        }
        addafter("Document No.")
        {
            field("Transaction Count"; Rec."Transaction Count")
            { ApplicationArea = All; }
        }

        modify(Amount)
        {
            Caption = 'Amount';
        }
        modify("Credit Amount")
        {
            Caption = 'Credit Amount';

        }
        modify("Debit Amount (LCY)")
        {
            Caption = 'Debit Amount (Ksh)';
        }
        modify("Debit Amount")
        {
            Caption = 'Debit Amount';

        }
        modify(RunningBalance)
        {
            Caption = 'Running Balance';
        }
        modify("Credit Amount (LCY)")
        {
            Caption = 'Credit Amount (Ksh)';
        }
        modify(RunningBalanceLCY)
        {
            Caption = 'RunningBalance (Ksh)';
        }
        modify("Amount (LCY)")
        {
            Caption = 'Amount (Ksh)';
        }
        addafter("Amount (LCY)")
        {

        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
