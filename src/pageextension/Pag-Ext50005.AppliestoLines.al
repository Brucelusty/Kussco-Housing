pageextension 50005 "Applies to Lines" extends "Apply Bank Acc. Ledger Entries"
{

    layout

    {


        addbefore(LineApplied)
        {
            field("Entry No."; Rec."Entry No.") { ApplicationArea = All; Editable = false; }
        }
        // Add changes to page layout here
        addafter("Posting Date")
        {

            field(Reconciled; Rec.Reconciled)
            {
                ApplicationArea = all;
                Editable = true;
            }

            field("ExternalDocument No."; Rec."External Document No.")
            {
                ApplicationArea = all;
                Caption = 'Cheque No';
                Editable = false;
            }
            field("Document No"; Rec."Document No.") { ApplicationArea = All; Caption = 'Transaction No'; Editable = false; }
            field(Descriptions; Rec.Description)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Amounts; Rec.Amount) { ApplicationArea = All; Editable = false; }
            field("StatementLine No."; Rec."Statement Line No.") { ApplicationArea = All; Editable = false; }
            field("StatementNo."; Rec."Statement No.") { ApplicationArea = All; Editable = false; }
            field("Bank Account No."; Rec."Bank Account No.") { ApplicationArea = All; Editable = false; }




        }

        addafter(Open)
        {
            field(StatementStatus; Rec."Statement Status") { ApplicationArea = All; Editable = false; }
        }



    }


    actions
    {

        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        BankRecon: Record "Bank Acc. Reconciliation";
    begin
        BankRecon.Reset();
        BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
        if BankRecon.Find('-') then begin
            Rec.SetFilter("Posting Date", '..%1', BankRecon."Statement Date");
        end;

    end;

    var
        myInt: Integer;

}
