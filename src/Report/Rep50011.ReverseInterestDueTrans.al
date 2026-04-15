report 50011 "ReverseInterestDueTrans"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customers; "G/l entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "Entry No.";

            DataItemTableView = where("Document No." = filter('LNRECOVERY 11/06/25'), Reversed = filter(false), "Entry No." = filter(> 1749737));//1750306
            ///DataItemTableView = where("Loan Product Type" = filter(''));
           // DataItemTableView = where(ISNormalMember = const(true));
            column(Loan__No_; "Posting Date")
            {
                //
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var

                loanapp: Record "Loans Register";
                MembersRegister: Record "Members Register";
                RSchedule: Record "Loan Repayment Schedule";
                RunBal: Decimal;
                TotalCredits: Decimal;
                DimOne: code[60];
                DimTwo: code[60];
                DimThree: code[60];
                DimFour: code[60];
                DimFive: code[60];
                DimValue: record "Dimension Value";

                ReversalEntry: Record "Reversal Entry";
                DetCust: Record "Detailed Cust. Ledg. Entry";
                DetLedg: Record "G/L Entry";
                ReverseNo: Integer;
                ReversalPost: codeunit "Reversal-Post";

            begin

                CLEAR(ReversalEntry);
                ReversalEntry.sethidedialog(true);
                ReversalEntry.SetHideWarningDialogs();
                //ReversalPost.SetHideDialog(true);
                ReversalEntry.ReverseTransaction(Customers."Transaction No.");


            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin




            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }



    var
        myInt: Integer;
        //    AuFactory: Codeunit "Post Monthly Interest";
        AuFactorys: Codeunit "Au Factory";
        TotalMRepay: Decimal;
        LInterest: Decimal;
        //loantype: Record "Loan Products Setup";
        LPrincipal: Decimal;
        LoanregisterCopy: Record "Loans Register";

        DataItemName: Record "Loans Register";

        Cust: Record Customer;

        //    FInterest: Codeunit "Financier Daily Interest";
        ///
        //        HrEMployee: Record "HR Employees";

        //Loans: Record "Loans Register";
        InterestDue: Decimal;
        //  Defaultloan: Record "Default Loan Classification";

        NumberOfDays: Integer;
        TotalPaidInterest: Decimal;
        LScheduleExpectationDate: Record "Loan Repayment Schedule";
        TotalSched: Decimal;
        TotalPayment: Decimal;
        DetCust: Record "Detailed Cust. Ledg. Entry";
        IntDueAmount: Decimal;
        //   InterestCalc: Record "Interest Calculation Buffer";
        IntNo: Integer;
        SFactory: Codeunit "Au Factory";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        JTemplate: Code[20];
        JBatch: Code[20];
        DOCUMENT_NO: code[40];
        LoanType: record "Loan Products Setup";
        LSchedule: Record "Loan Repayment Schedule";

        PenaltyBal: Decimal;
        LaceBal: Decimal;

        PrincipleBal: Decimal;

        InterestBal: Decimal;

        OtherFees: Decimal;

        OtherCharges: Decimal;

        BankCharges: Decimal;
        BouncedCheques: Decimal;

        ValuationFee: Decimal;

        AuctioneerFee: Decimal;
        LegalFee: Decimal;

        CarTracking: Decimal;

}
