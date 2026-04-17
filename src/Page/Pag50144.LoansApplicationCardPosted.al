//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50144 "Loans Application Card(Posted)"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Loans Register";

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
                field("Staff No"; Rec."Staff No")
                {
                    Caption = 'Staff No';
                    Editable = false;
                    Visible = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Account No"; Rec."Account No")
                {
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
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field(Source; Rec.Source)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Installments; Rec.Installments)
                {
                    Editable = false;
                    trigger OnValidate()
                    var
                        prodSetup: Record "Loan Products Setup";
                    begin

                        prodSetup.Reset();
                        prodSetup.SetRange(Code, rec."Loan Product Type");
                        if prodSetup.Find('-') then begin
                            if rec.Installments > prodSetup."Default Installements" then begin
                                Error('The number of installments cannot be greater than the default of %1.', prodSetup."Default Installements");
                            end else begin
                                rec.Validate("Repayment Start Date");
                                rec.modify;
                            end;
                        end;
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
                    Visible = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    Caption = 'Amount Applied';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Boost this Loan"; Rec."Boost this Loan")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Boosted Amount"; Rec."Boosted Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Total Interest-Scheduled"; Rec."Total Interest-Scheduled")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Caption = 'Approved Amount';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Tranch Amount Disbursed"; Rec."Tranch Amount Disbursed")
                {
                    Editable = false;

                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    Editable = false;

                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = false;
                    Visible = true;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    Editable = false;
                }
                field("Grace Period - Principle (M)"; Rec."Grace Period - Principle (M)")
                {
                    Editable = false;
                }
                field("Grace Period - Interest (M)"; Rec."Grace Period - Interest (M)")
                {
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    Caption = 'Principle Repayment';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    Caption = 'Interest Repayment';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Approved Repayment"; Rec."Approved Repayment")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //UpdateControl();
                    end;
                }
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
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    Editable = false;
                }
                field("Principal In Arrears"; Rec."Principal In Arrears")
                {
                    Editable = false;
                }
                field("Interest In Arrears"; Rec."Interest In Arrears")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Editable = false;
                    Visible = false;
                }



                group("Disbursement Details")
                {
                    Editable = false;
                    field("Credit Officer II"; Rec."Credit Officer II")
                    {
                        Caption = 'Credit Officer';
                        Editable = false;
                        Visible = false;
                    }
                    field("Loan Centre"; Rec."Loan Centre")
                    {
                        Editable = false;
                        Visible = false;

                    }
                    field("Captured By"; Rec."Captured By")
                    {
                        Editable = false;
                    }
                    field("Loan Offset Amount"; Rec."Loan Offset Amount")
                    {
                        Caption = 'Bridged Amount';
                        Editable = false;
                        Visible = false;
                    }
                    field("Repayment Frequency"; Rec."Repayment Frequency")
                    {
                        Editable = false;
                    }
                    field("Mode of Disbursement"; Rec."Mode of Disbursement")
                    {
                    }
                    field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                    {
                        AssistEdit = true;
                        Editable = false;
                        //Rec.Enabled = EditableField;
                        Importance = Promoted;
                        NotBlank = true;
                        ShowMandatory = true;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Cheque No."; Rec."Cheque No.")
                    {
                        Editable = false;
                        Visible = false;

                        trigger OnValidate()
                        begin
                            if StrLen(Rec."Cheque No.") > 6 then
                                Error('Document No. cannot contain More than 6 Characters.');
                        end;
                    }
                    field("Batch No."; Rec."Batch No.")
                    {
                        Editable = false;
                        Style = StrongAccent;
                        Visible = false;
                    }
                    field("Repayment Start Date"; Rec."Repayment Start Date")
                    {
                        Editable = false;
                    }
                    field("Expected Date of Completion"; Rec."Expected Date of Completion")
                    {
                        Editable = false;
                    }
                    field("Last Repayment Date"; Rec."Last Repayment Date")
                    {
                        Editable = false;
                    }
                    field("External EFT"; Rec."External EFT")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Approval Status"; Rec."Approval Status")
                    {
                        Editable = false;
                    }
                    field("Total Disbursed Tranches"; rec."Total Disbursed Tranches")
                    {
                        Editable = false;

                    }
                    field("partially Bridged"; Rec."partially Bridged")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field(Posted; Rec.Posted)
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Total Offset Commission"; Rec."Total Offset Commission")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Rejection  Remark"; Rec."Rejection  Remark")
                    {
                        Editable = false;
                        Visible = false;
                    }

                }
                group(LoanRecovery)
                {
                    Visible = false;
                    field("Recovery Mode"; Rec."Recovery Mode")
                    {
                        Editable = recoveryedit;
                        Visible = false;
                    }

                    field("Employer Code"; Rec."Employer Code")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Loan Recovery Account FOSA"; Rec."Loan Recovery Account FOSA")
                    {
                        Caption = 'Repayment Account FOSA';
                        Editable = false;
                        Visible = false;
                    }
                }
                group(LoanReschedule)
                {
                    Editable = false;
                    Visible = false;
                    //Visible = RescheduledVisible;
                    field(Rescheduled; Rec.Rescheduled)
                    {
                        Caption = 'Loan Restructured';
                    }
                    field("Loan Rescheduled Date"; Rec."Loan Rescheduled Date")
                    {
                        Caption = 'Restructured On';
                    }
                    field("Loan Rescheduled By"; Rec."Loan Rescheduled By")
                    {
                        Caption = 'Restructured By';
                    }
                    field("Loan to Reschedule"; Rec."Loan to Reschedule")
                    {
                        Caption = 'Restructured Loan No';
                    }
                    field("Reason For Loan Reschedule"; Rec."Reason For Loan Reschedule")
                    {
                        Caption = 'Reason for Restructure';
                    }
                }
                part(Control42; "Loan Application Stages")
                {
                    Visible = false;
                    Caption = 'Loan Stages';
                    SubPageLink = "Loan No" = field("Loan  No.");
                }
            }
            part(Tranches; "Tranche Disbursement Sublist")
            {
                Editable = false;
                SubPageLink = "Loan Number" = FIELD("Loan  No."), "Member No" = field("Client Code");
            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
                Editable = false;
                Visible = false;
                group(Earnings)
                {
                    Caption = 'Earnings';
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
                        Caption = 'Medical Allowance';
                    }
                    field("Transport/Bus Fare"; Rec."Transport/Bus Fare")
                    {
                        Caption = 'Commutter  Allowance';
                    }
                    field("Other Income"; Rec."Other Income")
                    {
                    }

                    field("Gross Pay"; Rec."Gross Pay")
                    {
                        Editable = false;
                    }

                    field("Provident Fund"; Rec."Provident Fund")
                    {
                        Visible = false;
                    }
                }
                group("Non-Taxable Deductions")
                {
                    Caption = 'Non-Taxable Deductions';
                    Visible = false;
                    field("Pension Scheme"; Rec."Pension Scheme")
                    {
                        Caption = 'Total Provident Fund';
                    }
                    field("Other Non-Taxable"; Rec."Other Non-Taxable")
                    {
                    }
                    field("Other Tax Relief"; Rec."Other Tax Relief")
                    {
                    }
                }
                group(Deductions)
                {
                    Visible = false;
                    Caption = 'Deductions';
                    field(PAYE; Rec.PAYE)
                    {
                    }
                    field(NSSF; Rec.NSSF)
                    {
                    }
                    field(NHIF; Rec.NHIF)
                    {
                    }
                    field("Staff Union Contribution"; Rec."Staff Union Contribution")
                    {
                        Caption = 'Union Dues';
                    }
                    field("Monthly Contribution"; Rec."Monthly Contribution")
                    {
                        Caption = 'Deposits';
                    }
                    field("Risk MGT"; Rec."Risk MGT")
                    {
                        Caption = 'Benevolent Fund';
                        Visible = false;
                    }
                    field("Medical Insurance"; Rec."Medical Insurance")
                    {
                    }
                    field("Life Insurance"; Rec."Life Insurance")
                    {
                        Caption = 'Gold Save / NIS';
                        Visible = false;
                    }
                    field("Provident Fund (Self)"; Rec."Provident Fund (Self)")
                    {
                        Visible = false;
                    }
                    field("Other Liabilities"; Rec."Other Liabilities")
                    {
                        Visible = false;
                    }
                    field("Sacco Deductions"; Rec."Sacco Deductions")
                    {
                    }
                    field("Existing Loan Repayments"; Rec."Existing Loan Repayments")
                    {
                        Editable = false;
                    }
                    field("Other Loans Repayments"; Rec."Other Loans Repayments")
                    {
                        Caption = 'Bank Loan Repayments';
                    }
                    field("Excess LSA Recovery"; Rec."Excess LSA Recovery")
                    {
                        Visible = false;
                    }
                    field("Total Deductions"; Rec."Total Deductions")
                    {
                    }
                    field(UtilizableAmount; Rec."Utilizable Amount")
                    {
                        Visible = false;
                    }
                    field("Bridge Amount Release"; Rec."Bridge Amount Release")
                    {
                        Caption = 'Cleared Loan Repayment';
                        Visible = false;
                    }
                    field("Net Utilizable Amount"; Rec."Net Utilizable Amount")
                    {
                    }
                }
            }
            group("Statement Details")
            {
                Caption = 'Statement Details';
                Editable = false;
                Visible = false;
                field("Bank Statement Avarage Credits"; Rec."Bank Statement Avarage Credits")
                {
                }
                field("Bank Statement Avarage Debits"; Rec."Bank Statement Avarage Debits")
                {
                }
                group("Monthly Expenses Details")
                {
                    Caption = 'Monthly Expenses Details';
                    Editable = false;
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
                Visible = false;
                Caption = 'Loan Top Up Details';
                SubPageLink = "Loan No." = field("Loan  No."), "Client Code" = field("Client Code");
                Editable = (rec."Loan Status" = rec."Loan Status"::Application);

            }
            part(Control16; "Loans Guarantee Details")
            {
                Visible = false;
                Caption = 'Guarantors  Detail';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control15; "Loan Collateral Security")
            {
                Caption = 'Loan Collateral Security';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            // part("<Mobile loan Appraisal>";"E Banking loan Appraisal")
            // {
            //     Caption = 'E-Banking Loan Appraisal';
            //     Editable = false;
            //     SubPageLink = "Document No"=field("Doc No Used");
            // }
            group("Repayment Date Change")
            {
                Visible = false;
                field("Reschedule Effective Date"; Rec."Reschedule Effective Date")
                {
                }
                field("New Repayment Start Date"; Rec."New Repayment Start Date")
                {
                }
                field("Repayment Dates Rescheduled"; Rec."Repayment Dates Rescheduled")
                {
                    Caption = 'Repayment Dates Changed';
                    Editable = false;
                }
                field("Repayment Dates Rescheduled On"; Rec."Repayment Dates Rescheduled On")
                {
                    Caption = 'Repayment Dates Changed On';
                    Editable = false;
                }
                field("Repayment Dates Rescheduled By"; Rec."Repayment Dates Rescheduled By")
                {
                    Caption = 'Repayment Dates Changed By';
                    Editable = false;
                }
            }
            group("Skip Loan Installment")
            {
                Visible = false;
                field("Installment Date to Skip From"; Rec."Installment Date to Skip From")
                {
                }
                field("Loan Installments to Skip"; Rec."Loan Installments to Skip")
                {
                    Caption = 'No of Loan Installments to Skip';
                }
                field("Skip Installments Effected"; Rec."Skip Installments Effected")
                {
                    Editable = false;
                }
                field("Skip Installments Effected By"; Rec."Skip Installments Effected By")
                {
                    Editable = false;
                }
                field("Skip Installments Effected On"; Rec."Skip Installments Effected On")
                {
                    Editable = false;
                }
            }
            group("Debt Collections Details")
            {
                Visible = false;
                Caption = 'Debt Collections Details';
                field("Loan Debt Collector"; Rec."Loan Debt Collector")
                {
                }
                field("Debt Collector Name"; Rec."Debt Collector Name")
                {
                }
                field("Loan Bal As At Debt Collection"; Rec."Loan Bal As At Debt Collection")
                {
                    Caption = 'Loan Bal As At Debt Collection Assignment';
                    Editable = false;
                }
                field("Loan Debt Collector Interest %"; Rec."Loan Debt Collector Interest %")
                {
                    // Editable = false;
                }
                field("Debt Collection date Assigned"; Rec."Debt Collection date Assigned")
                {
                    Editable = false;
                }
            }
            group("Auctioneer Details")
            {
                field("Disburesment Type"; Rec."Disburesment Type")
                {
                }
                field("Paying Bank Account No"; Rec."Paying Bank Account No")
                {
                }
                field("Loan Auctioneer"; Rec."Loan Auctioneer")
                {
                }
                field("Loan Auctioneer Name"; Rec."Loan Auctioneer Name")
                {
                    Editable = false;
                }
                field("Date Auctioneer Assigned"; Rec."Date Auctioneer Assigned")
                {
                    Editable = false;
                }
            }
            group(Exemptions)
            {
                Caption = 'Exemptions';
                Visible = false;
                field("Freeze Interest Accrual"; Rec."Freeze Interest Accrual")
                {
                    Caption = 'Stop Interest Accrual';
                }
                field("Except From Penalty"; Rec."Except From Penalty")
                {
                    Caption = 'Stop Penalty Accrual';
                }
                field("Freeze Until"; Rec."Freeze Until")
                {
                    Caption = 'Interest Acrual Resume Date';
                }
                field("Exempt From Payroll Deduction"; Rec."Exempt From Payroll Deduction")
                {
                }
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
                action("Loan Appraisal")
                {
                    Visible = false;
                    Caption = 'View Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Mode of Disbursement");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            if LoanApp.Source = LoanApp.Source::BOSA then
                                Report.run(50084, true, false, LoanApp)
                            else
                                Report.run(50084, true, false, LoanApp)
                        end;
                    end;
                }
                action("Member Ledger Entries")
                {
                    Caption = 'Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    RunPageView = sorting("Customer No.");
                }
                action("Go to FOSA Accounts")
                {
                    Image = List;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("Client Code");
                }
                action("Guarantors' Report")
                {
                    Visible = false;
                    Image = SelectReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Cust.SetFilter("Loan No. Filter", Rec."Loan  No.");
                        Cust.SetFilter("Loan Product Filter", Rec."Loan Product Type");
                        if Cust.Find('-') then
                            Report.run(172504, true, false, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    Image = "Report";
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Cust.SetFilter("Loan No. Filter", Rec."Loan  No.");
                        Cust.SetFilter("Loan Product Filter", Rec."Loan Product Type");
                        if Cust.Find('-') then
                            Report.run(172531, true, false, Cust);
                    end;
                }
                action("Member Statement")
                {
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        if Cust.Find('-') then begin
                            Report.run(80027, true, false, Cust);
                        end;
                    end;
                }
                action("Members Statistics")
                {
                    Caption = 'Member Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("Client Code");
                }
                action(Rectify)
                {
                    Visible = false;
                    Caption = 'Rectify Loan Repayment';
                    Image = Recalculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        user.Reset();
                        user.SetRange("User ID", UserId);
                        if user.Find('-') then begin
                            if user."Can edit recovery mode" = false then Error('This user %1, has no permissions to rectify loan repayment', UserId);
                        end;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(175115, true, false, LoanApp);
                        end;
                    end;
                }
                action("Generate Repayment Schedule")
                {
                    Caption = 'Generate Repayment Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';
                    Visible = true;


                    trigger OnAction()
                    var
                        LoanType: Record "Loan Products Setup";
                        AuFactory: Codeunit "Au Factory";
                    begin
                        loantype.Get(Rec."Loan Product Type");
                        if loantype."Non Recurring Interest" = false then begin
                            SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        end;
                        if loantype."Non Recurring Interest" = true then begin
                            AuFactory.FnGenerateLoanRepaymentScheduleZero(Rec."Loan  No.");
                        end;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Commit;
                            Report.Run(80014, true, false, LoanApp);
                        end;
                    end;
                }
                action("Loan Repayment Schedule")
                {
                    Caption = 'Loan Repayment Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

                    trigger OnAction()
                    var
                        LoansRec: Record "Loans Register";
                        RSchedule: Record "Loan Repayment Schedule";
                        LoanAmount: Decimal;
                        InterestRate: Decimal;
                        RepayPeriod: Integer;
                        InitialInstal: Decimal;
                        LBalance: Decimal;
                        RunDate: Date;
                        InstalNo: Decimal;
                        TotalMRepay: Decimal;
                        LInterest: Decimal;
                        LPrincipal: Decimal;
                        GrPrinciple: Integer;

                        GrInterest: Integer;
                        RepayCode: Code[10];
                        WhichDay: Integer;
                        LoanType: Record "Loan Products Setup";
                        AuFactory: Codeunit "Au Factory";
                    begin
                        loantype.Get(Rec."Loan Product Type");
                        if loantype."Non Recurring Interest" = false then begin
                            SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        end;
                        //SFactory.FnRunLoanAmountDue("Loan  No.");
                        //COMMIT;

                        if loantype."Non Recurring Interest" = true then begin
                            AuFactory.FnGenerateLoanRepaymentScheduleZero(Rec."Loan  No.");
                        end;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Commit;
                            Report.Run(80014, true, false, LoanApp);
                        end;
                        //end;



                        /*SFactory.FnRunLoanAmountDue("Loan  No.");
                        COMMIT;*/

                        // SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        // Commit;
                        //LoanApp.Reset;
                        //LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        // if LoanApp.Find('-') then
                        ///  Message('hereggg%1-%2', "Loan  No.", "Approved Amount");
                        //SFactory.FnGenerateLoanRepaymentSchedule(LoanApp."Loan  No.");

                        /*                         LoanApp.Reset;
                                                LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                                                if LoanApp.Find('-') then
                                                    Report.run(80014, true, false, LoanApp); */

                    end;
                }
                action("Reschedule Repayment Date")
                {
                    Caption = 'Reschedule Loan Repayment Date';
                    Image = Form;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        VarScheduleDay: Integer;
                        VarScheduleMonth: Integer;
                        VarScheduleYear: Integer;
                        VarInstallmentNo: Integer;
                        VarPeriodIncreament: Text;
                    begin
                        Rec.TestField("New Repayment Start Date");
                        if Confirm('Confirm you Want to Change Repayment Dates for  this Loan?', false) = true then begin
                            VarInstallmentNo := 0;
                            VarNewInstalmentDate := Rec."New Repayment Start Date";
                            //=======================================================================Loan Repayment Schedule
                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    ObjLoanRepaymentSchedule.ToDelete := true;
                                    ObjLoanRepaymentSchedule.Modify;
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule.ToDelete, true);
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                ObjLoanRepaymentScheduleII.Reset;
                                ObjLoanRepaymentScheduleII.SetCurrentkey(ObjLoanRepaymentScheduleII."Entry No");
                                if ObjLoanRepaymentScheduleII.FindLast then
                                    ScheduleEntryNo := ObjLoanRepaymentScheduleII."Entry No" + 1;

                                repeat
                                    ObjLoanRepaymentScheduleII.Init;
                                    ObjLoanRepaymentScheduleII."Loan No." := ObjLoanRepaymentSchedule."Loan No.";
                                    ObjLoanRepaymentScheduleII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleII."Loan Amount" := ObjLoanRepaymentSchedule."Loan Amount";
                                    ObjLoanRepaymentScheduleII."Instalment No" := ObjLoanRepaymentSchedule."Instalment No";
                                    ObjLoanRepaymentScheduleII."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleII."Member No." := ObjLoanRepaymentSchedule."Member No.";
                                    ObjLoanRepaymentScheduleII."Loan Category" := ObjLoanRepaymentSchedule."Loan Category";
                                    ObjLoanRepaymentScheduleII."Monthly Repayment" := ObjLoanRepaymentSchedule."Monthly Repayment";
                                    ObjLoanRepaymentScheduleII."Principal Repayment" := ObjLoanRepaymentSchedule."Principal Repayment";
                                    ObjLoanRepaymentScheduleII."Monthly Interest" := ObjLoanRepaymentSchedule."Monthly Interest";
                                    ObjLoanRepaymentScheduleII."Monthly Insurance" := ObjLoanRepaymentSchedule."Monthly Insurance";
                                    ObjLoanRepaymentScheduleII."Loan Balance" := ObjLoanRepaymentSchedule."Loan Balance";
                                    ObjLoanRepaymentScheduleII.Insert;

                                    VarInstallmentNo := VarInstallmentNo + 1;
                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                    VarPeriodIncreament := Format(VarInstallmentNo) + 'M';
                                    VarNewInstalmentDate := CalcDate(VarPeriodIncreament, Rec."New Repayment Start Date");
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule.ToDelete, true);
                            if ObjLoanRepaymentSchedule.FindSet then
                                ObjLoanRepaymentSchedule.DeleteAll;

                            //=======================================================================Loan Repayment Schedule  Temp

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    ObjLoanRepaymentScheduleTemp.ToDelete := true;
                                    ObjLoanRepaymentScheduleTemp.Modify;
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;

                            ObjLoanRepaymentScheduleTempII.Reset;
                            ObjLoanRepaymentScheduleTempII.SetCurrentkey(ObjLoanRepaymentScheduleTempII."Entry No");
                            if ObjLoanRepaymentScheduleTempII.FindLast then
                                ScheduleEntryNo := ObjLoanRepaymentScheduleTempII."Entry No" + 1;

                            VarInstallmentNo := 0;
                            VarNewInstalmentDate := Rec."New Repayment Start Date";

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp.ToDelete, true);
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    ObjLoanRepaymentScheduleTempII.Init;
                                    ObjLoanRepaymentScheduleTempII."Loan No." := ObjLoanRepaymentScheduleTemp."Loan No.";
                                    ObjLoanRepaymentScheduleTempII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleTempII."Loan Amount" := ObjLoanRepaymentScheduleTemp."Loan Amount";
                                    ObjLoanRepaymentScheduleTempII."Instalment No" := ObjLoanRepaymentScheduleTemp."Instalment No";
                                    ObjLoanRepaymentScheduleTempII."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleTempII."Member No." := ObjLoanRepaymentScheduleTemp."Member No.";
                                    ObjLoanRepaymentScheduleTempII."Loan Category" := ObjLoanRepaymentScheduleTemp."Loan Category";
                                    ObjLoanRepaymentScheduleTempII."Monthly Repayment" := ObjLoanRepaymentScheduleTemp."Monthly Repayment";
                                    ObjLoanRepaymentScheduleTempII."Principal Repayment" := ObjLoanRepaymentScheduleTemp."Principal Repayment";
                                    ObjLoanRepaymentScheduleTempII."Monthly Interest" := ObjLoanRepaymentScheduleTemp."Monthly Interest";
                                    ObjLoanRepaymentScheduleTempII."Monthly Insurance" := ObjLoanRepaymentScheduleTemp."Monthly Insurance";
                                    ObjLoanRepaymentScheduleTempII."Loan Balance" := ObjLoanRepaymentScheduleTemp."Loan Balance";
                                    ObjLoanRepaymentScheduleTempII.Insert;

                                    VarInstallmentNo := VarInstallmentNo + 1;
                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                    VarPeriodIncreament := Format(VarInstallmentNo) + 'M';
                                    VarNewInstalmentDate := CalcDate(VarPeriodIncreament, Rec."New Repayment Start Date");
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp.ToDelete, true);
                            if ObjLoanRepaymentScheduleTemp.FindSet then
                                ObjLoanRepaymentScheduleTemp.DeleteAll;

                            Rec."Repayment Dates Rescheduled" := true;
                            Rec."Repayment Dates Rescheduled By" := UserId;
                            Rec."Repayment Dates Rescheduled On" := Today;
                            Message('Loan Repayment Date Changed Succesfully');
                        end;
                    end;
                }
                action("Skip Loan Installments")
                {
                    Caption = 'Skip Loan Installments';
                    Image = Form;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        VarScheduleDay: Integer;
                        VarScheduleMonth: Integer;
                        VarScheduleYear: Integer;
                        VarInstallmentNo: Integer;
                        VarPeriodIncreament: Text;
                    begin
                        Rec.TestField("Installment Date to Skip From");
                        if Rec."Loan Installments to Skip" = 0 then
                            Error('You must specify the No. of Loan Installments you want to Skip');

                        if Confirm('Confirm you Want to Skip Installments for  this Loan?', false) = true then begin
                            //=======================================================================Loan Repayment Schedule
                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Installment Date to Skip From");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    ObjLoanRepaymentSchedule.ToDelete := true;
                                    ObjLoanRepaymentSchedule.Modify;
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Installment Date to Skip From");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                ObjLoanRepaymentScheduleII.Reset;
                                ObjLoanRepaymentScheduleII.SetCurrentkey(ObjLoanRepaymentScheduleII."Entry No");
                                if ObjLoanRepaymentScheduleII.FindLast then
                                    ScheduleEntryNo := ObjLoanRepaymentScheduleII."Entry No" + 1;

                                InstallmentsToSkip := Rec."Loan Installments to Skip";
                                VarInstallmentNo := ObjLoanRepaymentSchedule."Instalment No";
                                RepaymentDateSkip := ObjLoanRepaymentSchedule."Repayment Date";

                                repeat
                                    ObjLoanRepaymentScheduleII.Init;
                                    ObjLoanRepaymentScheduleII."Loan No." := ObjLoanRepaymentSchedule."Loan No.";
                                    ObjLoanRepaymentScheduleII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleII."Loan Amount" := ObjLoanRepaymentSchedule."Loan Amount";
                                    ObjLoanRepaymentScheduleII."Instalment No" := VarInstallmentNo;
                                    ObjLoanRepaymentScheduleII."Repayment Date" := RepaymentDateSkip;
                                    ObjLoanRepaymentScheduleII."Member No." := ObjLoanRepaymentSchedule."Member No.";
                                    ObjLoanRepaymentScheduleII."Loan Category" := ObjLoanRepaymentSchedule."Loan Category";
                                    ObjLoanRepaymentScheduleII."Monthly Repayment" := 0;
                                    ObjLoanRepaymentScheduleII."Principal Repayment" := 0;
                                    ObjLoanRepaymentScheduleII."Monthly Interest" := 0;
                                    ObjLoanRepaymentScheduleII."Monthly Insurance" := 0;
                                    ObjLoanRepaymentScheduleII."Loan Balance" := ObjLoanRepaymentSchedule."Loan Balance";
                                    ObjLoanRepaymentScheduleII.Insert;
                                    InstallmentsToSkip := InstallmentsToSkip - 1;
                                    VarInstallmentNo := VarInstallmentNo + 1;
                                    RepaymentDateSkip := CalcDate('1M', RepaymentDateSkip);
                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                until InstallmentsToSkip = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Instalment No");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Monthly Repayment", '<>%1', 0);
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Installment Date to Skip From");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule.ToDelete, true);
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    VarInstallmentNo := ObjLoanRepaymentSchedule."Instalment No" + Rec."Loan Installments to Skip";
                                    VarNewInstalmentDate := CalcDate(Format(Rec."Loan Installments to Skip") + 'M', ObjLoanRepaymentSchedule."Repayment Date");

                                    ObjLoanRepaymentScheduleII.Init;
                                    ObjLoanRepaymentScheduleII."Loan No." := ObjLoanRepaymentSchedule."Loan No.";
                                    ObjLoanRepaymentScheduleII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleII."Loan Amount" := ObjLoanRepaymentSchedule."Loan Amount";
                                    ObjLoanRepaymentScheduleII."Instalment No" := VarInstallmentNo;
                                    ObjLoanRepaymentScheduleII."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleII."Member No." := ObjLoanRepaymentSchedule."Member No.";
                                    ObjLoanRepaymentScheduleII."Loan Category" := ObjLoanRepaymentSchedule."Loan Category";
                                    ObjLoanRepaymentScheduleII."Monthly Repayment" := ObjLoanRepaymentSchedule."Monthly Repayment";
                                    ObjLoanRepaymentScheduleII."Principal Repayment" := ObjLoanRepaymentSchedule."Principal Repayment";
                                    ObjLoanRepaymentScheduleII."Monthly Interest" := ObjLoanRepaymentSchedule."Monthly Interest";
                                    ObjLoanRepaymentScheduleII."Monthly Insurance" := ObjLoanRepaymentSchedule."Monthly Insurance";
                                    ObjLoanRepaymentScheduleII."Loan Balance" := ObjLoanRepaymentSchedule."Loan Balance";
                                    ObjLoanRepaymentScheduleII.Insert;

                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Instalment No");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Monthly Repayment", '<>%1', 0);
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Installment Date to Skip From");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule.ToDelete, true);
                            if ObjLoanRepaymentSchedule.FindSet then
                                ObjLoanRepaymentSchedule.DeleteAll;

                            //=======================================================================Loan Repayment Schedule  Temp

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Installment Date to Skip From");
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    ObjLoanRepaymentScheduleTemp.ToDelete := true;
                                    ObjLoanRepaymentScheduleTemp.Modify;
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Installment Date to Skip From");
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                ObjLoanRepaymentScheduleTempII.Reset;
                                ObjLoanRepaymentScheduleTempII.SetCurrentkey(ObjLoanRepaymentScheduleTempII."Entry No");
                                if ObjLoanRepaymentScheduleTempII.FindLast then
                                    ScheduleEntryNo := ObjLoanRepaymentScheduleTempII."Entry No" + 1;

                                InstallmentsToSkip := Rec."Loan Installments to Skip";
                                VarInstallmentNo := ObjLoanRepaymentScheduleTemp."Instalment No";
                                RepaymentDateSkip := ObjLoanRepaymentScheduleTemp."Repayment Date";

                                repeat
                                    ObjLoanRepaymentScheduleTempII.Init;
                                    ObjLoanRepaymentScheduleTempII."Loan No." := ObjLoanRepaymentScheduleTemp."Loan No.";
                                    ObjLoanRepaymentScheduleTempII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleTempII."Loan Amount" := ObjLoanRepaymentScheduleTemp."Loan Amount";
                                    ObjLoanRepaymentScheduleTempII."Instalment No" := VarInstallmentNo;
                                    ObjLoanRepaymentScheduleTempII."Repayment Date" := RepaymentDateSkip;
                                    ObjLoanRepaymentScheduleTempII."Member No." := ObjLoanRepaymentScheduleTemp."Member No.";
                                    ObjLoanRepaymentScheduleTempII."Loan Category" := ObjLoanRepaymentScheduleTemp."Loan Category";
                                    ObjLoanRepaymentScheduleTempII."Monthly Repayment" := 0;
                                    ObjLoanRepaymentScheduleTempII."Principal Repayment" := 0;
                                    ObjLoanRepaymentScheduleTempII."Monthly Interest" := 0;
                                    ObjLoanRepaymentScheduleTempII."Monthly Insurance" := 0;
                                    ObjLoanRepaymentScheduleTempII."Loan Balance" := ObjLoanRepaymentScheduleTemp."Loan Balance";
                                    ObjLoanRepaymentScheduleTempII.Insert;
                                    InstallmentsToSkip := InstallmentsToSkip - 1;
                                    VarInstallmentNo := VarInstallmentNo + 1;
                                    RepaymentDateSkip := CalcDate('1M', RepaymentDateSkip);
                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                until InstallmentsToSkip = 0;
                            end;

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Instalment No");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Monthly Repayment", '<>%1', 0);
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Installment Date to Skip From");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp.ToDelete, true);
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    VarInstallmentNo := ObjLoanRepaymentScheduleTemp."Instalment No" + Rec."Loan Installments to Skip";
                                    VarNewInstalmentDate := CalcDate(Format(Rec."Loan Installments to Skip") + 'M', ObjLoanRepaymentScheduleTemp."Repayment Date");

                                    ObjLoanRepaymentScheduleTempII.Init;
                                    ObjLoanRepaymentScheduleTempII."Loan No." := ObjLoanRepaymentScheduleTemp."Loan No.";
                                    ObjLoanRepaymentScheduleTempII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleTempII."Loan Amount" := ObjLoanRepaymentScheduleTemp."Loan Amount";
                                    ObjLoanRepaymentScheduleTempII."Instalment No" := VarInstallmentNo;
                                    ObjLoanRepaymentScheduleTempII."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleTempII."Member No." := ObjLoanRepaymentScheduleTemp."Member No.";
                                    ObjLoanRepaymentScheduleTempII."Loan Category" := ObjLoanRepaymentScheduleTemp."Loan Category";
                                    ObjLoanRepaymentScheduleTempII."Monthly Repayment" := ObjLoanRepaymentScheduleTemp."Monthly Repayment";
                                    ObjLoanRepaymentScheduleTempII."Principal Repayment" := ObjLoanRepaymentScheduleTemp."Principal Repayment";
                                    ObjLoanRepaymentScheduleTempII."Monthly Interest" := ObjLoanRepaymentScheduleTemp."Monthly Interest";
                                    ObjLoanRepaymentScheduleTempII."Monthly Insurance" := ObjLoanRepaymentScheduleTemp."Monthly Insurance";
                                    ObjLoanRepaymentScheduleTempII."Loan Balance" := ObjLoanRepaymentScheduleTemp."Loan Balance";
                                    ObjLoanRepaymentScheduleTempII.Insert;

                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Instalment No");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Monthly Repayment", '<>%1', 0);
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Installment Date to Skip From");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp.ToDelete, true);
                            if ObjLoanRepaymentScheduleTemp.FindSet then
                                ObjLoanRepaymentScheduleTemp.DeleteAll;

                            Rec."Skip Installments Effected" := true;
                            Rec."Skip Installments Effected By" := UserId;
                            Rec."Skip Installments Effected On" := CurrentDatetime;
                            Message('Skip Installments Effected Succesfully. View Repayment Schedule to confirm.');
                        end;
                    end;
                }
                action("Loans to Offset")
                {
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List-P";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("Net Disbursed")
                {
                    Caption = 'Net Disbursed Loan';
                    Image = DistributionGroup;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        LoanApp.Reset();
                        LoanApp.SetRange("Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(175054, true, false, LoanApp);
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                    // ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            Rec."Loan Status" := Rec."loan status"::Application;
                            Rec."Approval Status" := "approval status"::Open;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Loan Recovery Logs")
                {
                    Image = Form;
                    Visible = false;
                    Promoted = true;
                    RunObject = Page "Loan Recovery Logs List";
                    RunPageLink = "Member No" = field("No. Series"),
                                  "Member Name" = field("Name of Chief/ Assistant");
                }
                action("Change Status")
                {
                    Caption = 'Change Loan Status';
                    Image = ChangeStatus;
                    Visible = false;
                    Promoted = true;
                    PromotedOnly = true;

                    trigger
                    OnAction()
                    begin
                        if userSetup.Get(UserId) then begin
                            if (Rec."Employer Code" = 'POSTAL CORP') or (Rec."Employer Code" = 'KENYA POSTAL') then begin
                                if userSetup."Change Defaulter Status" = false then begin
                                    Error('You cannot change this loan''s classification.');
                                end;
                            end else begin
                                if (userSetup."Change Defaulter Status" = false) or (userSetup."Is Manager" = false) then begin
                                    Error('You cannot change this loan''s classification.');
                                end;
                            end;
                        end;
                        if Confirm('Are you sure you wish to change the loan status to performing?', false) = true then begin
                            if LoanApp.Get(rec."Loan  No.") then begin
                                LoanApp."Loans Category" := LoanApp."Loans Category"::Perfoming;
                                LoanApp.Modify();
                                Message('The loan category is now , %1', LoanApp."Loans Category");
                            end;
                        end
                        else begin
                            Message('Ok');
                        end;
                    end;
                }
                action("Change Defaulted Status")
                {
                    Caption = 'Change Loan Defaulted Status';
                    Image = NewStatusChange;
                    Promoted = true;
                    Visible = false;
                    PromotedOnly = true;
                    trigger
                    OnAction()
                    begin
                        if userSetup.Get(UserId) then begin
                            if (Rec."Employer Code" = 'POSTAL CORP') or (Rec."Employer Code" = 'KENYA POSTAL') then begin
                                if userSetup."Change Defaulter Status" = false then begin
                                    Error('You cannot change this loan''s defaulted status.');
                                end;
                            end else begin
                                if (userSetup."Change Defaulter Status" = false) or (userSetup."Is Manager" = false) then begin
                                    Error('You cannot change this loan''s defaulted status.');
                                end;
                            end;
                        end;
                        if Confirm('Are you sure you wish to change the loan defaulted status?', false) = true then begin
                            if Rec.Defaulted = true then begin
                                Rec.Defaulted := false;
                                Rec.Modify();
                                Message('The loan''s defaulted status is now %1', Rec.Defaulted);
                            end
                            else if Rec.Defaulted = false then begin
                                Rec.Defaulted := true;
                                Rec.Modify();
                                Message('The loan''s defaulted status is now %1', Rec.Defaulted);
                            end
                        end else begin
                            Message('Ok');
                        end;
                    end;
                }
                action("Loan Recovery Log Report")
                {
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        ObjCust.Reset;
                        ObjCust.SetRange(ObjCust."No.", Rec."Client Code");
                        if ObjCust.Find('-') then
                            Report.run(172963, true, false, ObjCust);
                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    //ApprovalEntries: Page "Approval Entries";
                    begin

                        //DocumentType := Documenttype::LoanApplication;
                        ///ApprovalEntries.Setfilters(Database::"Loans Register", DocumentType, Rec."Loan  No.");
                       // ApprovalEntries.Run;
                    end;
                }
                action("Update PAYE")
                {
                    Image = PayrollStatistics;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    Caption = 'Update Salary Details';
                    PromotedOnly = true;
                    //Visible = false;

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
                        UpdatePaye: Codeunit "Payroll Processing";
                        TaxablePay: Decimal;
                        PayeAmount: Decimal;
                        monthlyContr: Decimal;
                        TotalDeductions: Decimal;
                        loanDeductions: Decimal;
                        loanOffsets: Decimal;
                        stoDeductions: Decimal;
                        thirdGross: Decimal;
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
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EditableField := true;
    end;

    trigger OnAfterGetRecord()
    var
        loanGuar: Record "Loans Guarantee Details";

    begin
        EditableField := true;
        DateChangedEditable := true;
        if Rec."Repayment Dates Rescheduled" = true then begin
            DateChangedEditable := false;
        end;
        RescheduledVisible := Rec.Rescheduled;
        Rec."Working Date" := WorkDate;

        Rec.Reset();
        Rec.SetRange("Loan  No.", rec."Loan  No.");
        if Rec.Find('-') then begin
            Rec.CalcFields("Guaranteed Amount");
            // Message('The Guaranteed amount for this loan is %1.', Rec."Guaranteed Amount");
        end;
    end;

    trigger OnOpenPage()
    var
        LoanProducts: Record "Loan Products Setup";
    begin
        EditableField := true;

        EditableField := true;
        DateChangedEditable := true;
        if Rec."Repayment Dates Rescheduled" = true then begin
            DateChangedEditable := false;
        end;

        RescheduledVisible := Rec.Rescheduled;

        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then begin
            if user."Can edit recovery mode" = true
            then begin
                recoveryedit := true;
            end;
        end;
    end;


    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        user: Record "User Setup";
        ScheduleRep: Record "Loan Repayment Schedule";
        LoanGuar: Record "Loans Guarantee Details";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
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
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        userSetup: Record "User Setup";
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
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GrossPay: Decimal;
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
        PartPay: Record "Loan Partial Disburesments";
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        RepaySched: Record "Loan Repayment Schedule";
        LoanReferee1NameEditable: Boolean;
        LoanReferee2NameEditable: Boolean;
        LoanReferee1MobileEditable: Boolean;
        LoanReferee2MobileEditable: Boolean;
        LoanReferee1AddressEditable: Boolean;
        LoanReferee2AddressEditable: Boolean;
        LoanReferee1PhyAddressEditable: Boolean;
        LoanReferee2PhyAddressEditable: Boolean;
        LoanReferee1RelationEditable: Boolean;
        LoanReferee2RelationEditable: Boolean;
        LoanPurposeEditable: Boolean;
        WitnessEditable: Boolean;
        compinfo: Record "Company Information";
        CummulativeGuarantee: Decimal;
        LoansRec: Record "Loans Register";
        RecoveryModeEditable: Boolean;
        RemarksEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        ScheduleBal: Decimal;
        SFactory: Codeunit "Au Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        ReschedulingFees: Decimal;
        ReschedulingFeeAccount: Code[50];
        LoanProcessingFee: Decimal;
        ExciseDuty: Decimal;
        EditableField: Boolean;
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        DateChangedEditable: Boolean;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        VarNewInstalmentDate: Date;
        ObjLoanRepaymentScheduleTemp: Record "Loan Repayment Schedule Temp";
        ObjCust: Record Customer;
        ObjLoanRepaymentScheduleII: Record "Loan Repayment Schedule";
        ObjLoanRepaymentScheduleTempII: Record "Loan Repayment Schedule Temp";
        ScheduleEntryNo: Integer;
        InstallmentsToSkip: Integer;
        RepaymentDateSkip: Date;
        RescheduledVisible: Boolean;
        SkipInstallmentEditable: Boolean;
        recoveryedit: Boolean;

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


    procedure UpdateControl()
    begin
        if Rec."Approval Status" = Rec."approval status"::Open then begin
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
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if Rec."Approval Status" = Rec."approval status"::Pending then begin
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
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if Rec."Approval Status" = Rec."approval status"::Rejected then begin
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
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if Rec."Approval Status" = Rec."approval status"::Approved then begin
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
            BatchNoEditable := true;
            RemarksEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;

    local procedure FnGenerateSchedule()
    begin
        if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
            Evaluate(InPeriod, '1D')
        else
            if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                Evaluate(InPeriod, '1W')
            else
                if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                    Evaluate(InPeriod, '1M')
                else
                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                        Evaluate(InPeriod, '1Q');


        QCounter := 0;
        QCounter := 3;
        ScheduleBal := 0;
        GrPrinciple := Rec."Grace Period - Principle (M)";
        GrInterest := Rec."Grace Period - Interest (M)";
        InitialGraceInt := Rec."Grace Period - Interest (M)";

        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
        if LoansR.Find('-') then begin

            Rec.TestField("Loan Disbursement Date");
            Rec.TestField("Repayment Start Date");

            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
            RSchedule.DeleteAll;

            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            InterestRate := LoansR.Interest;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments + Rec."Grace Period - Principle (M)";
            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            LNBalance := LoansR."Outstanding Balance";
            RunDate := Rec."Repayment Start Date";

            InstalNo := 0;
            Evaluate(RepayInterval, '1W');

            //Repayment Frequency
            if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                RunDate := CalcDate('-1D', RunDate)
            else
                if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else
                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                        RunDate := CalcDate('-1M', RunDate)
                    else
                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                            RunDate := CalcDate('-1Q', RunDate);
            //Repayment Frequency


            repeat
                InstalNo := InstalNo + 1;
                ScheduleBal := LBalance;

                //*************Repayment Frequency***********************//
                if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('1Q', RunDate);






                //*******************If Amortised****************************//
                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                    Rec.TestField(Installments);
                    Rec.TestField(Interest);
                    Rec.TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

                    LPrincipal := TotalMRepay - LInterest;
                end;



                if Rec."Repayment Method" = Rec."repayment method"::"Straight Line" then begin
                    Rec.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    if (Rec."Loan Product Type" = 'INST') or (Rec."Loan Product Type" = 'MAZAO') then begin
                        LInterest := 0;
                    end else begin
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
                    end;

                    Rec.Repayment := LPrincipal + LInterest;
                    Rec."Loan Principle Repayment" := LPrincipal;
                    Rec."Loan Interest Repayment" := LInterest;
                end;


                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                    Rec.TestField(Interest);
                    Rec.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
                end;

                if Rec."Repayment Method" = Rec."repayment method"::Constants then begin
                    Rec.TestField(Repayment);
                    if LBalance < Rec.Repayment then
                        LPrincipal := LBalance
                    else
                        LPrincipal := Rec.Repayment;
                    LInterest := Rec.Interest;
                end;


                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    if Rec."Instalment Period" <> InPeriod then
                        LBalance := LBalance - LPrincipal;
                    ScheduleBal := ScheduleBal - LPrincipal;
                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;
                LInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 0.05, '>'); //For Nafaka Only
                                                                                                                                          //Grace Period
                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := Rec."Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                RSchedule."Member No." := Rec."Client Code";
                RSchedule."Loan Category" := Rec."Loan Product Type";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;

        Commit;

        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
        if LoanApp.Find('-') then
            if LoanApp."Loan Product Type" <> 'INST' then begin
                Report.Run(172477, true, false, LoanApp);
            end else begin
                Report.Run(172477, true, false, LoanApp);
            end;
    end;


}




