//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50315 "Account Types Card"
{
    ApplicationArea = All;
    Editable = true;
    PageType = Card;
    SourceTable = "Account Types-Saving Products";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                }
                field("Activity Code"; Rec."Activity Code")
                {
                }
                field("Account Location"; Rec."Account Location")
                {

                }
                field(Description; Rec.Description)
                {
                }
                field("Account No Prefix"; Rec."Account No Prefix")
                {
                    Caption = 'Account No Prefix';
                }

                field("Product Type"; Rec."Product Type")
                {
                    // Caption = 'Account No Prefix';
                }
                field(Branch; Rec.Branch)
                {
                    Caption = 'Branch';
                }
                field("Product Code"; Rec."Product Code")
                {
                }
                field("Last No Used"; Rec."Last No Used")
                {
                }
                field("Paybill Code";Rec."Paybill Code")
                {
                }
                field("Store Series"; Rec."Store Series")
                {
                }
                field("SMS Description"; Rec."SMS Description")
                {
                }
                field(Withrawable; Rec.Withrawable)
                {
                }
                field(Depositable;Rec.Depositable)
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'Posting Group';
                }
                field("Dormancy Period (M)"; Rec."Dormancy Period (M)")
                {
                }
                field("Dormancy Period (-M)"; Rec."Dormancy Period (-M)")
                {
                }
                field("Withdrawal Interval"; Rec."Withdrawal Interval")
                {
                }
                field("Withdrawal Penalty"; Rec."Withdrawal Penalty")
                {
                }
                field("Withdrawal Interval Account"; Rec."Withdrawal Interval Account")
                {
                }
                field("Requires Opening Deposit"; Rec."Requires Opening Deposit")
                {
                }
                field("Allow Loan Applications"; Rec."Allow Loan Applications")
                {
                }
                field("Use Savings Account Number"; Rec."Use Savings Account Number")
                {
                }
                field("Fixed Deposit"; Rec."Fixed Deposit")
                {
                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                }
                field("Bulk Withdrawal Amount"; Rec."Bulk Withdrawal Amount")
                {
                }
                field("Standing Orders Suspense"; Rec."Standing Orders Suspense")
                {
                }
                field("Bankers Cheque Account"; Rec."Bankers Cheque Account")
                {
                }
                field("Maximum Withdrawal Amount"; Rec."Maximum Withdrawal Amount")
                {
                }
                field("Maximum Allowable Deposit"; Rec."Maximum Allowable Deposit")
                {
                }
                field("Check Off Recovery"; Rec."Check Off Recovery")
                {
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                }
                field("Use Graduated Charges"; Rec."Use Graduated Charges")
                {
                }
                field("Is Deposits"; Rec."Is Deposits")
                {
                }
                field("Is Share Capital"; Rec."Is Share Capital")
                {
                }
                field("Is ESS"; Rec."Is ESS")
                {
                }
                field("Is Business Account"; Rec."Is Business Account")
                {
                }
                field("Group Account"; Rec."Group Account")
                {
                }
                field("Default Account"; Rec."Default Account")
                {
                }
                field("Current Account"; Rec."Current Account")
                {
                }
                field("Maximum No Of Accounts"; Rec."Maximum No Of Accounts")
                {
                    ToolTip = 'Specify the maximum no of accounts a member can have for this product';
                }
                field("Individual Account"; Rec."Individual Account")
                {
                }
                field("Corporate Account"; Rec."Corporate Account")
                {
                }
                field("Over Draft Account"; Rec."Over Draft Account")
                {
                }
                field("Maximum Overdraft Period"; Rec."Maximum Overdraft Period")
                {
                }
                field("Default Piggy Bank Issuance"; Rec."Default Piggy Bank Issuance")
                {
                }
                field("Income Payment Code";Rec."Income Payment Code")
                {
                }
            }
            group("Interest Computation")
            {
                Caption = 'Interest Computation';
                field("Earns Interest"; Rec."Earns Interest")
                {

                    trigger OnValidate()
                    begin
                        InterestVisible := false;

                        if Rec."Earns Interest" = true then
                            InterestVisible := true;
                    end;
                }
                field("Interest Rate";Rec."Interest Rate")
                {
                }
                field("Interest Calc Min Balance"; Rec."Interest Calc Min Balance")
                {
                    Caption = 'Interest Min. Balance';
                }
                field("Allowable Withdrawals";Rec."Allowable Withdrawals")
                {
                    Caption = 'Interest Allowable Withdrawals';
                }
                field("Minimum Interest Period (M)"; Rec."Minimum Interest Period (M)")
                {
                }
                field("Tax On Interest"; Rec."Tax On Interest")
                {
                }
                field("Account Openning Fee"; Rec."Account Openning Fee")
                {
                    Caption = 'Account Openning Deposit';
                }
                field("Re-activation Fee"; Rec."Re-activation Fee")
                {
                }
                field("Requires Closure Notice"; Rec."Requires Closure Notice")
                {
                }
                field("Closure Notice Period"; Rec."Closure Notice Period")
                {
                }
                field("Closing Charge"; Rec."Closing Charge")
                {
                }
                field("Closing Prior Notice Charge"; Rec."Closing Prior Notice Charge")
                {
                }
                field("Min Bal. Calc Frequency"; Rec."Min Bal. Calc Frequency")
                {
                }
                field("Fee Below Minimum Balance"; Rec."Fee Below Minimum Balance")
                {
                }
                field("Over Draft Interest Rate"; Rec."Over Draft Interest Rate")
                {
                }
                field("Over Draft Interest Account"; Rec."Over Draft Interest Account")
                {
                }
                field("Overdraft Charge"; Rec."Overdraft Charge")
                {
                }
                field("Authorised Ovedraft Charge"; Rec."Authorised Ovedraft Charge")
                {
                }
                field("Service Charge"; Rec."Service Charge")
                {
                }
                field("Maintenence Fee"; Rec."Maintenence Fee")
                {
                }
                field("External EFT Charges"; Rec."External EFT Charges")
                {
                }
                field("Internal EFT Charges"; Rec."Internal EFT Charges")
                {
                }
                field("RTGS Charges"; Rec."RTGS Charges")
                {
                }
                field("Statement Charge"; Rec."Statement Charge")
                {
                }
                field("New Piggy Bank Fee"; Rec."New Piggy Bank Fee")
                {
                }
                field("Additional Piggy Bank Fee"; Rec."Additional Piggy Bank Fee")
                {
                }
                field("Savings Duration"; Rec."Savings Duration")
                {
                }
                field("Savings Withdrawal penalty"; Rec."Savings Withdrawal penalty")
                {
                }
                field("Term terminatination fee"; Rec."Term terminatination fee")
                {
                }
                field("FOSA Shares"; Rec."FOSA Shares")
                {
                }
                field("Account Type"; Rec."Account Type")
                {

                }
            }
            part(Control3; "Account Types Interest Rates")
            {
                SubPageLink = "Account Type" = field(Code);
                Visible = InterestVisible;
            }
            group("Fees & Comissions Accounts")
            {
                Caption = 'Fees & Comissions Accounts';
                field("Interest Expense Account"; Rec."Interest Expense Account")
                {
                }
                field("Interest Payable Account"; Rec."Interest Payable Account")
                {
                }
                field("Interest Forfeited Account"; Rec."Interest Forfeited Account")
                {
                }
                field("Interest Tax Account"; Rec."Interest Tax Account")
                {
                }
                field("Account Openning Fee Account"; Rec."Account Openning Fee Account")
                {
                }
                field("Re-activation Fee Account"; Rec."Re-activation Fee Account")
                {
                }
                field("Fee bellow Min. Bal. Account"; Rec."Fee bellow Min. Bal. Account")
                {
                }
                field("EFT Charges Account"; Rec."EFT Charges Account")
                {
                }
                field("RTGS Charges Account"; Rec."RTGS Charges Account")
                {
                }
                field("Savings Penalty Account"; Rec."Savings Penalty Account")
                {
                }
                field("Term Termination Account"; Rec."Term Termination Account")
                {
                }
                field("Piggy Bank Fee Account"; Rec."Piggy Bank Fee Account")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        InterestVisible := false;

        if Rec."Earns Interest" = true then
            InterestVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        InterestVisible := false;

        if Rec."Earns Interest" = true then
            InterestVisible := true;
    end;

    var
        InterestVisible: Boolean;
}






