page 51141 "Tranche Register Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Tranche Register";
    Caption = 'Tranche Register Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                }

                field("Loan No"; Rec."Loan No")
                {
                }

                field("Document Date"; Rec."Document Date")
                {
                }

                field("Client Code"; Rec."Client Code")
                {
                }

                field("Client Name"; Rec."Client Name")
                {
                }
                field(Description; Rec.Description)
                {
                }


                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }

                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                }
            }

            part(Tranches; "Tranche Disbursement Sublist")
            {
                Caption = 'Tranche Lines';
                SubPageLink = "Loan Number" = FIELD("Loan No"), "Member No" = field("Client Code"), Posted = filter(false);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    TrancheRec: Record "Tranche Disbursement Schedule";
                    LoansReg: Record "Loans Register";
                    LoanApp: Page "Loans Application Card(Approv)";
                begin
                    //  if Rec.Posted then
                    //   Error('Document already posted.');

                    // Validate at least one line
                    TrancheRec.Reset();
                    TrancheRec.SetRange("Loan Number", Rec."Loan No");
                    if not TrancheRec.FindFirst() then
                        Error('No tranche lines exist.');


                    if Confirm('Are you sure you want to post this tranche', true, false) = true then begin
                        BATCH_TEMPLATE := 'PAYMENTS';
                        BATCH_NAME := 'LOANS';
                        DOCUMENT_NO := Rec."Loan No";
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        LoansReg.Reset();
                        LoansReg.SetRange(LoansReg."Loan  No.", Rec."Loan No");
                        if LoansReg.FindFirst() then begin
                            TrancheRec.Reset();
                            TrancheRec.SetRange("Loan Number", LoansReg."Loan  No.");
                            TrancheRec.SetRange(TrancheRec.Select, true);
                            TrancheRec.SetRange(TrancheRec.Posted, false);
                            if TrancheRec.FindFirst() then begin
                                Message('Here%1', TrancheRec."Tranche Amount");
                                FnDisburseToBankAccount(LoansReg);

                                //CU posting                                    
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                                GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                end;
                                TrancheRec.Posted := true;
                                TrancheRec."Posted By" := UserId;
                                TrancheRec."Posting Date" := Today;
                                TrancheRec.modify;
                            end;
                        end;
                        // Mark header as posted
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec.Modify();
                        Message('Tranche document posted successfully.');
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
    procedure FnDisburseToBankAccount(LoanApps: Record "Loans Register")
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[30];
        TotalPCharges: Decimal;
        TrancheSchedule: Record "Tranche Disbursement Schedule";
        GenSetup: Record "Sacco General Set-Up";
        TCharges: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        VarAmounttoDisburse: Decimal;
        LineNo: Integer;
    begin

        GenSetUp.Get();
        if LoanApps.Get(Rec."Loan No") then begin
            TCharges := 0;
            TopUpComm := 0;
            TotalTopupComm := LoanApps."Loan Offset Amount";


            TrancheSchedule.Reset();
            TrancheSchedule.SetRange(TrancheSchedule."Loan Number", Rec."Loan No");
            TrancheSchedule.SetRange(TrancheSchedule.Posted, false);
            TrancheSchedule.SetRange(TrancheSchedule.Select, true);
            if TrancheSchedule.FindFirst() then begin
                VarAmounttoDisburse := TrancheSchedule."Tranche Amount";
            end;
            if VarAmounttoDisburse <= 0 then
                Error('You have specified Disbursement Mode as Tranche/Multiple Disbursement, Amount to Disburse on Tranche 1 must be greater than zero.');


            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            GenJournalLine."account type"::Customer, LoanApps."Client Code", Today, VarAmounttoDisburse, Format(LoanApps.Source), LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //--------------------------------(Debit Member Loan Account)---------------------------------------------


            //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"Bank Account", LoanApps."Paying Bank Account No", Today, VarAmounttoDisburse * -1, '', LoanApps."Cheque No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //----------------------------------(Credit Member Bank Account)------------------------------------------------

        end;

    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
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
        DOCUMENT_NO: Code[40];
        PayslipDetailsVisible: Boolean;
        BankStatementDetailsVisible: Boolean;
        ObjProductCharge: Record "Loan Product Charges";
        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
        ObjStatementB: Record "Loan Appraisal Statement Buffe";
        StatementStartDate: Date;
        StatementDateFilter: Date;
        StatementEndDate: Date;
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
        VerMonth5Date: Integer;
        VerMonth5Month: Integer;
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
        ObjCollateral: Record "Loan Collateral Details";
        ObjCust: Record Customer;
        ObjMemberLedg: Record "Member Ledger Entry";
        ObjMemberCellG: Record "Member House Groups";
        VarAmounttoDisburse: Decimal;
        TrunchDetailsVisible: Boolean;
        LInsurance: Decimal;
        RejectionDetailsVisible: Boolean;
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        EmailSend: Boolean;
        ObjMember: Record Customer;
        VarMemberEmail: Text[250];
        Filename: Text[250];
        //SMTPSetup: Record "SMTP Mail Setup";
        ObjLoans: Record "Loans Register";
        ObjMemberLedger: Record "Member Ledger Entry";
        VarLineNo: Integer;
        VarMemberName: Text;
        ObjLoansII: Record "Loans Register";
        varShowTranchDisbursement: Boolean;
        CoveragePercentStyle: Text;

        fieldsEditable: Boolean;

}


