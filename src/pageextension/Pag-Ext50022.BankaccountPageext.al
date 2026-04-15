//************************************************************************
pageextension 50022 "BankaccountPageext" extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bank Clearing Code")
        {
            field("EFT/RTGS Bank"; Rec."EFT/RTGS Bank")
            {
                ApplicationArea = All;

            }
            group("Teller/Treasury Addon")
            {
                Caption = 'Teller/Treasury Addon';
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("MPESA Account"; Rec."MPESA Account")
                {
                    ApplicationArea = Basic;
                }
                field("POS Account"; Rec."POS Account")
                {
                    ApplicationArea = Basic;
                }
                field("Teller Excess Account"; Rec."Teller Excess Account")
                {
                    ApplicationArea = Basic;
                }
                field("Teller Excess Account balance"; Rec."Teller Excess Account balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Teller Shortage Account"; Rec."Teller Shortage Account")
                {
                    ApplicationArea = Basic;
                }
                field("Teller Shortage Account balance"; Rec."Teller Shortage Account balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maximum Teller Withholding"; Rec."Maximum Teller Withholding")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Teller Withholding"; Rec."Minimum Teller Withholding")
                {
                    ApplicationArea = Basic;
                }
                field("Max Withdrawal Limit"; Rec."Max Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Max Deposit Limit"; Rec."Max Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Max Cheque Deposit Limit"; Rec."Max Cheque Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                field(CashierID; Rec.CashierID)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Bank"; Rec."Cheque Clearing Bank")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Bankers Cheque Clearing Bank"; Rec."Bankers Cheque Clearing Bank")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}


