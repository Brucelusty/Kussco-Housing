//************************************************************************
pageextension 50025 "PaymentJournalPageExtension" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Account No.")
        {
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = All;

            }
            field("Loan No"; Rec."Loan No")
            {
                ApplicationArea = All;

            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;

            }
        }
        addafter("Credit Amount")
        {
            field(GeneralPostingType; Rec."Gen. Posting Type")
            {
                ApplicationArea = All;

            }
            field("VAT ProdPosting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;

            }
            field("VATBusPosting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;

            }
        }

        modify("Recipient Bank Account")
        {
            Visible = false;
        }
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
        // addafter(PostAndPrint)
        //  {
        //  /action("Account closure Slip")
        /*             action("Import Journal")
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
         */
        // }
    }

    var
        myInt: Integer;
}


