page 50004 "Credited Fixed deposit list"
{
    ApplicationArea = All;
    CardPageID = "Fixed deposit card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Fixed Deposit";
    SourceTableView = WHERE(Fixed=FILTER(true),Posted=FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FD No";rec."FD No")
                {
                    Editable = false;
                }
                field("Account No";rec."Account No")
                {
                    Editable = false;
                }
                field("Account Name";rec."Account Name")
                {
                    Editable = false;
                }
                field("Fd Duration";rec."Fd Duration")
                {
                    Editable = false;
                }
                field(Amount;rec.Amount)
                {
                    Editable = false;
                }
                field(InterestRate;InterestRate)
                {
                    Editable = false;
                }
                field("ID NO";rec."ID NO")
                {
                    Editable = false;
                }
                field("Creted by";rec."Created by")
                {
                    Editable = false;
                }
                field(interestLessTax;rec.interestLessTax)
                {
                    Caption = '<interest Less Tax>';
                    Editable = false;
                }
                field("Amount After maturity";rec."Amount After maturity")
                {
                    Editable = false;
                }
                field(Date;rec.Date)
                {
                    Editable = false;
                }
                field(MaturityDate;rec.MaturityDate)
                {
                    Editable = false;
                }
                field(Posted;rec.Posted)
                {
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Reports)
            {
                Caption = 'Reports';
                action("Fixed Deposit Tracking")
                {
                    Caption = 'Fixed Deposit Tracking';
                    Image = ItemTracking;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = report "Fixed Deposits Tracking Report";
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // Rec.SETFILTER(MaturityDate,'>%1',TODAY);
    end;

    var
        LoanBalance: Decimal;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record 81;
        DefaultBatch: Record 232;
        GLPosting: Codeunit 12;
        window: Dialog;
        Account: Record 23;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record 98;
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record 270;
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record "Members Register";
        AccountHolders: Record 23;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        chqtransactions: Record Transactions;
        Trans: Record Transactions;
        TotalUnprocessed: Decimal;
        CustAcc: Record "Members Register";
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record Transactions;
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        FOSASetup: Record 312;
        Acc: Record 23;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record 2000000120;
        ChBank: Code[20];
        DValue: Record 349;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        Cheque: Boolean;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        BOSABank: Code[20];
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        genSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        AccP: Record 23;
        LoansR: Record "Loans Register";
        ClearingCharge: Decimal;
        ClearingRate: Decimal;
        [InDataSet]
        FChequeVisible: Boolean;
        [InDataSet]
        BChequeVisible: Boolean;
        [InDataSet]
        BReceiptVisible: Boolean;
        [InDataSet]
        BOSAReceiptChequeVisible: Boolean;
        [InDataSet]
        "Branch RefferenceVisible": Boolean;
        [InDataSet]
        LRefVisible: Boolean;
        [InDataSet]
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record 271;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Vend1: Record 23;
        TransDesc: Text;
        TransTypes: Record "Transaction Types";
        ObjTransactionCharges: Record "Transaction Charges";
        AccountBalance: Decimal;
        MinimumBalance: Decimal;
        TransactionAmount: Decimal;
        WithCharges: Decimal;
        fixedno: Code[30];
        fixeddeposit: Record "Fixed Deposit";
}

