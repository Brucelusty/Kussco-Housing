//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50069 "Loans Archived List"
{
    ApplicationArea = All;
    CardPageID = "Loans Archived Card";
    DeleteAllowed = false;
    //Editable = false;
    InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where("Archive Loan" = const(true));


    layout
    {
        area(content)
        {
            repeater(Control1000000008)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member No';
                    StyleExpr = StyleExprTxt;
                }
                field("Client Name"; Rec."Client Name")
                {
                    Caption = 'Member Name';
                    StyleExpr = StyleExprTxt;
                }
                field("ID NO"; Rec."ID NO")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Caption = 'Loan Product';
                    StyleExpr = StyleExprTxt;
                }

                field("Staff No"; Rec."Staff No")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    Editable = true;
                    StyleExpr = StyleExprTxt;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    StyleExpr = StyleExprTxt;
                }
                field(Interest; Rec.Interest)
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    StyleExpr = StyleExprTxt;
                }
                field(Installments; Rec.Installments)
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Disbursed By"; Rec."Disbursed By")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    StyleExpr = StyleExprTxt;

                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Principal In Arrears"; Rec."Principal In Arrears")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Interest In Arrears"; Rec."Interest In Arrears")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    StyleExpr = StyleExprTxt;
                }
                field(Reversed; Rec.Reversed)
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Captured By"; Rec."Captured By")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Offset Amount"; Rec."Loan Offset Amount")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Principal Offset"; Rec."Loan Principal Offset")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Loans Category"; Rec."Loans Category")
                {
                    StyleExpr = StyleExprTxt;
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
                Caption = 'UnArchive Loan';
                Image = AnalysisView;
                action("UnArchive Loan")
                {
                    Caption = 'UnArchive Loan';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                    if Confirm('Do you want to unArhieve this loan',true,false)=true then begin 
                        Rec."Archive Loan" := false;
                        Rec.Modify();
                        end;
                    end;
                }


            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;
        If Rec."Loans Category" = Rec."Loans Category"::Perfoming then begin
            StyleExprTxt := 'Favorable'
        end

        else
            If Rec."Loans Category" = Rec."Loans Category"::Watch then begin
                StyleExprTxt := 'Ambiguous'
            end else
                If Rec."Loans Category" = Rec."Loans Category"::Substandard then begin
                    StyleExprTxt := 'AttentionAccent'
                end else
                    If Rec."Loans Category" = Rec."Loans Category"::Doubtful then begin
                        StyleExprTxt := 'Unfavorable'

                    end
                    else
                        If Rec."Loans Category" = Rec."Loans Category"::Loss then begin
                            StyleExprTxt := 'Attention';
                        end


    end;

    var
        i: Integer;
        StyleExprTxt: text[500];
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
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
        GenSetUp: Record "Sales & Receivables Setup";
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
        SMSMessage: Record Customer;
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
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
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Overdue: Option Yes," ";
        ScheduleBal: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        VarNewInstalmentDate: Date;
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ObjLoanRepaymentScheduleTemp: Record "Loan Repayment Schedule Temp";
        SFactory: Codeunit "Au Factory";
        ObjCust: Record Customer;


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := Rec."Loan  No.";
        LoanProductType := Rec."Loan Product Type";
    end;


    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        if Rec."Outstanding Balance" > 0 then begin
            if (Rec."Expected Date of Completion" < Today) then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}






