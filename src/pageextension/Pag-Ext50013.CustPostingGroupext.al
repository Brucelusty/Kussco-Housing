//************************************************************************
pageextension 50013 "CustPostingGroupext" extends "Customer Posting Groups"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {

            field("Shares Deposits Account"; Rec."Shares Deposits Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Registration Fees Account"; Rec."Registration Fees Account")
            {
                ApplicationArea = All;
            }
            field("Savings Account"; Rec."Savings Account")
            {
                ApplicationArea = All;
                //Visible = false;
            }
            field("Shares Capital Account"; Rec."Shares Capital Account")
            {
                ApplicationArea = All;
                //Visible = false;
            }
            field("Dividend Account"; Rec."Dividend Account")
            {
                ApplicationArea = All;
            }
            field("Withdrawal Fee"; Rec."Withdrawal Fee")
            {
                ApplicationArea = All;
                Visible=false;
            }
            field("Investment Account"; Rec."Investment Account")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Un-allocated Funds Account"; Rec."Un-allocated Funds Account")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Prepayment Account"; Rec."Prepayment Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Withdrawable Deposits"; Rec."Withdrawable Deposits")
            {
                ApplicationArea = All;
                Visible = false;


            }
            field("Loan Form Fee"; Rec."Loan Form Fee")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Passbook Fee"; Rec."Passbook Fee")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Risk Fund Charged Account"; Rec."Risk Fund Charged Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Risk Fund Paid Account"; Rec."Risk Fund Paid Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Group Shares"; Rec."Group Shares")
            {
                ApplicationArea = All;
                Visible = false;
            }


            field("Insurance Fund Account"; Rec."Insurance Fund Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Benevolent Fund Account"; Rec."Benevolent Fund Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Coop Shares Account"; Rec."Coop Shares Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Recovery Account"; Rec."Recovery Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("FOSA Shares"; Rec."FOSA Shares")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Additional Shares"; Rec."Additional Shares")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Junior Savings Account"; Rec."Junior Savings Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Safari Savings Account"; Rec."Safari Savings Account")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Silver Savings Account"; Rec."Silver Savings Account")
            {
                ApplicationArea = All;
                Visible = false;
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


