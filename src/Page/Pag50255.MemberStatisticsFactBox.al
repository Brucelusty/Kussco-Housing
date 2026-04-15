//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50255 "Member Statistics FactBox"
{
    ApplicationArea = All;
    Caption = 'Member FactBox';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                Caption = 'Member No.';
            }
            field(Name; Rec.Name)
            {
            }
            field("ID No."; Rec."ID No.")
            {
            }
            field("Mobile Phone No"; Rec."Mobile Phone No")
            {
            }
            field("Membership Status"; Rec."Membership Status")
            {
                Style = AttentionAccent;
                StyleExpr = true;
            }
            field("No of BD Trainings Attended"; Rec."No of BD Trainings Attended")
            {
                Editable = false;
                Visible = false;
            }
            group("Member Details FactBox")
            {
                Caption = 'Member Details FactBox';
                field("Registration Fee Paid"; Rec."Registration Fee Paid")
                {
                    Caption = 'Registration Fee';
                    Importance = Promoted;

                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    Caption = 'Share Capital';
                    Style = Favorable;
                    StyleExpr = FieldStyleShareCap;
                    //Visible=false;

                }
                field("Current Shares"; Rec."Current Shares")
                {
                    Caption = 'Member Savings';
                    Importance = Promoted;
                    Style = Standard;
                    StyleExpr = FieldStyleDep;
                }

                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Caption = 'Loan Principal Balance';
                    StyleExpr = FieldStyleLoan;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    StyleExpr = FieldStyleInt;
                }
                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                    Editable = false;
                }

                field("Dividend Amount"; Rec."Dividend Amount")
                {

                }
                field("Interest On Deposits"; Rec."Interest On Deposits")
                {
                }

            }
            group("File Movement FactBox")
            {
                Caption = 'File Movement FactBox';
                Visible = false;
                field("Currect File Location"; Rec."Currect File Location")
                {
                }
                field("Loc Description"; Rec."Loc Description")
                {
                }
                field(User; Rec.User)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*ObjLoans.RESET;
        ObjLoans.SETRANGE("Client Code","No.");
        IF ObjLoans.FIND('-') THEN
        OutstandingInterest:=SFactory.FnGetInterestDueTodate(ObjLoans)-ObjLoans."Interest Paid";*/

        //VarMemberLiability:=SFactory.FnGetMemberLiability("No.");

        VarTotalInterestCharged := 0;
        VarTotalInterestPaid := 0;
        VarOutstandingInterest := 0;

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", Rec."No.");
        if ObjLoans.FindSet then begin
            repeat
            // VarLoanOutstandingInt := SFactory.FnRunLoanAmountDue(ObjLoans."Loan  No.");
            // VarOutstandingInterest := VarOutstandingInterest + ObjLoans."Current Interest Due";
            until ObjLoans.Next = 0;
        end;


    end;

    trigger OnAfterGetRecord()
    begin
        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then
                    Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;


        ChangeCustomer;
        GetLatestPayment;
        CalculateAging;


        SetFieldStyle;

        //VarMemberLiability:=SFactory.FnGetMemberLiability("No.");
    end;

    trigger OnOpenPage()
    begin
        // Default the Aging Period to 30D
        Evaluate(AgingPeriod, '<30D>');
        // Initialize Record Variables
        LatestCustLedgerEntry.Reset;
        LatestCustLedgerEntry.SetCurrentkey("Document Type", "Customer No.", "Posting Date");
        LatestCustLedgerEntry.SetRange("Document Type", LatestCustLedgerEntry."document type"::Payment);
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            CustLedgerEntry[I].Reset;
            CustLedgerEntry[I].SetCurrentkey("Customer No.", Open, Positive, "Due Date");
            CustLedgerEntry[I].SetRange(Open, true);
        end;

    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array[4] of Record "Cust. Ledger Entry";
        AgingTitle: array[4] of Text[30];
        AgingPeriod: DateFormula;
        I: Integer;
        PeriodStart: Date;
        PeriodEnd: Date;
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';
        LoanGuarantors: Record "Loans Guarantee Details";
        ComittedShares: Decimal;
        Loans: Record "Loans Register";
        FreeShares: Decimal;
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        FieldStyleLoan: Text;
        FieldStyleInt: Text;
        FieldStyleDep: Text;
        FieldStyleOrd: Text;
        FieldStyleESS: Text;
        FieldStyleShareCap: Text;
        LoanNo: Code[20];
        LoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        TAmountGuaranteed: Decimal;
        AllGuaratorsTotal: Decimal;
        AmounttoRelease: Decimal;
        TotalOutstaningBal: Decimal;
        TotalApprovedAmount: Decimal;
        TotalAmountPaid: Decimal;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Au Factory";
        ObjLoans: Record "Loans Register";
        saccoSetup: Record "Sacco General Set-Up";
        VarMemberLiability: Decimal;
        VarOutstandingInterest: Decimal;
        VarTotalInterestCharged: Decimal;
        VarTotalInterestPaid: Decimal;
        VarLoanOutstandingInt: Decimal;


    procedure CalculateAgingForPeriod(PeriodBeginDate: Date; PeriodEndDate: Date; Index: Integer)
    var
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        NumDaysToBegin: Integer;
        NumDaysToEnd: Integer;
    begin
        // Calculate the Aged Balance for a particular Date Range
        if PeriodEndDate = 0D then
            CustLedgerEntry[Index].SetFilter("Due Date", '%1..', PeriodBeginDate)
        else
            CustLedgerEntry[Index].SetRange("Due Date", PeriodBeginDate, PeriodEndDate);

        CustLedgerEntry2.Copy(CustLedgerEntry[Index]);
        CustLedgerEntry[Index]."Remaining Amt. (LCY)" := 0;
        if CustLedgerEntry2.Find('-') then
            repeat
                CustLedgerEntry2.CalcFields("Remaining Amt. (LCY)");
                CustLedgerEntry[Index]."Remaining Amt. (LCY)" :=
                  CustLedgerEntry[Index]."Remaining Amt. (LCY)" + CustLedgerEntry2."Remaining Amt. (LCY)";
            until CustLedgerEntry2.Next = 0;

        if PeriodBeginDate <> 0D then
            NumDaysToBegin := WorkDate - PeriodBeginDate;
        if PeriodEndDate <> 0D then
            NumDaysToEnd := WorkDate - PeriodEndDate;
        if PeriodEndDate = 0D then
            AgingTitle[Index] := Text002
        else
            if PeriodBeginDate = 0D then
                AgingTitle[Index] := StrSubstNo(Text003, NumDaysToEnd - 1)
            else
                AgingTitle[Index] := StrSubstNo(Text004, NumDaysToEnd, NumDaysToBegin);
    end;


    procedure CalculateAging()
    begin
        // Calculate the Entire Aging (four Periods)
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            case I of
                1:
                    begin
                        PeriodEnd := 0D;
                        PeriodStart := WorkDate;
                    end;
                ArrayLen(CustLedgerEntry):
                    begin
                        PeriodEnd := PeriodStart - 1;
                        PeriodStart := 0D;
                    end;
                else begin
                    PeriodEnd := PeriodStart - 1;
                    PeriodStart := CalcDate('-' + Format(AgingPeriod), PeriodStart);
                end;
            end;
            CalculateAgingForPeriod(PeriodStart, PeriodEnd, I);
        end;
    end;


    procedure GetLatestPayment()
    begin
        // Find the Latest Payment
        if LatestCustLedgerEntry.FindLast then
            LatestCustLedgerEntry.CalcFields("Amount (LCY)")
        else
            LatestCustLedgerEntry.Init;
    end;


    procedure ChangeCustomer()
    begin
        // Change the Customer Filters
        LatestCustLedgerEntry.SetRange("Customer No.", Rec."No.");
        for I := 1 to ArrayLen(CustLedgerEntry) do
            CustLedgerEntry[I].SetRange("Customer No.", Rec."No.");
    end;


    procedure DrillDown(Index: Integer)
    begin
        if Index = 0 then
            Page.RunModal(Page::"Customer Ledger Entries", LatestCustLedgerEntry)
        else
            Page.RunModal(Page::"Customer Ledger Entries", CustLedgerEntry[Index]);
    end;

    local procedure SetFieldStyle()
    begin
        saccoSetup.Get();
        FieldStyle := '';
        //Rec.CalcFields("Un-allocated Funds");
        //if Rec."Un-allocated Funds" <> 0 then
        //    FieldStyle := 'Attention';

        Rec.CalcFields("Outstanding Balance", "Outstanding Interest");
        if (Rec."Outstanding Balance" < 0) then begin
            FieldStyleLoan := 'Ambiguous';
        end else
            FieldStyleLoan := 'StandardAccent';
        if (Rec."Outstanding Interest" < 0) then begin
            FieldStyleInt := 'Ambiguous';
        end else
            FieldStyleInt := 'StandardAccent';

        if (rec."Ordinary Savings" < 0) then begin
            FieldStyleOrd := 'Unfavorable';
        end else if Rec."Ordinary Savings" < 1000 then begin
            FieldStyleOrd := 'Attention';
        end else if (rec."Ordinary Savings" > 0) then begin
            FieldStyleOrd := 'Favorable';
        end;
        if (rec."Current Shares" < 0) then begin
            FieldStyleDep := 'Unfavorable';
        end else if (rec."Current Shares" > 0) then begin
            FieldStyleDep := 'Favorable';
        end;
        if Rec."Shares Retained" >= saccoSetup."Retained Shares" then begin
            FieldStyleShareCap := 'Favorable'
        end;
        if Rec."Shares Retained" < saccoSetup."Retained Shares" then begin
            FieldStyleShareCap := 'Attention';
        end;
        if (Rec."Shares Retained" < saccoSetup."Retained Shares") and (Rec."Shares Retained" > 18000) then begin
            FieldStyleShareCap := 'AttentionAccent';
        end;

    end;
}






