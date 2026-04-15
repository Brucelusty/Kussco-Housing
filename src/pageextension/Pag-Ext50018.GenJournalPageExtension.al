//************************************************************************
pageextension 50018 "GenJournalPageExtension" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Amount)
        {
            field("Debit Amount2"; Rec."Debit Amount")
            {
                ApplicationArea = All;
                Caption = 'Debit Amount';
            }
            field("Credit Amount2"; Rec."Credit Amount")
            {
                ApplicationArea = All;
                Caption = 'Credit Amount';
            }
            field("test field"; Rec."test field")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Approved Amount';
                Visible = false;
            }
            field("Loan Balance"; Rec."Loan Balance")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Account No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = All;

            }
            field("Loan No"; Rec."Loan No")
            {
                ApplicationArea = All;

            }

            field("Loan Product Type"; Rec."Loan Product Type")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("Member No"; Rec."Member No")
            {
                ApplicationArea = All;
                Editable = false;

            }


        }

        modify("Document Type")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Bal. Account No.")
        {
            Visible = true;
        }
        modify("Bal. Account Type")
        {
            Visible = true;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter(PostAndPrint)
        {
            //  /action("Account closure Slip")
            action("Import Journal")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import Csvs';
                Promoted = true;
                Image = Import;
                PromotedCategory = Process;
                RunObject = xmlport "Import Journals";
            }

            action("Import Loans Journal")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import Loans Csvs';
                Promoted = true;
                Image = Import;
                PromotedCategory = Process;
                RunObject = xmlport "Import Loans Journals";
            }

        }
    }

    var
        myInt: Integer;
}


