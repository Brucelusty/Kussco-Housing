//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50137 "Sacco General Set-Up"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Sacco General Set-Up";
    UsageCategory = Administration;
    //   Editable = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Setup';
                //Editable = loanSetupEditor;

                field("The Key"; Rec."The Key")
                {
                    Visible = false;
                }
                field("Junior Acc Registration Fee"; Rec."Junior Acc Registration Fee")
                {
                    Caption = 'Junior Account Registration Fee';
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    Caption = 'Individual Account Registration Fee';
                }
                field("Cooperate Acc Registration Fee"; Rec."Cooperate Acc Registration Fee")
                {
                    Caption = 'Corporate Account Registration Fee';
                }
                field("Retained Shares"; Rec."Retained Shares")
                {
                    Caption = 'Min. Share Capital Amount';
                }
                field("Min Cooperate Share Capital"; Rec."Min Cooperate Share Capital")
                {
                    Caption = 'Min. Corporate Share Capital Amount';
                }
                field("Min. Contribution"; Rec."Min. Contribution")
                {
                    Caption = 'Individual Minimum Monthly Contributions';
                }
                field("Corporate Minimum Monthly Cont"; Rec."Corporate Minimum Monthly Cont")
                {
                    Caption = 'Corporate Minimum Monthly Contributions';
                }

                field("Min. Member Age"; Rec."Min. Member Age")
                {
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                }
                field("UFAA Duration"; Rec."UFAA Duration")
                {
                }
                field("Benevolent Fund Contribution"; Rec."Benevolent Fund Contribution")
                {
                    Caption = 'Benevolent Fund Contibution';
                    Visible = false;
                }


                field("FOSA Shares Amount"; Rec."FOSA Shares Amount")
                {
                    Visible = false;
                }
                field("Min Deposit Cont.(% of Basic)"; Rec."Min Deposit Cont.(% of Basic)")
                {
                    Visible = false;
                }
                field("Minimum Take home"; Rec."Minimum Take home")
                {
                    Visible = false;
                }
                field("Minimum take home FOSA"; Rec."Minimum take home FOSA")
                {
                }
                field("Max. Non Contribution Periods"; Rec."Max. Non Contribution Periods")
                {
                    Visible = false;
                }
                field("Dormancy Period"; Rec."Dormancy Period")
                {
                    Visible = false;
                }
                field("Min. Loan Application Period"; Rec."Min. Loan Application Period")
                {
                }
                field("Bank Statement Period"; Rec."Bank Statement Period")
                {
                    Caption = 'Loan Appraisal Statement Period';
                    Visible = false;
                }
                field("Maximum No of Guarantees"; Rec."Maximum No of Guarantees")
                {
                    Visible = false;
                }
                field("Min. Guarantors"; Rec."Min. Guarantors")
                {
                    Visible = false;
                }
                field("Max. Guarantors"; Rec."Max. Guarantors")
                {
                    Visible = false;
                }
                field("Member Can Guarantee Own Loan"; Rec."Member Can Guarantee Own Loan")
                {
                    Visible = false;
                }
                field("Self Guarantee Multiplier"; Rec."Self Guarantee Multiplier")
                {
                    Visible = false;
                }
                field("Dividend (%)"; Rec."Dividend (%)")
                {
                }
                field("Ess Interest%"; Rec."Ess Interest%")
                {
                    Visible = false;
                }
                field("Interest on Deposits (%)"; Rec."Interest on Deposits (%)")
                {
                }
                field("Withholding Tax on Dividends"; Rec."Withholding Tax on Dividends")
                {
                }
                field("Withholding Tax on Deposits"; Rec."Withholding Tax on Deposits")
                {
                }
                field("Guarantors Multiplier"; Rec."Guarantors Multiplier")
                {
                    Visible = false;
                }

                field("SMS Sender ID"; Rec."SMS Sender ID")
                {
                }
                field("MSG Product ID"; Rec."MSG Product ID")
                {
                }
                field("Min. Dividend Proc. Period"; Rec."Min. Dividend Proc. Period")
                {
                    Visible = false;
                }
                field("Div Capitalization Min_Indiv"; Rec."Div Capitalization Min_Indiv")
                {
                    Visible = false;
                    Caption = 'Dividend Capitalization Minimum Deposit_Individula';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization Min_Corp"; Rec."Div Capitalization Min_Corp")
                {
                    Visible = false;
                    Caption = 'Dividend Capitalization Minimum Deposit_Corporate Account';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization %"; Rec."Div Capitalization %")
                {
                    Caption = 'Dividend Capitalization %';
                }
                field("Days for Checkoff"; Rec."Days for Checkoff")
                {
                    Visible = false;
                }
                field("Salary Processing Fee"; Rec."Salary Processing Fee")
                {
                    Visible = false;
                }

                field("Salary Processing Fee Acc"; Rec."Salary Processing Fee Acc")
                {
                    Visible = false;
                }
                field("Boosting Shares Maturity (M)"; Rec."Boosting Shares Maturity (M)")
                {
                    Visible = false;
                }
                field("Contactual Shares (%)"; Rec."Contactual Shares (%)")
                {
                    Visible = false;
                }
                field("Express Charge %"; Rec."Express Charge %")
                {
                    Visible = false;
                }
                field("Use Bands"; Rec."Use Bands")
                {
                    Visible = false;
                }
                field("Max. Contactual Shares"; Rec."Max. Contactual Shares")
                {
                    Visible = false;
                }

                field("Welfare Contribution"; Rec."Welfare Contribution")
                {
                    Caption = 'Insurance Contribution';
                    Visible = false;
                }
                field("ATM Expiry Duration"; Rec."ATM Expiry Duration")
                {
                    Visible = false;
                }
                field("Monthly Share Contributions"; Rec."Monthly Share Contributions")
                {
                    Visible = false;
                }
                field("Risk Fund Amount"; Rec."Risk Fund Amount")
                {
                    Visible = false;
                }
                field("Deceased Cust Dep Multiplier"; Rec."Deceased Cust Dep Multiplier")
                {
                    Caption = 'Deposit Refund Multiplier-Death';
                    Visible = false;
                }
                field("Begin Of Month"; Rec."Begin Of Month")
                {
                }
                field("End Of Month"; Rec."End Of Month")
                {
                }
                field("E-Loan Qualification (%)"; Rec."E-Loan Qualification (%)")
                {
                    Visible = false;
                }
                field("Charge FOSA Registration Fee"; Rec."Charge FOSA Registration Fee")
                {
                    Visible = false;
                }
                field("Charge BOSA Registration Fee"; Rec."Charge BOSA Registration Fee")
                {
                    Visible = false;
                }
                field("Defaulter LN"; Rec."Defaulter LN")
                {
                    Visible = false;
                }
                field("Last Transaction Duration"; Rec."Last Transaction Duration")
                {
                    Visible = false;
                }
                field("Branch Code No"; Rec."Branch Code No")
                {
                    Visible = false;
                }
                field("Allowable Cheque Discounting %"; Rec."Allowable Cheque Discounting %")
                {
                    Visible = false;
                }
                field("Sto max tolerance Days"; Rec."Sto max tolerance Days")
                {
                    Visible = false;
                    Caption = 'Standing Order Maximum Tolerance Days';
                    ToolTip = 'Specify the Maximum No of  Days the Standing order should keep trying if the Member account has inserficient amount';
                }
                field("Dont Allow Sto Partial Ded."; Rec."Dont Allow Sto Partial Ded.")
                {
                    Caption = 'Dont Allow Sto Partial Deduction';
                    Visible = false;
                }
                field("Standing Order Bank"; Rec."Standing Order Bank")
                {
                    Visible = false;
                    ToolTip = 'Specify the Cash book account to be credit when a member places an External standing order';
                }
                field("ATM Destruction Period"; Rec."ATM Destruction Period")
                {
                    Visible= false;
                }
                field("Go Live Date"; Rec."Go Live Date")
                {
                    Visible = false;
                }
                field("Cheque Book Request Path"; Rec."Cheque Book Request Path")
                {
                    Visible = false;
                }
                field("ATM Card Request Path"; Rec."ATM Card Request Path")
                {
                    Visible = false;
                }
                field("Collateral Collection Period"; Rec."Collateral Collection Period")
                {
                    Visible = false;
                }
                field("Loan Amount Due Freeze Period"; Rec."Loan Amount Due Freeze Period")
                {
                    Visible = false;
                }
                field(OnlineMemberMonthlyTransLimit; rec.OnlineMemberMonthlyTransLimit)
                {
                    Visible = false;
                    Caption = 'Online Member Monthly Transaction Limit';
                }
                field("Referee Comm. Period"; Rec."Referee Comm. Period")
                {
                    //Visible = false;
                }
                field("Recruitment Commission"; Rec."Recruitment Commission")
                {
                }
                field("Recruitment Comm. Expense GL"; Rec."Recruitment Comm. Expense GL")
                {
                }
                field("Last Date of Checkoff Advice"; Rec."Last Date of Checkoff Advice")
                {
                    Visible = false;
                }
                field("Closure Notice Period"; Rec."Closure Notice Period")
                {
                }
                field("Co-Op PaytoFOSA"; Rec."Co-Op PaytoFOSA")
                {
                    Visible = false;
                }
                field("Min. Piggy Bank Bal"; Rec."Min. Piggy Bank Bal")
                {
                    Visible = false;
                    ToolTip = 'Minimum Mdosi Jr Balance to qualify for a piggy bank.';
                }
                field("ESS Refund Notice Maturity"; Rec."ESS Refund Notice Maturity")
                {
                    Visible = false;
                }
                field("ESS Refund Notice-Early"; Rec."ESS Refund Notice-Early")
                {
                    Visible = false;
                    Caption = 'Early ESS Refund';
                }
                field("Min Call Days to Earn Interest"; Rec."Min Call Days to Earn Interest")
                {
                    Visible = false;
                }
                field("Min FD to Earn Interest"; Rec."Min FD to Earn Interest")
                {
                    Visible = false;
                }
                field("Int Calc Intervals"; Rec."Int Calc Intervals")
                {
                    Visible = false;
                }
                field("Reg Fee Paybill Code"; Rec."Reg Fee Paybill Code")
                {
                    Visible = false;
                }
                field("KTDA Bank Code"; Rec."KTDA Bank Code")
                {
                    Visible = false;
                }
                field("Bulk Payment Paybill Code"; Rec."Bulk Payment Paybill Code")
                {
                    Visible = false;
                }
            }
            group("Membership Class Tiers")
            {
                Visible = false;
                caption = 'Membership Class Tiers';
                Editable = loanSetupEditor;
                field("Membership Class Tier"; Rec."Membership Class Tier")
                {
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        ClassAVisible := false;
                        ClassBVisible := false;
                        ClassCVisible := false;
                        ClassDVisible := false;
                        ClassFAVisible := false;
                        ClassFBVisible := false;
                        ClassFCVisible := false;

                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class A" then begin
                            ClassAVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class B" then begin
                            ClassBVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class C" then begin
                            ClassCVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class D" then begin
                            ClassDVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FA" then begin
                            ClassFAVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FB" then begin
                            ClassFBVisible := true;
                        end;
                        if Rec."Membership Class Tier" = Rec."Membership Class Tier"::"Class FC" then begin
                            ClassFCVisible := true;
                        end;
                    end;
                }
                group("Class A")
                {
                    caption = 'Class A Tiers Details';
                    visible = ClassAVisible;
                    field("RegistrationFee"; Rec."RegistrationFee")
                    {
                    }

                    field("Min Salary Range"; Rec."Min Salary Range")
                    {
                    }
                    field("Max Salary Range"; Rec."Max Salary Range")
                    {
                    }

                    field(MonthlyContributions; Rec.MonthlyContributions)
                    {
                    }
                    field(ShareCapital; Rec.ShareCapital)
                    {
                    }
                    field(BenevolentFund; Rec.BenevolentFund)
                    {
                    }
                }
                group("Class B")
                {
                    Visible = ClassBVisible;
                    caption = 'Class B Tier Details';

                    field("Class B RegistrationFee"; Rec."Class B RegistrationFee")
                    {
                    }
                    field("Minimum Class B Salary Range"; Rec."Minimum Class B Salary Range")
                    {
                    }
                    field("Maximum Class B Salary Range"; Rec."Maximum Class B Salary Range")
                    {
                    }
                    field("Class B MonthlyContributions"; Rec."Class B MonthlyContributions")
                    {
                    }
                    field("Class B ShareCapital"; Rec."Class B ShareCapital")
                    {
                    }
                    field("Class B BenevolentFund"; Rec."Class B BenevolentFund")
                    {
                    }
                }
                group("Class C")
                {
                    Visible = ClassCVisible;
                    caption = 'Class C Tier Details';

                    field("Class C RegistrationFee"; Rec."Class C RegistrationFee")
                    {
                    }
                    field("Minimum Class C Salary Range"; Rec."Minimum Class C Salary Range")
                    {
                    }
                    field("Maximum Class C Salary Range"; Rec."Maximum Class C Salary Range")
                    {
                    }
                    field("Class C MonthlyContributions"; Rec."Class C MonthlyContributions")
                    {
                    }
                    field("Class C ShareCapital"; Rec."Class C ShareCapital")
                    {
                    }
                    field("Class C BenevolentFund"; Rec."Class C BenevolentFund")
                    {
                    }
                }
                group("Class D")
                {
                    Visible = ClassDVisible;
                    caption = 'Class D Tier Details';

                    field("Class D RegistrationFee"; Rec."Class D RegistrationFee")
                    {
                    }
                    field("Minimum Class D Salary Range"; Rec."Minimum Class D Salary Range")
                    {
                    }
                    field("Maximum Class D Salary Range"; Rec."Maximum Class D Salary Range")
                    {
                    }
                    field("Class D MonthlyContributions"; Rec."Class D MonthlyContributions")
                    {
                    }
                    field("Class D ShareCapital"; Rec."Class D ShareCapital")
                    {
                    }
                    field("Class D BenevolentFund"; Rec."Class D BenevolentFund")
                    {
                    }
                }
                group("Class FA")
                {
                    Visible = ClassFAVisible;
                    caption = 'Class F-A Tier Details';

                    field("Class FA RegistrationFee"; Rec."Class FA RegistrationFee")
                    {
                    }
                    field("Minimum Class FA Salary Range"; Rec."Minimum Class FA Salary Range")
                    {
                    }
                    field("Maximum Class FA Salary Range"; Rec."Maximum Class FA Salary Range")
                    {
                    }
                    field("Class FA MonthlyContributions"; Rec."Class FA MonthlyContributions")
                    {
                    }
                    field("Class FA ShareCapital"; Rec."Class FA ShareCapital")
                    {
                    }
                    field("Class FA BenevolentFund"; Rec."Class FA BenevolentFund")
                    {
                    }
                }
                group("Class FB")
                {
                    Visible = ClassFBVisible;
                    caption = 'Class F-B Tier Details';

                    field("Class FB RegistrationFee"; Rec."Class FB RegistrationFee")
                    {
                    }
                    field("Minimum Class FB Salary Range"; Rec."Minimum Class FB Salary Range")
                    {
                    }
                    field("Maximum Class FB Salary Range"; Rec."Maximum Class FB Salary Range")
                    {
                    }
                    field("Class FB MonthlyContributions"; Rec."Class FB MonthlyContributions")
                    {
                    }
                    field("Class FB ShareCapital"; Rec."Class FB ShareCapital")
                    {
                    }
                    field("Class FB BenevolentFund"; Rec."Class FB BenevolentFund")
                    {
                    }
                }
                group("Class FC")
                {
                    Visible = ClassFCVisible;
                    caption = 'Class F-C Tier Details';

                    field("Class FC RegistrationFee"; Rec."Class FC RegistrationFee")
                    {
                    }
                    field("Minimum Class FC Salary Range"; Rec."Minimum Class FC Salary Range")
                    {
                    }
                    field("Maximum Class FC Salary Range"; Rec."Maximum Class FC Salary Range")
                    {
                    }
                    field("Class FC MonthlyContributions"; Rec."Class FC MonthlyContributions")
                    {
                    }
                    field("Class FC ShareCapital"; Rec."Class FC ShareCapital")
                    {
                    }
                    field("Class FC BenevolentFund"; Rec."Class FC BenevolentFund")
                    {
                    }
                }
            }
            group("Fees & Commissions")
            {
                Caption = 'Fees & Commissions';
                Editable = loanSetupEditor;
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    Visible = false;
                    Caption = 'Account Closure Fee';
                }
                field("ESS Refund-Early Charges"; Rec."ESS Refund-Early Charges")
                {
                    Visible = false;
                }
                field("Special Advance Commission"; Rec."Special Advance Commission")
                {
                    Visible = false;
                }
                field("Withholding Tax (%)"; Rec."Withholding Tax (%)") { }
                field("External Loan Comm (%)"; Rec."External Loan Comm (%)") { Visible = false; }
                field("FOSA Registration Fee Amount"; Rec."FOSA Registration Fee Amount")
                {
                    Visible = false;
                }
                field("Balance Enquiry Charge"; Rec."Balance Enquiry Charge")
                {
                    Visible = false;
                }
                field("Balance Enquiry Charge Account"; Rec."Balance Enquiry Charge Account")
                {
                    Visible = false;
                }
                field("Vendor Enquiry Charge"; Rec."Vendor Enquiry Charge")
                {
                    Visible = false;
                }
                field("Ministatement Charge"; Rec."Ministatement Charge")
                {
                    Visible = false;
                }
                field("Vendor MiniStatement Charge"; Rec."Vendor MiniStatement Charge")
                {
                    Visible = false;
                }
                field("Vendor G/L"; Rec."Vendor G/L")
                {
                    Visible = false;
                }
                field("BOSA Registration Fee Amount"; Rec."BOSA Registration Fee Amount")
                {

                    Caption = 'Registration Fee Individual';
                }
                field("BOSA RegistrationFee (%)"; Rec."BOSA RegistrationFee (%)") { Visible = false; }
                field("BOSA Reg. Fee Corporate"; Rec."BOSA Reg. Fee Corporate")
                {
                    Caption = 'Registration Fee Corporate';
                }
                field("Rejoining Fee"; Rec."Rejoining Fee")
                {
                    Caption = 'Reinstatement Fee';
                }
                field("Boosting Shares %"; Rec."Boosting Shares %")
                {
                    Visible = false;
                }
                field("Dividend Processing Fee"; Rec."Dividend Processing Fee")
                {
                }
                field("Top up Commission"; Rec."Top up Commission")
                {
                    Visible = false;
                }
                field("Excise Duty(%)"; Rec."Excise Duty(%)")
                {
                }
                field("SMS Fee Amount"; Rec."SMS Fee Amount")
                {
                }
                field("SMS Fee Account"; Rec."SMS Fee Account")
                {
                }
                field("Risk Beneficiary (%)"; Rec."Risk Beneficiary (%)")
                {
                    Visible = false;
                }
                field("Loan Cash Clearing Fee(%)"; Rec."Loan Cash Clearing Fee(%)")
                {
                    Visible = false;
                }
                field("Mpesa Withdrawal Fee"; Rec."Mpesa Withdrawal Fee")
                {
                    Visible = false;
                }
                field("Share Transfer Fee %"; Rec."Share Transfer Fee %")
                {
                }
                field("Cheque Discounting Comission"; Rec."Cheque Discounting Comission")
                {
                    Visible = false;
                }
                field("Funeral Expense Amount"; Rec."Funeral Expense Amount")
                {
                    Visible = false;
                }
                field("Share Capital Transfer Fee"; Rec."Share Capital Transfer Fee")
                {

                }
                field("Partial Deposit Refund Fee"; Rec."Partial Deposit Refund Fee")
                {
                    Visible = false;
                }
                field("Penalty On Deposit Arrears"; Rec."Penalty On Deposit Arrears")
                {
                    Visible = false;
                    Caption = 'Penalty on Failed Monthly Contribution';
                    ToolTip = 'Specify the Penalty Amount to Charge a Member who has not meet the minimum Monthly contribution';
                }
                field("ATM Card Fee-New Coop"; Rec."ATM Card Fee-New Coop")
                {
                    Visible = false;
                }
                field("ATM Card Fee-New Sacco"; Rec."ATM Card Fee-New Sacco")
                {
                    Visible = false;
                }
                field("ATM Card Fee-Replacement Coop"; Rec."ATM Card Fee-Replacement Coop")
                {
                    Visible = false;
                }
                field("ATM Card Fee-Replacement SACCO"; Rec."ATM Card Fee-Replacement SACCO")
                {
                    Visible = false;
                }
                field("ATM Card Renewal Fee Coop"; Rec."ATM Card Renewal Fee Coop")
                {
                    Visible = false;
                }
                field("ATM Card Renewal Fee Sacco"; Rec."ATM Card Renewal Fee Sacco")
                {
                    Visible = false;
                }
                field("CRB Check Charge"; Rec."CRB Check Charge")
                {

                }
                field("CRB Check Vendor Charge"; Rec."CRB Check Vendor Charge")
                {
                }
                field("Internal Transfer Fee"; Rec."Internal Transfer Fee")
                {
                    Visible = false;
                }
                field("FB ATM Withdrawal Limit"; Rec."FB ATM Withdrawal Limit")
                {
                    Visible = false;
                    Caption = 'Family Bank ATM Withdrawal Limit';
                }

                field("Loan Shares Deduction Amount"; Rec."Loan Shares Deduction Amount")
                {
                    Visible = false;
                }
            }
            group("Fees & Commissions Accounts")
            {
                Caption = 'Fees & Commissions Accounts';
                Editable = loanSetupEditor;
                field("FD Interest A/C"; Rec."FD Interest A/C")
                {
                    //Visible = false;
                    Caption='Debenture Interest Account';
                }
                field("Interest on FOSA A/C"; Rec."Interest on FOSA A/C")
                {
                    Visible = false;
                }
                field("External Loan Account"; Rec."External Loan Account") { Visible = false; }
                field("Withdrawal Before Maturity Charges"; Rec."Withdrawal Before Maturity Charges") { Visible = false; }
                field("WithHolding Tax Account"; Rec."WithHolding Tax Account") { }
                field("Interest Expense on Fixed Deposit"; Rec."Interest Expense on Fixed Deposit") { Visible = false; }

                field("Withdrawal Before Maturity Charges Account"; Rec."Withdrawal Before Maturity Charges Account") { Visible = false; }

                field("Suspense Account"; Rec."Suspense Account") { }

                field("Delayed Net Account"; Rec."Delayed Net Account") { Visible = false; }

                field("Penalties on Loans"; Rec."Penalties on Loans") { Visible = false; }
                field("Withdrawal Fee Account"; Rec."Withdrawal Fee Account")
                {
                }
                field("FOSA Registration Fee Account"; Rec."FOSA Registration Fee Account")
                {
                    Visible = false;
                }
                field("BOSA Registration Fee Account"; Rec."BOSA Registration Fee Account")
                {
                    Caption='Registration Fee Account ';
                }

                field("Rejoining Fees Account"; Rec."Rejoining Fees Account")
                {
                }
                field("Insurance Retension Account"; Rec."Insurance Retension Account")
                {
                    Visible = false;
                }

                field("Withholding Tax Acc Dividend"; Rec."Withholding Tax Acc Dividend")
                {
                    Visible = false;
                }
                field("Shares Retension Account"; Rec."Shares Retension Account")
                {
                    Visible = false;
                }
                field("Loan Transfer Fees Account"; Rec."Loan Transfer Fees Account")
                {
                    Visible = false;
                }
                field("Express Charge Account"; Rec."Express Charge Account")
                {
                    Visible = false;
                }
                field("Boosting Fees Account"; Rec."Boosting Fees Account")
                {
                    Visible = false;
                }
                field("Bridging Commision Account"; Rec."Bridging Commision Account")
                {
                    Visible = false;
                }
                field("Funeral Expenses Account"; Rec."Funeral Expenses Account")
                {
                    Visible = false;
                }
                field("Dividend Payable Account"; Rec."Dividend Payable Account")
                {
                }
                field("Dividend Process Fee Account"; Rec."Dividend Process Fee Account")
                {
                    Caption = 'Dividend Processing Fee Account';
                }
                field("Excise Duty Account"; Rec."Excise Duty Account")
                {
                }

                field("Cheque Discounting Fee Account"; Rec."Cheque Discounting Fee Account")
                {
                    Visible = false;
                }
                field("Deposit Refund On DeathAccount"; Rec."Deposit Refund On DeathAccount")
                {
                    Visible = false;
                }
                field("Loan Attachment Comm. Account"; Rec."Loan Attachment Comm. Account")
                {
                    Visible = false;
                }
                field("Share Capital Transfer Fee Acc"; Rec."Share Capital Transfer Fee Acc")
                {
                    Visible = false;
                }
                field("Partial Deposit Refund Fee A/C"; Rec."Partial Deposit Refund Fee A/C")
                {
                    Visible = false;
                }
                field("Penalty On Deposit Arrears A/C"; Rec."Penalty On Deposit Arrears A/C")
                {
                    Visible = false;
                    Caption = 'Penalty On Failed Monthly Contr. Account';
                }
                field("CRB Vendor Account"; Rec."CRB Vendor Account")
                {
                    Visible = false;
                }
                field("CRB Check SACCO income A/C"; Rec."CRB Check SACCO income A/C")
                {
                    Visible = false;
                }
                field("Benevolent Fund Account"; Rec."Benevolent Fund Account")
                {
                }
                field("ATM Card Co-op Bank Account"; Rec."ATM Card Co-op Bank Account")
                {
                    Visible = false;
                }
                field("ATM Card Income Account"; Rec."ATM Card Income Account")
                {
                    Visible = false;
                }
                field("Cheque Processing Fee Account"; Rec."Cheque Processing Fee Account")
                {
                    Visible = false;
                }
                field("Cheque Clearing Family Income"; Rec."Cheque Clearing Family Income")
                {
                    Visible = false;
                    Caption = 'Cheque Clearing Family Income Control';
                }
                field("Unpaid Cheques Fee Account"; Rec."Unpaid Cheques Fee Account")
                {
                    Visible = false;
                }
                field("Internal Transfer Fee Account"; Rec."Internal Transfer Fee Account")
                {
                }
                field("Savings Bal Account"; Rec."Savings Bal Account")
                {
                    Visible = false;
                }

                field("Paybill Suspense Account"; Rec."Paybill Suspense Account")
                {
                }
                field("Internal PV Control Account"; Rec."Internal PV Control Account")
                {
                    Visible = false;
                }
                field("New Piggy Bank Debit G/L"; Rec."New Piggy Bank Debit G/L")
                {
                    Visible = false;
                }
                field("New Piggy Bank Credit G/L"; Rec."New Piggy Bank Credit G/L")
                {
                    Visible = false;
                }
                field("ESS Refund-Early Charges A/C"; Rec."ESS Refund-Early Charges A/C")
                {
                    Visible = false;
                }
            }
            group("SMS Notifications")
            {
                Editable = loanSetupEditor;
                field("Send Membership App SMS"; Rec."Send Membership App SMS")
                {
                    Caption = 'Send Membership Application SMS';
                }
                field("Send Membership Reg SMS"; Rec."Send Membership Reg SMS")
                {
                    Caption = 'Send Membership Registration SMS';
                }
                field("Send Loan App SMS"; Rec."Send Loan App SMS")
                {
                    Caption = 'Send Loan Application SMS';
                }
                field("Send Loan Disbursement SMS"; Rec."Send Loan Disbursement SMS")
                {
                    Caption = 'Send Loan Disbursement SMS';
                }
                field("Send Guarantorship SMS"; Rec."Send Guarantorship SMS")
                {
                    Visible = false;
                    Caption = 'Send Guarantorship SMS';
                }
                field("Send Membership Withdrawal SMS"; Rec."Send Membership Withdrawal SMS")
                {
                    Caption = 'Send Membership Withdrawal SMS';
                }
                field("Send ATM Withdrawal SMS"; Rec."Send ATM Withdrawal SMS")
                {
                    Visible = false;
                    Caption = 'Send ATM Withdrawal SMS';
                }
                field("Send Cash Withdrawal SMS"; Rec."Send Cash Withdrawal SMS")
                {
                    Caption = 'Send Cash Withdrawal SMS';
                }
                field("SMS Alert Fees"; Rec."SMS Alert Fees")
                {
                    Caption = 'SMS Alert Fees';
                }
                field("SMS Alert Fee Account"; Rec."SMS Alert Fee Account")
                {
                }
                field("Active SMS Service Provider"; Rec."Active SMS Service Provider")
                {
                }
            }
            group("Email Notifications")
            {
                Editable = loanSetupEditor;
                field("Send Membership App Email"; Rec."Send Membership App Email")
                {
                }
                field("Send Membership Reg Email"; Rec."Send Membership Reg Email")
                {
                }
                field("Send Loan App Email"; Rec."Send Loan App Email")
                {
                }
                field("Send Loan Disbursement Email"; Rec."Send Loan Disbursement Email")
                {
                }
                field("Send Guarantorship Email"; Rec."Send Guarantorship Email")
                {
                    Visible = false;
                }
                field("Send Membship Withdrawal Email"; Rec."Send Membship Withdrawal Email")
                {
                }
                field("Send ATM Withdrawal Email"; Rec."Send ATM Withdrawal Email")
                {
                }
                field("Send Cash Withdrawal Email"; Rec."Send Cash Withdrawal Email")
                {
                }
            }
            group("Departmental Emails")
            {
                Editable = loanSetupEditor;
                field("Credit Department E-mail"; Rec."Credit Department E-mail")
                {
                }
                field("Operations Department E-mail"; Rec."Operations Department E-mail")
                {
                }
                field("Finance Department E-mail"; Rec."Finance Department E-mail")
                {
                }
                field("BD Department E-mail"; Rec."BD Department E-mail")
                {
                }
                field("IT Department E-mail"; Rec."IT Department E-mail")
                {
                }
            }
            group("Demand Notice Period")
            {
                Editable = loanSetupEditor;
                field("1st Demand Notice Days"; Rec."1st Demand Notice Days")
                {
                }
                field("2nd Demand Notice Days"; Rec."2nd Demand Notice Days")
                {
                }
                field("CRB Notice Days"; Rec."CRB Notice Days")
                {
                }
                field("Group Leaders Notice Days"; Rec."Group Leaders Notice Days")
                {
                }
                field("Auctioneer Notice Days"; Rec."Auctioneer Notice Days")
                {
                }
                field("Member Notice Days"; Rec."Member Notice Days")
                {
                }
                field("Repetitive SMS Frequency Days"; Rec."Repetitive SMS Frequency Days")
                {
                }
                field("Group Members Notice Days"; Rec."Group Members Notice Days")
                {
                }
                field("Mobile Loan CRB Notice Days"; Rec."Mobile Loan CRB Notice Days")
                {
                }
            }
            group("SASRA Required Provisions")
            {
                Visible = false;
                //  Editable = loanSetupEditor;
                Caption = 'SASRA Required Provision %';
                field("Performing Required Provision%"; Rec."Performing Required Provision%")
                {
                    Caption = 'Performing';
                }
                field("Watch Required Provision%"; Rec."Watch Required Provision%")
                {
                    Caption = 'Watch';
                }
                field("Substandar Required Provision%"; Rec."Substandar Required Provision%")
                {
                    Caption = 'Substandard';
                }
                field("Doubtful Required Provision%"; Rec."Doubtful Required Provision%")
                {
                    Caption = 'Doubtful';
                }
                field("Loss Required Provision%"; Rec."Loss Required Provision%")
                {
                    Caption = 'Loss';
                }
            }
            group("Default Posting Groups")
            {
                Editable = loanSetupEditor;
                field("Default Customer Posting Group"; Rec."Default Customer Posting Group")
                {
                }
                field("Default Micro Credit Posting G"; Rec."Default Micro Credit Posting G")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Shares Bands")
            {
                Caption = 'Shares Bands';
            }
        }
        area(processing)
        {
            action("Reset Data Sheet")
            {
                Visible = false;
                Caption = 'Reset Data Sheet';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then
                        Cust.ModifyAll(Cust.Advice, false);

                    Loans.Reset;
                    Loans.SetRange(Loans.Source, Loans.Source::" ");
                    if Loans.Find('-') then
                        Loans.ModifyAll(Loans.Advice, false);


                    Message('Reset Completed successfully.');
                end;
            }
        }
    }

    var
        Cust: Record "Members Register";
        Loans: Record "Loans Register";

        ClassFAVisible: Boolean;
        ClassAVisible: Boolean;
        ClassBVisible: Boolean;
        ClassCVisible: Boolean;
        ClassDVisible: Boolean;
        ClassFBVisible: Boolean;
        ClassFCVisible: Boolean;
        loanSetupEditor: Boolean;
        user: Record "User Setup";

    trigger OnOpenPage()

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






