//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50139 "Loan Products Setup Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; rec.Code)
                {
                    Editable = loanSetupEditor;
                }
                field("Mobile Application Source"; Rec."Mobile Application Source")
                {
                    Editable = loanSetupEditor;

                }

                field("WalkIn Application Source"; Rec."WalkIn Application Source")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Portal Application Source"; Rec."Portal Application Source")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Product Description"; Rec."Product Description")
                {
                    Editable = loanSetupEditor;
                }
                field(InActive; Rec.InActive)
                {

                    Editable = loanSetupEditor;
                }
                field("Ignore ShareCapital"; Rec."Ignore ShareCapital")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("% Share Capitalization"; Rec."% Share Capitalization")
                {
                    Editable = loanSetupEditor;
                    Caption = '% Savings Boosting';
                    Visible = false;
                }
                field("Share Capitalization"; Rec."Share Capitalization")
                {
                    Editable = loanSetupEditor;
                    Caption = 'Savings Boosting';
                    Visible = false;
                }
                field("Source."; Rec."Source.")
                {
                    Editable = loanSetupEditor;
                }
                field("Minimum Interest Rate"; Rec."Minimum Interest Rate")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }

                field("Maximum Interest Rate"; Rec."Maximum Interest Rate")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    Caption = 'Default Interest Rate';
                    Editable = loanSetupEditor;
                }
                field("Staff Interest rate"; Rec."Staff Interest rate")
                {
                    Caption = 'Staff Interest Rate';
                    Editable = loanSetupEditor;
                }
                field("Exempt Interest"; Rec."Exempt Interest")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    Editable = loanSetupEditor;
                }
                field("Grace Period - Principle (M)"; Rec."Grace Period - Principle (M)")
                {
                    Editable = loanSetupEditor;
                }
                field("Grace Period - Interest (M)"; Rec."Grace Period - Interest (M)")
                {
                    Editable = loanSetupEditor;
                }
                field("Instalment Period"; Rec."Instalment Period")
                {
                    Editable = loanSetupEditor;
                }
                field("No of Installment"; Rec."No of Installment")
                {
                    Editable = loanSetupEditor;
                }

                field("Default Installements"; Rec."Default Installements")
                {
                    Editable = loanSetupEditor;
                }
                field("Penalty Calculation Days"; Rec."Penalty Calculation Days")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Penalty Percentage"; Rec."Penalty Percentage")
                {
                    Editable = loanSetupEditor;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Self guaranteed Multiplier"; Rec."Self guaranteed Multiplier")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Guarantorship Multiplier"; Rec."Guarantorship Multiplier")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Min Re-application Period"; Rec."Min Re-application Period")
                {
                    Editable = loanSetupEditor;
                }
                field("Deposits Multiplier"; Rec."Deposits Multiplier")
                {
                    Caption = 'Deposits Multiplier';
                    Editable = loanSetupEditor;
                }
                field("Deposit Multiplier 1st Loan"; Rec."Deposit Multiplier 1st Loan")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Min No. Of Guarantors"; Rec."Min No. Of Guarantors")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Max No. Of Guarantor"; Rec."Max No. Of Guarantor")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Loan Appraisal %"; Rec."Loan Appraisal %")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Maximum No of Active Loans"; Rec."Maximum No of Active Loans")
                {
                    ToolTip = 'Specify the Maximum No of Active Loans a Member can have on this Product';
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Min. Loan Amount"; Rec."Min. Loan Amount")
                {
                    Editable = loanSetupEditor;
                }
                field("Max. Loan Amount"; Rec."Max. Loan Amount")
                {
                    Editable = loanSetupEditor;
                }
                field("Loan Increment"; Rec."Loan Increment")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }

                field("Loan Product Expiry Date"; Rec."Loan Product Expiry Date")
                {
                    Editable = loanSetupEditor;
                }
                field("Check Off Recovery"; Rec."Check Off Recovery")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Allowable Loan Offset(%)"; Rec."Allowable Loan Offset(%)")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("TOPUp Qualification %"; Rec."TOPUp Qualification %")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("TOPUp 1 Qualification %"; Rec."TOPUp 1 Qualification %")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Top Up Commision"; Rec."Top Up Commision")
                {
                    Caption = 'Top Up Interest';
                    Visible = true;
                    Editable = loanSetupEditor;
                }
                field("Member Category"; Rec."Member Category")
                {
                    Editable = loanSetupEditor;
                    Caption = 'Product Consumer';
                    Visible = false;
                }
                field("Refinancing %Charge for 1YR"; Rec."Refinancing %Charge for 1YR")
                {
                    Visible = false;
                    Editable = loanSetupEditor;

                }
                field("Refinancing %Charge > 1YR"; Rec."Refinancing %Charge > 1YR")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Loan Boosting Commission %"; Rec."Loan Boosting Commission %")
                {
                    Caption = 'Refinancing Charge %';
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Interest On Topup"; Rec."Interest On Topup")
                {
                    // Visible = false;
                    Editable = loanSetupEditor;
                }

                field("Topup1_Super Plus offset Comm%"; Rec."Topup1_Super Plus offset Comm%")
                {
                    Visible = false;
                }
                field("Loan PayOff Fee(%)"; Rec."Loan PayOff Fee(%)")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    Editable = loanSetupEditor;
                }
                field("Dont Recover Repayment"; Rec."Dont Recover Repayment")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Special Code"; Rec."Special Code")
                {
                    Editable = loanSetupEditor;
                }
                field("Is Staff Loan"; Rec."Is Staff Loan")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field(Deductible; rec.Deductible)
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Qualification for Saver(%)"; Rec."Qualification for Saver(%)")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Amortization Interest Rate(SI)"; Rec."Amortization Interest Rate(SI)")
                {
                    Caption = 'Amortization Interest Rate(Sacco Interest)';
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Accrue Total Insurance&Interes"; Rec."Accrue Total Insurance&Interes")
                {
                    Caption = 'Accrue Total Insurance & Interest on Disburesment';
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Minimum Deposit For Loan Appl"; Rec."Minimum Deposit For Loan Appl")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("FOSA Loan Shares Ratio"; Rec."FOSA Loan Shares Ratio")
                {
                    Caption = 'FOSA Loan Shares Ratio';
                    ToolTip = 'Specify the % of Deposits to Qualify For';
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("OneOff  Loan Repayment"; Rec."OneOff  Loan Repayment")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Charge Interest Upfront"; Rec."Charge Interest Upfront")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Recover Upfront Interest"; Rec."Recover Upfront Interest")
                {
                    Editable = loanSetupEditor;
                    visible = false;
                }
                field("Use Scale"; Rec."Use Scale")
                {
                    Editable = loanSetupEditor;

                }
                field("Non Recurring Interest"; Rec."Non Recurring Interest")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Requires Guarantors"; Rec."Requires Guarantors")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Income Payment Code"; Rec."Income Payment Code")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
            }

            group("Qualification Criteria")
            {
                Caption = 'Qualification Criteria';
                Visible = false;
                field("Appraise Deposits"; Rec."Appraise Deposits")
                {
                    Caption = 'Deposits';
                    Editable = loanSetupEditor;
                }
                field("Appraise Shares"; Rec."Appraise Shares")
                {
                    Caption = 'Shares';
                    Editable = loanSetupEditor;
                }
                field("Appraise Salary"; Rec."Appraise Salary")
                {
                    Caption = 'Salary';
                    Editable = loanSetupEditor;
                }
                field("Appraise Bank Statement"; Rec."Appraise Bank Statement")
                {
                    Editable = loanSetupEditor;
                }
                field("Appraise Guarantors"; Rec."Appraise Guarantors")
                {
                    Editable = loanSetupEditor;
                }
                field("Appraise Business"; Rec."Appraise Business")
                {
                    Editable = loanSetupEditor;
                }
                field("Appraise Dividend"; Rec."Appraise Dividend")
                {
                    Editable = loanSetupEditor;
                }
            }
            part(Control4; "Graduated Product Interest")
            {
                Caption = 'Graduated Product Interest';
                SubPageLink = "Product Code" = field(Code);
            }
            group("Fees & Comissions Accounts")
            {
                Caption = 'Fees & Comissions Accounts';
                field("Penalty Paid Account"; Rec."Penalty Paid Account")
                {
                    Editable = loanSetupEditor;
                }

                field("Penalty Charged Account"; Rec."Penalty Charged Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Loan Account"; Rec."Loan Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Loan Interest Account"; Rec."Loan Interest Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Receivable Interest Account"; Rec."Receivable Interest Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Top Up Commision Account"; Rec."Top Up Commision Account")
                {
                    Editable = loanSetupEditor;

                }
                field("Interest In Arrears Account"; Rec."Interest In Arrears Account")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Loan PayOff Fee Account"; Rec."Loan PayOff Fee Account")
                {
                    Editable = loanSetupEditor;
                    Visible = false;
                }
                field("Receivable Insurance Accounts"; Rec."Receivable Insurance Accounts")
                {
                    Editable = loanSetupEditor;
                }
                field("Loan Insurance Accounts"; Rec."Loan Insurance Accounts")
                {
                    Editable = loanSetupEditor;
                }
                field("Appraisal Fee Charged Account"; Rec."Appraisal Fee Charged Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Appraisal Fee Paid Account"; Rec."Appraisal Fee Paid Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Legal Fee Charged Account"; Rec."Legal Fee Charged Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Legal Fee Paid Account"; Rec."Legal Fee Paid Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Valuation Fee Charged Account"; Rec."Valuation Fee Charged Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Valuation Fee Paid Account"; Rec."Valuation Fee Paid Account")
                {
                    Editable = loanSetupEditor;
                }
                field("CRB Fee Charged Account"; Rec."CRB Fee Charged Account")
                {
                    Editable = loanSetupEditor;
                }
                field("CRB Fee Paid Account"; Rec."CRB Fee Paid Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Loan Interest Restructure A/C"; Rec."Loan Interest Restructure A/C")
                {
                    Editable = loanSetupEditor;
                }
                field("Loan Insurance Restructure A/C"; Rec."Loan Insurance Restructure A/C")
                {
                    Editable = loanSetupEditor;
                }
                field("Loan Penalty Restructure A/C"; Rec."Loan Penalty Restructure A/C")
                {
                    Editable = loanSetupEditor;
                }
            }
            group("Mobile Parameters")
            {
                field("Paybill Code"; Rec."Paybill Code")
                {
                    Editable = loanSetupEditor;
                }
                field("Is Mobile Loan?"; Rec."Is Mobile Loan?")
                {
                    Editable = loanSetupEditor;
                }
                field("Maximimum Amount Salaried"; Rec."Maximimum Amount Salaried")
                {
                    Editable = loanSetupEditor;
                }
                field("Maximimum Amount Non-Salaried"; Rec."Maximimum Amount Non-Salaried")
                {
                    Editable = loanSetupEditor;
                }
                field("Requires Guarantors Mobile"; Rec."Requires Guarantors Mobile")
                {
                    Editable = loanSetupEditor;
                }

            }
            group("Loan Numbering")

            {
                Caption = 'Loan Numbering';
                Visible = false;
                field("Loan No(HQ)"; Rec."Loan No(HQ)")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Loan No(NAIV)"; Rec."Loan No(NAIV)")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Loan No(ELD)"; Rec."Loan No(ELD)")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Loan No(MSA)"; Rec."Loan No(MSA)")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
                field("Loan No(NKR)"; Rec."Loan No(NKR)")
                {
                    Visible = false;
                    Editable = loanSetupEditor;
                }
            }
            group("Account Reference")
            {
                Visible = false;
                field("Requires Main FOSA Accounts"; Rec."Requires Main FOSA Accounts")
                {
                    Editable = loanSetupEditor;
                }
                field("Share Capital Account"; Rec."Share Capital Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'Share Capital';
                }
                field("BOSA Deposits Account"; Rec."BOSA Deposits Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'BOSA Deposits';
                }
                field("Ordinary Savings Account"; Rec."Ordinary Savings Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'Ordinary Savings';
                }
                field("ESS Account"; Rec."ESS Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'ESS';
                }
                field("Chamaa Account"; Rec."Chamaa Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'Chamaa';
                }
                field("Jibambe Account"; Rec."Jibambe Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'Jibambe';
                }
                field("Wezesha Account"; Rec."Wezesha Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'Wezesha';
                }
                field("FD Account"; Rec."FD Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'FD';
                }
                field("MdosiJr Account"; Rec."MdosiJr Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'MdosiJr';
                }
                field("PensionAkiba Account"; Rec."PensionAkiba Account")
                {
                    Editable = loanSetupEditor;
                    Caption = 'PensionAkiba';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Product)
            {
                Caption = 'Product';
                Visible = false;
                action("Product Charges")
                {
                    Caption = 'Product Charges';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = field(Code);
                }
                action("Loan to Share Ratio Analysis")
                {
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product Deposit>Loan Analysis";
                    RunPageLink = "Product Code" = field(Code);
                }
            }
        }
    }

    var
        loanSetupEditor: Boolean;
        user: Record "User Setup";

    trigger
    OnOpenPage()
    begin
        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if user."Loan Product Setup" = true
            then begin
                loanSetupEditor := true;
            end;
        end;
    end;
}






