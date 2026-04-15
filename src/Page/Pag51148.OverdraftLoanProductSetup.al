//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51148 "Overdraft Loan Product Setup"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";
    SourceTableView = where(Code = const('M_OD'));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; rec.Code)
                {
                    Editable = pageEditor;
                }
                field("Mobile Application Source"; Rec."Mobile Application Source")
                {
                    Editable = pageEditor;
                }

                field("WalkIn Application Source"; Rec."WalkIn Application Source")
                {
                    Editable = pageEditor;
                }
                field("Portal Application Source"; Rec."Portal Application Source")
                {
                    Editable = pageEditor;
                }
                field("Product Description"; Rec."Product Description")
                {
                    Editable = pageEditor;
                }
                field(InActive; Rec.InActive) {Visible=false; }
                field("Source."; Rec."Source.")
                {
                    Editable = pageEditor;
                }
                field("Minimum Interest Rate"; Rec."Minimum Interest Rate")
                {
                    Visible=false;
                }
                field("Maximum Interest Rate"; Rec."Maximum Interest Rate")
                {
                    Visible=false;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    Caption = 'Default Interest Rate';
                    Editable = pageEditor;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    Editable = pageEditor;
                }
                field("Grace Period - Principle (M)"; Rec."Grace Period - Principle (M)")
                {
                    Editable = pageEditor;
                }
                field("Grace Period - Interest (M)"; Rec."Grace Period - Interest (M)")
                {
                    Editable = pageEditor;
                }
                field("Instalment Period"; Rec."Instalment Period")
                {
                    Editable = pageEditor;
                }
                field("No of Installment"; Rec."No of Installment")
                {
                    Editable = pageEditor;
                }

                field("Default Installements"; Rec."Default Installements")
                {
                    Editable = pageEditor;
                }
                field("Penalty Calculation Days"; Rec."Penalty Calculation Days")
                {
                    Editable = pageEditor;
                }
                field("Penalty Percentage"; Rec."Penalty Percentage")
                {
                    Editable = pageEditor;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    Editable = pageEditor;
                }
                field("Min No. Of Guarantors"; Rec."Min No. Of Guarantors")
                {
                    Editable = pageEditor;
                }
                field("Max No. Of Guarantor"; Rec."Max No. Of Guarantor")
                {
                    Editable = pageEditor;

                }
                field("Min Re-application Period"; Rec."Min Re-application Period")
                {
                    Editable = pageEditor;
                }
                field("Deposits Multiplier"; Rec."Deposits Multiplier")
                {
                    Caption = 'Deposits Multiplier';
                    Editable = pageEditor;
                }
                field("Deposit Multiplier 1st Loan"; Rec."Deposit Multiplier 1st Loan")
                {
                    Visible=false;
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    Editable = pageEditor;
                }
                field("Self guaranteed Multiplier"; Rec."Self guaranteed Multiplier")
                {
                    Editable = pageEditor;
                }
                field("Guarantorship Multiplier"; Rec."Guarantorship Multiplier")
                {
                    Editable = pageEditor;
                }
                field("Loan Product Expiry Date"; Rec."Loan Product Expiry Date")
                {
                    Editable = pageEditor;
                }
                field("Maximum No of Active Loans"; Rec."Maximum No of Active Loans")
                {
                    ToolTip = 'Specify the Maximum No of Active Loans a Member can have on this Product';
                    Visible=false;
                }
                field("Min. Loan Amount"; Rec."Min. Loan Amount")
                {
                    Editable = pageEditor;
                }
                field("Max. Loan Amount"; Rec."Max. Loan Amount")
                {
                    Editable = pageEditor;
                }

                field("Check Off Recovery"; Rec."Check Off Recovery")
                {
                    Editable = pageEditor;
                }
                field("Allowable Loan Offset(%)"; Rec."Allowable Loan Offset(%)")
                {
                    Visible = false;
                }
                field("TOPUp Qualification %"; Rec."TOPUp Qualification %")
                {
                    Visible=false;
                }
                field("TOPUp 1 Qualification %"; Rec."TOPUp 1 Qualification %")
                {
                    Visible=false;
                }
                field("Top Up Commision"; Rec."Top Up Commision")
                {
                    Caption = 'Top Up Interest';
                    Visible=false;
                }


                field("Refinancing %Charge for 1YR"; Rec."Refinancing %Charge for 1YR") {Visible=false; }
                field("Refinancing %Charge > 1YR"; Rec."Refinancing %Charge > 1YR") { Visible=false;}
                field("Loan Boosting Commission %"; Rec."Loan Boosting Commission %")
                {
                    Caption = 'Refinancing Charge %';
                    Editable = pageEditor;
                }
                field("Interest On Topup"; Rec."Interest On Topup")
                {
                    Visible=false;
                }

                field("Topup1_Super Plus offset Comm%"; Rec."Topup1_Super Plus offset Comm%")
                {
                    Visible=false;
                }
                field("Loan PayOff Fee(%)"; Rec."Loan PayOff Fee(%)")
                {
                    Visible=false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    Editable = pageEditor;
                }
                field("Dont Recover Repayment"; Rec."Dont Recover Repayment")
                {
                    Editable = pageEditor;
                }
                field("Special Code"; Rec."Special Code")
                {
                    Editable = pageEditor;
                }
                field("Is Staff Loan"; Rec."Is Staff Loan")
                {
                    Editable = pageEditor;
                }

                field("Recovery Mode";Rec."Recovery Mode")
                {
                    Editable = pageEditor;
                }
                field(Deductible; rec.Deductible)
                {
                    Editable = pageEditor;
                }
                field("Qualification for Saver(%)"; Rec."Qualification for Saver(%)")
                {
                    Editable = pageEditor;
                }
                field("Amortization Interest Rate(SI)"; Rec."Amortization Interest Rate(SI)")
                {
                    Caption = 'Amortization Interest Rate(Sacco Interest)';
                    Editable = pageEditor;
                }
                field("Accrue Total Insurance&Interes"; Rec."Accrue Total Insurance&Interes")
                {
                    Caption = 'Accrue Total Insurance & Interest on Disburesment';
                    Editable = pageEditor;
                }
                field("Minimum Deposit For Loan Appl"; Rec."Minimum Deposit For Loan Appl")
                {
                    Editable = pageEditor;
                }
                field("FOSA Loan Shares Ratio"; Rec."FOSA Loan Shares Ratio")
                {
                    Caption = 'FOSA Loan Shares Ratio';
                    ToolTip = 'Specify the % of Deposits to Qualify For';
                    Editable = pageEditor;
                }

                field("OneOff  Loan Repayment"; Rec."OneOff  Loan Repayment")
                {
                    Editable = pageEditor;
                }
                field("Charge Interest Upfront"; Rec."Charge Interest Upfront")
                {
                    Editable = pageEditor;
                }

                field("Non Recurring Interest"; Rec."Non Recurring Interest")
                {
                    Editable = pageEditor;
                }
            }
            group("Qualification Criteria")
            {
                Caption = 'Qualification Criteria';
                field("Appraise Deposits"; Rec."Appraise Deposits")
                {
                    Caption = 'Deposits';
                    Editable = pageEditor;
                }
                field("Appraise Shares"; Rec."Appraise Shares")
                {
                    Caption = 'Shares';
                    Editable = pageEditor;
                }
                field("Appraise Salary"; Rec."Appraise Salary")
                {
                    Caption = 'Salary';
                    Editable = pageEditor;
                }
                field("Appraise Bank Statement"; Rec."Appraise Bank Statement")
                {
                    Editable = pageEditor;
                }
                field("Appraise Guarantors"; Rec."Appraise Guarantors")
                {
                    Editable = pageEditor;
                }
                field("Appraise Business"; Rec."Appraise Business")
                {
                    Editable = pageEditor;
                }
                field("Appraise Dividend"; Rec."Appraise Dividend")
                {
                    Editable = pageEditor;
                }
            }
            group("Fees & Comissions Accounts")
            {
                Caption = 'Fees & Comissions Accounts';
                field("Penalty Paid Account"; Rec."Penalty Paid Account")
                {
                    Editable = pageEditor;
                }

                field("Penalty Charged Account"; Rec."Penalty Charged Account")
                {
                    Editable = pageEditor;
                }
                field("Loan Account"; Rec."Loan Account")
                {
                    Editable = pageEditor;
                }
                field("Loan Interest Account"; Rec."Loan Interest Account")
                {
                    Editable = pageEditor;
                }
                field("Receivable Interest Account"; Rec."Receivable Interest Account")
                {
                    Editable = pageEditor;
                }
                field("Top Up Commision Account"; Rec."Top Up Commision Account")
                {
                    Editable = pageEditor;

                }
                field("Interest In Arrears Account"; Rec."Interest In Arrears Account")
                {
                    Editable = pageEditor;
                }
                field("Loan PayOff Fee Account"; Rec."Loan PayOff Fee Account")
                {
                    Editable = pageEditor;
                }
                field("Receivable Insurance Accounts"; Rec."Receivable Insurance Accounts")
                {
                    Editable = pageEditor;
                }
                field("Loan Insurance Accounts"; Rec."Loan Insurance Accounts")
                {
                    Editable = pageEditor;
                }
                field("Loan Interest Restructure A/C"; Rec."Loan Interest Restructure A/C")
                {
                    Editable = pageEditor;
                }
                field("Loan Insurance Restructure A/C"; Rec."Loan Insurance Restructure A/C")
                {
                    Editable = pageEditor;
                }
                field("Loan Penalty Restructure A/C"; Rec."Loan Penalty Restructure A/C")
                {
                    Editable = pageEditor;
                }
            }
            group("Mobile Parameters")
            {
                field("Paybill Code"; Rec."Paybill Code")
                {
                    Editable = pageEditor;
                }
                field("Loan Appraisal %"; Rec."Loan Appraisal %")
                {
                    Editable = pageEditor;
                }
                field("Is Mobile Loan?"; Rec."Is Mobile Loan?")
                {
                    Editable = pageEditor;
                }
                field("Maximimum Amount Salaried"; Rec."Maximimum Amount Salaried")
                {
                    Editable = pageEditor;
                }
                field("Maximimum Amount Non-Salaried"; Rec."Maximimum Amount Non-Salaried")
                {
                    Editable = pageEditor;
                }

            }
            group("Loan Numbering")
   
            {
                Caption = 'Loan Numbering';
                field("Loan No(HQ)"; Rec."Loan No(HQ)")
                {
                    Visible=false;
                }
                field("Loan No(NAIV)"; Rec."Loan No(NAIV)")
                {
                    Visible=false;
                }
                field("Loan No(ELD)"; Rec."Loan No(ELD)")
                {
                    Visible=false;
                }
                field("Loan No(MSA)"; Rec."Loan No(MSA)")
                {
                    Visible=false;
                }
                field("Loan No(NKR)"; Rec."Loan No(NKR)")
                {
                    Visible=false;
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
                action("Product Charges")
                {
                    Caption = 'Product Charges';
                    Image = Setup;
                    Enabled = pageEditor;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = field(Code);
                }
                action("Loan to Share Ratio Analysis")
                {
                    Image = Setup;
                    Enabled = pageEditor;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product Deposit>Loan Analysis";
                    RunPageLink = "Product Code" = field(Code);
                }
            }
        }
    }
    

    var
    pageEditor: Boolean;
    user: Record "User Setup";

    trigger
    OnOpenPage()
    begin
        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if user.Overdraft = true
            then begin
                pageEditor := true;
            end;
        end;
    end;
}
