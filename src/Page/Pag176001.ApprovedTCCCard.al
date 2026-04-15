//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 65723 "Approved TCC Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; Rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Source."; Rec."Source.")
                {
                    Editable = false;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member';
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Ordinary Account';
                    ShowMandatory = true;
                    Editable = false;
                    Visible = false;
                }
                field("Client Name"; Rec."Client Name")
                {
                    Editable = false;
                }
                field("ID NO"; Rec."ID NO")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    Caption = 'Member Deposits';//
                }
                field("Total Outstanding Loan BAL"; Rec."Total Outstanding Loan BAL")
                {
                    Caption = 'Total Outstanding Loan Balance';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("1st Time Loanee"; Rec."1st Time Loanee")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Private Member"; Rec."Private Member")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    //Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    Caption = 'Product Name';
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    Editable = false;
                    //Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(Interest; Rec.Interest)
                {
                    Editable = false;
                }
                field("Product Currency Code"; Rec."Product Currency Code")
                {
                    Editable = false;
                    Enabled = true;
                    Importance = Additional;
                }
                field("Loan Deposit Multiplier"; Rec."Loan Deposit Multiplier")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Guarantorship Multiplier"; Rec."Guarantorship Multiplier") { Editable = false; Visible = false; }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    Caption = 'Amount Applied';
                    Editable = false;
                    //Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    Caption = 'Qualifying Amount';
                    Editable = false;
                    Visible = false;
                }
                field("Sacco Decision"; Rec."Sacco Decision")
                {

                    Visible = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Caption = 'Approved Amount';
                    //Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Disburesment Type"; Rec."Disburesment Type")
                {
                    Visible = false;

                    trigger OnValidate()
                    var
                        TrunchDetailsVisible: Boolean;
                    begin
                        TrunchDetailsVisible := false;

                        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
                            TrunchDetailsVisible := false;
                        end else
                            TrunchDetailsVisible := true;
                    end;
                }
                group("Tranch Details")
                {
                    Caption = 'Tranch Details';
                    Visible = false;

                    field("Amount to Disburse on Tranch 1"; Rec."Amount to Disburse on Tranch 1")
                    {
                    }
                    field("No of Tranch Disbursment"; Rec."No of Tranch Disbursment")
                    {
                    }
                }
                field(Remarks; rec.Remarks)
                {

                    Visible = false;
                }

                field("Deduct Share Capital Amount?"; Rec."Deduct Share Capital Amount?")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Boost this Loan"; Rec."Boost this Loan")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Boosted Amount"; Rec."Boosted Amount")
                {
                    Editable = false;
                    Caption = 'Deposit Boosting Amount';
                    Visible = false;
                }
                field("Boosting Commision"; Rec."Boosting Commision")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Share Capital Boosting"; Rec."Share Capital Boosting")
                {
                    Editable = false;
                    Visible = false;
                }
                field("15% on Karibu"; Rec."15% on Karibu")
                {
                    Editable = false;
                    Caption = 'Share Capital Amount';
                    Visible = false;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    Editable = false;

                }
                field("Main Sector"; Rec."Main Sector")
                {
                    Visible = false;

                }
                field("Manin Sector Name"; Rec."Manin Sector Name")
                {
                    Editable = false;
                    Caption = 'Main sector Name';
                    Visible = false;
                }

                field("Sub Sector"; Rec."Sub Sector")
                {
                    Visible = false;

                }
                field("SubSector Name"; Rec."SubSector Name") { Editable = false; Visible = false; }


                field("Sector Specific"; Rec."Sector Specific")
                {
                    Caption = 'Specific Sector';
                    Editable = false;
                    Visible = false;
                    trigger OnValidate()
                    var
                        SpecificSector: Record "Specific Sector";
                    begin
                        /*                         SpecificSector.Reset();
                                                SpecificSector.SetRange(SpecificSector.Code, Rec."Sector Specific");
                                                if SpecificSector.FindFirst() then begin
                                                    Rec."Sector Specific Name" := SpecificSector.Description;
                                                    Rec."Main Sector" := SpecificSector."Main Sector";
                                                    Rec."Sub Sector" := SpecificSector."Sub-Sector";
                                                end; */
                    end;
                }
                field("Sector Specific Name"; Rec."Sector Specific Name") { Editable = false; Caption = 'Specific Sector Name'; Visible = false; }
                field("Member House Group"; Rec."Member House Group")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Member House Group Name"; Rec."Member House Group Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Income Type"; Rec."Income Type")
                {
                    Visible = false;

                    trigger OnValidate()

                    begin
                        FnVisibility();
                    end;
                }
                field("Statement Account"; Rec."Statement Account")
                {
                    Visible = false;
                }
                field("Received Copy Of ID"; Rec."Received Copy Of ID")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Received Payslip/Bank Statemen"; Rec."Received Payslip/Bank Statemen")
                {
                    // Editable = CopyofPayslipEditable;
                }

                field(Repayment; rec.Repayment)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Upfront Interest Amount"; Rec."Upfront Interest Amount")
                {
                    Editable = false;
                    Importance = Promoted;
                    Visible = false;
                    //Upfront Interest Amount
                }

                field("Approved Repayment"; Rec."Approved Repayment")
                {
                    Visible = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    Editable = false;
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    //Editable = BatchNoEditable;
                    Importance = Additional;
                    Visible = false;
                }

                field("Credit Officer"; Rec."Credit Officer")
                {
                    Caption = 'Credit Officer';
                    Visible = false;
                }
                field("Loan Centre"; Rec."Loan Centre")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Loan Offset Amount"; Rec."Loan Offset Amount")
                {
                    Caption = 'Loan Offset Amount';
                    Visible = false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    Editable = false;
                    //Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Agency EFT Ref"; Rec."Agency EFT Ref")
                {
                    Visible = false;

                }
                field("Agency EFT"; Rec."Agency EFT")
                {
                    Visible = false;

                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    Editable = true;
                }
                field("Loan Age"; Rec."Loan Age") { Editable = false; Visible = false; }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if StrLen(rec."Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }

                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ShowMandatory = true;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("External EFT"; Rec."External EFT")
                {
                    Visible = false;
                }
                field(Posted; rec.Posted)
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }

                field("Committee Approval"; Rec."Committee Approval")
                {
                    Editable = false;
                    Style = Strong;
                    Visible = false;
                    // StyleExpr = StyleExprTxt;

                }
                field("Committee Approval Comments"; rec."Committee Approval Comments")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Loan Application Type"; Rec."Loan Application Type")
                {
                    //Editable = RecoveryModeEditable;
                    //  Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;

                }


            }
            //Appraissal
            group("Personal Details")
            {
                Caption = 'Part A: Member Profile Summary';
                Visible = individualVisible;
                Editable = false;

                field("Global Dimension 2 Code."; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Region';
                    //Visible = false;
                }
                field(Age; Rec.Age)
                {

                    //Visible = false;
                }
                field("Marital Status"; Rec."Marital Status")
                {

                    //Visible = false;
                }

                field(Dependants; Rec.Dependants)
                {

                    //Visible = false;
                }
                field("Ages Of Dependants"; Rec."Ages Of Dependants")
                {

                    //Visible = false;
                }
                field(Proffession; Rec.Proffession)
                {

                    //Visible = false;
                }
                field("Years In Said Proffession"; Rec."Years In Said Proffession")
                {

                    //Visible = false;
                }
                field("Education Level"; Rec."Education Level")
                {

                    //Visible = false;
                }
                field("Current Living Status"; Rec."Current Living Status")
                {

                    //Visible = false;
                }


            }
            group("Individual Documents.")
            {
                Caption = 'Part B:Document Received Details';
                Visible = individualVisible;
                Editable = false;
                field("Received Copy Of ID."; Rec."Received Copy Of ID")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Bill Of Quantities"; Rec."Bill Of Quantities")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Bulding Plan"; Rec."Bulding Plan")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Consent Letter"; Rec."Consent Letter")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Copy Of KRA Pin"; Rec."Copy Of KRA Pin")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Received Payslip/Bank Statemen."; Rec."Received Payslip/Bank Statemen")
                {
                    // Editable = CopyofPayslipEditable;
                }

            }
            group("Account Details")
            {
                Caption = 'Part C: Account Details';
                Visible = individualVisible;
                Editable = false;
                field("Status Of Account(6 Months)"; Rec."Status Of Account(6 Months)")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Average Savings Per Month"; Rec."Average Savings Per Month")
                {
                    // Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Savings Balance"; Rec."Savings Balance")
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field(Shares; Rec.Shares)
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Existing Loan Balance"; Rec."Existing Loan Balance")
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }

                field("New Loan Amount"; Rec."Requested Amount")
                {
                    // Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Total Exposure with KHC"; Rec."Total Exposure with KHC")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Account Conduct Rating"; Rec."Account Conduct Rating")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Nature Of Savings"; Rec."Nature Of Savings")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Is Waiting Applicable?"; Rec."Is Waiting Applicable?")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Pended Description"; Rec."Pended Description")
                {

                    //Editable = CopyofIDEditable;
                }


            }

            group("Loan Details")
            {
                Caption = 'Part D: Loan Details';
                Visible = individualVisible;
                Editable = false;
                field("Requested Amount."; Rec."Requested Amount")
                {
                    Caption = 'Loan Amount';
                    //Editable = CopyofIDEditable;
                }
                field("Loan Type"; Rec."Loan Product Type")
                {
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Loan Type Name"; Rec."Loan Product Type Name")
                {
                    // Caption = 'Product Name';
                    Editable = false;
                }
                field("Loan Purpose Description"; Rec."Loan Purpose Description")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Tenure."; Rec.Tenure)
                {
                    //Editable = CopyofIDEditable;
                }
                field("Monthly Installment"; Rec.Repayment)
                {
                    //Editable = CopyofIDEditable;
                }
                field("Total BQ Amount"; Rec."Total BQ Amount")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Personal Contribution Amount"; Rec."Personal Contribution Amount")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    //Editable = CopyofIDEditable;
                }

            }


            part(Control40; "Loan Income Part")

            {
                Visible = individualVisible;
                Editable = false;
                Caption = 'Part E: Repayment Capacity Details';
                SubPageLink = "Loan No." = field("Loan  No.");
            }

            part(Control24; "Loan monthly Expenses")
            {
                Visible = individualVisible;
                Editable = false;
                Caption = 'Existing Obligations';
                SubPageLink = "Document No" = field("Loan  No.");
            }
            group("Major Expenses")
            {
                Visible = individualVisible;
                Editable = false;
                field(Rent; Rec.Rent)
                {
                    //Editable = CopyofIDEditable;
                }
                field("School Fees"; Rec."School Fees")
                {
                    Caption = 'Fees';
                    //Editable = CopyofIDEditable;
                }
                field(Food; Rec.Food)
                {
                    //Editable = CopyofIDEditable;
                }
                field(Transport; Rec.Transport)
                {
                    //Editable = CopyofIDEditable;
                }


            }
            part(Control25; "Evidence Of Income Part")
            {
                Visible = individualVisible;
                Editable = false;

                Caption = 'Evidence Of Income';
                SubPageLink = "Loan No." = field("Loan  No.");
            }

            part(PreAppraisalCall; "Pre-Appraisal Call Part")
            {
                Visible = individualVisible;
                Editable = false;
                Caption = 'Pre-Apprassal Call';
                SubPageLink = "Loan No." = field("Loan  No.");
                UpdatePropagation = Both;
            }


            group("Variation After Appraisal")
            {
                Caption = 'Variation After Appraisal';
                Visible = individualVisible;
                Editable = false;
                field("Loan Amount(VAA)"; Rec."Loan Amount(VAA)")
                {
                    Caption = 'Loan Amount';
                    //Editable = CopyofIDEditable;
                }
                field("Reason(VAA)"; Rec."Reason(VAA)")
                {
                    Caption = 'Reason';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Tenure(VAA)"; Rec."Tenure(VAA)")
                {
                    Caption = 'Tenure';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Monthly Repayment(VAA)"; Rec."Monthly Repayment(VAA)")
                {
                    Caption = 'Monthly Repayment';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }

            }

            group("Valuation Instruction")
            {
                Visible = individualVisible;
                Editable = false;
                field(Comments; Rec."Valuation Instruction")
                {
                    //Editable = CopyofIDEditable;
                }
            }
            group("Loan Security Analysis")
            {
                Caption = 'Part H. Loan Security Analysis';
                Visible = individualVisible;
                Editable = false;
                field("Current Property Owner"; Rec."Current Property Owner")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Owner After Loan Uptake"; Rec."Owner After Loan Uptake")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Consent From Guarantor"; Rec."Consent From Guarantor")
                {
                    //Editable = CopyofIDEditable;
                }
            }

            //corporate
            group("Corporate Details")
            {
                Visible = CooporateVisible;
                Editable = false;
                field("Corporate Type"; Rec."Corporate Type")
                {
                    //  Editable = false;

                }
                field("Corporate Date of Registration"; Rec."Corporate Date of Registration")
                {
                    //  Editable = false;

                }

                field("Corporate Tax Pin"; Rec."Corporate Tax Pin")
                {
                    //  Editable = false;

                }
                field("Corporate Bankers"; Rec."Corporate Bankers")
                {
                    //  Editable = false;

                }


            }

            group("Ownership Structure")
            {
                Visible = CooporateVisible;
                Editable = false;
                field("Number of Members/Shareholders"; Rec."Number of Members/Shareholders")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Membership Sector"; Rec."Membership Sector")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Years In Operation"; Rec."Years In Operation")
                {
                    //Editable = CopyofIDEditable;
                }


            }

            group("Corporate Documents.")
            {
                Visible = CooporateVisible;
                Editable = false;
                field("Cert of Registration"; Rec."Cert of Registration")
                {
                    //Editable = CopyofIDEditable;
                }
                field(CR12; Rec.CR12)
                {
                    //Editable = CopyofIDEditable;
                }
                field(Constitution; Rec.Constitution)
                {
                    //Editable = CopyofIDEditable;
                }
                field("Board Resolution to Borrow"; Rec."Board Resolution to Borrow")
                {
                    //Editable = CopyofIDEditable;
                }
                field("ID & KYC of Directors"; Rec."ID & KYC of Directors")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Tax Compliance Certificate"; Rec."Tax Compliance Certificate")
                {
                    // Editable = CopyofPayslipEditable;
                }
                field("Audited Financials"; Rec."Audited Financials")
                {
                    // Editable = CopyofPayslipEditable;
                }
                field("MINUTES of Borrowing"; Rec."MINUTES of Borrowing")
                {
                    Caption = 'MINUTES- With borrowing as an Agenda';
                }

            }

            group("Corporate Loan Details")
            {
                Caption = 'Part D: Loan Details CP';
                Visible = CooporateVisible;
                Editable = false;
                field("Requested Amount CP"; Rec."Requested Amount")
                {
                    Caption = 'Loan Amount';
                    //Editable = CopyofIDEditable;
                }
                field("Loan Type CP"; Rec."Loan Product Type")
                {
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Loan Type Name CP"; Rec."Loan Product Type Name")
                {
                    // Caption = 'Product Name';
                    Editable = false;
                }
                field("Loan Purpose Description CP"; Rec."Loan Purpose Description")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Tenure CP"; Rec.Tenure)
                {
                    //Editable = CopyofIDEditable;
                }
                field("Monthly Installment CP"; Rec.Repayment)
                {
                    //Editable = CopyofIDEditable;
                }
                field("Total BQ Amount CP"; Rec."Total BQ Amount")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Personal Contribution Amount CP"; Rec."Personal Contribution Amount")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Source of Funds CP"; Rec."Source of Funds")
                {
                    //Editable = CopyofIDEditable;
                }

            }
            group("Account Details CP")
            {
                Caption = 'Part C: Account Details';
                Visible = CooporateVisible;
                Editable = false;
                field("Status Of Account(6 Months) CP"; Rec."Status Of Account(6 Months)")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Average Savings Per Month CP"; Rec."Average Savings Per Month")
                {
                    // Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Savings Balance CP"; Rec."Savings Balance")
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Shares CP"; Rec.Shares)
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Existing Loan Balance CP"; Rec."Existing Loan Balance")
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }

                field("New Loan Amount CP"; Rec."Requested Amount")
                {
                    // Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Total Exposure with KHC CP"; Rec."Total Exposure with KHC")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Account Conduct Rating CP"; Rec."Account Conduct Rating")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Nature Of Savings CP"; Rec."Nature Of Savings")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Is Waiting Applicable? CP"; Rec."Is Waiting Applicable?")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Pended Description CP"; Rec."Pended Description")
                {

                    //Editable = CopyofIDEditable;
                }


            }
            part(Control42; "Loan Income Part")
            {
                Visible = CooporateVisible;
                Editable = false;
                Caption = 'Part E: Repayment Capacity Details CP';
                SubPageLink = "Loan No." = field("Loan  No.");
            }
            part(Control43; "Evidence Of Income Part")
            {
                Visible = CooporateVisible;
                Editable = false;
                Caption = 'Evidence Of Revenue CP';
                SubPageLink = "Loan No." = field("Loan  No.");
            }
            group("Loan Security Analysis CP")
            {
                Caption = 'Part H. Loan Security Analysis CP';
                Visible = CooporateVisible;
                Editable = false;
                field("Current Property Owner CP"; Rec."Current Property Owner")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Owner After Loan Uptake CP"; Rec."Owner After Loan Uptake")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Property Location CP"; Rec."Property Location")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Distance From Main Road."; Rec."Distance From Main Road")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Collateral Type."; Rec."Collateral Type")
                {
                    Caption = 'Type';
                    //Editable = CopyofIDEditable;
                }
                field("Expected Security value After Disbursement"; Rec."Expected Security value After Disbursement")
                {
                    //Editable = CopyofIDEditable;
                }

                field("Current Market Value CP"; Rec."Current Market Value")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Forced Sale Value CP"; Rec."Forced Sale Value")
                {
                    //Editable = CopyofIDEditable;
                }
            }


            group("Additional Security")
            {
                Caption = 'Additional Security Cp';
                Visible = CooporateVisible;
                Editable = false;

                field("Personal Directors Guarantees"; Rec."Personal Directors Guarantees")
                {
                    Caption = 'Personal Directors Guarantees';
                }
                field("Joint & Several Liability"; Rec."Joint & Several Liability")
                {
                    Caption = 'Joint & Several Liability';
                }
                field("Assignment of Rental Income"; Rec."Assignment of Rental Income")
                {
                    Caption = 'Assignment of Rental Income';
                }

            }


            //Loan Against Savings
            group("Individual Documents.SV")
            {
                Caption = 'Part B:Document Received Details';
                Visible = LoanSavingsVIsible;
                Editable = false;
                field("Received Copy Of ID SV"; Rec."Received Copy Of ID")
                {
                    //Editable = CopyofIDEditable;
                }

                field("Copy Of KRA Pin SV"; Rec."Copy Of KRA Pin")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Copy of Title Deed SV"; Rec."Copy of Title Deed")
                {
                    // Editable = CopyofPayslipEditable;
                }

            }



            group("Account Details SV")
            {
                Caption = 'Part C: Account Details';
                Visible = LoanSavingsVIsible;
                Editable = false;
                field("Status Of Account(6 Months) SV"; Rec."Status Of Account(6 Months)")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Average Savings Per Month SV"; Rec."Average Savings Per Month")
                {
                    // Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Savings Balance sv"; Rec."Savings Balance")
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Shares sv"; Rec.Shares)
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Existing Loan Balance sv"; Rec."Existing Loan Balance")
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }

                field("New Loan Amount sv"; Rec."Requested Amount")
                {
                    // Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Total Exposure with KHC sv"; Rec."Total Exposure with KHC")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Account Conduct Rating sv"; Rec."Account Conduct Rating")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Nature Of Savings sv"; Rec."Nature Of Savings")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Is Waiting Applicable? sv"; Rec."Is Waiting Applicable?")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Pended Description sv"; Rec."Pended Description")
                {

                    //Editable = CopyofIDEditable;
                }


            }

            part(Control44; "Loan Income Part")
            {
                Visible = LoanSavingsVIsible;
                Editable = false;
                Caption = 'Part E: Repayment Capacity Details SV';
                SubPageLink = "Loan No." = field("Loan  No.");
            }


            part(Control47; "Loan monthly Expenses")
            {
                Visible = LoanSavingsVIsible;
                Editable = false;
                Caption = 'Existing Obligations sv';
                SubPageLink = "Document No" = field("Loan  No.");
            }
            group("Major Expenses sv")
            {
                Visible = LoanSavingsVIsible;
                Editable = false;
                field("Rent sv"; Rec.Rent)
                {
                    //Editable = CopyofIDEditable;
                }
                field("School Fees sv"; Rec."School Fees")
                {
                    Caption = 'Fees';
                    //Editable = CopyofIDEditable;
                }
                field("Food sv"; Rec.Food)
                {
                    //Editable = CopyofIDEditable;
                }
                field("Transport sv"; Rec.Transport)
                {
                    //Editable = CopyofIDEditable;
                }


            }
            part(Control45; "Evidence Of Income Part")
            {
                Visible = LoanSavingsVIsible;
                Editable = false;
                Caption = 'Evidence Of Income';
                SubPageLink = "Loan No." = field("Loan  No.");
            }

            group("Loan Security Analysis sv")
            {
                Visible = LoanSavingsVIsible;
                Editable = false;
                field("Savings Less Appraissal Fee"; Rec."Savings Less Appraissal Fee")
                {
                    //Editable = CopyofIDEditable;
                }
                field("% Required per Policy"; Rec."% Required per Policy")
                {
                    Caption = 'Fees';
                    //Editable = CopyofIDEditable;
                }
                field("Requested Amount SV"; Rec."Requested Amount")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Maximum as Per % Policy"; Rec."Maximum as Per % Policy")
                {
                    //Editable = CopyofIDEditable;
                }


            }
            //Loan against savings



            //Top Up


            group("Personal Details TU")
            {
                Caption = 'Part A: Member Profile Summary';
                Visible = TopupVisible;
                Editable = false;
                //Visible=false;


                field("Global Dimension 2 Code TU"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Region';
                    //Visible = false;
                }
                field("Age TU"; Rec.Age)
                {

                    //Visible = false;
                }
                field("Marital Status Tu"; Rec."Marital Status")
                {

                    //Visible = false;
                }

                field("Dependants Tu"; Rec.Dependants)
                {

                    //Visible = false;
                }
                field("Ages Of Dependants Tu"; Rec."Ages Of Dependants")
                {

                    //Visible = false;
                }
                field("Proffession Tu"; Rec.Proffession)
                {

                    //Visible = false;
                }
                field("Years In Said Proffession Tu"; Rec."Years In Said Proffession")
                {

                    //Visible = false;
                }
                field("Education Level Tu"; Rec."Education Level")
                {

                    //Visible = false;
                }
                field("Current Living Status Tu"; Rec."Current Living Status")
                {

                    //Visible = false;
                }


            }

            group("Individual Documents.Tu")
            {
                Caption = 'Part B:Document Received Details';
                Visible = TopupVisible;
                Editable = false;
                field("Received Copy Of ID Tu"; Rec."Received Copy Of ID")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Copy Of KRA Pin Tu"; Rec."Copy Of KRA Pin")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Copy of Title Deed Tu"; Rec."Copy of Title Deed")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Consent Letter Tu"; Rec."Consent Letter")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Sales Agreement Tu"; Rec."Sales Agreement")
                {
                    // Editable = CopyofPayslipEditable;
                }
                field("Bill Of Quantities Tu"; Rec."Bill Of Quantities")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Bulding Plan Tu"; Rec."Bulding Plan")
                {
                    //Editable = CopyofIDEditable;
                }




            }

            group("Account Details TU")
            {
                Caption = 'Part C: Account Details';
                Visible = TopupVisible;
                Editable = false;
                field("Status Of Account(6 Months) TU"; Rec."Status Of Account(6 Months)")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Average Savings Per Month Tu"; Rec."Average Savings Per Month")
                {
                    // Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Savings Balance Tu"; Rec."Savings Balance")
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Shares Tu"; Rec.Shares)
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Existing Loan Balance Tu"; Rec."Existing Loan Balance")
                {
                    Editable = false;
                    //Editable = CopyofIDEditable;
                }

                field("New Loan Amount Tu"; Rec."Requested Amount")
                {
                    // Editable = false;
                    //Editable = CopyofIDEditable;
                }
                field("Total Exposure with KHC Tu"; Rec."Total Exposure with KHC")
                {

                    //Editable = CopyofIDEditable;
                }
                field("Account Conduct Rating Tu"; Rec."Account Conduct Rating")
                {

                    //Editable = CopyofIDEditable;
                }


            }


            group("Topup Loan Details")
            {
                Caption = 'Part D: Loan Details     TU';
                Visible = TopupVisible;
                Editable = false;
                field("Requested Amount TU"; Rec."Requested Amount")
                {
                    Caption = 'Loan Amount';
                    //Editable = CopyofIDEditable;
                }
                field("Loan Type TU"; Rec."Loan Product Type")
                {
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Loan Type Name TU"; Rec."Loan Product Type Name")
                {
                    // Caption = 'Product Name';
                    Editable = false;
                }
                field("Loan Purpose Description TU"; Rec."Loan Purpose Description")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Tenure TU"; Rec.Tenure)
                {
                    //Editable = CopyofIDEditable;
                }
                field("Monthly Installment TU"; Rec.Repayment)
                {
                    //Editable = CopyofIDEditable;
                }
                field("Total BQ Amount TU"; Rec."Total BQ Amount")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Personal Contribution Amount TU"; Rec."Personal Contribution Amount")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Source of Funds TU"; Rec."Source of Funds")
                {
                    //Editable = CopyofIDEditable;
                }

            }
            part(Control46; "Loan Income Part")
            {
                Visible = TopupVisible;
                Editable = false;
                Caption = 'Part E: Repayment Capacity Details Tu';
                SubPageLink = "Loan No." = field("Loan  No.");
            }

            group("Loan Security Analysis TU")
            {
                Caption = 'Part H. Loan Security Analysis TU';
                Visible = TopupVisible;
                field("Property Location TU"; Rec."Property Location")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Distance From Main Road TU"; Rec."Distance From Main Road")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Collateral Type TU"; Rec."Collateral Type")
                {
                    Caption = 'Type';
                    //Editable = CopyofIDEditable;
                }
                field("Expected Security value After Disbursement TU"; Rec."Expected Security value After Disbursement")
                {
                    //Editable = CopyofIDEditable;
                }

                field("Current Market Value CP TU"; Rec."Current Market Value")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Forced Sale Value CP TU"; Rec."Forced Sale Value")
                {
                    //Editable = CopyofIDEditable;
                }


            }
            group("Current Security Details")
            {
                Caption = 'Part H. Current Security Details';
                Visible = TopupVisible;
                Editable = false;
                field("Current Property Owner TU"; Rec."Current Property Owner")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Owner After Loan Uptake TU"; Rec."Owner After Loan Uptake")
                {
                    //Editable = CopyofIDEditable;
                }
                field("Consent From Guarantor Tu"; Rec."Consent From Guarantor")
                {
                    //Editable = CopyofIDEditable;
                }
            }
            group("Variation After Appraisal(TU)")
            {
                Caption = 'Variation After Appraisal';
                Visible = TopupVisible;
                Editable = false;
                field("Loan Amount(TU)"; Rec."Loan Amount(VAA)")
                {
                    Caption = 'Loan Amount';
                    //Editable = CopyofIDEditable;
                }
                field("Reason(TU)"; Rec."Reason(VAA)")
                {
                    Caption = 'Reason';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Tenure(TU)"; Rec."Tenure(VAA)")
                {
                    Caption = 'Tenure';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Monthly Repayment(TU)"; Rec."Monthly Repayment(VAA)")
                {
                    Caption = 'Monthly Repayment';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }

            }

            group("Valuation Instruction(TU)")
            {
                Visible = TopupVisible;
                Editable = false;
                field("Comments TU"; Rec."Valuation Instruction")
                {
                    //Editable = CopyofIDEditable;
                }
            }




            //Loan Appraissal
            //Valuation
            group("Valuation Details")
            {
                Editable = false;
                field("Valuer Code"; Rec."Valuer Code")
                {


                }
                field("Valuer Name"; Rec."Valuer Name")
                {


                }
                field("Valuation Comments"; Rec."Valuation Comments")
                {


                }

            }
            group("Security input After Valuation")
            {
                Editable = false;
                field("LR No"; Rec."LR No (VAV)")
                {
                    MultiLine = true;


                }
                field("Property Location"; Rec."Property Location (VAV)")
                {
                    MultiLine = true;


                }
                field("Property Description"; Rec."Property Description(VAV)")
                {
                    MultiLine = true;
                }
                field("Distance From Main Road"; Rec."Distance From Main Road(VAV)")
                {
                    MultiLine = true;
                }
                field("Collateral Type"; Rec."Collateral Type(VAv)")
                {
                    MultiLine = true;
                }
                field("Urban/Rural?"; Rec."Urban/Rural?")
                {
                    MultiLine = true;
                }
                field("Expected value After Disbursement"; Rec."Expected value After Disbursement(VAV)")
                {
                    MultiLine = true;
                }
                field("Current Market Value"; Rec."Current Market Value")
                {
                    MultiLine = true;
                }
                field("Forced Sale Value"; Rec."Forced Sale Value(VAV)")
                {
                    MultiLine = true;
                }
                field("Percentage CMV"; Rec."Percentage CMV(VAV)")
                {
                    MultiLine = true;
                }

            }

            group("Variation After Valuation")
            {
                Caption = 'Variation After Valuation';
                Editable = false;
                field("Loan Amount"; Rec."Loan Amount(VAV)")
                {
                    Caption = 'Loan Amount';
                    //Editable = CopyofIDEditable;
                }
                field("Reason"; Rec."Reason(VAV)")
                {
                    Caption = 'Reason';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Tenure"; Rec."Tenure(VAV)")
                {
                    Caption = 'Tenure';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }
                field("Monthly Repayment"; Rec."Monthly Repayment(VAV)")
                {
                    Caption = 'Monthly Repayment';
                    // Editable = false;
                    // Editable = LProdTypeEditable;
                }

            }


            group("Findings.")
            {
                field("Findings Summary"; Rec."Findings Summary")
                {
                    Editable = false;
                    MultiLine = true;


                }

            }

            group("Reccomendation from Mortgage Desk")
            {
                field("Mortgage Officers Comments"; Rec."Mortgage Officers Comments")
                {
                    Editable = false;
                    MultiLine = true;
                    Caption = 'Reccomendation';


                }

            }


            //Valuation
            part(Control50; "TCC Policy Check")
            {

                Caption = 'Policy Check';
                SubPageLink = "Loan No." = field("Loan  No.");
            }
            group("TCC Risk Review")
            {
                Caption = 'TCC Risk Review';
                field("Income Assessment"; Rec."Income Assessment")
                {
                }
                field("Collateral Assessment"; Rec."Collateral Assessment")
                {
                }
                field("Equity Release Ratio Observed"; Rec."Equity Release Ratio Observed")
                {
                }

            }

            group("TCC Recommendation")
            {
                Caption = 'TCC Recommendation';
                field("TCC Reccomendation"; Rec."TCC Reccomendation")
                {
                }

            }



            part(Control34; "Loan Deliberations")
            {

                Caption = 'Loan Deliberations';
                SubPageLink = "Document No" = field("Loan  No.");
            }

            part(Control3; "Loan Collateral Security")
            {
                // Visible = false;
                Caption = 'Loan Collateral  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
        }
        area(factboxes)
        {

            part(Control1; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }

            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                Caption = 'Documents';
                UpdatePropagation = Both;//
                SubPageLink = "Table ID" = const(Database::"Loans Register"),
                              "No." = field("Loan  No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("Reset Loan Application")
                {
                    Image = RefreshExcise;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            rec."Client Code" := '';
                            rec."Client Name" := '';
                            rec."ID NO" := '';
                            rec."Staff No" := '';
                            rec.Installments := 0;
                            rec.Interest := 0;
                            rec."Requested Amount" := 0;
                            rec."Approved Amount" := 0;
                        end;
                    end;
                }
                action("Loan Application Form")
                {
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(172913, true, false, LoanApp);
                        end;
                    end;
                }
                action("Print Offer Letter")
                {
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            if Rec."Loan Application Type" = Rec."Loan Application Type"::individual then begin
                                Report.Run(172913, true, false, LoanApp);
                            end else if Rec."Loan Application Type" = Rec."Loan Application Type"::Joint then begin
                                Report.Run(172913, true, false, LoanApp);
                            end else if Rec."Loan Application Type" = Rec."Loan Application Type"::Corporate then begin
                                Report.Run(172913, true, false, LoanApp);
                            end;
                        end;
                    end;
                }
                action("Re-Open Loan")
                {
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF Confirm('Do you want to re-open this loan?', True, False) = true then begin
                            LoanApp.Reset;
                            LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                            if LoanApp.Find('-') then begin
                                LoanApp."Loan Status" := LoanApp."Loan Status"::Application;
                                LoanApp."Approval Status" := LoanApp."Approval Status"::Open;
                                LoanApp.Modify(true);
                            end;
                        end;
                    end;
                }
                action(LoanAttachments)
                {
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        LoanAttachments: Page "Loan Attachments";
                    begin
                        LoanAttachments.SetLoanNo(Rec."Loan  No.");
                        LoanAttachments.RunModal();
                    end;
                }
                action("Update Loan Repayemnt")
                {
                    Image = Form;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        LoanAppraisal: report "Loan Appraisal Draft";
                        LInterests: Decimal;
                        LPrincipals: Decimal;
                    begin

                        if Confirm('Update Repayment?', true, false) = true then begin
                            if Rec."Repayment Method" = Rec."repayment method"::"Straight Line" then begin
                                Rec.TestField(Installments);
                                LPrincipals := ROUND(Rec."Approved Amount" / Rec.Installments, 1, '>');
                                LInterests := ROUND(((Rec.Interest / 100) * Rec."Approved Amount") / Rec.Installments, 1, '>');
                                Rec."Loan Principle Repayment" := LPrincipals;
                                Rec."Loan Interest Repayment" := LInterests;
                                Rec.Repayment := TotalMRepay;
                                Rec.Modify;
                            end;


                            if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                Rec.TestField(Interest);
                                Rec.TestField(Installments);
                                LPrincipals := ROUND(Rec."Approved Amount" / Rec.Installments, 1, '>');
                                LInterests := ROUND(Rec."Approved Amount" * Rec.Interest / Rec.Installments / 100, 1, '>');
                                Rec."Loan Principle Repayment" := LPrincipals;
                                Rec."Loan Interest Repayment" := LInterests;
                                Rec.Repayment := TotalMRepay;
                                Rec.Modify;
                            end;


                            if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin

                                LInterests := ROUND(((((ROUND((Rec.Interest / 12), 0.01, '>') * Rec.Installments) + ROUND((Rec.Interest / 12), 0.01, '>')) * Rec."Approved Amount") / 200) / Rec.Installments, 0.01, '=');
                                LPrincipals := ROUND(Rec."Approved Amount" / Rec.Installments, 0.01, '=');
                                TotalMRepay := LPrincipals + LInterests;
                                Rec."Loan Principle Repayment" := LPrincipals;
                                Rec."Loan Interest Repayment" := LInterests;
                                Rec.Repayment := TotalMRepay;
                                Rec.Modify;
                            end;
                        end;
                    end;
                }
                action("Loan Appraisal")
                {
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    // Visible = false;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    begin
                        rec.TestField("Mode of Disbursement");
                        ProvidedGuarantors := 0;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50084, true, false, LoanApp)
                        end;
                        Audit.FnInsertAuditRecords(UserId, 'Loan Appraisal', Rec."Approved Amount", Rec."Loan  No.", today, time, '', Rec."Loan  No.", Rec."Client Code", '');
                        FnRunCreateLoanStages;//========================Create Loan Stages
                    end;
                }
                action("Go to FOSA Accounts")
                {
                    Image = List;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("Client Code");
                }
                action("Update PAYE")
                {
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    Caption = 'Update Salary Details';
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        loansregister: Record "Loans Register";
                        Repayment: Decimal;
                        Interest: Decimal;
                        SalPayments: Record "Salary Details";
                        payroll: Record "prPeriod Transactions.";
                        Schedule: Record "Loan Repayment Schedule";
                        GrossAmount: Decimal;
                        ThirdAmount: Decimal;
                        twothirds: Decimal;
                        loansTypes: Record "Loan Products Setup";
                        Membs: record "Members Register";
                        TaxablePay: Decimal;
                        PayeAmount: Decimal;
                        monthlyContr: Decimal;
                        payrollPeriod: Date;
                    begin
                        if rec."Is PCK Salary?" <> true then begin
                            if rec."Employer Code" = 'STAFF' then begin
                                if Rec."Recovery Mode" = Rec."Recovery Mode"::Salary then begin
                                    GrossAmount := 0;
                                    loansTypes.get(Rec."Loan Product Type");
                                    loansTypes.TestField(loansTypes."Loan Appraisal %");
                                    payroll.Reset();
                                    payroll.SetRange(payroll."Employee Code", Rec."Staff No");
                                    payroll.SetRange(payroll."Group Text", 'NET PAY');
                                    payroll.SetCurrentKey("Payroll Period");
                                    payroll.SetAscending("Payroll Period", true);
                                    if payroll.FindLast() then begin
                                        Rec."Member Gross Salary" := payroll.Amount;
                                        Rec."Third Percentage" := loansTypes."Loan Appraisal %";
                                        Rec."Basic Pay H" := payroll.Amount;
                                        rec.Validate("Basic Pay H");
                                        Rec."Third Gross" := Round((loansTypes."Loan Appraisal %" * payroll.Amount / 100), 0.01, '>');
                                        Rec."Gross Pay" := payroll.Amount;
                                        thirdGross := payroll."Amount" - (Round((loansTypes."Loan Appraisal %" * payroll."Amount" / 100), 0.01, '>'));
                                        Rec."Member Loans Deductions" := FnFetchLoanDeductions(Rec."Client Code");// + FnFetchSTODeductions(Rec."Client Code");
                                        Rec."Sacco Deductions" := FnFetchSTODeductions(Rec."Client Code");
                                        Rec."Total DeductionsH" := FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code");
                                        Rec."Member Offets" := FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.");
                                        Rec."Member Ability" := (Rec."Third Gross" + Rec."Other Income" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code"));
                                        Rec."Utilizable Amount" := (Rec."Third Gross" + Rec."Other Income" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code"));
                                        if LoanType.Get(Rec."Loan Product Type") then begin
                                            rec."15% on Karibu" := (LoanType."% Share Capitalization" / 100) * rec."Approved Amount";
                                            if LoanType."Exempt Interest" = false then begin
                                                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin

                                                    Rec.Repayment := ROUND((LoanType."Interest rate" / 12 / 100) / (1 - Power((1 + (LoanType."Interest rate" / 12 / 100)), -(Rec.Installments))) * (Rec."Requested Amount"), 0.0001, '>'); //- ROUND(Rec."Requested Amount" / 100 / 12 * LoanType."Interest rate", 0.0001, '>');

                                                    //  Message('Outstanding%1Int%2', LoansRegister."Outstanding Balance", LoanType."Interest rate");
                                                end;
                                                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                                    if LoansRegister.Installments > 12 then
                                                        Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / 1200, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=')
                                                    else
                                                        //  Message('Req%1Int%2Insta%3', Rec."Requested Amount", LoanType."Interest rate", Rec.Installments);
                                                        Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / Rec.Installments / 100, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                                end;

                                                if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Straight Line" then begin
                                                    Rec.Repayment := (LoanType."Interest rate" / 12 / 100) * Rec."Requested Amount" / Rec.Installments + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                                end;
                                            end else begin
                                                rec.Repayment := Round((rec."Requested Amount" / rec.Installments), 0.001, '>');
                                            end;
                                        end;
                                        Rec.Modify();
                                        Message('Salary Details Updated Successfully');
                                    end else begin
                                        Error('Salary Details Not Found');
                                    end;
                                end else if rec."Recovery Mode" = rec."Recovery Mode"::Checkoff then begin
                                    GenSetUp.Get();
                                    // twothirds := 0;
                                    // TaxablePay := 0;
                                    // PayeAmount := 0;
                                    // TaxablePay := GrossPay - Rec."Tax Exempt Deductions";

                                    // PayeAmount := ROUND((UpdatePaye.fnGetEmployeePaye(TaxablePay)));

                                    // rec.PAYE := PayeAmount - Rec."Other Tax Relief";
                                    // rec."Housing Levy" := 1.5 * GrossPay / 100;
                                    // rec.NSSF := 1080;
                                    // Rec.NHIF := round((UpdatePaye.fnGetEmployeeNHIF(GrossPay)), 1, '>');
                                    // rec.Modify;

                                    // rec.CalcFields(rec."Bridge Amount Release");

                                    // rec."Chargeable Pay" := rec."Gross Pay" + rec."Other Tax Relief" - rec."Provident Fund" - rec."Pension Scheme" - rec.NSSF;

                                    // twothirds := (rec."Basic Pay H") * 2 / 3;
                                    // Rec.TwoThirds := twothirds;

                                    // TotalDeductions := Rec."Monthly Contribution" + rec.NHIF + rec.NSSF + Rec."Sacco Deductions" + Rec."Other Liabilities" + rec.PAYE;

                                    // if LoanType.Get(Rec."Loan Product Type") then begin
                                    //     rec."15% on Karibu" := (LoanType."% Share Capitalization"/100) * rec."Approved Amount";
                                    //     if LoanType."Exempt Interest" = false then begin
                                    //         if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                                    //             Rec.Repayment := ROUND((LoanType."Interest rate" / 12 / 100) / (1 - Power((1 + (LoanType."Interest rate" / 12 / 100)), -(Rec.Installments))) * (Rec."Requested Amount"), 0.0001, '>'); //- ROUND(Rec."Requested Amount" / 100 / 12 * LoanType."Interest rate", 0.0001, '>');
                                    //             //  Message('Outstanding%1Int%2', LoansRegister."Outstanding Balance", LoanType."Interest rate");
                                    //         end;
                                    //         if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                    //             if LoansRegister.Installments > 12 then
                                    //                 Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / 1200, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=')
                                    //             else
                                    //                 //  Message('Req%1Int%2Insta%3', Rec."Requested Amount", LoanType."Interest rate", Rec.Installments);
                                    //                 Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / Rec.Installments / 100, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                    //         end;

                                    //         if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Straight Line" then begin
                                    //             Rec.Repayment := (LoanType."Interest rate" / 12 / 100) * Rec."Requested Amount" / Rec.Installments + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                    //         end;
                                    //     end else begin
                                    //         rec.Repayment := Round((rec."Requested Amount"/ rec.Installments), 0.001, '>');
                                    //     end;
                                    // end;
                                    // //TotalDeductions := TotalDeductions + Rec.Repayment;
                                    // // Message('TOtalDed%1ToThir%2', TotalDeductions, twothirds);

                                    // NetUtilizable := ROUND((GrossPay - TotalDeductions), 0.01, '=');
                                    // rec."Utilizable Amount" := NetUtilizable;
                                    // rec."Total DeductionsH" := TotalDeductions;
                                    // rec.Modify;

                                    // payroll.Reset();
                                    // payroll.SetRange("Employee Code", rec."Staff No");
                                    // payroll.SetCurrentKey("Payroll Period");
                                    // payroll.SetAscending("Payroll Period", true);
                                    // if payroll.FindSet() then begin
                                    //     payroll.SetRange("Transaction Code", 'BPAY');
                                    //     if payroll.Find('-') then begin
                                    //         rec."Basic Pay H" := payroll.Amount;
                                    //         rec.Validate("Basic Pay H");
                                    //         rec.modify;
                                    //     end;
                                    // end;
                                    monthlyContr := 0;

                                    payroll.Reset();
                                    payroll.SetRange("Employee Code", rec."Staff No");
                                    payroll.SetCurrentKey("Payroll Period");
                                    payroll.SetAscending("Payroll Period", true);
                                    if payroll.FindLast() then begin
                                        payrollPeriod := payroll."Payroll Period";
                                    end;

                                    payroll.Reset();
                                    payroll.SetRange("Employee Code", rec."Staff No");
                                    payroll.SetRange("Payroll Period", payrollPeriod);
                                    if payroll.FindSet() then begin
                                        payroll.SetRange("Transaction Code", 'BPAY');
                                        if payroll.Find('-') then begin
                                            rec."Basic Pay H" := payroll.Amount;
                                            rec.Validate("Basic Pay H");
                                        end;
                                        payroll.SetRange("Transaction Code", 'E002');
                                        if payroll.Find('-') then begin
                                            rec."Transport Allowance" := payroll.Amount;
                                        end;
                                        payroll.SetRange("Transaction Code", 'E008');
                                        if payroll.Find('-') then begin
                                            rec."Other Allowance" := payroll.Amount;
                                        end;
                                        rec.modify;
                                        rec."Gross Pay" := rec."Basic Pay H" + Rec."House AllowanceH" + rec."Other Allowance" + rec."Transport Allowance";
                                        // rec.modify;
                                        payroll.SetRange("Transaction Code", 'NSSF');
                                        if payroll.Find('-') then begin
                                            rec.NSSF := payroll.Amount;
                                        end;
                                        payroll.SetRange("Transaction Code", 'NHIF');
                                        if payroll.Find('-') then begin
                                            rec.NHIF := payroll.Amount;
                                        end;
                                        payroll.SetRange("Transaction Code", 'PAYE');
                                        if payroll.Find('-') then begin
                                            rec.PAYE := payroll.Amount;
                                        end;
                                        payroll.SetRange("Transaction Code", 'D027');
                                        if payroll.Find('-') then begin
                                            rec."Housing Levy" := payroll.Amount;
                                        end;
                                        payroll.SetRange("Transaction Code", 'D001');
                                        if payroll.Find('-') then begin
                                            monthlyContr := payroll.Amount;
                                        end;
                                        payroll.SetRange("Transaction Code", 'D002');
                                        if payroll.Find('-') then begin
                                            monthlyContr := payroll.Amount + monthlyContr;
                                        end;
                                        payroll.SetRange("Transaction Code", 'D018');
                                        if payroll.Find('-') then begin
                                            monthlyContr := payroll.Amount + monthlyContr;
                                        end;
                                        rec."Monthly Contribution" := monthlyContr;
                                        // payroll.SetRange("Transaction Code", 'BPAY');
                                        // if payroll.Find('-') then begin
                                        //     rec."Basic Pay H" := payroll.Amount;
                                        // end;
                                        Rec."Member Loans Deductions" := FnFetchLoanDeductions(Rec."Client Code");
                                        Rec."Sacco Deductions" := FnFetchSTODeductions(Rec."Client Code");
                                        // Rec."Monthly Contribution" := FnFetchSTODeductions(Rec."Client Code");
                                        rec."Member Offets" := FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.");

                                        GrossPay := rec."Basic Pay H" + Rec."House AllowanceH" + rec."Other Income" + rec."Transport Allowance";
                                        rec."Gross Pay" := GrossPay;//rec."Gross Pay";
                                        rec.modify;

                                        TotalDeductions := Rec."Monthly Contribution" + rec.NHIF + rec.NSSF + Rec."Sacco Deductions" + Rec."Other Liabilities" + rec.PAYE + rec."Housing Levy" + Rec."Member Loans Deductions";

                                        if LoanType.Get(Rec."Loan Product Type") then begin
                                            if LoanType."Exempt Interest" = false then begin
                                                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                                                    Rec.Repayment := ROUND((LoanType."Interest rate" / 12 / 100) / (1 - Power((1 + (LoanType."Interest rate" / 12 / 100)), -(Rec.Installments))) * (Rec."Requested Amount"), 0.0001, '>'); //- ROUND(Rec."Requested Amount" / 100 / 12 * LoanType."Interest rate", 0.0001, '>');
                                                    //  Message('Outstanding%1Int%2', LoansRegister."Outstanding Balance", LoanType."Interest rate");
                                                end;
                                                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                                    if LoansRegister.Installments > 12 then
                                                        Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / 1200, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=')
                                                    else
                                                        //  Message('Req%1Int%2Insta%3', Rec."Requested Amount", LoanType."Interest rate", Rec.Installments);
                                                        Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / Rec.Installments / 100, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                                end;

                                                if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Straight Line" then begin
                                                    Rec.Repayment := (LoanType."Interest rate" / 12 / 100) * Rec."Requested Amount" / Rec.Installments + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                                end;
                                            end else begin
                                                rec.Repayment := Round((rec."Requested Amount" / rec.Installments), 0.001, '>');
                                            end;
                                        end;
                                        rec."Utilizable Amount" := (Rec."Gross Pay" - Rec."Third Basic") - (TotalDeductions - rec."Member Offets");
                                        rec."Total DeductionsH" := TotalDeductions;
                                        rec.modify;
                                    end;
                                end;
                                Message('Salary details have been updated.');
                            end else begin
                                if Rec."Recovery Mode" = Rec."Recovery Mode"::"Direct Debits" then begin
                                    Rec.TestField("Bank Statement Avarage Credits");
                                    Rec.TestField("Bank Statement Avarage Debits");

                                    Rec."Bank Statement Net Income" := Rec."Bank Statement Avarage Credits" - Rec."Bank Statement Avarage Debits";
                                    Rec."Member Ability" := Rec."Bank Statement Avarage Credits" - Rec."Bank Statement Avarage Debits";
                                    Rec."Utilizable Amount" := Rec."Bank Statement Avarage Credits" - Rec."Bank Statement Avarage Debits";
                                    Rec.Modify();
                                end else
                                    if (Rec."Recovery Mode" = Rec."Recovery Mode"::Salary) or (rec."Recovery Mode" = rec."Recovery Mode"::Pension) then begin
                                        GrossAmount := 0;
                                        loansTypes.get(Rec."Loan Product Type");
                                        loansTypes.TestField(loansTypes."Loan Appraisal %");
                                        SalPayments.Reset();
                                        SalPayments.SetRange(SalPayments."Member No", Rec."Client Code");
                                        SalPayments.SetFilter("Salary Type", '%1|%2', SalPayments."Salary Type"::Salary, SalPayments."Salary Type"::Pension);
                                        if SalPayments.FindLast() then begin
                                            Rec."Member Gross Salary" := SalPayments."Gross Amount";
                                            Rec."Third Percentage" := loansTypes."Loan Appraisal %";
                                            Rec."Basic Pay H" := SalPayments."Gross Amount";
                                            rec.Validate("Basic Pay H");
                                            Rec."Third Gross" := Round((loansTypes."Loan Appraisal %" * SalPayments."Gross Amount" / 100), 0.01, '>');
                                            Rec."Gross Pay" := SalPayments."Gross Amount";
                                            thirdGross := SalPayments."Gross Amount" - (Round((loansTypes."Loan Appraisal %" * SalPayments."Gross Amount" / 100), 0.01, '>'));
                                            Rec."Member Loans Deductions" := FnFetchLoanDeductions(Rec."Client Code");// + FnFetchSTODeductions(Rec."Client Code");
                                            Rec."Total DeductionsH" := FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code");
                                            Rec."Sacco Deductions" := FnFetchSTODeductions(Rec."Client Code");
                                            Rec."Member Offets" := FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.");
                                            Rec."Member Ability" := (Rec."Third Gross" + Rec."Other Income" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code") + 144) + rec."T-Kash";
                                            Rec."Utilizable Amount" := (Rec."Third Gross" + Rec."Other Income" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code") + 144) + rec."T-Kash";
                                            if LoanType.Get(Rec."Loan Product Type") then begin
                                                rec."15% on Karibu" := (LoanType."% Share Capitalization" / 100) * rec."Approved Amount";
                                                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin

                                                    Rec.Repayment := ROUND((LoanType."Interest rate" / 12 / 100) / (1 - Power((1 + (LoanType."Interest rate" / 12 / 100)), -(Rec.Installments))) * (Rec."Requested Amount"), 0.0001, '>'); //- ROUND(Rec."Requested Amount" / 100 / 12 * LoanType."Interest rate", 0.0001, '>');

                                                    //  Message('Outstanding%1Int%2', LoansRegister."Outstanding Balance", LoanType."Interest rate");
                                                end;
                                                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                                    if LoansRegister.Installments > 12 then
                                                        Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / 1200, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=')
                                                    else
                                                        //  Message('Req%1Int%2Insta%3', Rec."Requested Amount", LoanType."Interest rate", Rec.Installments);
                                                        Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / Rec.Installments / 100, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                                end;

                                                if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Straight Line" then begin
                                                    Rec.Repayment := (LoanType."Interest rate" / 12 / 100) * Rec."Requested Amount" / Rec.Installments + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                                end;
                                            end;
                                            Rec.Modify();
                                            Message('Salary Details Updated Successfully');
                                        end else begin
                                            Error('Salary Details Not Found');
                                        end;
                                    end else if Rec."Recovery Mode" = Rec."Recovery Mode"::Checkoff then begin
                                        GenSetUp.Get();
                                        twothirds := 0;
                                        GrossPay := rec."Basic Pay H" + Rec."House AllowanceH" + rec."Other Income" + rec."Transport Allowance";
                                        rec."Gross Pay" := GrossPay;//rec."Gross Pay";
                                        TaxablePay := 0;
                                        PayeAmount := 0;
                                        TaxablePay := GrossPay - Rec."Tax Exempt Deductions";

                                        PayeAmount := ROUND((UpdatePaye.fnGetEmployeePaye(TaxablePay)));
                                        //Message('Tax%1Gross%2Taxable%3OtherTaxrelief%4Payee%5', Rec."Tax Exempt Deductions", GrossPay, TaxablePay, Rec."Other Tax Relief", PayeAmount);
                                        rec.PAYE := PayeAmount - Rec."Other Tax Relief" - 2400;
                                        rec."Housing Levy" := 1.5 * GrossPay / 100;
                                        rec.NSSF := 1080;
                                        Rec.NHIF := round((UpdatePaye.fnGetEmployeeNHIF(GrossPay)), 1, '>');
                                        rec.Modify;

                                        rec.CalcFields(rec."Bridge Amount Release");

                                        rec."Chargeable Pay" := rec."Gross Pay" + rec."Other Tax Relief" - rec."Provident Fund" - rec."Pension Scheme" - rec.NSSF;

                                        twothirds := (rec."Basic Pay H") * 2 / 3;
                                        Rec.TwoThirds := twothirds;

                                        loanDeductions := FnFetchLoanDeductions(rec."Client Code");
                                        loanOffsets := FnFetchOffsetDeductions(rec."Client Code", rec."Loan  No.");
                                        stoDeductions := FnFetchSTODeductions(rec."Client Code");
                                        rec."Member Loans Deductions" := loanDeductions;
                                        rec."Sacco Deductions" := stoDeductions;
                                        rec."Member Offets" := loanOffsets;
                                        rec.modify;
                                        TotalDeductions := Rec."Monthly Contribution" + rec.NHIF + rec.NSSF + loanDeductions + Rec."Other Liabilities" + rec.PAYE + rec."Housing Levy" + rec."Other Tax Relief" + 300;

                                        if LoanType.Get(Rec."Loan Product Type") then begin
                                            rec."15% on Karibu" := (LoanType."% Share Capitalization" / 100) * rec."Approved Amount";
                                            if LoanType."Exempt Interest" = false then begin
                                                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                                                    Rec.Repayment := ROUND((LoanType."Interest rate" / 12 / 100) / (1 - Power((1 + (LoanType."Interest rate" / 12 / 100)), -(Rec.Installments))) * (Rec."Requested Amount"), 0.0001, '>'); //- ROUND(Rec."Requested Amount" / 100 / 12 * LoanType."Interest rate", 0.0001, '>');
                                                                                                                                                                                                                                           //  Message('Outstanding%1Int%2', LoansRegister."Outstanding Balance", LoanType."Interest rate");
                                                end;
                                                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                                    if LoansRegister.Installments > 12 then
                                                        Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / 1200, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=')
                                                    else
                                                        //  Message('Req%1Int%2Insta%3', Rec."Requested Amount", LoanType."Interest rate", Rec.Installments);
                                                        Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / Rec.Installments / 100, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                                end;

                                                if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Straight Line" then begin
                                                    Rec.Repayment := (LoanType."Interest rate" / 12 / 100) * Rec."Requested Amount" / Rec.Installments + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                                end;
                                            end else begin
                                                rec.Repayment := Round((rec."Requested Amount" / rec.Installments), 0.001, '>');
                                            end;

                                        end;
                                        //TotalDeductions := TotalDeductions + Rec.Repayment;
                                        // Message('TOtalDed%1ToThir%2', TotalDeductions, twothirds);

                                        NetUtilizable := ROUND(((twothirds + loanOffsets) - TotalDeductions), 0.01, '=');
                                        rec."Utilizable Amount" := NetUtilizable + rec."T-Kash";
                                        rec."Total DeductionsH" := TotalDeductions;
                                        rec.Modify;
                                    end;
                                Message('Salary Details Have Been Updated.');
                            end;
                        end;

                        if rec."Is PCK Salary?" = true then begin
                            if (Rec."Recovery Mode" = Rec."Recovery Mode"::Salary) or (rec."Recovery Mode" = rec."Recovery Mode"::Pension) then begin
                                GrossAmount := 0;
                                loansTypes.get(Rec."Loan Product Type");
                                loansTypes.TestField(loansTypes."Loan Appraisal %");
                                SalPayments.Reset();
                                SalPayments.SetRange(SalPayments."Member No", Rec."Client Code");
                                SalPayments.SetRange("Salary Type", SalPayments."Salary Type"::Salary);
                                if SalPayments.FindLast() then begin
                                    Rec."Member Gross Salary" := SalPayments."Gross Amount";
                                    Rec."Third Percentage" := loansTypes."Loan Appraisal %";
                                    Rec."Basic Pay H" := SalPayments."Gross Amount";
                                    Rec.Validate("Basic Pay H");
                                    Rec."Third Gross" := Round((loansTypes."Loan Appraisal %" * SalPayments."Gross Amount" / 100), 0.01, '>');
                                    thirdGross := SalPayments."Gross Amount" - (Round((loansTypes."Loan Appraisal %" * SalPayments."Gross Amount" / 100), 0.01, '>'));
                                    Rec."Gross Pay" := SalPayments."Gross Amount";
                                    Rec."Member Loans Deductions" := FnFetchLoanDeductions(Rec."Client Code");// + FnFetchSTODeductions(Rec."Client Code");
                                    Rec."Sacco Deductions" := FnFetchSTODeductions(Rec."Client Code");
                                    rec."Total DeductionsH" := FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code");
                                    Rec."Member Offets" := FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.");
                                    Rec."Member Ability" := (Rec."Third Gross" + Rec."Other Income" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code") + 144);
                                    Rec."Utilizable Amount" := (Rec."Third Gross" + Rec."Other Income" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code") + 144);

                                    if LoanType.Get(Rec."Loan Product Type") then begin
                                        rec."15% on Karibu" := (LoanType."% Share Capitalization" / 100) * rec."Approved Amount";
                                    end;
                                    Rec.Modify();
                                    Message('Salary Details Updated Successfully');
                                end else begin
                                    Error('Salary Details Not Found');
                                end;
                            end;

                            if Rec."Recovery Mode" = Rec."Recovery Mode"::Checkoff then begin
                                GenSetUp.Get();
                                twothirds := 0;
                                GrossPay := rec."Basic Pay H" + Rec."House AllowanceH" + rec."Other Income" + rec."Transport Allowance";
                                rec."Gross Pay" := GrossPay;//rec."Gross Pay";
                                TaxablePay := 0;
                                PayeAmount := 0;
                                TaxablePay := GrossPay - Rec."Tax Exempt Deductions";

                                PayeAmount := ROUND((UpdatePaye.fnGetEmployeePaye(TaxablePay)));
                                //Message('Tax%1Gross%2Taxable%3OtherTaxrelief%4Payee%5', Rec."Tax Exempt Deductions", GrossPay, TaxablePay, Rec."Other Tax Relief", PayeAmount);
                                rec.PAYE := PayeAmount - Rec."Other Tax Relief";
                                rec."Housing Levy" := 1.5 * GrossPay / 100;
                                rec.NSSF := 1080;
                                Rec.NHIF := round((UpdatePaye.fnGetEmployeeNHIF(GrossPay)), 1, '>');
                                rec.Modify;

                                rec.CalcFields(rec."Bridge Amount Release");

                                rec."Chargeable Pay" := rec."Gross Pay" + rec."Other Tax Relief" - rec."Provident Fund" - rec."Pension Scheme" - rec.NSSF;

                                twothirds := (rec."Basic Pay H") * 1 / 3;
                                Rec.TwoThirds := twothirds;

                                TotalDeductions := Rec."Monthly Contribution" + rec.NHIF + rec.NSSF + Rec."Sacco Deductions" + Rec."Other Liabilities" + rec.PAYE + twothirds;

                                if LoanType.Get(Rec."Loan Product Type") then begin
                                    rec."15% on Karibu" := (LoanType."% Share Capitalization" / 100) * rec."Approved Amount";
                                    if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin

                                        Rec.Repayment := ROUND((LoanType."Interest rate" / 12 / 100) / (1 - Power((1 + (LoanType."Interest rate" / 12 / 100)), -(Rec.Installments))) * (Rec."Requested Amount"), 0.0001, '>'); //- ROUND(Rec."Requested Amount" / 100 / 12 * LoanType."Interest rate", 0.0001, '>');

                                        //  Message('Outstanding%1Int%2', LoansRegister."Outstanding Balance", LoanType."Interest rate");
                                    end;
                                    if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                        if LoansRegister.Installments > 12 then
                                            Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / 1200, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=')
                                        else
                                            //  Message('Req%1Int%2Insta%3', Rec."Requested Amount", LoanType."Interest rate", Rec.Installments);
                                            Rec.Repayment := ROUND(Rec."Requested Amount" * LoanType."Interest rate" / Rec.Installments / 100, 1, '>') + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                    end;
                                    if LoansRegister."Repayment Method" = LoansRegister."repayment method"::"Straight Line" then begin
                                        Rec.Repayment := (LoanType."Interest rate" / 12 / 100) * Rec."Requested Amount" / Rec.Installments + Round((Rec."Requested Amount" / Rec.Installments), 0.01, '=');
                                    end;
                                end;
                                //TotalDeductions := TotalDeductions + Rec.Repayment;
                                // Message('TOtalDed%1ToThir%2', TotalDeductions, twothirds);

                                NetUtilizable := ROUND((GrossPay - TotalDeductions), 0.01, '=');
                                rec."Utilizable Amount" := NetUtilizable;
                                rec."Total DeductionsH" := TotalDeductions;
                                rec.Modify;
                            end;
                            Message('Salary Details Have Been Updated.');
                        end;
                    end;

                }
                action("Submit for legal review")
                {
                    Caption = 'Submit for Legal Review';
                    //Enabled = CanCancelApprovalForRecord;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    //Visible=false;

                    trigger OnAction()
                    var
                        TotalL: decimal;
                        LoansGuaranteeDetails: Record "Loans Guarantee Details";
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        if Confirm('Are you sure you want to submit this form for legal review?', false) = true then begin
                            rec."Loan Status" := rec."loan status"::"Legal";
                            rec."Approval Status" := rec."approval status"::Approved;

                            rec.Modify;
                            CurrPage.Close();
                            // FnSendGuarantorAppSMS(Rec."Loan  No.", Rec."Client Code");
                        end;
                    end;
                }
                action("Update Salary")
                {
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        loansregister: Record "Loans Register";
                        loansTypes: Record "Loan Products Setup";
                        SalPayments: Record "Salary Details";
                        Schedule: Record "Loan Repayment Schedule";
                        GrossAmount: Decimal;
                        ThirdAmount: Decimal;
                    begin
                        GrossAmount := 0;
                        loansTypes.get(Rec."Loan Product Type");
                        loansTypes.TestField(loansTypes."Loan Appraisal %");
                        SalPayments.Reset();
                        SalPayments.SetRange(SalPayments."Member No", Rec."Client Code");
                        if SalPayments.FindLast() then begin
                            Rec."Member Gross Salary" := SalPayments."Gross Amount";
                            Rec."Third Percentage" := loansTypes."Loan Appraisal %";
                            Rec."Third Gross" := Round((loansTypes."Loan Appraisal %" * SalPayments."Gross Amount" / 100), 0.01, '>');
                            Rec."Member Loans Deductions" := FnFetchLoanDeductions(Rec."Client Code");
                            Rec."Member Offets" := FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.");
                            Rec."Member Ability" := (Rec."Third Gross" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - FnFetchLoanDeductions(Rec."Client Code");
                            Rec.Modify();
                            Message('Salary Details Updated Successfully');
                        end else begin
                            Error('Salary Details Not Found');
                        end;

                    end;
                }

                action("View Loan Schedule")
                {
                    Caption = 'View Schedule';
                    Image = "Table";
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        SFactory.FnGenerateLoanRepaymentSchedule(rec."Loan  No.");
                        LoanApp.reset;
                        LoanApp.SetRange(loanapp."Loan  No.", Rec."Loan  No.");
                        if loanapp.Find('-') then begin
                            Report.Run(80014, true, false, LoanApp);
                        end
                    end;

                }

                action("Account Statement Transactions ")
                {
                    Image = Form;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Statement Buffe";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }
                action("Member Deposit Saving History")
                {
                    Image = Form;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Deposit Saving History";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }
                action("Load Account Statement Details")
                {
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    begin
                        //Clear Buffer
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        if ObjStatementB.FindSet then begin
                            ObjStatementB.DeleteAll;
                        end;



                        //Initialize Variables
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        GenSetUp.Get();

                        //Month 1
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth1Date := Date2dmy(StatementStartDate, 1);
                        VerMonth1Month := Date2dmy(StatementStartDate, 2);
                        VerMonth1Year := Date2dmy(StatementStartDate, 3);


                        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
                        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

                        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth1EndDate;
                            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
                            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
                            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;


                        //Month 2
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth2Date := Date2dmy(StatementStartDate, 1);
                        VerMonth2Month := (VerMonth1Month + 1);
                        VerMonth2Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth2Month > 12 then begin
                            VerMonth2Month := VerMonth2Month - 12;
                            VerMonth2Year := VerMonth2Year + 1;
                        end;

                        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
                        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
                        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth2EndDate;
                            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
                            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
                            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;

                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        //Month 3
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth3Date := Date2dmy(StatementStartDate, 1);
                        VerMonth3Month := (VerMonth1Month + 2);
                        VerMonth3Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth3Month > 12 then begin
                            VerMonth3Month := VerMonth3Month - 12;
                            VerMonth3Year := VerMonth3Year + 1;
                        end;

                        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
                        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
                        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth3EndDate;
                            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
                            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
                            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 4
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth4Date := Date2dmy(StatementStartDate, 1);
                        VerMonth4Month := (VerMonth1Month + 3);
                        VerMonth4Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth4Month > 12 then begin
                            VerMonth4Month := VerMonth4Month - 12;
                            VerMonth4Year := VerMonth4Year + 1;
                        end;

                        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
                        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
                        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth4EndDate;
                            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
                            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
                            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 5
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth5Date := Date2dmy(StatementStartDate, 1);
                        VerMonth5Month := (VerMonth1Month + 4);
                        VerMonth5Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth5Month > 12 then begin
                            VerMonth5Month := VerMonth5Month - 12;
                            VerMonth5Year := VerMonth5Year + 1;
                        end;

                        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
                        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
                        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth5EndDate;
                            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
                            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
                            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 6
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth6Date := Date2dmy(StatementStartDate, 1);
                        VerMonth6Month := (VerMonth1Month + 5);
                        VerMonth6Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth6Month > 12 then begin
                            VerMonth6Month := VerMonth6Month - 12;
                            VerMonth6Year := VerMonth6Year + 1;
                        end;

                        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
                        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
                        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat

                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth6EndDate;
                            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
                            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
                            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;

                        VerStatementAvCredits := 0;
                        //Get Statement Avarage Credits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementAvCredits := VerStatementAvCredits + ObjStatementB."Amount In";
                                rec."Bank Statement Avarage Credits" := VerStatementAvCredits / 6;
                                rec.Modify;
                            until ObjStatementB.Next = 0;
                        end;

                        VerStatementsAvDebits := 0;
                        //Get Statement Avarage Debits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementsAvDebits := VerStatementsAvDebits + ObjStatementB."Amount Out";
                                rec."Bank Statement Avarage Debits" := VerStatementsAvDebits / 6;
                                rec.Modify;
                            until ObjStatementB.Next = 0;
                        end;

                        rec."Bank Statement Net Income" := rec."Bank Statement Avarage Credits" - rec."Bank Statement Avarage Debits";
                        rec.Modify;
                    end;
                }
                action("House Group Statement")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    begin
                        ObjMemberCellG.Reset;
                        ObjMemberCellG.SetRange(ObjMemberCellG."Cell Group Code", Rec."Member House Group");
                        Report.Run(172920, true, false, ObjMemberCellG);
                    end;
                }
                action("Loans Top Up")
                {
                    Caption = 'Loans Top Up';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("&Card")
                {
                    Caption = 'Member Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = FIELD("Client Code");
                    ShortCutKey = 'Shift+F7';

                }
                action("Posted Loan List")
                {
                    Caption = 'Posted Loan List';
                    Image = EditLines;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loans Posted List";
                    RunPageLink = "Client Code" = FIELD("Client Code");
                    ShortCutKey = 'Shift+F7';

                }

                action("Send Approval Request")
                {
                    Caption = 'Send A&pproval Request';
                    //Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    // Visible = false;
                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        Text010: label 'Kindly state the reason for inputting the additional income.';
                        /// ApprovalMgt: Codeunit "Approvals Mgmt.";
                        Workflowintegration: Codeunit WorkflowIntegration;
                    begin

                        // Cust.Reset();
                        // Cust.SetRange("No.", rec."Client Code");
                        // if Cust.Find('-') then begin
                        //     if cust.Status <> cust.Status::Active then Error('The member account should be active.');
                        // end;

                        if rec."Approved Amount" = 0 then Error('Kindly appraise your loan application before sending an approval request.');

                        rec.TestField(rec."Loan Product Type");
                        rec.TestField("Requested Amount");

                        if rec."Approval Status" <> rec."approval status"::Open then Error(Text001);
                        if (Rec."Other Income" > 0) and (Rec."Reason for Other Income" = '') then Error(Text010);
                        //End allocate batch number
                        Doc_Type := Doc_type::LoanApplication;
                        Table_id := Database::"Loans Register";



                        if Workflowintegration.CheckLoanAppliedApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnSendLoanAppliedForApproval(Rec);

                        Audit.FnInsertAuditRecords(UserId, 'Loan Approval', Rec."Approved Amount", Rec."Loan  No.", today, time, '', Rec."Loan  No.", Rec."Client Code", '');
                        //ENSURE THAT REQUESTED AMOUNT IS ENTERED

                        CurrPage.Close;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    var
                        Workflowintegration: Codeunit WorkflowIntegration;
                    begin
                        if rec."Approval Status" <> rec."Approval Status"::Pending then Error('The loan''s approval status is %1.', rec."Approval Status");
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            Workflowintegration.OnCancelLoanAppliedApprovalRequest(Rec);
                        end;
                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                    ///ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::LoanApplication;
                        ///ApprovalEntries.Setfilters(Database::"Loans Register", DocumentType,Rec."Loan  No.");
                       // ApprovalEntries.Run;
                    end;
                }
                action("CRB Check Charge")
                {
                    Image = Calculate;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "CRB Check Charge List";
                    RunPageLink = "Member No" = field("Client Code"),
                                  "Loan No" = field("Loan  No.");
                }
                action("Archive Loan")
                {
                    Caption = 'Archive Loan';
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //  SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        LoanApp.reset;
                        LoanApp.SetRange(loanapp."Loan  No.", Rec."Loan  No.");
                        if loanapp.Find('-') then begin
                            LoanApp."Archive Loan" := true;
                            LoanApp.modify;
                            //Report.Run(80014, true, false, LoanApp);
                        end
                    end;
                }
                action(Reject)
                {
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    trigger OnAction()
                    begin
                        IF rec."Loan Status" <> rec."Loan Status"::Appraisal THEN
                            ERROR(Text001);

                        IF rec."Reason for Loan rejection" = '' THEN
                            ERROR('You must give a reason for rejecting the loan');

                        rec."Loan Status" := rec."Loan Status"::Rejected;
                        rec."Approval Status" := rec."Approval Status"::Rejected;
                        rec.MODIFY;
                        MESSAGE('Loan rejection successful');

                        //SMS MESSAGE

                        SMSMessages.RESET;
                        IF SMSMessages.FIND('+') THEN BEGIN
                            iEntryNo := SMSMessages."Entry No";
                            iEntryNo := iEntryNo + 1;
                        END
                        ELSE BEGIN
                            iEntryNo := 1;
                        END;

                        SMSMessages.RESET;
                        SMSMessages.INIT;
                        SMSMessages."Entry No" := iEntryNo;
                        SMSMessages."Account No" := rec."Account No";
                        SMSMessages."Date Entered" := TODAY;
                        SMSMessages."Time Entered" := TIME;
                        SMSMessages.Source := 'LOAN APPL';
                        SMSMessages."Entered By" := USERID;
                        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                        SMSMessages."SMS Message" := 'Dear ' + rec."Client Name" + ', your ' + rec."Loan Product Type Name" + ' application of KSHs.' + format(rec."Requested Amount") +
                                                  ' has been rejected due to: ' + rec."Reason for loan rejection" + ' TELEPOST SACCO';
                        Cust.RESET;
                        IF Cust.GET(rec."Client Code") THEN
                            SMSMessages."Telephone No" := Cust."Phone No.";
                        SMSMessages.INSERT;

                    end;
                }
                action("Reject Loan Appraisal")
                {
                    Image = Reject;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Confirm Rejection?', false) = true then begin
                            rec."Intent to Reject" := true;

                            RejectionDetailsVisible := false;
                            if rec."Intent to Reject" = true then begin
                                RejectionDetailsVisible := true;
                            end;

                            if rec."Rejection  Remark" = '' then begin
                                Error('Specify the Rejection Remarks/Reason on the Rejection Details Tab');
                            end else
                                rec."Rejected By" := UserId;
                            rec."Date of Rejection" := WorkDate;
                            rec."Approval Status" := rec."approval status"::Rejected;
                            rec."Loan Status" := rec."loan status"::Rejected;

                            //=========================================================================================Loan Stages Common On All Applications
                            ObjLoanStages.Reset;
                            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::Declined);
                            ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
                            if ObjLoanStages.FindSet then begin
                                repeat
                                    ObjLoanApplicationStages.Init;
                                    ObjLoanApplicationStages."Loan No" := rec."Loan  No.";
                                    ObjLoanApplicationStages."Member No" := rec."Client Code";
                                    ObjLoanApplicationStages."Member Name" := rec."Client Name";
                                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                                    ObjLoanApplicationStages."Stage Status" := ObjLoanApplicationStages."stage status"::Succesful;
                                    ObjLoanApplicationStages."Updated By" := UserId;
                                    ObjLoanApplicationStages."Date Upated" := WorkDate;
                                    ObjLoanApplicationStages.Insert;
                                until ObjLoanStages.Next = 0;
                            end;

                        end;
                        CurrPage.Close;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        EnableCreateMember := false;
        EditableAction := true;
        FnVisibility();
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        //CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = rec."approval status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec."Approval Status" = rec."approval status"::Approved) then
            EnableCreateMember := true;

        if Rec."Approval Status" <> rec."approval status"::Open then
            EditableAction := false;
        if rec."Approval Status" = rec."approval status"::Pending then
            CanCancelApprovalForRecord := true; //to correct
    end;

    trigger OnAfterGetRecord()
    begin
        //rec.Source := rec.Source::BOSA;
        FnVisibility();

        TrunchDetailsVisible := false;

        if (rec."Disburesment Type" = rec."disburesment type"::"Full/Single disbursement") or (rec."Disburesment Type" = rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;

        If Rec."Committee Approval" = Rec."Committee Approval"::Approved then begin
            StyleExprTxt := 'Favorable'
        end

        else
            StyleExprTxt := 'Unfavorable';
        LoanSavingsVIsible := false;
        TopupVisible := false;
        individualVisible := false;
        CooporateVisible := false;
        JointVisible := false;

        if Rec."Loan Application Type" = Rec."Loan Application Type"::individual then
            individualVisible := true;
        if Rec."Loan Application Type" = Rec."Loan Application Type"::Corporate then
            CooporateVisible := true;
        if Rec."Loan Application Type" = Rec."Loan Application Type"::TopUp then
            TopupVisible := true;
        if Rec."Loan Application Type" = Rec."Loan Application Type"::"Loan Against Savings" then
            LoanSavingsVIsible := true;
        if Rec."Loan Application Type" = Rec."Loan Application Type"::Joint then
            JointVisible := true;


    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //rec.Source := rec.Source::BOSA;
        rec."Mode of Disbursement" := rec."mode of disbursement"::" ";
        rec.Discard := true;
        Rec."Mode Of Application" := Rec."Mode Of Application"::"Over The Counter";
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        if rec."Loan Status" = rec."loan status"::Disbursed then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        rec.SetRange(Posted, false);
        FnVisibility();
        TrunchDetailsVisible := false;

        if (rec."Disburesment Type" = rec."disburesment type"::"Full/Single disbursement") or (rec."Disburesment Type" = rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
        LoanSavingsVIsible := false;
        TopupVisible := false;
        individualVisible := false;
        CooporateVisible := false;
        JointVisible := false;

        if Rec."Loan Application Type" = Rec."Loan Application Type"::individual then
            individualVisible := true;
        if Rec."Loan Application Type" = Rec."Loan Application Type"::Corporate then
            CooporateVisible := true;
        if Rec."Loan Application Type" = Rec."Loan Application Type"::TopUp then
            TopupVisible := true;
        if Rec."Loan Application Type" = Rec."Loan Application Type"::"Loan Against Savings" then
            LoanSavingsVIsible := true;
        if Rec."Loan Application Type" = Rec."Loan Application Type"::Joint then
            JointVisible := true;
    end;


    var
        i: Integer;
        TopupVisible: Boolean;
        individualVisible: Boolean;
        LoanSavingsVIsible: Boolean;
        CooporateVisible: Boolean;
        JointVisible: Boolean;
        thirdGross: Decimal;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        LoanGuar: Record "Loan GuarantorsFOSA";
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        Vend1: Record Vendor;
        InstalmentEnddate: Date;
        SMSMessage: Record "SMS Messages";
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        SMSMessages: Record "SMS Messages";
        NoOfGracePeriod: Integer;
        iEntryNo: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        smsManagement: Codeunit "Sms Management";
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        RepaymentMent: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Register";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Offset Details";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loan GuarantorsFOSA";

        LGuarantorss: Record "Loans Guarantee Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        Interrest: Boolean;
        InterestSal: Decimal;
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        ReceiptAllocations: Record "HISA Allocation";
        ReceiptAllocation: Record "HISA Allocation";
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        loanDeductions: Decimal;
        loanOffsets: Decimal;
        stoDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        TAXABLEPAY: Record "PAYE Brackets Credit";
        PAYE: Decimal;
        PAYESUM: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        Taxrelief: Decimal;
        OTrelief: Decimal;
        Chargeable: Decimal;
        GrossPay: Decimal;
        FOSASet: Record "FOSA Guarantors Setup";
        MinGNo: Integer;
        ProvidedGuarantors: Integer;
        LoansRec: Record "Loans Register";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        EditableAction: Boolean;
        SFactory: Codeunit "Au Factory";
        PayslipDetailsVisible: Boolean;
        CheckoffDetailsVisible: Boolean;
        BankStatementDetailsVisible: Boolean;
        ObjProductCharge: Record "Loan Product Charges";
        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
        ObjStatementB: Record "Loan Appraisal Statement Buffe";
        StatementStartDate: Date;
        StatementDateFilter: Date;
        StatementEndDate: Date;
        UpdatePaye: Codeunit "Payroll Processing";
        VerStatementAvCredits: Decimal;
        VerStatementsAvDebits: Decimal;
        VerMonth1Date: Integer;
        VerMonth1Month: Integer;
        VerMonth1Year: Integer;
        VerMonth1StartDate: Date;
        VerMonth1EndDate: Date;
        VerMonth1DebitAmount: Decimal;
        VerMonth1CreditAmount: Decimal;
        VerMonth2Date: Integer;
        VerMonth2Month: Integer;
        VerMonth2Year: Integer;
        VerMonth2StartDate: Date;
        VerMonth2EndDate: Date;
        VerMonth2DebitAmount: Decimal;
        VerMonth2CreditAmount: Decimal;
        VerMonth3Date: Integer;
        VerMonth3Month: Integer;
        VerMonth3Year: Integer;
        VerMonth3StartDate: Date;
        VerMonth3EndDate: Date;
        VerMonth3DebitAmount: Decimal;
        VerMonth3CreditAmount: Decimal;
        VerMonth4Date: Integer;
        VerMonth4Month: Integer;
        VerMonth4Year: Integer;
        VerMonth4StartDate: Date;
        VerMonth4EndDate: Date;
        VerMonth4DebitAmount: Decimal;
        VerMonth4CreditAmount: Decimal;

        CreationMessage: Text[2500];
        VerMonth5Date: Integer;
        VerMonth5Month: Integer;
        Audit: Codeunit "AU Audit Management";
        VerMonth5Year: Integer;
        VerMonth5StartDate: Date;
        VerMonth5EndDate: Date;
        VerMonth5DebitAmount: Decimal;
        VerMonth5CreditAmount: Decimal;
        VerMonth6Date: Integer;
        VerMonth6Month: Integer;
        VerMonth6Year: Integer;
        VerMonth6StartDate: Date;
        VerMonth6EndDate: Date;
        VerMonth6DebitAmount: Decimal;
        VerMonth6CreditAmount: Decimal;
        VarMonth1Datefilter: Text;
        VarMonth2Datefilter: Text;
        VarMonth3Datefilter: Text;
        VarMonth4Datefilter: Text;
        VarMonth5Datefilter: Text;
        VarMonth6Datefilter: Text;
        ObjMemberCellG: Record "Member House Groups";
        TrunchDetailsVisible: Boolean;
        AccountNoEditable: Boolean;
        Remarkseditable: Boolean;
        LoanPurposeEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        RejectionRemarkEditable: Boolean;
        RecoveryModeEditable: Boolean;
        StyleExpr: Text[2048];
        compinfo: Record "Company Information";
        Text001: label 'Status Must Be Open';
        LoanAppMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        SMSMessageText: label 'Your loan application of KSHs.%1 has been received and your qualification is KSHs.%2 The application is being processed.%3.';
        ErrorApproval: label 'Approved Amount of Zero or Less Can not be sent for Approval';
        RejectionDetailsVisible: Boolean;
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        ErrorPostingAccount: label 'Specify the Loan Disburesment Account';


    procedure UpdateControl()
    begin

        if rec."Approval Status" = rec."approval status"::Open then begin
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;

            LoanPurposeEditable := true;
            RecoveryModeEditable := true;
            Remarkseditable := true;
            LoanPurposeEditable := true;
            CopyofIDEditable := true;
            CopyofPayslipEditable := true;
            AccountNoEditable := true;
        end;

        if rec."Approval Status" = rec."approval status"::Pending then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
            CopyofIDEditable := false;
            CopyofPayslipEditable := false;
        end;

        if rec."Approval Status" = rec."approval status"::Rejected then begin
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
            CopyofIDEditable := false;
            CopyofPayslipEditable := false;
        end;

        if rec."Approval Status" = rec."approval status"::Approved then begin
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := rec."Batch No.";
        SMSMessage."Document No" := rec."Loan  No.";
        SMSMessage."Account No" := rec."Account No";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'LOANAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan of amount ' + Format(rec."Requested Amount") + ' for ' +
        rec."Client Code" + ' ' + rec."Client Name" + ' has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", Rec."Client Code");
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnSendReceivedLoanApplEmail(LoanNo: Code[20])
    var
        LoanRec: Record "Loans Register";
        //  SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Email: Text[50];
        Recipient: List of [Text];
    begin
        //  SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
                if Cust."E-Mail (Personal)" <> '' then begin
                    if Email = '' then begin
                        Error('Email Address Missing for LoanRecer Application number' + '-' + LoanRec."Loan  No.");
                    end;
                    // if Email <> '' then
                    //     Recipient.Add(Email);
                    // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Loan Application', '', true);
                    // SMTPMail.AppendBody(StrSubstNo(LoanAppMessage, LoanRec."Client Name", IDNo, UserId));
                    // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                    // SMTPMail.AppendBody('<br><br>');
                    // SMTPMail.AddAttachment(FileName, Attachment);
                    // SMTPMail.Send;
                end;
            end;
        end;
    end;

    local procedure FnSendGuarantorAppSMS(LoanNo: Code[20]; member: Code[20])
    var
        Cust: Record Customer;
        Sms: Record "SMS Messages";
        vend: Record Vendor;
        loanee: Code[20];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;

    begin
        vend.Reset();
        vend.SetRange("BOSA Account No", member);
        vend.SetRange("Account Type", '103');
        if vend.Find('-') then begin
            loanee := vend."No.";
        end;
        LGuarantorss.Reset;
        LGuarantorss.SetRange(LGuarantorss."Loan No", LoanNo);
        if LGuarantorss.FindFirst then begin
            repeat
                Cust.Reset();
                Cust.SetRange(Cust."No.", LGuarantorss."Member No");
                Cust.SetFilter(Cust."Mobile Phone No", '<>%1', '');
                if Cust.FindFirst() then begin
                    if LoansRec.Get(LGuarantorss."Loan No") then begin
                        CreationMessage := 'Dear ' + Cust.Name + ' , You have been listed to guarantee KES ' + Format(LGuarantorss."Amont Guaranteed") + ' to ' + LGuarantorss."Loanees  Name" + ' ' + LoansRec."Loan Product Type" + ' of amount ' + format(LoansRec."Requested Amount") + '. Dial *720# or use our Mobile APP to Accept or Reject.';
                        //smsManagement.SendSmsResponse(Cust."Mobile Phone No", CreationMessage);
                        smsManagement.SendSmsWithID(Source::LOAN_GUARANTORS, Cust."Mobile Phone No", CreationMessage, Loanee, Loanee, TRUE, 200, TRUE, 'CBS', CreateGuid(), 'CBS');
                    end;
                end;
            until LGuarantorss.Next = 0;

        end
    end;

    local procedure FnFetchLoanDeductions(ClientCode: Code[20]) TotalLoans: Decimal
    var
        Loans: Record "Loans Register";
        LoanSchedule: Record "Loan Repayment Schedule";
        RemainingBal: Decimal;
        LoanProducts: Record "Loan Products Setup";
    begin
        TotalLoans := 0;
        RemainingBal := 0;

        Cust.Reset();
        if Cust.Get(ClientCode) then begin
            if Cust."Employer Code" = 'STAFF' then begin
                Loans.Reset();
                Loans.SetRange(Loans."Client Code", ClientCode);
                Loans.SetAutoCalcFields(Loans."Total Outstanding Balance");
                Loans.SetFilter(Loans."Total Outstanding Balance", '>%1', 0);
                if Loans.FindFirst() then begin
                    repeat
                        Loans.CalcFields("Outstanding Balance");
                        LoanProducts.Get(Loans."Loan Product Type");
                        if LoanProducts."Recovery Mode" <> LoanProducts."Recovery Mode"::Mobile then begin
                            LoanSchedule.reset;
                            LoanSchedule.SetRange(LoanSchedule."Loan No.", Loans."Loan  No.");
                            if LoanSchedule.FindFirst() then begin
                                TotalLoans := TotalLoans + LoanSchedule."Monthly Repayment";

                                if LoanSchedule."Monthly Repayment" > Loans."Outstanding Balance" then
                                    RemainingBal := LoanSchedule."Monthly Repayment" - Loans."Outstanding Balance";
                            end;
                            //Message('remaining%1LoansSchedule%2OutstandingLoan%3',RemainingBal,LoanSchedule."Monthly Repayment",Loans."Outstanding Balance");
                            TotalLoans := TotalLoans - RemainingBal;
                        end;
                    until loans.Next() = 0;
                end;
            end else begin
                Loans.Reset();
                Loans.SetRange(Loans."Client Code", ClientCode);
                Loans.SetAutoCalcFields(Loans."Total Outstanding Balance");
                // Loans.SetFilter("Recovery Mode", '=%1|%2',Loans."Recovery Mode"::Salary, Loans."Recovery Mode"::Pension);
                Loans.SetFilter(Loans."Total Outstanding Balance", '>%1', 0);
                if Loans.FindFirst() then begin
                    repeat
                        RemainingBal := 0;
                        LoanProducts.Get(Loans."Loan Product Type");
                        if LoanProducts."Recovery Mode" <> LoanProducts."Recovery Mode"::Mobile then begin
                            LoanSchedule.Reset;
                            LoanSchedule.SetRange(LoanSchedule."Loan No.", Loans."Loan  No.");
                            if LoanSchedule.FindFirst() then begin
                                TotalLoans := TotalLoans + LoanSchedule."Monthly Repayment";

                                if LoanSchedule."Monthly Repayment" > Loans."Total Outstanding Balance" then
                                    RemainingBal := LoanSchedule."Monthly Repayment" - Loans."Outstanding Balance";
                            end;
                            //Message('remaining%1LoansSchedule%2OutstandingLoan%3',RemainingBal,LoanSchedule."Monthly Repayment",Loans."Outstanding Balance");
                            TotalLoans := TotalLoans - RemainingBal;
                        end;
                    until loans.Next() = 0;
                end;
            end;
        end;
    end;

    local procedure FnFetchSTODeductions(ClientCode: Code[20]) STO: Decimal
    var
        Loans: Record "Loans Register";
        LoanSchedule: Record "Loan Repayment Schedule";
        STORegister: Record "Standing Orders";
        Ven: Record Vendor;
        RecieptAll: Record "Receipt Allocation";
        standingOrder: Decimal;
    begin
        Ven.Reset();
        Ven.SetRange("BOSA Account No", ClientCode);
        Ven.SetRange(Ven."Account Type", '103');
        if Ven.FindFirst() then begin
            STO := 0;
            standingOrder := 0;
            STORegister.Reset();
            STORegister.SetRange(STORegister."Is Active", true);
            STORegister.SetRange(STORegister.Status, STORegister.Status::Approved);
            STORegister.SetRange(STORegister."Source Account No.", Ven."No.");
            if STORegister.Find('-') then begin
                repeat
                    RecieptAll.reset;
                    RecieptAll.Setrange(RecieptAll."Document No", STORegister."No.");
                    if RecieptAll.Findset then begin
                        RecieptAll.CalcSums(RecieptAll.Amount);
                        standingOrder := RecieptAll.Amount;
                    end;
                    STO := standingOrder + STO;
                until STORegister.Next() = 0;
            end;
        end;
    end;

    local procedure FnFetchOffsetDeductions(ClientCode: Code[20]; LoanNo: Code[20]) TotalOffsets: Decimal
    var
        Loans: Record "Loan Offset Details";
        LoanSchedule: Record "Loan Repayment Schedule";
    begin
        TotalOffsets := 0;
        Loans.Reset();
        Loans.SetRange(Loans."Client Code", ClientCode);
        Loans.SetRange(Loans."Loan No.", LoanNo);
        Loans.SetFilter(Loans."Loan Type", '<>%1', 'A03');
        if Loans.FindFirst() then begin
            repeat
                LoanSchedule.reset;
                LoanSchedule.SetRange(LoanSchedule."Loan No.", Loans."Loan Top Up");
                if LoanSchedule.FindFirst() then begin
                    TotalOffsets := TotalOffsets + LoanSchedule."Monthly Repayment";
                end;
            until loans.Next() = 0;
        end;
    end;

    local procedure FnVisibility()
    begin
        PayslipDetailsVisible := false;
        BankStatementDetailsVisible := false;
        CheckoffDetailsVisible := false;

        if rec."Recovery Mode" = rec."Recovery Mode"::Checkoff then begin
            BankStatementDetailsVisible := false;
            PayslipDetailsVisible := false;
            CheckoffDetailsVisible := true;
        end else
            if (rec."Recovery Mode" = rec."Recovery Mode"::Salary) or (rec."Recovery Mode" = rec."Recovery Mode"::Pension) then begin
                BankStatementDetailsVisible := false;
                PayslipDetailsVisible := true;
                CheckoffDetailsVisible := false;
            end else
                if rec."Income Type" = rec."income type"::"Payslip & Bank Statement" then begin
                    PayslipDetailsVisible := true;
                    BankStatementDetailsVisible := true;
                end;
    end;

    local procedure FnRunCreateLoanStages()
    var
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoanCollateral: Record "Loan Collateral Details";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange("Loan No", Rec."Loan  No.");
        if ObjLoanApplicationStages.FindSet then begin
            ObjLoanApplicationStages.DeleteAll;
        end;

        //=========================================================================================Loan Stages Based On Amount
        ObjLoanStages.Reset;
        ObjLoanStages.SetRange("Mobile App Specific", false);
        if ObjLoanStages.Find('-') then begin
            repeat
                if (rec."Requested Amount" >= ObjLoanStages."Min Loan Amount") and (rec."Requested Amount" <= ObjLoanStages."Max Loan Amount") then begin

                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                end;
            until ObjLoanStages.Next = 0;
        end;

        //=========================================================================================Loan Stages Based On Group Guarantorship
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", Rec."Loan  No.");
        if ObjLoanGuarantors.Find('-') = true then begin
            if rec."Member House Group" <> '' then begin
                ObjLoanStages.Reset;
                ObjLoanStages.SetRange("Mobile App Specific", false);
                ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::"Group Guarantorship");
                if ObjLoanStages.FindSet then begin
                    repeat
                        ObjLoanApplicationStages.Init;
                        ObjLoanApplicationStages."Loan No" := rec."Loan  No.";
                        ObjLoanApplicationStages."Member No" := rec."Client Code";
                        ObjLoanApplicationStages."Member Name" := rec."Client Name";
                        ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                        ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                        ObjLoanApplicationStages.Insert;
                    until ObjLoanStages.Next = 0;
                end;
            end;
        end;

        //=========================================================================================Loan Stages Based On Collateral Security
        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Loan No", Rec."Loan  No.");
        if ObjLoanCollateral.Find('-') = true then begin

            ObjLoanStages.Reset;
            ObjLoanStages.SetRange("Mobile App Specific", false);
            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::"Collateral Security");
            if ObjLoanStages.FindSet then begin
                repeat
                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                until ObjLoanStages.Next = 0;
            end;
        end;

        //=========================================================================================Loan Stages Common On All Applications
        ObjLoanStages.Reset;
        ObjLoanStages.SetRange("Mobile App Specific", false);
        ObjLoanStages.SetFilter("Loan Purpose", '=%1', '');
        ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::All);
        ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
        if ObjLoanStages.FindSet then begin
            repeat
                ObjLoanApplicationStages.Init;
                ObjLoanApplicationStages."Loan No" := rec."Loan  No.";
                ObjLoanApplicationStages."Member No" := rec."Client Code";
                ObjLoanApplicationStages."Member Name" := rec."Client Name";
                ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                ObjLoanApplicationStages.Insert;
            until ObjLoanStages.Next = 0;
        end;

        //=========================================================================================Loan Stages Based On Education Finance
        if rec."Loan Purpose" <> '' then begin
            ObjLoanStages.Reset;
            ObjLoanStages.SetRange("Mobile App Specific", false);
            ObjLoanStages.SetFilter("Loan Purpose", '<>%1', '');
            ObjLoanStages.SetRange(ObjLoanStages."Loan Purpose", Rec."Loan Purpose");
            if ObjLoanStages.FindSet then begin
                repeat
                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                until ObjLoanStages.Next = 0;
            end;
        end;
    end;

    local procedure FnCheckIfGuarantorsMet(LoanNo: Code[60]; ClientCode: Code[60]; RequestedAmount: Decimal)
    var
        Guarantors: Record "Loans Guarantee Details";
        collDetails: Record "Loan Collateral Details";
        totalGuaranteed: Decimal;
        totalCollateral: Decimal;
        totalSecurity: Decimal;
    begin
        totalGuaranteed := 0;
        totalCollateral := 0;
        totalSecurity := 0;

        Guarantors.Reset();
        Guarantors.SetRange(Guarantors."Loan No", LoanNo);
        Guarantors.SetRange(Guarantors."Loanees  No", ClientCode);
        Guarantors.SetRange(Guarantors.Substituted, false);
        if Guarantors.FindSet() then begin
            Guarantors.CalcSums(Guarantors."Amont Guaranteed");
            totalGuaranteed := Guarantors."Amont Guaranteed";
        end;

        collDetails.Reset();
        collDetails.SetRange("Loan No", LoanNo);
        collDetails.SetRange("Member No", ClientCode);
        if collDetails.FindSet() then begin
            collDetails.CalcSums("Guarantee Value");
            totalCollateral := collDetails."Guarantee Value";
        end;

        // if RequestedAmount > totalGuaranteed then begin
        //     Error('Guaranteed amount should be equal to requested amount');
        // end;

        totalSecurity := totalGuaranteed + totalCollateral;
        if totalSecurity < RequestedAmount then Error('Kindly fill the deficit guarantors or collateral.');
    end;

    procedure StyleExpession() StyleExprTxt: Text[20];
    var
        myInt: Integer;

    begin
        If Rec."Committee Approval" = Rec."Committee Approval"::Approved then begin
            StyleExprTxt := 'Favorable'
        end

        else
            StyleExprTxt := 'Unfavorable';

        exit(StyleExprTxt);
    end;

    var
        StyleExprTxt: Text;

}




