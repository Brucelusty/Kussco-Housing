//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50111 "Loan Application Card(BOSA)"
{
    ApplicationArea = All;
    Caption = 'Loan Application Card';
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(
                            Posted = const(false));

    layout
    {//
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; Rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Loan Application Mode"; Rec."Loan Application Mode")
                {
                    Visible = false;
                    // trigger OnValidate()
                    // var
                    //     ProductSetUp: Record "Loan Products Setup";
                    //     RegisterLoan: Record "Loans Register";
                    // begin
                    //     RegisterLoan.Reset();
                    //     RegisterLoan.setFilter("Loan Application Mode", '<>%1',RegisterLoan."Loan Application Mode"::WalkIn);
                    //     if RegisterLoan.find('-') then
                    //     begin
                    //     repeat
                    //         ProductSetUp."Walkin Application Source" := true;
                    //     until RegisterLoan.Next() = 0;                               
                    //      end;
                    // end;
                }
                field("Source."; Rec."Source.")
                {
                    Editable = true;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member';
                    Editable = MNoEditable;
                }
                field("Account No"; Rec."Account No") { ShowMandatory = true; Visible = false; }
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
                    Caption = 'Member Deposits';
                }
                field("Boost this Loan"; Rec."Boost this Loan") { visible = false; }
                field("Boosted Amount"; Rec."Boosted Amount") { Caption = 'Deposit Boosting Amount'; visible = false; }
                field("Boosting Commision"; Rec."Boosting Commision") { visible = false; }
                field("Share Capital Boosting"; Rec."Share Capital Boosting") { visible = false; }
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
                }
                field("Private Member"; Rec."Private Member")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Application Date"; Rec."Application Date")
                {
                    //Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    // Editable = LProdTypeEditable;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    Caption = 'Product Name';
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
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
                field("Loan Deposit Multiplier"; Rec."Loan Deposit Multiplier") { Visible = false; }
                field("Guarantorship Multiplier"; Rec."Guarantorship Multiplier") { Editable = false; Visible = false; }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    Caption = 'Amount Applied';
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
                    Visible = false;
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
                field("SubSector Name"; Rec."SubSector Name") { Editable = false; Caption = 'Sub Sector Name'; Visible = false; }


                field("Sector Specific"; Rec."Sector Specific")
                {
                    ShowMandatory = true;
                    caption = 'Specific Sector';
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
                    //Visible = false;
                }
                field("Statement Account"; Rec."Statement Account")
                {
                    Visible = false;
                }
                field("Received Copy Of ID"; Rec."Received Copy Of ID")
                {
                    //Editable = CopyofIDEditable;
                    Visible = false;
                }
                field("Received Payslip/Bank Statemen"; Rec."Received Payslip/Bank Statemen")
                {
                    Visible = false;
                    // Editable = CopyofPayslipEditable;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    Editable = false;
                    Importance = Additional;
                    //Visible = false;
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
                    Visible = false;
                    Importance = Additional;
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
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    Editable = true;
                    visible = false;
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
                    visible = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    Editable = false;
                    Importance = Additional;
                    visible = false;
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
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ShowMandatory = true;
                    //Editable = RecoveryModeEditable;
                    Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                }
                field("Mortgage Officer"; Rec."Mortgage Officer")
                {

                }
                field("Loan Application Type"; Rec."Loan Application Type")
                {

                }
                field("Rejection  Remark"; Rec."Rejection  Remark")
                {
                    Visible = false;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    Visible = false;
                }
                field("Date of Rejection"; Rec."Date of Rejection")
                {
                    Caption = 'Rejection Date';
                    Visible = false;
                }
                field("Reason for Loan Re-open"; Rec."Reason for Loan Re-open")
                {
                    Visible = false;
                }
                field("Guarantor Remarks-Appraisal"; Rec."Guarantor Remarks-Appraisal") { Visible = false; }
                field("Deposit Remarks-Appraisal"; Rec."Deposit Remarks-Appraisal") { Visible = false; }
                field("Salary Remarks-Appraisal"; Rec."Salary Remarks-Appraisal") { Visible = false; }
                field("Business Remarks-Appraisal"; Rec."Business Remarks-Appraisal") { Visible = false; }

                part(Control32; "Loan Application Stages")
                {
                    Visible = false;
                    Caption = 'Loan Stages';
                    SubPageLink = "Loan No" = field("Loan  No.");
                }

            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
                // Visible = CheckoffDetailsVisible;
                Visible = false;
                group("Payslip Details")
                {
                    field("Is PCK Salary?"; Rec."Is PCK Salary?")
                    {

                        // Visible = false;
                    }
                    field("Basic Pay H"; Rec."Basic Pay H")
                    {
                        Caption = 'Basic Pay';
                    }

                    field("House AllowanceH"; Rec."House AllowanceH")
                    {
                        Caption = 'House Allowance';



                    }
                    field("Medical AllowanceH"; Rec."Medical AllowanceH")
                    {
                        Visible = false;

                    }
                    field("Transport Allowance"; Rec."Transport Allowance")
                    {
                        Caption = 'Commuter Allowance';

                    }
                    field("Other Income"; Rec."Other Income")
                    {

                    }

                    field("Gross Pay"; Rec."Gross Pay") { }


                    field("Tax Exempt Deductions"; Rec."Tax Exempt Deductions")
                    {
                    }

                    field("Other Tax Relief"; Rec."Other Tax Relief")
                    {

                    }
                    //   field("All Statutory Deduction"; Rec."All Statutory Deduction") { }
                    //  field("All Other Expenses"; Rec."All Other Expenses") { }
                    field("External loan"; Rec."External loan") { }
                    field(Nettakehome; Rec."Net take Home")
                    {
                        Caption = 'Net Take Home';
                        Visible = false;
                    }
                    field("Chargeable Pay"; Rec."Chargeable Pay")
                    {
                        Visible = false;
                    }

                }
                group("None Taxable Deductions")
                {
                    field("Other Non-Taxable"; Rec."Other Non-Taxable")
                    {
                        Visible = false;
                    }

                    field("Pension Scheme"; Rec."Pension Scheme")
                    {
                        Visible = false;
                    }

                }
                group(Deductions)
                {
                    field(PAYE; rec.PAYE)
                    {
                        Visible = true;
                    }
                    field("Other Liabilities"; Rec."Other Liabilities")
                    {
                        Caption = 'Other Deductions';
                        Visible = true;
                    }

                    field("Exempt Salary Details"; Rec."Exempt Salary Details")
                    {
                        Visible = true;
                    }

                }
                group("Monthly Expenses Detailss")
                {
                    Visible = false;
                    field("SExpenses Rent"; Rec."SExpenses Rent")
                    {
                        Caption = 'Rent';
                        Visible = false;
                    }
                    field("SExpenses Transport"; Rec."SExpenses Transport")
                    {
                        Caption = 'Transport';
                        Visible = false;
                    }
                    field("SExpenses Education"; Rec."SExpenses Education")
                    {
                        Caption = 'Education';
                        Visible = false;
                    }
                    field("SExpenses Food"; Rec."SExpenses Food")
                    {
                        Caption = 'Food';
                        Visible = false;
                    }
                    field("SExpenses Utilities"; Rec."SExpenses Utilities")
                    {
                        Caption = 'Utilities';
                        Visible = false;
                    }
                    field("SExpenses Others"; Rec."SExpenses Others")
                    {
                        Caption = 'Others';
                        Visible = false;
                    }
                    field("Exisiting Loans Repayments"; Rec."Exisiting Loans Repayments")
                    {
                        Visible = false;
                    }
                }
                field("Salary Net Utilizable"; Rec."Salary Net Utilizable")
                {
                    Visible = false;
                }
            }
            group("Salary Details.")
            {
                Caption = 'Salary Details.';
                // Visible = PayslipDetailsVisible;
                Visible = false;
                group("Details")
                {


                    field("Member Gross Salary"; Rec."Member Gross Salary")
                    {

                    }
                    field("Third Percentage"; Rec."Third Percentage")
                    {

                    }
                    field("Third Gross"; Rec."Third Gross")
                    {

                    }
                    field("Member Loans Deductions"; Rec."Member Loans Deductions")
                    {

                    }
                    field("Member Offets"; Rec."Member Offets")
                    {
                        Caption = 'Offset Installments';

                    }
                    field("Other Incomes"; Rec."Other Income")
                    {
                    }
                    field("Member Ability"; Rec."Member Ability")
                    {

                    }

                }

            }
            group("Statement Details")
            {
                Caption = 'Business Appraisal';
                Visible = false;
                //Visible = BankStatementDetailsVisible;
                field("Bank Statement Avarage Credits"; Rec."Bank Statement Avarage Credits")
                {
                }
                field("Bank Statement Avarage Debits"; Rec."Bank Statement Avarage Debits")
                {
                }
                group("Monthly Expenses Details")
                {
                    Caption = 'Recurrent Expenses Details';
                    Visible = false;
                    field("BSExpenses Rent"; Rec."BSExpenses Rent")
                    {
                        Caption = 'Rent';
                    }
                    field("BSExpenses Transport"; Rec."BSExpenses Transport")
                    {
                        Caption = 'Transport';
                    }
                    field("BSExpenses Education"; Rec."BSExpenses Education")
                    {
                        Caption = 'Education';
                    }
                    field("BSExpenses Food"; Rec."BSExpenses Food")
                    {
                        Caption = 'Food';
                    }
                    field("BSExpenses Utilities"; Rec."BSExpenses Utilities")
                    {
                        Caption = 'Utilities';
                    }
                    field("BSExpenses Others"; Rec."BSExpenses Others")
                    {
                        Caption = 'Others';
                    }
                    field("<Exisiting Loans Repayments.>"; Rec."Exisiting Loans Repayments")
                    {
                        Caption = 'Exisiting Loans Repayments.';
                    }
                }
                field("Bank Statement Net Income"; Rec."Bank Statement Net Income")
                {
                }
            }
            part(Control5; "Loan Offset Detail List")
            {
                Caption = 'Loan Top Up Details';
                SubPageLink = "Loan No." = field("Loan  No."), "Client Code" = field("Client Code");
                Visible = false;
                // Editable = (rec."Loan Status" = rec."Loan Status"::Application);

            }
            part(Control4; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
                Visible = false;
            }

            part(Control3; "Loan Collateral Security")
            {
                Caption = 'Loan Security Details';
                SubPageLink = "Loan No" = field("Loan  No.");
                Visible = false;
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
                //ObsoleteTag = '25.0';
                Caption = 'Documents';
                UpdatePropagation = Both;
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
                action("Return to Loan Application")
                {
                    Image = RefreshExcise;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;
                    Enabled = rec."Archive Loan";
                    trigger OnAction()
                    begin
                        if Confirm('Do you wish to return this loan to application?', false) = true then begin
                            if rec."Reason for Loan Re-open" = '' then begin

                            end else begin
                                rec."Approval Status" := rec."Approval Status"::Open;
                                rec."Loan Status" := rec."Loan Status"::Application;
                                rec."Archive Loan" := false;
                                rec."Re-Opened By" := UserId;
                                rec."Re-Opened On" := Today;
                                rec."Re-Opened On Time" := Time;
                                rec.modify;
                            end;

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
                action("Reject Loan Application")
                {
                    Image = Reject;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    Enabled = not rec."archive Loan";
                    trigger OnAction()
                    begin
                        if Confirm('Confirm Rejection?', false) = true then begin
                            if rec."Rejection  Remark" = '' then begin
                                Error('Specify the Rejection Remarks/Reason on the Rejection Details Tab');
                            end else begin
                                rec."Rejected By" := UserId;
                                rec."Date of Rejection" := Today;
                                rec."Approval Status" := rec."approval status"::Rejected;
                                rec."Loan Status" := rec."loan status"::Rejected;
                                rec."Archive Loan" := true;
                                rec.modify;
                            end;

                            //=========================================================================================Loan Stages Common On All Applications
                            // ObjLoanStages.Reset;
                            // ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::Declined);
                            // ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
                            // if ObjLoanStages.FindSet then begin
                            //     repeat
                            //         ObjLoanApplicationStages.Init;
                            //         ObjLoanApplicationStages."Loan No" := rec."Loan  No.";
                            //         ObjLoanApplicationStages."Member No" := rec."Client Code";
                            //         ObjLoanApplicationStages."Member Name" := rec."Client Name";
                            //         ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                            //         ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                            //         ObjLoanApplicationStages.Insert;
                            //     until ObjLoanStages.Next = 0;
                            // end;

                        end;

                        CurrPage.Close;
                    end;
                }
                action("Re-Open Loan")
                {
                    Image = Form;
                    Promoted = true;
                    visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            LoanApp."Loan Status" := LoanApp."Loan Status"::Appraisal;
                            LoanApp."Approval Status" := LoanApp."Approval Status"::Open;
                            LoanApp.Modify(true);
                        end;
                    end;
                }
                action("Send Loan to Committee Approval")
                {
                    Image = Form;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            LoanApp."Committee Approval" := LoanApp."Committee Approval"::Pending;
                            //LoanApp."Approval Status" := LoanApp."Approval Status"::Open;
                            LoanApp.Modify(true);
                        end;
                    end;
                }
                action("Loan Appraisal")
                {
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

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
                        Schedule: Record "Loan Repayment Schedule";
                        GrossAmount: Decimal;
                        ThirdAmount: Decimal;
                        twothirds: Decimal;
                        loansTypes: Record "Loan Products Setup";
                        Membs: record "Members Register";
                        TaxablePay: Decimal;
                        PayeAmount: Decimal;
                    begin
                        if rec."Is PCK Salary?" <> true then begin
                            if Rec."Recovery Mode" = Rec."Recovery Mode"::Salary then begin
                                GrossAmount := 0;
                                loansTypes.get(Rec."Loan Product Type");
                                loansTypes.TestField(loansTypes."Loan Appraisal %");
                                SalPayments.Reset();
                                SalPayments.SetRange(SalPayments."Member No", Rec."Client Code");
                                if SalPayments.FindLast() then begin
                                    Rec."Member Gross Salary" := SalPayments."Gross Amount";
                                    Rec."Third Percentage" := loansTypes."Loan Appraisal %";
                                    Rec."Basic Pay H" := SalPayments."Gross Amount";
                                    Rec."Third Gross" := Round((loansTypes."Loan Appraisal %" * SalPayments."Gross Amount" / 100), 0.01, '>');
                                    Rec."Gross Pay" := SalPayments."Gross Amount";
                                    Rec."Member Loans Deductions" := FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code");
                                    Rec."Sacco Deductions" := FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code");
                                    Rec."Member Offets" := FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.");
                                    Rec."Member Ability" := (Rec."Third Gross" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code"));
                                    Rec."Utilizable Amount" := (Rec."Third Gross" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code"));
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

                                twothirds := (rec."Gross Pay") * 2 / 3;
                                Rec.TwoThirds := twothirds;




                                TotalDeductions := Rec."Monthly Contribution" + rec.NHIF + rec.NSSF + Rec."Sacco Deductions" + Rec."Other Liabilities" + rec.PAYE;



                                if LoanType.Get(Rec."Loan Product Type") then begin
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



                                NetUtilizable := ROUND((twothirds - TotalDeductions), 0.01, '=');
                                rec."Utilizable Amount" := NetUtilizable;
                                rec."Total DeductionsH" := TotalDeductions;
                                rec.Modify;
                            end;
                            Message('Salary Details Have Been Updated.');
                        end;


                        if rec."Is PCK Salary?" = true then begin
                            if Rec."Recovery Mode" = Rec."Recovery Mode"::Salary then begin
                                GrossAmount := 0;
                                loansTypes.get(Rec."Loan Product Type");
                                loansTypes.TestField(loansTypes."Loan Appraisal %");
                                SalPayments.Reset();
                                SalPayments.SetRange(SalPayments."Member No", Rec."Client Code");
                                if SalPayments.FindLast() then begin
                                    Rec."Member Gross Salary" := SalPayments."Gross Amount";
                                    Rec."Third Percentage" := loansTypes."Loan Appraisal %";
                                    Rec."Basic Pay H" := SalPayments."Gross Amount";
                                    Rec."Third Gross" := Round((loansTypes."Loan Appraisal %" * SalPayments."Gross Amount" / 100), 0.01, '>');
                                    Rec."Gross Pay" := SalPayments."Gross Amount";
                                    Rec."Member Loans Deductions" := FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code");
                                    Rec."Sacco Deductions" := FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code");
                                    Rec."Member Offets" := FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.");
                                    Rec."Member Ability" := (Rec."Third Gross" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code"));
                                    Rec."Utilizable Amount" := (Rec."Third Gross" + FnFetchOffsetDeductions(Rec."Client Code", Rec."Loan  No.")) - (FnFetchLoanDeductions(Rec."Client Code") + FnFetchSTODeductions(Rec."Client Code"));
                                    if LoanType.Get(Rec."Loan Product Type") then begin
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
                action("Submit To Appraisal")
                {
                    Caption = 'Submit To Appraisal';
                    Enabled = not (rec."Archive Loan");
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        TotalL: decimal;
                        LoansGuaranteeDetails: Record "Loans Guarantee Details";
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        Cust.Reset();
                        Cust.SetRange("No.", rec."Client Code");
                        if Cust.Find('-') then begin
                            if cust.Status <> cust.Status::Active then Error('The member account should be active.');
                        end;




                        rec.TestField("Loan Product Type");
                        rec.TestField("Requested Amount");
                        rec.TestField("Client Code");
                        rec.TestField(Installments);


                        LoanApp.Reset();
                        LoanApp.SetRange("Client Code", rec."Client Code");
                        LoanApp.SetRange("Loan Product Type", rec."Loan Product Type");
                        LoanApp.SetAutoCalcFields("Outstanding Balance");
                        LoanApp.SetFilter("Outstanding Balance", '>%1', 0);
                        if LoanApp.findSet() then begin
                            repeat
                                loanApp.CalcFields(LoanApp."Outstanding Balance");
                                LoanTopUp.Reset();
                                loantopup.setrange("Loan No.", Rec."Loan  No.");
                                LoanTopUp.setrange("Loan Top Up", LoanApp."Loan  No.");
                                if not loantopup.Find('-') then begin
                                    Error('The member %1 has a %2 with an outstanding balance of %3 that has not been offset.', Rec."Client Code", Rec."Loan Product Type Name", loanApp."Outstanding Balance");
                                end;
                            until LoanApp.Next() = 0;
                        end;

                        if LoanType.Get(Rec."Loan Product type") then begin
                            if LoanType."Appraise Guarantors" = true then begin
                                if FnCheckIfGuarantorsMet(Rec."Loan  No.", Rec."Client Code", Rec."Requested Amount") then begin
                                    Message('Kindly note that the guarantors or collateral do not fully secure the requested amount.');
                                end;
                            end;
                        end;

                        rec."Recover Share Capital" := checkifcanrecoverShareCapital(rec."Loan  No.", rec."Requested Amount", rec."Client Code");
                        rec.modify;

                        if Confirm('Are you sure you want to submit this form for Appraisal', false) = true then begin
                            //FnSendCLientSMS(rec."Client Code");
                            // FnSendGuarantorAppSMS(Rec."Loan  No.", Rec."Client Code");
                            rec."Loan Status" := rec."loan status"::Appraisal;
                            rec."Approval Status" := rec."approval status"::Open;
                            Rec."Appraised Date" := Today;
                            Rec."Appraised Time" := Time;
                            rec.Modify;
                        end;
                    end;
                }
                action("Archive Loan")
                {
                    Caption = 'Archive Loan';
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to archive this loan?', false) = true then begin
                            LoanApp.reset;
                            LoanApp.SetRange(loanapp."Loan  No.", Rec."Loan  No.");
                            if loanapp.Find('-') then begin
                                LoanApp."Archive Loan" := true;
                                LoanApp.modify;
                                //Report.Run(80014, true, false, LoanApp);
                            end;
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
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Loans Posted List";
                    RunPageLink = "Client Code" = FIELD("Client Code");
                    ShortCutKey = 'Shift+F7';

                }

                action("Send Approval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Visible = false;
                    //Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        /// ApprovalMgt: Codeunit "Approvals Mgmt.";
                        Workflowintegration: Codeunit WorkflowIntegration;
                    begin

                        if rec."Approved Amount" = 0 then Error('Kindly upraise your loan application before sending approval request');

                        rec.TestField(rec."Loan Product Type");
                        rec.TestField(rec."Recovery Mode");
                        rec.TestField(rec."Sector Specific");
                        rec.TestField(rec."Account No");



                        LoanGuar.Reset;
                        LoanGuar.SetRange("Loan No", Rec."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            if LoanType.Get(rec."Loan Product Type") then begin
                                if LoanGuar.Count < LoanType."Min No. Of Guarantors" then
                                    Error('You must capture atleast ' + Format(LoanType."Min No. Of Guarantors") + ' for ' + rec."Loan Product Type");
                            end;
                        end;

                        //Message('Approval%1',rec."Approval Status");
                        if rec."Approval Status" <> rec."approval status"::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::LoanApplication;
                        Table_id := Database::"Loans Register";
                        rec.TestField("Requested Amount");
                        if Workflowintegration.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnSendLoanApplicationForApproval(Rec);

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
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalMgt.SendLoanApprRequest(Rec);
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            rec."Loan Status" := rec."loan status"::Application;
                            rec."Approval Status" := rec."approval status"::Open;
                            //ApprovalsMgmt.OnCancelLoanApplicationApprovalRequest(Rec);
                            rec.Modify;
                        end;
                    end;
                }
                action(Approval)
                {
                    Caption = 'Archive Loan';
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
        if Rec."Approval Status" = "approval status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec."Approval Status" = "approval status"::Approved) then
            EnableCreateMember := true;

        if Rec."Approval Status" <> "approval status"::Open then
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
    end;


    var
        i: Integer;
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

    local procedure FnSendGuarantorAppSMS(LoanNo: Code[20]; loanee: Code[30])
    var
        Cust: Record Customer;
        LoanOwner: Record Vendor;
        LoanOwnerFOSA: Code[20];
        Sms: Record "SMS Messages";
        nameStyle: Codeunit "SMS Reminders";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    begin
        LoanOwnerFOSA := '';
        LoanOwner.Reset;
        LoanOwner.SetRange("BOSA Account No", loanee);
        LoanOwner.SetRange("Account Type", '103');
        if LoanOwner.Find('-') then begin
            LoanOwnerFOSA := LoanOwner."No.";
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
                        CreationMessage := 'Dear ' + nameStyle.NameStyle(Cust."No.") + ' , You have guaranteed KES ' + Format(LGuarantorss."Amont Guaranteed") + ' to a ' + LoansRec."Loan Product Type Name" + ' for ' + nameStyle.NameStyle(loanee) + '. Call 0205029217 if in disagreement.';
                        //smsManagement.SendSmsResponse(Cust."Mobile Phone No", CreationMessage);
                        smsManagement.SendSmsWithID(Source::LOAN_GUARANTORS, Cust."Mobile Phone No", CreationMessage, LoanOwnerFOSA, LoanOwnerFOSA, TRUE, 210, TRUE, 'CBS', CreateGuid(), 'CBS');
                    end;
                end;
            until LGuarantorss.Next = 0;

        end
    end;

    local procedure FnSendCLientSMS(CLientCode: Code[20])
    var
        Cust: Record Customer;
        Sms: Record "SMS Messages";
        guarantors: Record "Loans Guarantee Details";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
    begin

        Cust.Reset();
        Cust.SetRange(Cust."No.", CLientCode);
        Cust.SetFilter(Cust."Mobile Phone No", '<>%1', '');
        if Cust.FindFirst() then begin
            CreationMessage := 'Dear Member,Your Loan of amount of Ksh:' + Format(rec."Requested Amount") + ' has been received for processing.';
            //smsManagement.SendSmsResponse(Cust."Mobile Phone No", CreationMessage);
            smsManagement.SendSmsWithID(Source::LOAN_APPRAISAL, Cust."Mobile Phone No", CreationMessage, Cust."FOSA Account No.", Cust."FOSA Account No.", TRUE, 210, TRUE, 'CBS', CreateGuid(), 'CBS');
        end;

    end;

    local procedure FnFetchLoanDeductions(ClientCode: Code[20]) TotalLoans: Decimal
    var
        Loans: Record "Loans Register";
        LoanSchedule: Record "Loan Repayment Schedule";
    begin
        TotalLoans := 0;
        Loans.Reset();
        Loans.SetRange(Loans."Client Code", ClientCode);
        Loans.SetAutoCalcFields(Loans."Outstanding Balance");
        Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
        if Loans.FindFirst() then begin
            repeat
                LoanSchedule.reset;
                LoanSchedule.SetRange(LoanSchedule."Loan No.", Loans."Loan  No.");
                if LoanSchedule.FindFirst() then begin
                    TotalLoans := TotalLoans + LoanSchedule."Monthly Repayment";
                end;
            until loans.Next() = 0;
        end;
    end;

    local procedure FnFetchSTODeductions(ClientCode: Code[20]) STO: Decimal
    var
        Loans: Record "Loans Register";
        LoanSchedule: Record "Loan Repayment Schedule";
        STORegister: Record "Standing Orders";
        Ven: Record Vendor;
        RecieptAll: Record "Receipt Allocation";
    begin
        Ven.Reset();
        Ven.SetRange("BOSA Account No", ClientCode);
        Ven.SetRange(Ven."Account Type", '103');
        if Ven.FindFirst() then begin
            STO := 0;
            STORegister.Reset();
            STORegister.SetRange(STORegister."Is Active", true);
            STORegister.SetRange(STORegister.Status, STORegister.Status::Approved);
            STORegister.SetRange(STORegister."Source Account No.", Ven."No.");
            if STORegister.FindFirst() then begin
                RecieptAll.reset;
                RecieptAll.Setrange(RecieptAll."Document No", STORegister."No.");
                if RecieptAll.Findset then begin
                    RecieptAll.CalcSums(RecieptAll.Amount);
                    STO := RecieptAll.Amount;
                end;
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
            if rec."Recovery Mode" = rec."Recovery Mode"::Salary then begin
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

    local procedure FnCheckIfGuarantorsMet(LoanNo: Code[60]; ClientCode: Code[60]; RequestedAmount: Decimal): Boolean
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

        totalSecurity := totalGuaranteed + totalCollateral;
        if totalSecurity < RequestedAmount then exit(true);

    end;

    local procedure checkifcanrecoverShareCapital(loanNo: Code[20]; amount: Decimal; member: Code[20]) recoverShareCap: Decimal
    var
        loanTopup: Record "Loan Offset Details";
        cust: Record Customer;
        saccoGen: Record "Sacco General Set-Up";
        totalOffset: Decimal;
        remainder: Decimal;
        diff: Decimal;
    begin
        totalOffset := 0;
        remainder := 0;
        diff := 0;
        loanTopup.Reset();
        loanTopup.SetRange("Loan No.", loanNo);
        if loanTopup.FindSet() then begin
            loanTopup.CalcSums("Total Top Up");
            totalOffset := loanTopup."Total Top Up";
        end;

        if (amount - totalOffset) > 30000 then begin
            if cust.Get(member) then begin
                cust.CalcFields("Shares Retained");
                saccoGen.Get();
                if cust."Shares Retained" < saccoGen."Retained Shares" then begin
                    diff := (saccoGen."Retained Shares" - cust."Shares Retained");
                    if (amount - totalOffset) > diff then begin
                        recoverShareCap := diff;
                    end else begin
                        recoverShareCap := 0;
                        Error('The member''s share capital of %1 cannot be filled with the net loan of %2.', cust."Shares Retained", (amount - totaloffset));
                    end;
                end else
                    recoverShareCap := 0;
            end else
                recoverShareCap := 0;
        end;

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




