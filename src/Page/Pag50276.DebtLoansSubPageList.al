//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50276 "Loans Debt Collectors List"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    // Editable = false;
    // InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    Caption = 'Loan Product Name';
                    Editable = false;
                    Enabled = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member No';
                    Editable = false;
                    Enabled = false;
                }
                field("Client Name"; Rec."Client Name")
                {
                    Caption = 'Member Name';
                    Editable = false;
                    Enabled = false;
                }
                field(Installments; Rec.Installments)
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    Caption = 'Requested Amount';
                    Editable = false;
                    Enabled = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Editable = false;
                }
                field("Loan Debt Collector"; Rec."Loan Debt Collector")
                {
                    Editable = false;
                    Style = StandardAccent;
                }
                field("Debt Collector Name"; Rec."Debt Collector Name")
                {
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Last Repayment Date"; Rec."Last Pay Date")
                {
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Caption = 'Principle Balance';
                    Editable = false;
                    StyleExpr = FieldStyle;
                }

                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    Caption = 'Outstanding Interest';
                    Editable = false;
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    Editable = false;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Caption = 'Arrears Days';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = FieldStyleArrears;
                }
                field(Repayment; Rec.Repayment)
                {
                    Editable = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Loans Category"; Rec."Loans Category")
                {
                    Caption = 'Loans Category';
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                }
                field("Loan Application Mode"; Rec."Loan Application Mode")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Assign Debt Collector")
            {
                Enabled = false;
                Image = CustomerList;

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
            action("Loan Appraisal")
            {
                Caption = 'View Loan Appraisal';
                Enabled = true;
                Image = GanttChart;

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
            action("Guarantors' Report")
            {
                Image = SelectReport;

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
                Visible = false;

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
                Caption = 'Member Statistics';
                Image = Report;

                trigger OnAction()
                begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", Rec."Client Code");
                    Report.run(172886, true, false, Cust);
                end;
            }
            action("Members Statistics")
            {
                Caption = 'Member Statistics';
                Image = Statistics;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Client Code");
            }
            action("Loan Repayment Schedule")
            {
                Caption = 'Loan Repayment Schedule';
                Image = "Table";
                ShortCutKey = 'Ctrl+F7';

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

                    if loantype."Non Recurring Interest" = true then begin
                        AuFactory.FnGenerateLoanRepaymentScheduleZero(Rec."Loan  No.");
                    end;
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                    if LoanApp.Find('-') then begin
                        Commit;
                        Report.Run(80014, true, false, LoanApp);
                    end;

                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                    if LoanApp.Find('-') then
                        Report.run(80014, true, false, LoanApp);

                end;
            }
            // action("Loan Recovery Logs")
            // {
            //     Image = Form;
            //     Promoted = true;
            //     RunObject = Page "Loan Recovery Logs List";
            //     RunPageLink = "Member No" = field("No. Series"),
            //                   "Member Name" = field("Name of Chief/ Assistant");
            // }
            // action("Loan Recovery Log Report")
            // {
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     PromotedOnly = true;

            //     trigger OnAction()
            //     begin
            //         ObjCust.Reset;
            //         ObjCust.SetRange(ObjCust."No.", Rec."Client Code");
            //         if ObjCust.Find('-') then
            //             Report.run(172963, true, false, ObjCust);
            //     end;
            // }
        }

    }

    trigger OnAfterGetCurrRecord()
    begin
        /*InterestDue:=SFactory.FnGetInterestDueTodate(Rec);
        OutstandingInterest:=SFactory.FnGetInterestDueTodate(Rec)-"Interest Paid";
        
        
        SFactory.FnGetLoanArrearsAmountII("Loan  No.");
        
        CALCFIELDS("Interest Due","Interest Paid");
        "Outstanding Interest":="Interest Due"-("Interest Paid");
        
        "Loan Current Payoff Amount":=SFactory.FnRunGetLoanPayoffAmount("Loan  No.");
        
        "Loan Amount Due":=SFactory.FnRunLoanAmountDue("Loan  No.");
        */

    end;

    trigger OnAfterGetRecord()
    begin
        //SFactory.FnGetLoanArrearsAmountII("Loan  No.");


        //"Loan Current Payoff Amount" := SFactory.FnRunGetLoanPayoffAmount("Loan  No.");

        //"Loan Amount Due" := SFactory.FnRunLoanAmountDue("Loan  No.");
    end;

    trigger OnOpenPage()
    begin
        //SetFilter("Loan Status", '<>%1', "loan status"::Closed);

        /*"Loan Current Payoff Amount":=SFactory.FnRunGetLoanPayoffAmount("Loan  No.");
        
        "Loan Amount Due":=SFactory.FnRunLoanAmountDue("Loan  No.");*/

    end;

    var
        LoanType: Record "Loan Products Setup";
        NoSeriesMgt: Codeunit "No. Series";
        FieldStyle: Text;
        FieldStyleI: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Au Factory";
        LoanApp: Record "Loans Register";
        cust: Record Customer;
        VarLoanPayoffAmount: Decimal;
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterestI: Decimal;
        FieldStyleArrears: Text;

        PrincipleAmountupdate: Decimal;


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20]; var MemberNo: Code[20])
    begin
        LoanNo := Rec."Loan  No.";
        LoanProductType := Rec."Loan Product Type";
        MemberNo := Rec."Client Code";
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        Rec.CalcFields("Outstanding Balance", "Outstanding Interest");
        if (Rec."Outstanding Balance" < 0) then
            FieldStyle := 'Attention';

        if (Rec."Outstanding Interest" < 0) then
            FieldStyleI := 'Attention';


        FieldStyleArrears := 'Strong';
        if (Rec."Amount in Arrears" > 0) then
            FieldStyleArrears := 'Unfavorable';
        if (Rec."Amount in Arrears" = 0) then
            FieldStyleArrears := 'Favorable';
    end;
}




