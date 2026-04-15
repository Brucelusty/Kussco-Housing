//************************************************************************
pageextension 50017 "DetCustLedgerpExt" extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Transaction Type";Rec."Transaction Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Loan No";Rec."Loan No")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Loan Type";Rec."Loan Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

            }
            field(Reversed; Rec.Reversed)
            {
                ApplicationArea = basic;
            }
            // field("Loan No";"Loan No"){}
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Unapply Entries")
        {
            action(Correct)
            {
                ApplicationArea = All;
                Caption = 'Correct Reversals';
                Image = Recalculate;

                trigger OnAction() begin
                    custledger.Reset();
                    custLedger.SetRange("Entry No.", Rec."Cust. Ledger Entry No.");
                    if custLedger.Find('-') then begin
                        if custLedger.Reversed = true then Error('The selected entry is correctly reversed within the respective Ledger Entry. Kindly investigate further.');

                        if custLedger.Reversed = false then begin
                            Rec.Reversed := false;
                            Rec."Reversed Cust Entry" := '';
                            Rec."Reversal Date" := 0D;
                            Rec."Correct Reversal Date" := Today;
                            Rec.Modify();
                            Message('The entry was unmarked as reversed successfully.');
                        end;
                    end;
                end;
            }
            
            action(Mark)
            {
                ApplicationArea = All;
                Caption = 'MArk As Reversed';
                Image = Recalculate;

                trigger OnAction() begin
                    custledger.Reset();
                    custLedger.SetRange("Entry No.", Rec."Cust. Ledger Entry No.");
                    custLedger.SetRange(Reversed, true);
                    if custLedger.Find('-') then begin
                        if Rec.Reversed = false then begin
                            Rec.Reversed := true;
                            Rec."Correct Reversal Date" := Today;
                            Rec.Modify();
                            Message('The entry was marked as reversed successfully.');
                        end;
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
        custLedger: Record "Cust. Ledger Entry";
        detCust: Record "Detailed Cust. Ledg. Entry";
}


